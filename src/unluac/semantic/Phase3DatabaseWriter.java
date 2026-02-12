package unluac.semantic;

import java.nio.charset.Charset;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.Statement;
import java.time.OffsetDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.LinkedHashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Set;

/**
 * Phase3 入库执行器：将 Phase2/2.5 的 JSON 结果落到 MySQL 结构化表。
 *
 * <p>所属链路：链路 A（luc -> 读取 -> semantic -> 写入 MySQL）。</p>
 * <p>输入：phase2_quest_data.json、phase2_5_quest_npc_dependency_graph.json。</p>
 * <p>输出：phase3_db_insert_summary.json。</p>
 * <p>数据库副作用：会建表、清表并批量写入 quest/npc 关系数据。</p>
 * <p>文件副作用：写出入库统计报告。</p>
 * <p>阶段依赖：依赖 Phase2 和 Phase2.5 的报告格式稳定。</p>
 */
public class Phase3DatabaseWriter {

  private static final Charset UTF8 = Charset.forName("UTF-8");
  private static final String DEFAULT_JDBC = "jdbc:mysql://127.0.0.1:3306/ghost_game"
      + "?useUnicode=true&characterEncoding=utf8&serverTimezone=UTC&useSSL=false&allowPublicKeyRetrieval=true";
  private static final String DEFAULT_USER = "root";
  private static final String DEFAULT_PASSWORD = "root";

  /**
   * CLI 入口。
   *
   * @param args 参数顺序：phase2QuestJson、phase25GraphJson、summaryOutput、jdbcUrl、user、password
   * @throws Exception 输入无效、数据库连接失败或事务执行失败时抛出
   */
  public static void main(String[] args) throws Exception {
    Path phase2QuestJson = args.length >= 1
        ? Paths.get(args[0])
        : Paths.get("reports", "phase2_quest_data.json");
    Path phase25GraphJson = args.length >= 2
        ? Paths.get(args[1])
        : Paths.get("reports", "phase2_5_quest_npc_dependency_graph.json");
    Path summaryOutput = args.length >= 3
        ? Paths.get(args[2])
        : Paths.get("reports", "phase3_db_insert_summary.json");
    String jdbcUrl = args.length >= 4 ? args[3] : DEFAULT_JDBC;
    String user = args.length >= 5 ? args[4] : DEFAULT_USER;
    String password = args.length >= 6 ? args[5] : DEFAULT_PASSWORD;

    long start = System.nanoTime();
    Phase3DatabaseWriter writer = new Phase3DatabaseWriter();
    InsertSummary summary = writer.write(phase2QuestJson, phase25GraphJson, summaryOutput, jdbcUrl, user, password);
    long elapsed = (System.nanoTime() - start) / 1_000_000L;

    System.out.println("phase2QuestJson=" + phase2QuestJson.toAbsolutePath());
    System.out.println("phase25GraphJson=" + phase25GraphJson.toAbsolutePath());
    System.out.println("summaryOutput=" + summaryOutput.toAbsolutePath());
    System.out.println("totalQuestInserted=" + summary.totalQuestInserted);
    System.out.println("totalGoalGetItemRows=" + summary.totalGoalGetItemRows);
    System.out.println("totalGoalKillMonsterRows=" + summary.totalGoalKillMonsterRows);
    System.out.println("totalGoalMeetNpcRows=" + summary.totalGoalMeetNpcRows);
    System.out.println("totalRewardItemRows=" + summary.totalRewardItemRows);
    System.out.println("totalNpcReferenceRows=" + summary.totalNpcReferenceRows);
    System.out.println("insertMillis=" + elapsed);
  }

