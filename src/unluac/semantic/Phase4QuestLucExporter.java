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
import java.time.OffsetDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * Phase4 导出器：从 MySQL 重建 quest 脚本（Lua 文本形态）。
 *
 * <p>所属链路：链路 B（DB -> semantic model -> 导出 lua -> 导出 luc -> 客户端读取）的 quest 分支。</p>
 * <p>输入：`ghost_game` 中 quest 相关表（quest_main/goal/reward 等）。</p>
 * <p>输出：`phase4_exported_quest.lua`。</p>
 * <p>数据库副作用：无（只读）。</p>
 * <p>文件副作用：创建/覆盖导出文件。</p>
 * <p>阶段依赖：依赖 Phase3 成功入库与字段顺序语义。</p>
 */
public class Phase4QuestLucExporter {

  private static final Charset UTF8 = Charset.forName("UTF-8");
  private static final String DEFAULT_JDBC = "jdbc:mysql://127.0.0.1:3306/ghost_game"
      + "?useUnicode=true&characterEncoding=utf8&serverTimezone=UTC&useSSL=false&allowPublicKeyRetrieval=true";
  private static final String DEFAULT_USER = "root";
  private static final String DEFAULT_PASSWORD = "root";

  /**
   * CLI 入口。
   *
   * @param args 参数顺序：output、jdbcUrl、user、password
   * @throws Exception DB 读取失败或文件写入失败时抛出
   */
  public static void main(String[] args) throws Exception {
    Path output = args.length >= 1
        ? Paths.get(args[0])
        : Paths.get("reports", "phase4_exported_quest.lua");
    String jdbcUrl = args.length >= 2 ? args[1] : DEFAULT_JDBC;
    String user = args.length >= 3 ? args[2] : DEFAULT_USER;
    String password = args.length >= 4 ? args[3] : DEFAULT_PASSWORD;

    long start = System.nanoTime();
    Phase4QuestLucExporter exporter = new Phase4QuestLucExporter();
    ExportResult result = exporter.export(output, jdbcUrl, user, password);
    long elapsed = (System.nanoTime() - start) / 1_000_000L;

    System.out.println("output=" + output.toAbsolutePath());
    System.out.println("questCount=" + result.questCount);
    System.out.println("exportMillis=" + elapsed);
  }

  /**
   * 执行 DB -> quest.lua 导出。
   *
   * @param output 导出文件路径
   * @param jdbcUrl DB 连接串
   * @param user DB 用户
   * @param password DB 密码
   * @return 导出结果统计
   * @throws Exception 驱动加载、查询或写文件失败时抛出
   * @implNote 副作用：写出 quest.lua 文件；不修改数据库
   */
  public ExportResult export(Path output,
                             String jdbcUrl,
                             String user,
                             String password) throws Exception {
    ensureMysqlDriverAvailable();

    List<QuestRecord> quests = loadFromDb(jdbcUrl, user, password);

    StringBuilder sb = new StringBuilder();
    sb.append("-- phase4 exported quest data\n");
    sb.append("-- generatedAt: ").append(OffsetDateTime.now().format(DateTimeFormatter.ISO_OFFSET_DATE_TIME)).append("\n\n");

    // 逐任务按稳定顺序输出，确保后续 validator 比对时结构可预测。
    for(int i = 0; i < quests.size(); i++) {
      QuestRecord quest = quests.get(i);
      appendQuest(sb, quest);
      if(i < quests.size() - 1) {
        sb.append("\n");
      }
    }

    ensureParent(output);
    Files.write(output, sb.toString().getBytes(UTF8));

    ExportResult result = new ExportResult();
    result.questCount = quests.size();
    return result;
  }

