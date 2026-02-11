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
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * Phase5 导出器：基于 DB 快照重建 NPC 脚本文本（Lua）。
 *
 * <p>所属链路：链路 B（DB -> semantic model -> 导出 lua -> 导出 luc -> 客户端读取）的 NPC 分支。</p>
 * <p>输入：phase2_npc_reference_index.json + MySQL quest/npc 关系数据。</p>
 * <p>输出：`reports/phase5_exported_npc/*.lua` 及导出摘要。</p>
 * <p>数据库副作用：无（只读）。</p>
 * <p>文件副作用：创建/覆盖 NPC 导出目录与 summary JSON。</p>
 * <p>阶段依赖：依赖 Phase3 入库表完整性与 phase2 索引文件一致性。</p>
 */
public class Phase5NpcLucExporter {

  private static final Charset UTF8 = Charset.forName("UTF-8");
  private static final String DEFAULT_JDBC = "jdbc:mysql://127.0.0.1:3306/ghost_game"
      + "?useUnicode=true&characterEncoding=utf8&serverTimezone=UTC&useSSL=false&allowPublicKeyRetrieval=true";
  private static final String DEFAULT_USER = "root";
  private static final String DEFAULT_PASSWORD = "root";

  /**
   * CLI 入口。
   *
   * @param args 参数顺序：phase2NpcIndex、outputDir、summaryOutput、jdbcUrl、user、password
   * @throws Exception 输入、DB 或导出失败时抛出
   */
  public static void main(String[] args) throws Exception {
    Path phase2NpcIndex = args.length >= 1
        ? Paths.get(args[0])
        : Paths.get("reports", "phase2_npc_reference_index.json");
    Path outputDir = args.length >= 2
        ? Paths.get(args[1])
        : Paths.get("reports", "phase5_exported_npc");
    Path summaryOutput = args.length >= 3
        ? Paths.get(args[2])
        : Paths.get("reports", "phase5_export_summary.json");
    String jdbcUrl = args.length >= 4 ? args[3] : DEFAULT_JDBC;
    String user = args.length >= 5 ? args[4] : DEFAULT_USER;
    String password = args.length >= 6 ? args[5] : DEFAULT_PASSWORD;

    long start = System.nanoTime();
    Phase5NpcLucExporter exporter = new Phase5NpcLucExporter();
    ExportSummary summary = exporter.export(phase2NpcIndex, outputDir, summaryOutput, jdbcUrl, user, password);
    long elapsed = (System.nanoTime() - start) / 1_000_000L;

    System.out.println("phase2NpcIndex=" + phase2NpcIndex.toAbsolutePath());
    System.out.println("outputDir=" + outputDir.toAbsolutePath());
    System.out.println("summaryOutput=" + summaryOutput.toAbsolutePath());
    System.out.println("sourceNpcDir=" + summary.sourceNpcDir);
    System.out.println("expectedNpcFiles=" + summary.expectedNpcFiles);
    System.out.println("exportedNpcFiles=" + summary.exportedNpcFiles);
    System.out.println("missingNpcFiles=" + summary.missingNpcFiles.size());
    System.out.println("exportMillis=" + elapsed);
  }