  /**
   * 执行 Phase3 入库流程（建表 + 清表 + 插入 + 报告）。
   *
   * @param phase2QuestJson Phase2 quest 报告
   * @param phase25GraphJson Phase2.5 依赖图报告
   * @param summaryOutput 入库统计输出文件
   * @param jdbcUrl MySQL 连接串
   * @param user DB 用户名
   * @param password DB 密码
   * @return 入库统计摘要
   * @throws Exception 事务失败时抛出，且会回滚
   * @implNote 副作用：写数据库（覆盖式刷新）与写 summary JSON
   */
  public InsertSummary write(Path phase2QuestJson,
                             Path phase25GraphJson,
                             Path summaryOutput,
                             String jdbcUrl,
                             String user,
                             String password) throws Exception {
    if(phase2QuestJson == null || !Files.exists(phase2QuestJson) || !Files.isRegularFile(phase2QuestJson)) {
      throw new IllegalStateException("phase2_quest_data.json not found: " + phase2QuestJson);
    }
    if(phase25GraphJson == null || !Files.exists(phase25GraphJson) || !Files.isRegularFile(phase25GraphJson)) {
      throw new IllegalStateException("phase2_5_quest_npc_dependency_graph.json not found: " + phase25GraphJson);
    }

    List<QuestRow> quests = parseQuestRows(phase2QuestJson);
    List<NpcQuestReferenceRow> npcReferences = parseNpcQuestReferences(phase25GraphJson);

    long start = System.nanoTime();

    try {
      Class.forName("com.mysql.cj.jdbc.Driver");
    } catch(Throwable ignored) {
    }

    InsertSummary summary = new InsertSummary();
    try(Connection connection = DriverManager.getConnection(jdbcUrl, user, password)) {
      connection.setAutoCommit(false);
      try {
        // 采用“建表 -> 清表 -> 全量写入”固定顺序，确保 DB 始终对应同一批 phase2/2.5 快照。
        createSchema(connection);
        truncateData(connection);
        insertQuestData(connection, quests, summary);
        insertNpcReferences(connection, npcReferences, summary);
        connection.commit();
      } catch(Exception ex) {
        connection.rollback();
        throw ex;
      }
    }

    summary.insertMillis = (System.nanoTime() - start) / 1_000_000L;
    ensureParent(summaryOutput);
    Files.write(summaryOutput, summary.toJson().getBytes(UTF8));
    return summary;
  }