  /**
   * 读取 DB 并重建内存 QuestRecord 列表。
   *
   * @param jdbcUrl DB 连接串
   * @param user DB 用户
   * @param password DB 密码
   * @return quest 列表（quest_id 升序）
   * @throws Exception 任一查询失败时抛出
   * @implNote 副作用：仅数据库读取
   */
  private List<QuestRecord> loadFromDb(String jdbcUrl,
                                       String user,
                                       String password) throws Exception {
    Map<Integer, QuestRecord> byQuest = new LinkedHashMap<Integer, QuestRecord>();

    try(Connection connection = DriverManager.getConnection(jdbcUrl, user, password)) {
      String mainSql = "SELECT quest_id, name, need_level, bq_loop, reward_exp, reward_gold "
          + "FROM quest_main ORDER BY quest_id ASC";
      try(PreparedStatement ps = connection.prepareStatement(mainSql);
          ResultSet rs = ps.executeQuery()) {
        while(rs.next()) {
          QuestRecord record = new QuestRecord();
          record.questId = rs.getInt("quest_id");
          record.name = rs.getString("name");
          if(rs.wasNull()) {
            record.name = null;
          }

          record.needLevel = toNullableInt(rs, "need_level");
          record.bqLoop = toNullableInt(rs, "bq_loop");
          record.rewardExp = toNullableInt(rs, "reward_exp");
          record.rewardGold = toNullableInt(rs, "reward_gold");
          byQuest.put(Integer.valueOf(record.questId), record);
        }
      }

      loadStringArray(connection, byQuest, "quest_contents", ArrayType.CONTENTS);
      loadStringArray(connection, byQuest, "quest_answer", ArrayType.ANSWER);
      loadStringArray(connection, byQuest, "quest_info", ArrayType.INFO);

      loadPairArray(connection, byQuest, "quest_goal_getitem", "item_id", "item_count", PairType.GOAL_GET_ITEM);
      loadPairArray(connection, byQuest, "quest_goal_killmonster", "monster_id", "monster_count", PairType.GOAL_KILL_MONSTER);
      loadIntArray(connection, byQuest, "quest_goal_meetnpc", "npc_id");
      loadPairArray(connection, byQuest, "quest_reward_item", "item_id", "item_count", PairType.REWARD_ITEM);
    }

    List<QuestRecord> quests = new ArrayList<QuestRecord>(byQuest.values());
    Collections.sort(quests, (left, right) -> Integer.compare(left.questId, right.questId));
    return quests;
  }

  private Integer toNullableInt(ResultSet rs, String column) throws Exception {
    int value = rs.getInt(column);
    if(rs.wasNull()) {
      return null;
    }
    return Integer.valueOf(value);
  }

  private void loadStringArray(Connection connection,
                               Map<Integer, QuestRecord> byQuest,
                               String table,
                               ArrayType type) throws Exception {
    String sql = "SELECT quest_id, seq_index, text FROM " + table + " ORDER BY quest_id ASC, seq_index ASC";
    try(PreparedStatement ps = connection.prepareStatement(sql);
        ResultSet rs = ps.executeQuery()) {
      while(rs.next()) {
        int questId = rs.getInt("quest_id");
        QuestRecord quest = byQuest.get(Integer.valueOf(questId));
        if(quest == null) {
          continue;
        }
        String text = rs.getString("text");

        if(type == ArrayType.CONTENTS) {
          quest.contents.add(text);
        } else if(type == ArrayType.ANSWER) {
          quest.answer.add(text);
        } else {
          quest.info.add(text);
        }
      }
    }
  }

  private void loadPairArray(Connection connection,
                             Map<Integer, QuestRecord> byQuest,
                             String table,
                             String idColumn,
                             String countColumn,
                             PairType type) throws Exception {
    String sql = "SELECT quest_id, seq_index, " + idColumn + ", " + countColumn
        + " FROM " + table + " ORDER BY quest_id ASC, seq_index ASC";
    try(PreparedStatement ps = connection.prepareStatement(sql);
        ResultSet rs = ps.executeQuery()) {
      while(rs.next()) {
        int questId = rs.getInt("quest_id");
        QuestRecord quest = byQuest.get(Integer.valueOf(questId));
        if(quest == null) {
          continue;
        }

        Pair pair = new Pair();
        pair.id = toNullableInt(rs, idColumn);
        pair.count = toNullableInt(rs, countColumn);

        if(type == PairType.GOAL_GET_ITEM) {
          quest.goalGetItem.add(pair);
        } else if(type == PairType.GOAL_KILL_MONSTER) {
          quest.goalKillMonster.add(pair);
        } else {
          quest.rewardItems.add(pair);
        }
      }
    }
  }

