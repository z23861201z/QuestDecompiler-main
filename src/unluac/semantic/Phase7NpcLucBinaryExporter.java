package unluac.semantic;

import java.net.URL;
import java.net.URLClassLoader;
import java.nio.charset.Charset;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.Driver;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

import unluac.chunk.Lua50ChunkParser;
import unluac.chunk.Lua50ChunkSerializer;
import unluac.chunk.Lua50StructureValidator;
import unluac.chunk.LuaChunk;

/**
 * Phase7 单文件字节码导出器：将 DB 文本改动直接打进指定 npc_xxxx.luc。
 *
 * <p>所属链路：链路 B（MySQL 修改 -> 保存 DB -> 导出 luc -> 客户端读取）的最终落地步骤。</p>
 * <p>输入：npc 文件名、原始 npc.luc、DB 中 npc_text_edit_map 的 modifiedText。</p>
 * <p>输出：单个 patched npc.luc。</p>
 * <p>数据库副作用：无（只读）。</p>
 * <p>文件副作用：会创建/覆盖目标 luc 文件。</p>
 * <p>阶段依赖：依赖 Phase7B/7C 的定位与文本基线约定（rawText 与 modifiedText）。</p>
 */
public class Phase7NpcLucBinaryExporter {

  private static final String DEFAULT_JDBC = "jdbc:mysql://127.0.0.1:3306/ghost_game"
      + "?useUnicode=true&characterEncoding=utf8&serverTimezone=UTC&useSSL=false&allowPublicKeyRetrieval=true";
  private static final String DEFAULT_USER = "root";
  private static final String DEFAULT_PASSWORD = "root";

  /**
   * CLI 入口。
   *
   * @param args 参数顺序：npcFileName、inputLuc、outputLuc、jdbcUrl、user、password、stringCharset
   * @throws Exception DB 读取、字节码解析/序列化、结构校验失败时抛出
   */
  public static void main(String[] args) throws Exception {
    if(args.length < 3) {
      System.out.println("Usage: java -cp build unluac.semantic.Phase7NpcLucBinaryExporter <npcFileName> <inputLuc> <outputLuc> [jdbcUrl] [user] [password] [stringCharset]");
      return;
    }

    String npcFileName = args[0];
    Path inputLuc = Paths.get(args[1]);
    Path outputLuc = Paths.get(args[2]);
    String jdbcUrl = args.length >= 4 ? args[3] : DEFAULT_JDBC;
    String user = args.length >= 5 ? args[4] : DEFAULT_USER;
    String password = args.length >= 6 ? args[5] : DEFAULT_PASSWORD;
    String charsetName = args.length >= 7 ? args[6] : System.getProperty("unluac.stringCharset", "GBK");

    Charset stringCharset = Charset.forName(charsetName);

    ensureMysqlDriverAvailable(jdbcUrl);
    List<TextMutation> mutations = loadMutations(jdbcUrl, user, password, npcFileName);
    if(mutations.isEmpty()) {
      throw new IllegalStateException("No modifiedText rows found for npc=" + npcFileName);
    }

    byte[] original = Files.readAllBytes(inputLuc);
    LuaChunk chunk = new Lua50ChunkParser(stringCharset).parse(original);

    List<ConstantRef> stringConstants = new ArrayList<ConstantRef>();
    collectStringConstants(chunk.mainFunction, stringConstants);

    // 在常量池层应用 DB 变更，保持字节码控制流不变。
    int patchedCount = applyMutations(chunk, stringConstants, mutations, stringCharset);
    if(patchedCount != mutations.size()) {
      throw new IllegalStateException("Not all mutations applied. expected=" + mutations.size() + " actual=" + patchedCount);
    }

    byte[] rebuilt = new Lua50ChunkSerializer().serialize(chunk);

    Lua50StructureValidator.ValidationReport report = new Lua50StructureValidator(original).validateLuc(rebuilt);
    if(!report.structureConsistent) {
      throw new IllegalStateException("structure validation failed after npc luc patch\n" + report.toTextReport());
    }

    if(outputLuc.getParent() != null && !Files.exists(outputLuc.getParent())) {
      Files.createDirectories(outputLuc.getParent());
    }
    Files.write(outputLuc, rebuilt);

    System.out.println("npc=" + npcFileName);
    System.out.println("input=" + inputLuc.toAbsolutePath());
    System.out.println("output=" + outputLuc.toAbsolutePath());
    System.out.println("mutations=" + mutations.size());
    System.out.println("patchedConstants=" + patchedCount);
    System.out.println("structureConsistent=" + report.structureConsistent);
  }