  /**
   * 处理create Schema辅助逻辑。
   * @param connection 方法参数
   * @throws Exception 处理失败时抛出
   */
  private void createSchema(Connection connection) throws Exception {
    List<String> ddl = new ArrayList<String>();
    ddl.add("CREATE TABLE IF NOT EXISTS quest_main ("
        + "quest_id INT NOT NULL PRIMARY KEY,"
        + "name TEXT,"
        + "need_level INT NOT NULL DEFAULT 0,"
        + "bq_loop INT NOT NULL DEFAULT 0,"
        + "reward_exp INT NOT NULL DEFAULT 0,"
        + "reward_gold INT NOT NULL DEFAULT 0"
        + ") ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci");

    ddl.add("CREATE TABLE IF NOT EXISTS quest_contents ("
        + "id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,"
        + "quest_id INT NOT NULL,"
        + "seq_index INT NOT NULL,"
        + "text LONGTEXT,"
        + "UNIQUE KEY uk_quest_contents (quest_id, seq_index),"
        + "KEY idx_quest_contents_quest (quest_id)"
        + ") ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci");

    ddl.add("CREATE TABLE IF NOT EXISTS quest_answer ("
        + "id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,"
        + "quest_id INT NOT NULL,"
        + "seq_index INT NOT NULL,"
        + "text LONGTEXT,"
        + "UNIQUE KEY uk_quest_answer (quest_id, seq_index),"
        + "KEY idx_quest_answer_quest (quest_id)"
        + ") ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci");

    ddl.add("CREATE TABLE IF NOT EXISTS quest_info ("
        + "id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,"
        + "quest_id INT NOT NULL,"
        + "seq_index INT NOT NULL,"
        + "text LONGTEXT,"
        + "UNIQUE KEY uk_quest_info (quest_id, seq_index),"
        + "KEY idx_quest_info_quest (quest_id)"
        + ") ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci");

    ddl.add("CREATE TABLE IF NOT EXISTS quest_goal_getitem ("
        + "id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,"
        + "quest_id INT NOT NULL,"
        + "seq_index INT NOT NULL,"
        + "item_id INT NOT NULL,"
        + "item_count INT NOT NULL,"
        + "UNIQUE KEY uk_goal_getitem (quest_id, seq_index),"
        + "KEY idx_goal_getitem_quest (quest_id)"
        + ") ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci");

    ddl.add("CREATE TABLE IF NOT EXISTS quest_goal_killmonster ("
        + "id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,"
        + "quest_id INT NOT NULL,"
        + "seq_index INT NOT NULL,"
        + "monster_id INT NOT NULL,"
        + "monster_count INT NOT NULL,"
        + "UNIQUE KEY uk_goal_killmonster (quest_id, seq_index),"
        + "KEY idx_goal_killmonster_quest (quest_id)"
        + ") ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci");

    ddl.add("CREATE TABLE IF NOT EXISTS quest_goal_meetnpc ("
        + "id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,"
        + "quest_id INT NOT NULL,"
        + "seq_index INT NOT NULL,"
        + "npc_id INT NOT NULL,"
        + "UNIQUE KEY uk_goal_meetnpc (quest_id, seq_index),"
        + "KEY idx_goal_meetnpc_quest (quest_id)"
        + ") ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci");

    ddl.add("CREATE TABLE IF NOT EXISTS quest_reward_item ("
        + "id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,"
        + "quest_id INT NOT NULL,"
        + "seq_index INT NOT NULL,"
        + "item_id INT NOT NULL,"
        + "item_count INT NOT NULL,"
        + "UNIQUE KEY uk_reward_item (quest_id, seq_index),"
        + "KEY idx_reward_item_quest (quest_id)"
        + ") ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci");

    ddl.add("CREATE TABLE IF NOT EXISTS npc_quest_reference ("
        + "id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,"
        + "npc_file VARCHAR(255) NOT NULL,"
        + "quest_id INT NOT NULL,"
        + "reference_count INT NOT NULL DEFAULT 0,"
        + "goal_access_count INT NOT NULL DEFAULT 0,"
        + "UNIQUE KEY uk_npc_quest_reference (npc_file, quest_id),"
        + "KEY idx_npc_ref_quest (quest_id),"
        + "KEY idx_npc_ref_file (npc_file)"
        + ") ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci");

    try(Statement statement = connection.createStatement()) {
      for(String sql : ddl) {
        statement.execute(sql);
      }
    }
  }

  /**
   * 处理truncate Data辅助逻辑。
   * @param connection 方法参数
   * @throws Exception 处理失败时抛出
   */
  private void truncateData(Connection connection) throws Exception {
    List<String> tables = new ArrayList<String>();
    tables.add("npc_quest_reference");
    tables.add("quest_reward_item");
    tables.add("quest_goal_meetnpc");
    tables.add("quest_goal_killmonster");
    tables.add("quest_goal_getitem");
    tables.add("quest_info");
    tables.add("quest_answer");
    tables.add("quest_contents");
    tables.add("quest_main");

    // Truncate child tables first to keep operations deterministic and avoid
    // transient integrity/order issues in future schema extensions.
    try(Statement statement = connection.createStatement()) {
      for(String table : tables) {
        statement.execute("TRUNCATE TABLE " + table);
      }
    }
  }