  private void loadIntArray(Connection connection,
                            Map<Integer, QuestRecord> byQuest,
                            String table,
                            String valueColumn) throws Exception {
    String sql = "SELECT quest_id, seq_index, " + valueColumn
        + " FROM " + table + " ORDER BY quest_id ASC, seq_index ASC";
    try(PreparedStatement ps = connection.prepareStatement(sql);
        ResultSet rs = ps.executeQuery()) {
      while(rs.next()) {
        int questId = rs.getInt("quest_id");
        QuestRecord quest = byQuest.get(Integer.valueOf(questId));
        if(quest == null) {
          continue;
        }
        int value = rs.getInt(valueColumn);
        if(rs.wasNull()) {
          quest.goalMeetNpc.add(null);
        } else {
          quest.goalMeetNpc.add(Integer.valueOf(value));
        }
      }
    }
  }

  private void appendQuest(StringBuilder sb, QuestRecord quest) {
    sb.append("qt[").append(quest.questId).append("] = {\n");
    sb.append("  id = ").append(quest.questId).append(",\n");
    sb.append("  name = ").append(luaStringOrNil(quest.name)).append(",\n");
    sb.append("  contents = ");
    appendStringArray(sb, quest.contents, 2);
    sb.append(",\n");
    sb.append("  answer = ");
    appendStringArray(sb, quest.answer, 2);
    sb.append(",\n");
    sb.append("  info = ");
    appendStringArray(sb, quest.info, 2);
    sb.append(",\n");

    sb.append("  goal = {\n");
    sb.append("    getItem = ");
    appendPairArray(sb, quest.goalGetItem, 4, "id", "count");
    sb.append(",\n");
    sb.append("    killMonster = ");
    appendPairArray(sb, quest.goalKillMonster, 4, "id", "count");
    sb.append(",\n");
    sb.append("    meetNpc = ");
    appendIntArray(sb, quest.goalMeetNpc, 4);
    sb.append("\n");
    sb.append("  },\n");

    sb.append("  reward = {\n");
    sb.append("    exp = ").append(luaIntOrNil(quest.rewardExp)).append(",\n");
    sb.append("    gold = ").append(luaIntOrNil(quest.rewardGold)).append(",\n");
    sb.append("    items = ");
    appendPairArray(sb, quest.rewardItems, 4, "id", "count");
    sb.append("\n");
    sb.append("  },\n");

    sb.append("  needLevel = ").append(luaIntOrNil(quest.needLevel)).append(",\n");
    sb.append("  bQLoop = ").append(luaIntOrNil(quest.bqLoop)).append("\n");
    sb.append("}\n");
  }

  private void appendStringArray(StringBuilder sb, List<String> values, int indent) {
    if(values == null || values.isEmpty()) {
      sb.append("{}");
      return;
    }
    String pad = pad(indent);
    String childPad = pad(indent + 2);
    sb.append("{\n");
    for(int i = 0; i < values.size(); i++) {
      sb.append(childPad).append(luaStringOrNil(values.get(i)));
      if(i < values.size() - 1) {
        sb.append(',');
      }
      sb.append("\n");
    }
    sb.append(pad).append("}");
  }

  private void appendIntArray(StringBuilder sb, List<Integer> values, int indent) {
    if(values == null || values.isEmpty()) {
      sb.append("{}");
      return;
    }
    String pad = pad(indent);
    String childPad = pad(indent + 2);
    sb.append("{\n");
    for(int i = 0; i < values.size(); i++) {
      sb.append(childPad).append(luaIntOrNil(values.get(i)));
      if(i < values.size() - 1) {
        sb.append(',');
      }
      sb.append("\n");
    }
    sb.append(pad).append("}");
  }

  private void appendPairArray(StringBuilder sb,
                               List<Pair> values,
                               int indent,
                               String leftKey,
                               String rightKey) {
    if(values == null || values.isEmpty()) {
      sb.append("{}");
      return;
    }

    String pad = pad(indent);
    String childPad = pad(indent + 2);
    sb.append("{\n");
    for(int i = 0; i < values.size(); i++) {
      Pair pair = values.get(i);
      sb.append(childPad)
          .append("{")
          .append(leftKey).append(" = ").append(luaIntOrNil(pair == null ? null : pair.id)).append(", ")
          .append(rightKey).append(" = ").append(luaIntOrNil(pair == null ? null : pair.count))
          .append("}");
      if(i < values.size() - 1) {
        sb.append(',');
      }
      sb.append("\n");
    }
    sb.append(pad).append("}");
  }