  /**
   * 将 DB 变更应用到 chunk 的字符串常量池。
   *
   * @param chunk 已解析的 Lua chunk
   * @param constants 可修改的字符串常量列表
   * @param mutations 本次应应用的文本修改
   * @param stringCharset 字符串编码
   * @return 实际打补丁条数
   * @implNote 副作用：会原地修改 chunk 常量对象
   */
  private static int applyMutations(LuaChunk chunk,
                                    List<ConstantRef> constants,
                                    List<TextMutation> mutations,
                                    Charset stringCharset) {
    int applied = 0;
    Set<Integer> usedConstantIndexes = new HashSet<Integer>();

    for(TextMutation mutation : mutations) {
      int chosen = -1;
      // 使用 rawText 匹配常量而不是位置匹配：确保不引入新常量，仅替换已存在常量内容。
      for(int i = 0; i < constants.size(); i++) {
        ConstantRef ref = constants.get(i);
        if(usedConstantIndexes.contains(Integer.valueOf(i))) {
          continue;
        }
        String oldText = ref.constant.stringValue == null ? "" : ref.constant.stringValue.toDisplayString();
        if(mutation.rawText.equals(oldText)) {
          chosen = i;
          break;
        }
      }

      if(chosen < 0) {
        throw new IllegalStateException("Cannot locate rawText in chunk constants for textId=" + mutation.textId + " rawText=" + mutation.rawText);
      }

      ConstantRef target = constants.get(chosen);
      target.constant.stringValue = buildLuaString(mutation.modifiedText, stringCharset);
      usedConstantIndexes.add(Integer.valueOf(chosen));
      applied++;
    }

    return applied;
  }

  /**
   * 构建带显式结尾空字节的 LuaString 负载。
   */
  private static LuaChunk.LuaString buildLuaString(String text, Charset charset) {
    byte[] body = text == null ? new byte[0] : text.getBytes(charset);
    byte[] decoded = new byte[body.length + 1];
    System.arraycopy(body, 0, decoded, 0, body.length);
    decoded[decoded.length - 1] = 0;

    LuaChunk.LuaString value = new LuaChunk.LuaString();
    value.lengthField = decoded.length;
    value.decodedBytes = decoded;
    value.nullTerminated = true;
    value.text = text == null ? "" : text;
    return value;
  }

  /**
   * 递归收集函数/子原型树中的全部字符串常量。
   */
  private static void collectStringConstants(LuaChunk.Function function, List<ConstantRef> out) {
    if(function == null) {
      return;
    }
    for(int i = 0; i < function.constants.size(); i++) {
      LuaChunk.Constant constant = function.constants.get(i);
      if(constant != null && constant.type == LuaChunk.Constant.Type.STRING && constant.stringValue != null) {
        ConstantRef ref = new ConstantRef();
        ref.functionPath = function.path;
        ref.constantIndex = i;
        ref.constant = constant;
        out.add(ref);
      }
    }
    for(LuaChunk.Function child : function.prototypes) {
      collectStringConstants(child, out);
    }
  }

  /**
   * 从 DB 读取某个 NPC 的有效文本变更集合。
   *
   * @param jdbcUrl DB 连接串
   * @param user DB 用户
   * @param password DB 密码
   * @param npcFileName NPC 文件名（如 npc_218008.lua）
   * @return 变更列表（仅包含 modifiedText != rawText）
   * @throws Exception 查询失败时抛出
   * @implNote 副作用：仅数据库读取
   */
  private static List<TextMutation> loadMutations(String jdbcUrl,
                                                  String user,
                                                  String password,
                                                  String npcFileName) throws Exception {
    List<TextMutation> out = new ArrayList<TextMutation>();
    String sql = "SELECT textId, rawText, modifiedText, line, columnNumber, astMarker "
        + "FROM npc_text_edit_map "
        + "WHERE npcFile=? AND modifiedText IS NOT NULL AND modifiedText <> rawText "
        + "ORDER BY textId";

    try(Connection connection = DriverManager.getConnection(jdbcUrl, user, password);
        PreparedStatement ps = connection.prepareStatement(sql)) {
      ps.setString(1, npcFileName);
      try(ResultSet rs = ps.executeQuery()) {
        while(rs.next()) {
          TextMutation row = new TextMutation();
          row.textId = rs.getLong("textId");
          row.rawText = rs.getString("rawText");
          row.modifiedText = rs.getString("modifiedText");
          row.line = rs.getInt("line");
          row.column = rs.getInt("columnNumber");
          row.astMarker = rs.getString("astMarker");
          out.add(row);
        }
      }
    }

    Set<Long> unique = new LinkedHashSet<Long>();
    for(TextMutation row : out) {
      unique.add(Long.valueOf(row.textId));
    }
    if(unique.size() != out.size()) {
      throw new IllegalStateException("Duplicate textId found in mutation rows for npc=" + npcFileName);
    }

    return out;
  }