  /**
   * 在单事务内写入任务主表、对话数组、目标与奖励。
   */
  private void insertQuestData(Connection connection,
                               List<QuestRow> quests,
                               InsertSummary summary) throws Exception {
    String insertMain = "INSERT INTO quest_main(quest_id, name, need_level, bq_loop, reward_exp, reward_gold) VALUES(?,?,?,?,?,?)";
    String insertContents = "INSERT INTO quest_contents(quest_id, seq_index, text) VALUES(?,?,?)";
    String insertAnswer = "INSERT INTO quest_answer(quest_id, seq_index, text) VALUES(?,?,?)";
    String insertInfo = "INSERT INTO quest_info(quest_id, seq_index, text) VALUES(?,?,?)";
    String insertGoalItem = "INSERT INTO quest_goal_getitem(quest_id, seq_index, item_id, item_count) VALUES(?,?,?,?)";
    String insertGoalKill = "INSERT INTO quest_goal_killmonster(quest_id, seq_index, monster_id, monster_count) VALUES(?,?,?,?)";
    String insertGoalMeet = "INSERT INTO quest_goal_meetnpc(quest_id, seq_index, npc_id) VALUES(?,?,?)";
    String insertRewardItem = "INSERT INTO quest_reward_item(quest_id, seq_index, item_id, item_count) VALUES(?,?,?,?)";

    try(PreparedStatement psMain = connection.prepareStatement(insertMain);
        PreparedStatement psContents = connection.prepareStatement(insertContents);
        PreparedStatement psAnswer = connection.prepareStatement(insertAnswer);
        PreparedStatement psInfo = connection.prepareStatement(insertInfo);
        PreparedStatement psGoalItem = connection.prepareStatement(insertGoalItem);
        PreparedStatement psGoalKill = connection.prepareStatement(insertGoalKill);
        PreparedStatement psGoalMeet = connection.prepareStatement(insertGoalMeet);
        PreparedStatement psRewardItem = connection.prepareStatement(insertRewardItem)) {

      // 按当前数组位置写入 seq_index，保持原始列表顺序。
      for(QuestRow quest : quests) {
        psMain.setInt(1, quest.questId);
        psMain.setString(2, quest.name);
        psMain.setInt(3, quest.needLevel);
        psMain.setInt(4, quest.bqLoop);
        psMain.setInt(5, quest.rewardExp);
        psMain.setInt(6, quest.rewardGold);
        psMain.addBatch();
        summary.totalQuestInserted++;

        for(int i = 0; i < quest.contents.size(); i++) {
          psContents.setInt(1, quest.questId);
          psContents.setInt(2, i);
          psContents.setString(3, quest.contents.get(i));
          psContents.addBatch();
        }

        for(int i = 0; i < quest.answer.size(); i++) {
          psAnswer.setInt(1, quest.questId);
          psAnswer.setInt(2, i);
          psAnswer.setString(3, quest.answer.get(i));
          psAnswer.addBatch();
        }

        for(int i = 0; i < quest.info.size(); i++) {
          psInfo.setInt(1, quest.questId);
          psInfo.setInt(2, i);
          psInfo.setString(3, quest.info.get(i));
          psInfo.addBatch();
        }

        for(int i = 0; i < quest.goalGetItem.size(); i++) {
          IntPair row = quest.goalGetItem.get(i);
          psGoalItem.setInt(1, quest.questId);
          psGoalItem.setInt(2, i);
          psGoalItem.setInt(3, row.left);
          psGoalItem.setInt(4, row.right);
          psGoalItem.addBatch();
          summary.totalGoalGetItemRows++;
        }

        for(int i = 0; i < quest.goalKillMonster.size(); i++) {
          IntPair row = quest.goalKillMonster.get(i);
          psGoalKill.setInt(1, quest.questId);
          psGoalKill.setInt(2, i);
          psGoalKill.setInt(3, row.left);
          psGoalKill.setInt(4, row.right);
          psGoalKill.addBatch();
          summary.totalGoalKillMonsterRows++;
        }

        for(int i = 0; i < quest.goalMeetNpc.size(); i++) {
          psGoalMeet.setInt(1, quest.questId);
          psGoalMeet.setInt(2, i);
          psGoalMeet.setInt(3, quest.goalMeetNpc.get(i).intValue());
          psGoalMeet.addBatch();
          summary.totalGoalMeetNpcRows++;
        }

        for(int i = 0; i < quest.rewardItems.size(); i++) {
          IntPair row = quest.rewardItems.get(i);
          psRewardItem.setInt(1, quest.questId);
          psRewardItem.setInt(2, i);
          psRewardItem.setInt(3, row.left);
          psRewardItem.setInt(4, row.right);
          psRewardItem.addBatch();
          summary.totalRewardItemRows++;
        }
      }

      psMain.executeBatch();
      psContents.executeBatch();
      psAnswer.executeBatch();
      psInfo.executeBatch();
      psGoalItem.executeBatch();
      psGoalKill.executeBatch();
      psGoalMeet.executeBatch();
      psRewardItem.executeBatch();
    }
  }