  private String pad(int count) {
    StringBuilder sb = new StringBuilder();
    for(int i = 0; i < count; i++) {
      sb.append(' ');
    }
    return sb.toString();
  }

  private String luaIntOrNil(Integer value) {
    return value == null ? "nil" : Integer.toString(value.intValue());
  }

  private String luaStringOrNil(String value) {
    if(value == null) {
      return "nil";
    }
    StringBuilder sb = new StringBuilder();
    sb.append('"');
    for(int i = 0; i < value.length(); i++) {
      char ch = value.charAt(i);
      switch(ch) {
        case '\\':
          sb.append("\\\\");
          break;
        case '"':
          sb.append("\\\"");
          break;
        case '\n':
          sb.append("\\n");
          break;
        case '\r':
          sb.append("\\r");
          break;
        case '\t':
          sb.append("\\t");
          break;
        case '\b':
          sb.append("\\b");
          break;
        case '\f':
          sb.append("\\f");
          break;
        default:
          if(ch < 0x20) {
            sb.append(String.format("\\u%04X", (int) ch));
          } else {
            sb.append(ch);
          }
          break;
      }
    }
    sb.append('"');
    return sb.toString();
  }

  private void ensureParent(Path output) throws Exception {
    if(output.getParent() != null && !Files.exists(output.getParent())) {
      Files.createDirectories(output.getParent());
    }
  }

  private void ensureMysqlDriverAvailable() throws Exception {
    try {
      DriverManager.getDriver(DEFAULT_JDBC);
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
    URLClassLoader loader = new URLClassLoader(new URL[] {url}, Phase4QuestLucExporter.class.getClassLoader());
    Class<?> cls = Class.forName("com.mysql.cj.jdbc.Driver", true, loader);
    Object obj = cls.getDeclaredConstructor().newInstance();
    if(!(obj instanceof Driver)) {
      throw new IllegalStateException("Loaded class is not java.sql.Driver: " + cls.getName());
    }
    DriverManager.registerDriver(new DriverShim((Driver) obj));
  }

  private static final class DriverShim implements Driver {
    private final Driver driver;

    DriverShim(Driver driver) {
      this.driver = driver;
    }

    @Override
    public java.sql.Connection connect(String url, java.util.Properties info) throws java.sql.SQLException {
      return driver.connect(url, info);
    }

    @Override
    public boolean acceptsURL(String url) throws java.sql.SQLException {
      return driver.acceptsURL(url);
    }

    @Override
    public java.sql.DriverPropertyInfo[] getPropertyInfo(String url, java.util.Properties info) throws java.sql.SQLException {
      return driver.getPropertyInfo(url, info);
    }

    @Override
    public int getMajorVersion() {
      return driver.getMajorVersion();
    }

    @Override
    public int getMinorVersion() {
      return driver.getMinorVersion();
    }

    @Override
    public boolean jdbcCompliant() {
      return driver.jdbcCompliant();
    }

    @Override
    public java.util.logging.Logger getParentLogger() throws java.sql.SQLFeatureNotSupportedException {
      return driver.getParentLogger();
    }
  }

  private enum ArrayType {
    CONTENTS,
    ANSWER,
    INFO
  }

  private enum PairType {
    GOAL_GET_ITEM,
    GOAL_KILL_MONSTER,
    REWARD_ITEM
  }

  private static final class Pair {
    Integer id;
    Integer count;
  }

  private static final class QuestRecord {
    int questId;
    String name;
    Integer needLevel;
    Integer bqLoop;
    Integer rewardExp;
    Integer rewardGold;
    final List<String> contents = new ArrayList<String>();
    final List<String> answer = new ArrayList<String>();
    final List<String> info = new ArrayList<String>();
    final List<Pair> goalGetItem = new ArrayList<Pair>();
    final List<Pair> goalKillMonster = new ArrayList<Pair>();
    final List<Integer> goalMeetNpc = new ArrayList<Integer>();
    final List<Pair> rewardItems = new ArrayList<Pair>();
  }

  public static final class ExportResult {
    int questCount;
  }
}
