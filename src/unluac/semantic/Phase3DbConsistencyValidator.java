package unluac.semantic;

import java.nio.charset.Charset;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Connection;
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
 * Phase3 回写一致性校验器：验证 DB 数据能否无损还原 Phase2 结构。
 *
 * <p>所属链路：链路 A（写库后质量门禁）。</p>
 * <p>输入：phase2_quest_data.json + MySQL quest 相关表。</p>
 * <p>输出：phase3_db_roundtrip_validation.json。</p>
 * <p>数据库副作用：无（只读）。</p>
 * <p>文件副作用：写校验报告。</p>
 */
public class Phase3DbConsistencyValidator {

  private static final Charset UTF8 = Charset.forName("UTF-8");
  private static final String DEFAULT_JDBC = "jdbc:mysql://127.0.0.1:3306/ghost_game"
      + "?useUnicode=true&characterEncoding=utf8&serverTimezone=UTC&useSSL=false&allowPublicKeyRetrieval=true";
  private static final String DEFAULT_USER = "root";
  private static final String DEFAULT_PASSWORD = "root";

  /**
   * 命令行入口。
   * @param args 方法参数
   * @throws Exception 处理失败时抛出
   */
  public static void main(String[] args) throws Exception {
    Path phase2QuestJson = args.length >= 1
        ? Paths.get(args[0])
        : Paths.get("reports", "phase2_quest_data.json");
    Path output = args.length >= 2
        ? Paths.get(args[1])
        : Paths.get("reports", "phase3_db_roundtrip_validation.json");
    String jdbcUrl = args.length >= 3 ? args[2] : DEFAULT_JDBC;
    String user = args.length >= 4 ? args[3] : DEFAULT_USER;
    String password = args.length >= 5 ? args[4] : DEFAULT_PASSWORD;

    Phase3DbConsistencyValidator validator = new Phase3DbConsistencyValidator();
    ValidationReport report = validator.validate(phase2QuestJson, output, jdbcUrl, user, password);

    System.out.println("totalComparedQuests=" + report.totalComparedQuests);
    System.out.println("mismatchCount=" + report.mismatchCount);
    System.out.println("finalStatus=" + report.finalStatus);
    System.out.println("output=" + output.toAbsolutePath());
  }

  /**
   * 比对 phase2 JSON 与 DB 读回结果。
   *
   * @param phase2QuestJson phase2 任务报告
   * @param output 输出报告文件
   * @param jdbcUrl DB 连接串
   * @param user DB 用户
   * @param password DB 密码
   * @return 校验报告
   * @throws Exception 输入/查询/写报告失败时抛出
   */
  public ValidationReport validate(Path phase2QuestJson,
                                   Path output,
                                   String jdbcUrl,
                                   String user,
                                   String password) throws Exception {
    if(phase2QuestJson == null || !Files.exists(phase2QuestJson) || !Files.isRegularFile(phase2QuestJson)) {
      throw new IllegalStateException("phase2_quest_data.json not found: " + phase2QuestJson);
    }

    List<QuestRow> expected = parseQuestRows(phase2QuestJson);
    Map<Integer, QuestRow> actualByQuestId = readFromDb(jdbcUrl, user, password);

    ValidationReport report = new ValidationReport();
    report.totalComparedQuests = expected.size();

    for(QuestRow row : expected) {
      QuestRow actual = actualByQuestId.get(Integer.valueOf(row.questId));
      if(actual == null) {
        report.mismatchDetails.add("questId=" + row.questId + " missing in DB");
        continue;
      }

      compareField(report, row.questId, "name", row.name, actual.name);
      compareField(report, row.questId, "needLevel", Integer.valueOf(row.needLevel), Integer.valueOf(actual.needLevel));
      compareField(report, row.questId, "bqLoop", Integer.valueOf(row.bqLoop), Integer.valueOf(actual.bqLoop));
      compareField(report, row.questId, "rewardExp", Integer.valueOf(row.rewardExp), Integer.valueOf(actual.rewardExp));
      compareField(report, row.questId, "rewardGold", Integer.valueOf(row.rewardGold), Integer.valueOf(actual.rewardGold));

      compareStringList(report, row.questId, "contents", row.contents, actual.contents);
      compareStringList(report, row.questId, "answer", row.answer, actual.answer);
      compareStringList(report, row.questId, "info", row.info, actual.info);

      comparePairList(report, row.questId, "goal.getItem", row.goalGetItem, actual.goalGetItem);
      comparePairList(report, row.questId, "goal.killMonster", row.goalKillMonster, actual.goalKillMonster);
      compareIntList(report, row.questId, "goal.meetNpc", row.goalMeetNpc, actual.goalMeetNpc);
      comparePairList(report, row.questId, "reward.items", row.rewardItems, actual.rewardItems);
    }

    report.mismatchCount = report.mismatchDetails.size();
    report.finalStatus = report.mismatchCount == 0 ? "SAFE" : "UNSAFE";

    ensureParent(output);
    Files.write(output, report.toJson().getBytes(UTF8));

    if(report.mismatchCount > 0) {
      throw new IllegalStateException("Phase3 DB roundtrip mismatch detected: " + report.mismatchCount);
    }
    return report;
  }