  /**
   * 写入 NPC-任务引用索引行。
   */
  private void insertNpcReferences(Connection connection,
                                   List<NpcQuestReferenceRow> references,
                                   InsertSummary summary) throws Exception {
    String sql = "INSERT INTO npc_quest_reference(npc_file, quest_id, reference_count, goal_access_count) VALUES(?,?,?,?)";
    try(PreparedStatement ps = connection.prepareStatement(sql)) {
      for(NpcQuestReferenceRow row : references) {
        ps.setString(1, row.npcFile);
        ps.setInt(2, row.questId);
        ps.setInt(3, row.referenceCount);
        ps.setInt(4, row.goalAccessCount);
        ps.addBatch();
        summary.totalNpcReferenceRows++;
      }
      ps.executeBatch();
    }
  }

  /**
   * 解析来源数据。
   * @param phase2QuestJson 方法参数
   * @return 计算结果
   * @throws Exception 处理失败时抛出
   */
  private List<QuestRow> parseQuestRows(Path phase2QuestJson) throws Exception {
    String text = new String(Files.readAllBytes(phase2QuestJson), UTF8);
    Map<String, Object> root = QuestSemanticJson.parseObject(text, "phase2_quest_data", 0);
    Object questsObj = root.get("quests");
    if(!(questsObj instanceof List<?>)) {
      throw new IllegalStateException("phase2_quest_data.quests must be array");
    }

    List<QuestRow> out = new ArrayList<QuestRow>();
    @SuppressWarnings("unchecked")
    List<Object> quests = (List<Object>) questsObj;
    for(Object item : quests) {
      if(!(item instanceof Map<?, ?>)) {
        continue;
      }
      @SuppressWarnings("unchecked")
      Map<String, Object> map = (Map<String, Object>) item;

      QuestRow row = new QuestRow();
      row.questId = intOf(map.get("questId"));
      if(row.questId <= 0) {
        continue;
      }
      row.name = safe(map.get("name"));
      row.needLevel = intOf(map.get("needLevel"));
      row.bqLoop = intOf(map.get("bQLoop"));

      row.contents.addAll(asStringList(map.get("contents")));
      row.answer.addAll(asStringList(map.get("answer")));
      row.info.addAll(asStringList(map.get("info")));

      Map<String, Object> goal = asMap(map.get("goal"));
      for(IntPair pair : asPairList(goal.get("getItem"), "id", "count")) {
        row.goalGetItem.add(pair);
      }
      for(IntPair pair : asPairList(goal.get("killMonster"), "id", "count")) {
        row.goalKillMonster.add(pair);
      }
      row.goalMeetNpc.addAll(asIntList(goal.get("meetNpc")));

      Map<String, Object> reward = asMap(map.get("reward"));
      row.rewardExp = intOf(reward.get("exp"));
      row.rewardGold = intOf(reward.get("gold"));
      for(IntPair pair : asPairList(reward.get("items"), "id", "count")) {
        row.rewardItems.add(pair);
      }

      out.add(row);
    }

    Collections.sort(out, (left, right) -> Integer.compare(left.questId, right.questId));
    return out;
  }