  /**
   * 执行 Phase5 导出（DB -> NPC Lua）。
   *
   * @param phase2NpcIndex phase2 npc 索引文件
   * @param outputDir 导出目录
   * @param summaryOutput 汇总报告路径
   * @param jdbcUrl DB 连接串
   * @param user DB 用户
   * @param password DB 密码
   * @return 导出摘要
   * @throws Exception 数据源不完整或 I/O 失败时抛出
   * @implNote 副作用：写导出目录与 summary 报告
   */
  public ExportSummary export(Path phase2NpcIndex,
                              Path outputDir,
                              Path summaryOutput,
                              String jdbcUrl,
                              String user,
                              String password) throws Exception {
    if(phase2NpcIndex == null || !Files.exists(phase2NpcIndex) || !Files.isRegularFile(phase2NpcIndex)) {
      throw new IllegalStateException("phase2_npc_reference_index.json not found: " + phase2NpcIndex);
    }

    Map<String, Object> npcIndex = readJsonObject(phase2NpcIndex, "phase2_npc_reference_index");
    Set<String> expectedFiles = extractExpectedNpcFiles(npcIndex);
    if(expectedFiles.isEmpty()) {
      throw new IllegalStateException("No npc files found from phase2 index");
    }

    ensureMysqlDriverAvailable();
    DbSnapshot db = loadDbSnapshot(jdbcUrl, user, password);
    validateDbConsistency(db);
    Map<Integer, QuestDbModel> quests = loadQuestModels(jdbcUrl, user, password);

    if(!Files.exists(outputDir)) {
      Files.createDirectories(outputDir);
    }

    List<String> sortedFiles = new ArrayList<String>(expectedFiles);
    Collections.sort(sortedFiles, String.CASE_INSENSITIVE_ORDER);

    ExportSummary summary = new ExportSummary();
    summary.generatedAt = OffsetDateTime.now().format(DateTimeFormatter.ISO_OFFSET_DATE_TIME);
    summary.sourceNpcDir = "DB_DRIVEN_GENERATION";
    summary.outputDir = outputDir.toAbsolutePath().toString();
    summary.expectedNpcFiles = sortedFiles.size();
    summary.dbQuestCount = db.questIds.size();
    summary.dbNpcReferenceRows = db.npcReferenceRows;
    summary.dbOrphanReferenceRows = db.orphanReferenceRows;
    summary.dbGoalGetItemRows = db.goalGetItemRows;
    summary.dbGoalKillMonsterRows = db.goalKillMonsterRows;
    summary.dbGoalMeetNpcRows = db.goalMeetNpcRows;
    summary.dbRewardItemRows = db.rewardItemRows;

    Map<String, Set<Integer>> questsByNpc = buildNpcQuestMap(db.references);

    long start = System.nanoTime();
    // 逐文件写出而非增量 patch，确保每次导出都是同一份 DB 快照的确定性结果。
    for(String relative : sortedFiles) {
      Path dst = outputDir.resolve(relative);
      ensureParent(dst);
      String content = buildNpcLua(relative, questsByNpc.get(relative), quests);
      Files.write(dst, content.getBytes(UTF8));
      summary.exportedNpcFiles++;
    }
    summary.exportMillis = (System.nanoTime() - start) / 1_000_000L;

    ensureParent(summaryOutput);
    Files.write(summaryOutput, summary.toJson().getBytes(UTF8));
    return summary;
  }

  private Set<String> extractExpectedNpcFiles(Map<String, Object> npcIndex) {
    Set<String> files = new LinkedHashSet<String>();
    Object byNpcObj = npcIndex.get("byNpcFile");
    if(byNpcObj instanceof Map<?, ?>) {
      @SuppressWarnings("unchecked")
      Map<String, Object> byNpc = (Map<String, Object>) byNpcObj;
      for(String key : byNpc.keySet()) {
        String file = normalizePath(key);
        if(isNpcLua(file)) {
          files.add(file);
        }
      }
    }
    int declaredTotal = intOf(npcIndex.get("totalNpcFiles"));
    if(declaredTotal > 0 && files.size() < declaredTotal) {
      throw new IllegalStateException("Expected npc files less than totalNpcFiles: " + files.size() + " < " + declaredTotal);
    }
    return files;
  }

  private boolean isNpcLua(String relativePath) {
    if(relativePath == null) {
      return false;
    }
    String lower = relativePath.toLowerCase();
    return lower.startsWith("npc_") && lower.endsWith(".lua");
  }

  private DbSnapshot loadDbSnapshot(String jdbcUrl,
                                    String user,
                                    String password) throws Exception {
    DbSnapshot out = new DbSnapshot();
    try(Connection connection = DriverManager.getConnection(jdbcUrl, user, password)) {
      out.questIds.addAll(queryIntSet(connection, "SELECT quest_id FROM quest_main"));
      out.goalGetItemRows = queryCount(connection, "SELECT COUNT(*) FROM quest_goal_getitem");
      out.goalKillMonsterRows = queryCount(connection, "SELECT COUNT(*) FROM quest_goal_killmonster");
      out.goalMeetNpcRows = queryCount(connection, "SELECT COUNT(*) FROM quest_goal_meetnpc");
      out.rewardItemRows = queryCount(connection, "SELECT COUNT(*) FROM quest_reward_item");

      String refSql = "SELECT npc_file, quest_id, reference_count, goal_access_count FROM npc_quest_reference";
      try(PreparedStatement ps = connection.prepareStatement(refSql);
          ResultSet rs = ps.executeQuery()) {
        while(rs.next()) {
          NpcRefRow row = new NpcRefRow();
          row.npcFile = normalizePath(safe(rs.getString("npc_file")));
          row.questId = rs.getInt("quest_id");
          row.referenceCount = rs.getInt("reference_count");
          row.goalAccessCount = rs.getInt("goal_access_count");
          out.references.add(row);
        }
      }
      out.npcReferenceRows = out.references.size();
    }
    return out;
  }