  /**
   * Read quest-related tables and reconstruct quest model from DB.
   */
  private Map<Integer, QuestRow> readFromDb(String jdbcUrl,
                                            String user,
                                            String password) throws Exception {
    try {
      Class.forName("com.mysql.cj.jdbc.Driver");
    } catch(Throwable ignored) {
    }

    Map<Integer, QuestRow> out = new LinkedHashMap<Integer, QuestRow>();
    try(Connection connection = DriverManager.getConnection(jdbcUrl, user, password)) {
      loadQuestMain(connection, out);
      loadStringArray(connection, out, "quest_contents", "contents");
      loadStringArray(connection, out, "quest_answer", "answer");
      loadStringArray(connection, out, "quest_info", "info");
      loadPairArray(connection, out, "quest_goal_getitem", "goalGetItem", "item_id", "item_count");
      loadPairArray(connection, out, "quest_goal_killmonster", "goalKillMonster", "monster_id", "monster_count");
      loadIntArray(connection, out, "quest_goal_meetnpc", "goalMeetNpc", "npc_id");
      loadPairArray(connection, out, "quest_reward_item", "rewardItems", "item_id", "item_count");
    }
    return out;
  }

  /**
   * Load `quest_main` rows into reconstruction map.
   */
  private void loadQuestMain(Connection connection,
                             Map<Integer, QuestRow> out) throws Exception {
    String sql = "SELECT quest_id, name, need_level, bq_loop, reward_exp, reward_gold FROM quest_main ORDER BY quest_id ASC";
    try(PreparedStatement ps = connection.prepareStatement(sql);
        ResultSet rs = ps.executeQuery()) {
      while(rs.next()) {
        QuestRow row = new QuestRow();
        row.questId = rs.getInt("quest_id");
        row.name = safe(rs.getString("name"));
        row.needLevel = rs.getInt("need_level");
        row.bqLoop = rs.getInt("bq_loop");
        row.rewardExp = rs.getInt("reward_exp");
        row.rewardGold = rs.getInt("reward_gold");
        out.put(Integer.valueOf(row.questId), row);
      }
    }
  }

  /**
   * Load ordered string arrays (`contents`/`answer`/`info`).
   */
  private void loadStringArray(Connection connection,
                               Map<Integer, QuestRow> out,
                               String table,
                               String field) throws Exception {
    String sql = "SELECT quest_id, seq_index, text FROM " + table + " ORDER BY quest_id ASC, seq_index ASC";
    try(PreparedStatement ps = connection.prepareStatement(sql);
        ResultSet rs = ps.executeQuery()) {
      while(rs.next()) {
        int questId = rs.getInt("quest_id");
        QuestRow row = out.get(Integer.valueOf(questId));
        if(row == null) {
          continue;
        }
        String text = safe(rs.getString("text"));
        if("contents".equals(field)) {
          row.contents.add(text);
        } else if("answer".equals(field)) {
          row.answer.add(text);
        } else if("info".equals(field)) {
          row.info.add(text);
        }
      }
    }
  }

  /**
   * Load ordered pair arrays (id/count style goal/reward rows).
   */
  private void loadPairArray(Connection connection,
                             Map<Integer, QuestRow> out,
                             String table,
                             String field,
                             String leftColumn,
                             String rightColumn) throws Exception {
    String sql = "SELECT quest_id, seq_index, " + leftColumn + ", " + rightColumn + " FROM " + table
        + " ORDER BY quest_id ASC, seq_index ASC";
    try(PreparedStatement ps = connection.prepareStatement(sql);
        ResultSet rs = ps.executeQuery()) {
      while(rs.next()) {
        int questId = rs.getInt("quest_id");
        QuestRow row = out.get(Integer.valueOf(questId));
        if(row == null) {
          continue;
        }
        IntPair pair = new IntPair();
        pair.left = rs.getInt(leftColumn);
        pair.right = rs.getInt(rightColumn);

        if("goalGetItem".equals(field)) {
          row.goalGetItem.add(pair);
        } else if("goalKillMonster".equals(field)) {
          row.goalKillMonster.add(pair);
        } else if("rewardItems".equals(field)) {
          row.rewardItems.add(pair);
        }
      }
    }
  }

  /**
   * Load ordered integer arrays (e.g. goal meetNpc).
   */
  private void loadIntArray(Connection connection,
                            Map<Integer, QuestRow> out,
                            String table,
                            String field,
                            String valueColumn) throws Exception {
    String sql = "SELECT quest_id, seq_index, " + valueColumn + " FROM " + table
        + " ORDER BY quest_id ASC, seq_index ASC";
    try(PreparedStatement ps = connection.prepareStatement(sql);
        ResultSet rs = ps.executeQuery()) {
      while(rs.next()) {
        int questId = rs.getInt("quest_id");
        QuestRow row = out.get(Integer.valueOf(questId));
        if(row == null) {
          continue;
        }
        if("goalMeetNpc".equals(field)) {
          row.goalMeetNpc.add(Integer.valueOf(rs.getInt(valueColumn)));
        }
      }
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
      row.goalGetItem.addAll(asPairList(goal.get("getItem"), "id", "count"));
      row.goalKillMonster.addAll(asPairList(goal.get("killMonster"), "id", "count"));
      row.goalMeetNpc.addAll(asIntList(goal.get("meetNpc")));

      Map<String, Object> reward = asMap(map.get("reward"));
      row.rewardExp = intOf(reward.get("exp"));
      row.rewardGold = intOf(reward.get("gold"));
      row.rewardItems.addAll(asPairList(reward.get("items"), "id", "count"));

      out.add(row);
    }

    Collections.sort(out, (left, right) -> Integer.compare(left.questId, right.questId));
    return out;
  }