  /**
   * 解析来源数据。
   * @param phase25GraphJson 方法参数
   * @return 计算结果
   * @throws Exception 处理失败时抛出
   */
  private List<NpcQuestReferenceRow> parseNpcQuestReferences(Path phase25GraphJson) throws Exception {
    String text = new String(Files.readAllBytes(phase25GraphJson), UTF8);
    Map<String, Object> root = QuestSemanticJson.parseObject(text, "phase2_5_quest_npc_dependency_graph", 0);
    Object edgesObj = root.get("edges");
    if(!(edgesObj instanceof List<?>)) {
      return Collections.emptyList();
    }

    Map<String, NpcQuestReferenceRow> grouped = new LinkedHashMap<String, NpcQuestReferenceRow>();

    @SuppressWarnings("unchecked")
    List<Object> edges = (List<Object>) edgesObj;
    for(Object edgeObj : edges) {
      if(!(edgeObj instanceof Map<?, ?>)) {
        continue;
      }
      @SuppressWarnings("unchecked")
      Map<String, Object> edge = (Map<String, Object>) edgeObj;
      String npcFile = safe(edge.get("from"));
      int questId = parseQuestId(edge.get("to"));
      String accessType = safe(edge.get("accessType"));

      if(npcFile.isEmpty() || questId <= 0) {
        continue;
      }

      String key = npcFile + "#" + questId;
      NpcQuestReferenceRow row = grouped.get(key);
      if(row == null) {
        row = new NpcQuestReferenceRow();
        row.npcFile = npcFile;
        row.questId = questId;
        grouped.put(key, row);
      }
      row.referenceCount++;
      if(isGoalAccessType(accessType)) {
        row.goalAccessCount++;
      }
    }

    List<NpcQuestReferenceRow> out = new ArrayList<NpcQuestReferenceRow>(grouped.values());
    Collections.sort(out, (left, right) -> {
      int cmp = left.npcFile.compareToIgnoreCase(right.npcFile);
      if(cmp != 0) {
        return cmp;
      }
      return Integer.compare(left.questId, right.questId);
    });
    return out;
  }

  /**
   * 计算并返回结果。
   * @param accessType 方法参数
   * @return 计算结果
   */
  private boolean isGoalAccessType(String accessType) {
    if(accessType == null) {
      return false;
    }
    String normalized = accessType.trim().toLowerCase(Locale.ROOT);
    return "getitem".equals(normalized)
        || "killmonster".equals(normalized)
        || "meetnpc".equals(normalized)
        || normalized.startsWith("goal.");
  }

  /**
   * 解析来源数据。
   * @param toValue 方法参数
   * @return 计算结果
   */
  private int parseQuestId(Object toValue) {
    String text = safe(toValue);
    if(text.isEmpty()) {
      return 0;
    }
    if(text.startsWith("quest_")) {
      return parseIntSafe(text.substring("quest_".length()));
    }
    return parseIntSafe(text);
  }

  /**
   * 计算并返回结果。
   * @param value 方法参数
   * @return 计算结果
   */
  private List<String> asStringList(Object value) {
    List<String> out = new ArrayList<String>();
    if(!(value instanceof List<?>)) {
      return out;
    }
    @SuppressWarnings("unchecked")
    List<Object> list = (List<Object>) value;
    for(Object item : list) {
      out.add(safe(item));
    }
    return out;
  }

  /**
   * 计算并返回结果。
   * @param value 方法参数
   * @return 计算结果
   */
  private List<Integer> asIntList(Object value) {
    List<Integer> out = new ArrayList<Integer>();
    if(!(value instanceof List<?>)) {
      return out;
    }
    @SuppressWarnings("unchecked")
    List<Object> list = (List<Object>) value;
    for(Object item : list) {
      out.add(Integer.valueOf(intOf(item)));
    }
    return out;
  }

  /**
   * 计算并返回结果。
   * @param value 方法参数
   * @param leftKey 方法参数
   * @param rightKey 方法参数
   * @return 计算结果
   */
  private List<IntPair> asPairList(Object value, String leftKey, String rightKey) {
    List<IntPair> out = new ArrayList<IntPair>();
    if(!(value instanceof List<?>)) {
      return out;
    }
    @SuppressWarnings("unchecked")
    List<Object> list = (List<Object>) value;
    for(Object item : list) {
      if(!(item instanceof Map<?, ?>)) {
        continue;
      }
      @SuppressWarnings("unchecked")
      Map<String, Object> map = (Map<String, Object>) item;
      IntPair pair = new IntPair();
      pair.left = intOf(map.get(leftKey));
      pair.right = intOf(map.get(rightKey));
      out.add(pair);
    }
    return out;
  }