  private Map<Integer, QuestDbModel> loadQuestModels(String jdbcUrl,
                                                     String user,
                                                     String password) throws Exception {
    Map<Integer, QuestDbModel> out = new LinkedHashMap<Integer, QuestDbModel>();
    try(Connection connection = DriverManager.getConnection(jdbcUrl, user, password)) {
      String sqlMain = "SELECT quest_id, name, need_level, bq_loop FROM quest_main";
      try(PreparedStatement ps = connection.prepareStatement(sqlMain);
          ResultSet rs = ps.executeQuery()) {
        while(rs.next()) {
          QuestDbModel model = new QuestDbModel();
          model.questId = rs.getInt("quest_id");
          model.name = safe(rs.getString("name"));
          model.needLevel = rs.getInt("need_level");
          model.bqLoop = rs.getInt("bq_loop");
          out.put(Integer.valueOf(model.questId), model);
        }
      }

      String sqlContent = "SELECT quest_id, seq_index, text FROM quest_contents ORDER BY quest_id ASC, seq_index ASC";
      try(PreparedStatement ps = connection.prepareStatement(sqlContent);
          ResultSet rs = ps.executeQuery()) {
        while(rs.next()) {
          int questId = rs.getInt("quest_id");
          QuestDbModel model = out.get(Integer.valueOf(questId));
          if(model != null) {
            model.contents.add(safe(rs.getString("text")));
          }
        }
      }

      String sqlReward = "SELECT quest_id, seq_index, item_id, item_count FROM quest_reward_item ORDER BY quest_id ASC, seq_index ASC";
      try(PreparedStatement ps = connection.prepareStatement(sqlReward);
          ResultSet rs = ps.executeQuery()) {
        while(rs.next()) {
          int questId = rs.getInt("quest_id");
          QuestDbModel model = out.get(Integer.valueOf(questId));
          if(model != null) {
            RewardItemDb item = new RewardItemDb();
            item.itemId = rs.getInt("item_id");
            item.itemCount = rs.getInt("item_count");
            model.rewardItems.add(item);
          }
        }
      }
    }
    return out;
  }

  private Map<String, Set<Integer>> buildNpcQuestMap(List<NpcRefRow> rows) {
    Map<String, Set<Integer>> out = new LinkedHashMap<String, Set<Integer>>();
    for(NpcRefRow row : rows) {
      if(row.npcFile == null || row.npcFile.isEmpty() || row.questId <= 0) {
        continue;
      }
      Set<Integer> questIds = out.get(row.npcFile);
      if(questIds == null) {
        questIds = new LinkedHashSet<Integer>();
        out.put(row.npcFile, questIds);
      }
      questIds.add(Integer.valueOf(row.questId));
    }
    return out;
  }

  private String buildNpcLua(String file,
                             Set<Integer> questIds,
                             Map<Integer, QuestDbModel> quests) {
    StringBuilder sb = new StringBuilder(1024);
    String npcId = file;
    if(npcId.endsWith(".lua")) {
      npcId = npcId.substring(0, npcId.length() - 4);
    }

    sb.append("-- DB_DRIVEN_EXPORT\n");
    sb.append("-- source: ").append(file).append("\n");
    sb.append("function npcsay(msg)\n");
    sb.append("  return msg\n");
    sb.append("end\n\n");
    sb.append("function chkQState(qData, qt)\n");
    sb.append("  local npc = ").append(QuestSemanticJson.jsonString(npcId)).append("\n");
    sb.append("  local refs = {}\n");

    List<Integer> sorted = new ArrayList<Integer>();
    if(questIds != null) {
      sorted.addAll(questIds);
    }
    Collections.sort(sorted);
    for(Integer questIdObj : sorted) {
      int questId = questIdObj.intValue();
      QuestDbModel model = quests.get(Integer.valueOf(questId));
      if(model == null) {
        continue;
      }
      String name = model.name;
      String firstContent = model.contents.isEmpty() ? "" : model.contents.get(0);
      int rewardCount = model.rewardItems.isEmpty() ? 0 : model.rewardItems.get(0).itemCount;
      sb.append("  refs[").append(questId).append("] = {\n");
      sb.append("    name = ").append(QuestSemanticJson.jsonString(name)).append(",\n");
      sb.append("    content0 = ").append(QuestSemanticJson.jsonString(firstContent)).append(",\n");
      sb.append("    reward0_count = ").append(rewardCount).append(",\n");
      sb.append("    needLevel = ").append(model.needLevel).append(",\n");
      sb.append("    bQLoop = ").append(model.bqLoop).append("\n");
      sb.append("  }\n");
    }

    sb.append("  return refs\n");
    sb.append("end\n");
    return sb.toString();
  }

  private int queryCount(Connection connection, String sql) throws Exception {
    try(PreparedStatement ps = connection.prepareStatement(sql);
        ResultSet rs = ps.executeQuery()) {
      if(rs.next()) {
        return rs.getInt(1);
      }
    }
    return 0;
  }

  private Set<Integer> queryIntSet(Connection connection, String sql) throws Exception {
    Set<Integer> out = new LinkedHashSet<Integer>();
    try(PreparedStatement ps = connection.prepareStatement(sql);
        ResultSet rs = ps.executeQuery()) {
      while(rs.next()) {
        out.add(Integer.valueOf(rs.getInt(1)));
      }
    }
    return out;
  }