  /**
   * 比较单个标量字段，差异时追加不一致详情。
   */
  private void compareField(ValidationReport report,
                            int questId,
                            String field,
                            Object expected,
                            Object actual) {
    if(expected == null && actual == null) {
      return;
    }
    if(expected == null || actual == null || !expected.equals(actual)) {
      report.mismatchDetails.add("questId=" + questId + " field=" + field
          + " expected=" + String.valueOf(expected)
          + " actual=" + String.valueOf(actual));
    }
  }

  /**
   * 比较有序字符串数组（contents/answer/info）。
   */
  private void compareStringList(ValidationReport report,
                                 int questId,
                                 String field,
                                 List<String> expected,
                                 List<String> actual) {
    int size = Math.max(expected.size(), actual.size());
    for(int i = 0; i < size; i++) {
      String ex = i < expected.size() ? expected.get(i) : null;
      String ac = i < actual.size() ? actual.get(i) : null;
      if(ex == null && ac == null) {
        continue;
      }
      if(ex == null || ac == null || !ex.equals(ac)) {
        report.mismatchDetails.add("questId=" + questId + " field=" + field + "[" + i + "]"
            + " expected=" + String.valueOf(ex)
            + " actual=" + String.valueOf(ac));
      }
    }
  }

  /**
   * 比较有序整数数组。
   */
  private void compareIntList(ValidationReport report,
                              int questId,
                              String field,
                              List<Integer> expected,
                              List<Integer> actual) {
    int size = Math.max(expected.size(), actual.size());
    for(int i = 0; i < size; i++) {
      Integer ex = i < expected.size() ? expected.get(i) : null;
      Integer ac = i < actual.size() ? actual.get(i) : null;
      if(ex == null && ac == null) {
        continue;
      }
      if(ex == null || ac == null || ex.intValue() != ac.intValue()) {
        report.mismatchDetails.add("questId=" + questId + " field=" + field + "[" + i + "]"
            + " expected=" + String.valueOf(ex)
            + " actual=" + String.valueOf(ac));
      }
    }
  }

  /**
   * 比较有序 id/count 对数组。
   */
  private void comparePairList(ValidationReport report,
                               int questId,
                               String field,
                               List<IntPair> expected,
                               List<IntPair> actual) {
    int size = Math.max(expected.size(), actual.size());
    for(int i = 0; i < size; i++) {
      IntPair ex = i < expected.size() ? expected.get(i) : null;
      IntPair ac = i < actual.size() ? actual.get(i) : null;
      if(ex == null && ac == null) {
        continue;
      }
      if(ex == null || ac == null || ex.left != ac.left || ex.right != ac.right) {
        String exText = ex == null ? "null" : (ex.left + ":" + ex.right);
        String acText = ac == null ? "null" : (ac.left + ":" + ac.right);
        report.mismatchDetails.add("questId=" + questId + " field=" + field + "[" + i + "]"
            + " expected=" + exText + " actual=" + acText);
      }
    }
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
    String text = safe(value).trim();
    if(text.isEmpty()) {
      return 0;
    }
    try {
      return Integer.parseInt(text);
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
   * @param output 方法参数
   * @throws Exception 处理失败时抛出
   */
  private void ensureParent(Path output) throws Exception {
    if(output.getParent() != null && !Files.exists(output.getParent())) {
      Files.createDirectories(output.getParent());
    }
  }

  private static final class IntPair {
    int left;
    int right;
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

  public static final class ValidationReport {
    int totalComparedQuests;
    int mismatchCount;
    final List<String> mismatchDetails = new ArrayList<String>();
    String finalStatus = "UNSAFE";

    String toJson() {
      StringBuilder sb = new StringBuilder();
      sb.append("{\n");
      sb.append("  \"generatedAt\": ").append(QuestSemanticJson.jsonString(OffsetDateTime.now().format(DateTimeFormatter.ISO_OFFSET_DATE_TIME))).append(",\n");
      sb.append("  \"totalComparedQuests\": ").append(totalComparedQuests).append(",\n");
      sb.append("  \"mismatchCount\": ").append(mismatchCount).append(",\n");
      sb.append("  \"mismatchDetails\": ").append(QuestSemanticJson.toJsonArrayString(mismatchDetails)).append(",\n");
      sb.append("  \"finalStatus\": ").append(QuestSemanticJson.jsonString(finalStatus)).append("\n");
      sb.append("}\n");
      return sb.toString();
    }
  }
}