  /**
   * 确保当前运行时可用 MySQL JDBC 驱动。
   */
  private static void ensureMysqlDriverAvailable(String jdbcUrl) throws Exception {
    try {
      DriverManager.getDriver(jdbcUrl);
      return;
    } catch(Exception ignored) {
    }

    try {
      Class<?> cls = Class.forName("com.mysql.cj.jdbc.Driver");
      Object obj = cls.getDeclaredConstructor().newInstance();
      if(obj instanceof Driver) {
        DriverManager.registerDriver((Driver) obj);
        return;
      }
    } catch(Throwable ignored) {
    }

    Path jar = Paths.get("lib", "mysql-connector-j-8.4.0.jar");
    if(!Files.exists(jar)) {
      throw new IllegalStateException("MySQL JDBC driver not found on classpath and missing jar: " + jar.toAbsolutePath());
    }

    URL url = jar.toUri().toURL();
    URLClassLoader loader = new URLClassLoader(new URL[] {url}, Phase7NpcLucBinaryExporter.class.getClassLoader());
    Class<?> cls = Class.forName("com.mysql.cj.jdbc.Driver", true, loader);
    Object obj = cls.getDeclaredConstructor().newInstance();
    if(!(obj instanceof Driver)) {
      throw new IllegalStateException("Loaded class is not java.sql.Driver: " + cls.getName());
    }
    DriverManager.registerDriver(new DriverShim((Driver) obj));
  }

  /**
   * 用于类加载器加载 MySQL 驱动的适配器。
   */
  private static final class DriverShim implements Driver {
    private final Driver driver;

    /**
     * 包装底层 JDBC 驱动实例。
     */
    DriverShim(Driver driver) {
      this.driver = driver;
    }

    @Override
    /**
     * 计算并返回结果。
     * @param url 方法参数
     * @param info 方法参数
     * @return 计算结果
     * @throws Exception 处理失败时抛出
     */
    public Connection connect(String url, java.util.Properties info) throws java.sql.SQLException {
      return driver.connect(url, info);
    }

    @Override
    /**
     * 计算并返回结果。
     * @param url 方法参数
     * @return 计算结果
     * @throws Exception 处理失败时抛出
     */
    public boolean acceptsURL(String url) throws java.sql.SQLException {
      return driver.acceptsURL(url);
    }

    @Override
    public java.sql.DriverPropertyInfo[] getPropertyInfo(String url, java.util.Properties info) throws java.sql.SQLException {
      return driver.getPropertyInfo(url, info);
    }

    @Override
    /**
     * 计算并返回结果。
     * @return 计算结果
     */
    public int getMajorVersion() {
      return driver.getMajorVersion();
    }

    @Override
    /**
     * 计算并返回结果。
     * @return 计算结果
     */
    public int getMinorVersion() {
      return driver.getMinorVersion();
    }

    @Override
    /**
     * 计算并返回结果。
     * @return 计算结果
     */
    public boolean jdbcCompliant() {
      return driver.jdbcCompliant();
    }

    @Override
    public java.util.logging.Logger getParentLogger() throws java.sql.SQLFeatureNotSupportedException {
      return driver.getParentLogger();
    }
  }

  /**
   * 指向 chunk 树中某个可变字符串常量的引用。
   */
  private static final class ConstantRef {
    String functionPath;
    int constantIndex;
    LuaChunk.Constant constant;
  }

  /**
   * 从数据库加载的一条文本变更记录。
   */
  private static final class TextMutation {
    long textId;
    String rawText;
    String modifiedText;
    int line;
    int column;
    String astMarker;
  }
}