  private void validateDbConsistency(DbSnapshot db) {
    if(db.questIds.isEmpty()) {
      throw new IllegalStateException("quest_main has no data");
    }
    int orphan = 0;
    for(NpcRefRow row : db.references) {
      if(!db.questIds.contains(Integer.valueOf(row.questId))) {
        orphan++;
      }
    }
    db.orphanReferenceRows = orphan;
  }

  private Map<String, Object> readJsonObject(Path path, String field) throws Exception {
    String json = new String(Files.readAllBytes(path), UTF8);
    return QuestSemanticJson.parseObject(json, field, 0);
  }

  private void ensureParent(Path file) throws Exception {
    if(file.getParent() != null && !Files.exists(file.getParent())) {
      Files.createDirectories(file.getParent());
    }
  }

  private String normalizePath(String path) {
    if(path == null) {
      return "";
    }
    return path.replace('\\', '/').trim();
  }

  private int intOf(Object value) {
    if(value == null) {
      return 0;
    }
    if(value instanceof Number) {
      return ((Number) value).intValue();
    }
    try {
      return Integer.parseInt(String.valueOf(value).trim());
    } catch(Exception ex) {
      return 0;
    }
  }

  private String safe(Object value) {
    return value == null ? "" : String.valueOf(value);
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
    URLClassLoader loader = new URLClassLoader(new URL[] {url}, Phase5NpcLucExporter.class.getClassLoader());
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
    public Connection connect(String url, java.util.Properties info) throws java.sql.SQLException {
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

  private static final class NpcRefRow {
    String npcFile = "";
    int questId;
    int referenceCount;
    int goalAccessCount;
  }

  private static final class RewardItemDb {
    int itemId;
    int itemCount;
  }

  private static final class QuestDbModel {
    int questId;
    String name = "";
    int needLevel;
    int bqLoop;
    final List<String> contents = new ArrayList<String>();
    final List<RewardItemDb> rewardItems = new ArrayList<RewardItemDb>();
  }

  private static final class DbSnapshot {
    final Set<Integer> questIds = new LinkedHashSet<Integer>();
    int goalGetItemRows;
    int goalKillMonsterRows;
    int goalMeetNpcRows;
    int rewardItemRows;
    int npcReferenceRows;
    int orphanReferenceRows;
    final List<NpcRefRow> references = new ArrayList<NpcRefRow>();
  }

  public static final class ExportSummary {
    String generatedAt = "";
    String sourceNpcDir = "";
    String outputDir = "";
    int expectedNpcFiles;
    int exportedNpcFiles;
    final List<String> missingNpcFiles = new ArrayList<String>();

    int dbQuestCount;
    int dbGoalGetItemRows;
    int dbGoalKillMonsterRows;
    int dbGoalMeetNpcRows;
    int dbRewardItemRows;
    int dbNpcReferenceRows;
    int dbOrphanReferenceRows;
    long exportMillis;

    String toJson() {
      StringBuilder sb = new StringBuilder();
      sb.append("{\n");
      sb.append("  \"generatedAt\": ").append(QuestSemanticJson.jsonString(generatedAt)).append(",\n");
      sb.append("  \"sourceNpcDir\": ").append(QuestSemanticJson.jsonString(sourceNpcDir)).append(",\n");
      sb.append("  \"outputDir\": ").append(QuestSemanticJson.jsonString(outputDir)).append(",\n");
      sb.append("  \"expectedNpcFiles\": ").append(expectedNpcFiles).append(",\n");
      sb.append("  \"exportedNpcFiles\": ").append(exportedNpcFiles).append(",\n");
      sb.append("  \"missingNpcFiles\": ").append(QuestSemanticJson.toJsonArrayString(missingNpcFiles)).append(",\n");
      sb.append("  \"dbQuestCount\": ").append(dbQuestCount).append(",\n");
      sb.append("  \"dbGoalGetItemRows\": ").append(dbGoalGetItemRows).append(",\n");
      sb.append("  \"dbGoalKillMonsterRows\": ").append(dbGoalKillMonsterRows).append(",\n");
      sb.append("  \"dbGoalMeetNpcRows\": ").append(dbGoalMeetNpcRows).append(",\n");
      sb.append("  \"dbRewardItemRows\": ").append(dbRewardItemRows).append(",\n");
      sb.append("  \"dbNpcReferenceRows\": ").append(dbNpcReferenceRows).append(",\n");
      sb.append("  \"dbOrphanReferenceRows\": ").append(dbOrphanReferenceRows).append(",\n");
      sb.append("  \"exportMillis\": ").append(exportMillis).append("\n");
      sb.append("}\n");
      return sb.toString();
    }
  }
}