  @SuppressWarnings("unchecked")
  /**
   * 计算并返回结果。
   * @param value 方法参数
   * @return 计算结果
   */
  private Map<String, Object> asMap(Object value) {
    if(value instanceof Map<?, ?>) {
      return (Map<String, Object>) value;
    }
    return Collections.emptyMap();
  }

  /**
   * 计算并返回结果。
   * @param value 方法参数
   * @return 计算结果
   */
  private int intOf(Object value) {
    if(value == null) {
      return 0;
    }
    if(value instanceof Number) {
      return ((Number) value).intValue();
    }
    return parseIntSafe(safe(value));
  }

  /**
   * 解析来源数据。
   * @param text 方法参数
   * @return 计算结果
   */
  private int parseIntSafe(String text) {
    if(text == null) {
      return 0;
    }
    String value = text.trim();
    if(value.isEmpty()) {
      return 0;
    }
    try {
      return Integer.parseInt(value);
    } catch(Exception ex) {
      return 0;
    }
  }

  /**
   * 计算并返回结果。
   * @param value 方法参数
   * @return 计算结果
   */
  private String safe(Object value) {
    return value == null ? "" : String.valueOf(value);
  }

  /**
   * 确保前置条件满足。
   * @param file 方法参数
   * @throws Exception 处理失败时抛出
   */
  private void ensureParent(Path file) throws Exception {
    if(file.getParent() != null && !Files.exists(file.getParent())) {
      Files.createDirectories(file.getParent());
    }
  }

  private static final class QuestRow {
    int questId;
    String name = "";
    int needLevel;
    int bqLoop;
    int rewardExp;
    int rewardGold;
    final List<String> contents = new ArrayList<String>();
    final List<String> answer = new ArrayList<String>();
    final List<String> info = new ArrayList<String>();
    final List<IntPair> goalGetItem = new ArrayList<IntPair>();
    final List<IntPair> goalKillMonster = new ArrayList<IntPair>();
    final List<Integer> goalMeetNpc = new ArrayList<Integer>();
    final List<IntPair> rewardItems = new ArrayList<IntPair>();
  }

  private static final class IntPair {
    int left;
    int right;
  }

  private static final class NpcQuestReferenceRow {
    String npcFile = "";
    int questId;
    int referenceCount;
    int goalAccessCount;
  }

  public static final class InsertSummary {
    int totalQuestInserted;
    int totalGoalGetItemRows;
    int totalGoalKillMonsterRows;
    int totalGoalMeetNpcRows;
    int totalRewardItemRows;
    int totalNpcReferenceRows;
    long insertMillis;

    String toJson() {
      StringBuilder sb = new StringBuilder();
      sb.append("{\n");
      sb.append("  \"generatedAt\": ").append(QuestSemanticJson.jsonString(OffsetDateTime.now().format(DateTimeFormatter.ISO_OFFSET_DATE_TIME))).append(",\n");
      sb.append("  \"totalQuestInserted\": ").append(totalQuestInserted).append(",\n");
      sb.append("  \"totalGoalGetItemRows\": ").append(totalGoalGetItemRows).append(",\n");
      sb.append("  \"totalGoalKillMonsterRows\": ").append(totalGoalKillMonsterRows).append(",\n");
      sb.append("  \"totalGoalMeetNpcRows\": ").append(totalGoalMeetNpcRows).append(",\n");
      sb.append("  \"totalRewardItemRows\": ").append(totalRewardItemRows).append(",\n");
      sb.append("  \"totalNpcReferenceRows\": ").append(totalNpcReferenceRows).append(",\n");
      sb.append("  \"insertMillis\": ").append(insertMillis).append("\n");
      sb.append("}\n");
      return sb.toString();
    }
  }
}
