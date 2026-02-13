package unluac.semantic;

import java.net.URL;
import java.net.URLClassLoader;
import java.nio.charset.Charset;
import java.nio.file.DirectoryStream;
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
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

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
  private static final List<String> KNOWN_TOP_FIELDS = listOf(
      "id", "name", "contents", "answer", "info", "needItem", "requstItem", "goal", "reward", "needLevel", "bQLoop");
  private static final List<String> KNOWN_GOAL_FIELDS = listOf("getItem", "killMonster", "meetNpc");
  private static final List<String> KNOWN_REWARD_FIELDS = listOf("money", "exp", "fame", "pvppoint", "mileage", "getItem", "getSkill");

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
    Path referenceQuestLua = args.length >= 5 ? Paths.get(args[4]) : null;

    long start = System.nanoTime();
    Phase4QuestLucExporter exporter = new Phase4QuestLucExporter();
    ExportResult result = exporter.export(output, jdbcUrl, user, password, referenceQuestLua);
    long elapsed = (System.nanoTime() - start) / 1_000_000L;

    System.out.println("output=" + output.toAbsolutePath());
    System.out.println("referenceQuestLua=" + (result.referenceQuestLua == null ? "<none>" : result.referenceQuestLua.toAbsolutePath()));
    System.out.println("profileQuestCount=" + result.profileQuestCount);
    System.out.println("profileMissingQuestCount=" + result.profileMissingQuestCount);
    System.out.println("suppressedFieldCount=" + result.suppressedFieldCount);
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
    return export(output, jdbcUrl, user, password, null);
  }

  public ExportResult export(Path output,
                             String jdbcUrl,
                             String user,
                             String password,
                             Path referenceQuestLua) throws Exception {
    ensureMysqlDriverAvailable();

    List<QuestRecord> quests = loadFromDb(jdbcUrl, user, password);
    Path resolvedReference = resolveReferenceQuestLua(referenceQuestLua);
    Map<Integer, QuestFieldProfile> profiles = loadReferenceFieldProfiles(resolvedReference);
    ExportResult result = new ExportResult();
    result.referenceQuestLua = resolvedReference;
    result.profileQuestCount = profiles.size();

    StringBuilder sb = new StringBuilder();
    sb.append("-- phase4 exported quest data\n");
    sb.append("-- generatedAt: ").append(OffsetDateTime.now().format(DateTimeFormatter.ISO_OFFSET_DATE_TIME)).append("\n\n");

    // 逐任务按稳定顺序输出，确保后续 validator 比对时结构可预测。
    for(int i = 0; i < quests.size(); i++) {
      QuestRecord quest = quests.get(i);
      QuestFieldProfile profile = profiles.get(Integer.valueOf(quest.questId));
      if(profile == null) {
        profile = QuestFieldProfile.defaultProfile();
        result.profileMissingQuestCount++;
      }
      appendQuest(sb, quest, profile, result);
      if(i < quests.size() - 1) {
        sb.append("\n");
      }
    }

    ensureParent(output);
    Files.write(output, sb.toString().getBytes(UTF8));

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
      String mainSql = "SELECT quest_id, name, need_level, bq_loop, reward_exp, reward_gold, reward_money, reward_fame, reward_pvppoint, reward_mileage, need_item "
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
          Integer rewardGold = toNullableInt(rs, "reward_gold");
          record.rewardMoney = toNullableInt(rs, "reward_money");
          if(!isPositive(record.rewardMoney) && isPositive(rewardGold)) {
            record.rewardMoney = rewardGold;
          }
          record.rewardFame = toNullableInt(rs, "reward_fame");
          record.rewardPvppoint = toNullableInt(rs, "reward_pvppoint");
          record.rewardMileage = toNullableInt(rs, "reward_mileage");
          record.needItem = toNullableInt(rs, "need_item");
          byQuest.put(Integer.valueOf(record.questId), record);
        }
      }

      loadStringArray(connection, byQuest, "quest_contents", ArrayType.CONTENTS);
      loadStringArray(connection, byQuest, "quest_answer", ArrayType.ANSWER);
      loadStringArray(connection, byQuest, "quest_info", ArrayType.INFO);

      loadPairArray(connection, byQuest, "quest_goal_getitem", "item_id", "item_count", PairType.GOAL_GET_ITEM);
      loadPairArray(connection, byQuest, "quest_goal_killmonster", "monster_id", "monster_count", PairType.GOAL_KILL_MONSTER);
      loadIntArray(connection, byQuest, "quest_goal_meetnpc", "npc_id");
      loadPairArray(connection, byQuest, "quest_reward_item", "item_id", "item_count", PairType.REWARD_GET_ITEM);
      loadSkillArray(connection, byQuest);
      loadRequstItemArray(connection, byQuest);
    }

    List<QuestRecord> quests = new ArrayList<QuestRecord>(byQuest.values());
    Collections.sort(quests, (left, right) -> Integer.compare(left.questId, right.questId));
    return quests;
  }

  /**
   * 计算并返回结果。
   * @param rs 方法参数
   * @param column 方法参数
   * @return 计算结果
   * @throws Exception 处理失败时抛出
   */
  private Integer toNullableInt(ResultSet rs, String column) throws Exception {
    int value = rs.getInt(column);
    if(rs.wasNull()) {
      return null;
    }
    return Integer.valueOf(value);
  }

  /**
   * 从数据库加载有序字符串数组（contents/answer/info）。
   */
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

  /**
   * 从数据库加载有序对数组（goal/reward 的 id-count 行）。
   */
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
          quest.rewardGetItem.add(pair);
        }
      }
    }
  }

  /**
   * 从数据库加载有序整数数组（goal.meetNpc）。
   */
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

  /**
   * 从数据库加载 reward.getSkill（按 seq_index 保序）。
   */
  private void loadSkillArray(Connection connection,
                              Map<Integer, QuestRecord> byQuest) throws Exception {
    String sql = "SELECT quest_id, seq_index, skill_id FROM quest_reward_skill ORDER BY quest_id ASC, seq_index ASC";
    try(PreparedStatement ps = connection.prepareStatement(sql);
        ResultSet rs = ps.executeQuery()) {
      while(rs.next()) {
        int questId = rs.getInt("quest_id");
        QuestRecord quest = byQuest.get(Integer.valueOf(questId));
        if(quest == null) {
          continue;
        }
        Integer skillId = toNullableInt(rs, "skill_id");
        if(skillId != null && skillId.intValue() > 0) {
          quest.rewardGetSkill.add(skillId);
        }
      }
    } catch(Exception ignored) {
      // 兼容旧库：没有 quest_reward_skill 时保留为空集合。
    }
  }

  /**
   * 从数据库加载 requstItem 原始 JSON 结构。
   */
  private void loadRequstItemArray(Connection connection,
                                   Map<Integer, QuestRecord> byQuest) throws Exception {
    String sql = "SELECT quest_id, seq_index, raw_json FROM quest_requst_item ORDER BY quest_id ASC, seq_index ASC";
    Map<Integer, List<Object>> grouped = new LinkedHashMap<Integer, List<Object>>();
    try(PreparedStatement ps = connection.prepareStatement(sql);
        ResultSet rs = ps.executeQuery()) {
      while(rs.next()) {
        int questId = rs.getInt("quest_id");
        QuestRecord quest = byQuest.get(Integer.valueOf(questId));
        if(quest == null) {
          continue;
        }
        Object value = parseJsonValue(rs.getString("raw_json"));
        List<Object> list = grouped.get(Integer.valueOf(questId));
        if(list == null) {
          list = new ArrayList<Object>();
          grouped.put(Integer.valueOf(questId), list);
        }
        list.add(value);
      }
    } catch(Exception ignored) {
      // 兼容旧库：没有 quest_requst_item 时保持为空。
      return;
    }

    for(Map.Entry<Integer, List<Object>> entry : grouped.entrySet()) {
      QuestRecord quest = byQuest.get(entry.getKey());
      if(quest == null) {
        continue;
      }
      List<Object> values = entry.getValue();
      if(values == null || values.isEmpty()) {
        continue;
      }
      quest.requstItem = values.size() == 1 ? values.get(0) : values;
    }
  }

  /**
   * 将数据追加到目标容器。
   * @param sb 方法参数
   * @param quest 方法参数
   */
  private void appendQuest(StringBuilder sb,
                           QuestRecord quest,
                           QuestFieldProfile profile,
                           ExportResult result) {
    List<String> fields = new ArrayList<String>();
    recordSuppressedTopFields(quest, profile, result);
    for(String field : profile.topFieldOrder) {
      if("id".equals(field)) {
        fields.add("id = " + quest.questId);
        continue;
      }
      String rendered = renderTopField(field, quest, profile, result);
      if(rendered != null) {
        fields.add(rendered);
      }
    }
    if(fields.isEmpty()) {
      fields.add("id = " + quest.questId);
    }
    sb.append("qt[").append(quest.questId).append("] = {\n");
    for(int i = 0; i < fields.size(); i++) {
      sb.append("  ").append(fields.get(i));
      if(i < fields.size() - 1) {
        sb.append(",");
      }
      sb.append("\n");
    }
    sb.append("}\n");
  }

  private String renderTopField(String field,
                                QuestRecord quest,
                                QuestFieldProfile profile,
                                ExportResult result) {
    if("name".equals(field)) {
      return "name = " + luaStringOrNil(quest.name);
    }
    if("contents".equals(field)) {
      return "contents = " + renderStringArray(quest.contents, 2);
    }
    if("answer".equals(field)) {
      return "answer = " + renderStringArray(quest.answer, 2);
    }
    if("info".equals(field)) {
      return "info = " + renderStringArray(quest.info, 2);
    }
    if("needItem".equals(field)) {
      return "needItem = " + luaIntOrNil(quest.needItem);
    }
    if("requstItem".equals(field)) {
      return "requstItem = " + toLuaValue(quest.requstItem, 2);
    }
    if("goal".equals(field)) {
      return "goal = " + renderGoal(quest, profile, result);
    }
    if("reward".equals(field)) {
      return "reward = " + renderReward(quest, profile, result);
    }
    if("needLevel".equals(field)) {
      return "needLevel = " + luaIntOrNil(quest.needLevel);
    }
    if("bQLoop".equals(field)) {
      return "bQLoop = " + luaIntOrNil(quest.bqLoop);
    }
    return null;
  }

  private String renderGoal(QuestRecord quest, QuestFieldProfile profile, ExportResult result) {
    recordSuppressedGoalFields(quest, profile, result);
    List<String> lines = new ArrayList<String>();
    for(String field : profile.goalFieldOrder) {
      if("getItem".equals(field)) {
        lines.add("getItem = " + renderPairArray(quest.goalGetItem, 4, "id", "count"));
      } else if("killMonster".equals(field)) {
        lines.add("killMonster = " + renderPairArray(quest.goalKillMonster, 4, "id", "count"));
      } else if("meetNpc".equals(field)) {
        lines.add("meetNpc = " + renderIntArray(quest.goalMeetNpc, 4));
      }
    }
    return renderFieldBlock(lines);
  }

  private String renderReward(QuestRecord quest, QuestFieldProfile profile, ExportResult result) {
    recordSuppressedRewardFields(quest, profile, result);
    List<String> lines = new ArrayList<String>();
    for(String field : profile.rewardFieldOrder) {
      if("money".equals(field)) {
        lines.add("money = " + luaIntOrNil(quest.rewardMoney));
      } else if("exp".equals(field)) {
        lines.add("exp = " + luaIntOrNil(quest.rewardExp));
      } else if("fame".equals(field)) {
        lines.add("fame = " + luaIntOrNil(quest.rewardFame));
      } else if("pvppoint".equals(field)) {
        lines.add("pvppoint = " + luaIntOrNil(quest.rewardPvppoint));
      } else if("mileage".equals(field)) {
        lines.add("mileage = " + luaIntOrNil(quest.rewardMileage));
      } else if("getItem".equals(field)) {
        lines.add("getItem = " + renderPairArray(quest.rewardGetItem, 4, "id", "count"));
      } else if("getSkill".equals(field)) {
        lines.add("getSkill = " + renderIntArray(quest.rewardGetSkill, 4));
      }
    }
    return renderFieldBlock(lines);
  }

  private String renderFieldBlock(List<String> lines) {
    if(lines == null || lines.isEmpty()) {
      return "{}";
    }
    StringBuilder sb = new StringBuilder();
    sb.append("{\n");
    for(int i = 0; i < lines.size(); i++) {
      sb.append("    ").append(lines.get(i));
      if(i < lines.size() - 1) {
        sb.append(",");
      }
      sb.append("\n");
    }
    sb.append("  }");
    return sb.toString();
  }

  private void recordSuppressedTopFields(QuestRecord quest,
                                         QuestFieldProfile profile,
                                         ExportResult result) {
    if(result == null || profile == null) {
      return;
    }
    if(!profile.hasTopField("name") && hasText(quest.name)) {
      addSuppressedField(result, quest.questId, "name");
    }
    if(!profile.hasTopField("contents") && !quest.contents.isEmpty()) {
      addSuppressedField(result, quest.questId, "contents");
    }
    if(!profile.hasTopField("answer") && !quest.answer.isEmpty()) {
      addSuppressedField(result, quest.questId, "answer");
    }
    if(!profile.hasTopField("info") && !quest.info.isEmpty()) {
      addSuppressedField(result, quest.questId, "info");
    }
    if(!profile.hasTopField("needItem") && isNonNullNumber(quest.needItem)) {
      addSuppressedField(result, quest.questId, "needItem");
    }
    if(!profile.hasTopField("requstItem") && quest.requstItem != null) {
      addSuppressedField(result, quest.questId, "requstItem");
    }
    if(!profile.hasTopField("goal") && hasGoalData(quest)) {
      addSuppressedField(result, quest.questId, "goal");
    }
    if(!profile.hasTopField("reward") && hasRewardData(quest)) {
      addSuppressedField(result, quest.questId, "reward");
    }
    if(!profile.hasTopField("needLevel") && isNonNullNumber(quest.needLevel)) {
      addSuppressedField(result, quest.questId, "needLevel");
    }
    if(!profile.hasTopField("bQLoop") && isNonNullNumber(quest.bqLoop)) {
      addSuppressedField(result, quest.questId, "bQLoop");
    }
  }

  private void recordSuppressedGoalFields(QuestRecord quest,
                                          QuestFieldProfile profile,
                                          ExportResult result) {
    if(result == null || profile == null) {
      return;
    }
    if(!profile.hasGoalField("getItem") && !quest.goalGetItem.isEmpty()) {
      addSuppressedField(result, quest.questId, "goal.getItem");
    }
    if(!profile.hasGoalField("killMonster") && !quest.goalKillMonster.isEmpty()) {
      addSuppressedField(result, quest.questId, "goal.killMonster");
    }
    if(!profile.hasGoalField("meetNpc") && !quest.goalMeetNpc.isEmpty()) {
      addSuppressedField(result, quest.questId, "goal.meetNpc");
    }
  }

  private void recordSuppressedRewardFields(QuestRecord quest,
                                            QuestFieldProfile profile,
                                            ExportResult result) {
    if(result == null || profile == null) {
      return;
    }
    if(!profile.hasRewardField("money") && isNonNullNumber(quest.rewardMoney)) {
      addSuppressedField(result, quest.questId, "reward.money");
    }
    if(!profile.hasRewardField("exp") && isNonNullNumber(quest.rewardExp)) {
      addSuppressedField(result, quest.questId, "reward.exp");
    }
    if(!profile.hasRewardField("fame") && isNonNullNumber(quest.rewardFame)) {
      addSuppressedField(result, quest.questId, "reward.fame");
    }
    if(!profile.hasRewardField("pvppoint") && isNonNullNumber(quest.rewardPvppoint)) {
      addSuppressedField(result, quest.questId, "reward.pvppoint");
    }
    if(!profile.hasRewardField("mileage") && isNonNullNumber(quest.rewardMileage)) {
      addSuppressedField(result, quest.questId, "reward.mileage");
    }
    if(!profile.hasRewardField("getItem") && !quest.rewardGetItem.isEmpty()) {
      addSuppressedField(result, quest.questId, "reward.getItem");
    }
    if(!profile.hasRewardField("getSkill") && !quest.rewardGetSkill.isEmpty()) {
      addSuppressedField(result, quest.questId, "reward.getSkill");
    }
  }

  private void addSuppressedField(ExportResult result, int questId, String fieldPath) {
    result.suppressedFieldCount++;
    if(result.suppressedFieldExamples.size() >= 20) {
      return;
    }
    result.suppressedFieldExamples.add("questId=" + questId + ", field=" + fieldPath);
  }

  private boolean hasGoalData(QuestRecord quest) {
    return quest != null
        && (!quest.goalGetItem.isEmpty() || !quest.goalKillMonster.isEmpty() || !quest.goalMeetNpc.isEmpty());
  }

  private boolean hasRewardData(QuestRecord quest) {
    return quest != null
        && (isNonNullNumber(quest.rewardMoney)
        || isNonNullNumber(quest.rewardExp)
        || isNonNullNumber(quest.rewardFame)
        || isNonNullNumber(quest.rewardPvppoint)
        || isNonNullNumber(quest.rewardMileage)
        || !quest.rewardGetItem.isEmpty()
        || !quest.rewardGetSkill.isEmpty());
  }

  private boolean isNonNullNumber(Integer value) {
    return value != null;
  }

  private Path resolveReferenceQuestLua(Path explicitReference) throws Exception {
    if(explicitReference != null) {
      if(Files.exists(explicitReference) && Files.isRegularFile(explicitReference)) {
        return explicitReference;
      }
      throw new IllegalStateException("reference quest lua not found: " + explicitReference.toAbsolutePath());
    }
    Path reportsDir = Paths.get("reports");
    if(!Files.exists(reportsDir) || !Files.isDirectory(reportsDir)) {
      return null;
    }
    List<Path> candidates = new ArrayList<Path>();
    try(DirectoryStream<Path> stream = Files.newDirectoryStream(reportsDir, "structure_audit_*")) {
      for(Path dir : stream) {
        if(!Files.isDirectory(dir)) {
          continue;
        }
        Path candidate = dir.resolve("questbak_decompiled.lua");
        if(Files.exists(candidate) && Files.isRegularFile(candidate)) {
          candidates.add(candidate);
        }
      }
    }
    if(candidates.isEmpty()) {
      Path fallback = reportsDir.resolve("questbak_decompiled.lua");
      if(Files.exists(fallback) && Files.isRegularFile(fallback)) {
        return fallback;
      }
      return null;
    }
    Collections.sort(candidates, (left, right) -> right.toString().compareTo(left.toString()));
    return candidates.get(0);
  }

  private Map<Integer, QuestFieldProfile> loadReferenceFieldProfiles(Path referenceQuestLua) throws Exception {
    Map<Integer, QuestFieldProfile> out = new LinkedHashMap<Integer, QuestFieldProfile>();
    if(referenceQuestLua == null || !Files.exists(referenceQuestLua) || !Files.isRegularFile(referenceQuestLua)) {
      return out;
    }
    String text = new String(Files.readAllBytes(referenceQuestLua), UTF8);
    int cursor = 0;
    while(cursor < text.length()) {
      int tupleStart = text.indexOf("({", cursor);
      if(tupleStart < 0) {
        break;
      }
      int tableOpen = tupleStart + 1;
      int tableClose = findMatchingBrace(text, tableOpen);
      if(tableClose < 0) {
        break;
      }
      String tableBlock = text.substring(tableOpen, tableClose + 1);
      List<FieldSpan> tableFields = scanTableFields(tableBlock);
      Integer questId = parseQuestIdFromFieldSpans(tableBlock, tableFields);
      if(questId == null || questId.intValue() <= 0) {
        cursor = tableClose + 1;
        continue;
      }

      QuestFieldProfile profile = out.get(questId);
      if(profile == null) {
        profile = new QuestFieldProfile();
        out.put(questId, profile);
      }
      mergeBaseProfileFields(profile, tableFields);

      int suffixIndex = skipWhitespaceAndComments(text, tableClose + 1, text.length());
      if(suffixIndex < text.length() && text.charAt(suffixIndex) == ')') {
        suffixIndex++;
      }
      suffixIndex = skipWhitespaceAndComments(text, suffixIndex, text.length());
      if(suffixIndex < text.length() && text.charAt(suffixIndex) == '.') {
        int keyStart = suffixIndex + 1;
        int keyEnd = keyStart;
        while(keyEnd < text.length() && isIdentifierPart(text.charAt(keyEnd))) {
          keyEnd++;
        }
        String assignedField = normalizeTopField(text.substring(keyStart, keyEnd));
        int afterField = skipWhitespaceAndComments(text, keyEnd, text.length());
        if(afterField < text.length() && text.charAt(afterField) == '=') {
          int valueStart = skipWhitespaceAndComments(text, afterField + 1, text.length());
          int valueEnd = valueStart;
          int valueCursor = valueStart;
          while(valueCursor < text.length()) {
            int singleEnd = skipLuaValue(text, valueCursor, text.length());
            if(singleEnd <= valueCursor) {
              break;
            }
            if("goal".equals(assignedField) || "reward".equals(assignedField)) {
              String assignedBlock = text.substring(valueCursor, Math.min(singleEnd, text.length()));
              mergeNestedProfileFields(profile, assignedField, assignedBlock);
            }
            int next = skipWhitespaceAndComments(text, singleEnd, text.length());
            valueEnd = singleEnd;
            if(next < text.length() && text.charAt(next) == ',') {
              valueCursor = skipWhitespaceAndComments(text, next + 1, text.length());
              continue;
            }
            break;
          }
          if(assignedField != null && KNOWN_TOP_FIELDS.contains(assignedField)) {
            profile.addTopField(assignedField);
          }
          cursor = valueEnd;
          profile.ensureIdAsFirstField();
          continue;
        }
      }
      profile.ensureIdAsFirstField();
      cursor = tableClose + 1;
    }
    for(QuestFieldProfile profile : out.values()) {
      profile.ensureIdAsFirstField();
    }
    return out;
  }

  private void mergeBaseProfileFields(QuestFieldProfile profile, List<FieldSpan> topFields) {
    if(profile == null || topFields == null) {
      return;
    }
    for(FieldSpan span : topFields) {
      String normalized = normalizeTopField(span.key);
      if(normalized == null || !KNOWN_TOP_FIELDS.contains(normalized)) {
        continue;
      }
      profile.addTopField(normalized);
    }
  }

  private void mergeNestedProfileFields(QuestFieldProfile profile, String containerField, String containerBlock) {
    if(profile == null || containerField == null || containerBlock == null) {
      return;
    }
    List<FieldSpan> nestedFields = scanTableFields(containerBlock);
    for(FieldSpan span : nestedFields) {
      if("goal".equals(containerField)) {
        String normalizedGoal = normalizeGoalField(span.key);
        if(normalizedGoal != null && KNOWN_GOAL_FIELDS.contains(normalizedGoal)) {
          profile.addGoalField(normalizedGoal);
        }
      } else if("reward".equals(containerField)) {
        String normalizedReward = normalizeRewardField(span.key);
        if(normalizedReward != null && KNOWN_REWARD_FIELDS.contains(normalizedReward)) {
          profile.addRewardField(normalizedReward);
        }
      }
    }
  }

  private Integer parseQuestIdFromFieldSpans(String tableBlock, List<FieldSpan> fields) {
    if(tableBlock == null || fields == null) {
      return null;
    }
    for(FieldSpan span : fields) {
      if(!"id".equals(span.key)) {
        continue;
      }
      String valueText = tableBlock.substring(span.valueStart, Math.min(span.valueEnd, tableBlock.length())).trim();
      if(valueText.isEmpty()) {
        continue;
      }
      int end = 0;
      while(end < valueText.length() && (Character.isDigit(valueText.charAt(end)) || (end == 0 && valueText.charAt(end) == '-'))) {
        end++;
      }
      if(end <= 0) {
        continue;
      }
      try {
        return Integer.valueOf(Integer.parseInt(valueText.substring(0, end)));
      } catch(Exception ignored) {
      }
    }
    return null;
  }

  private List<FieldSpan> scanTableFields(String tableText) {
    List<FieldSpan> out = new ArrayList<FieldSpan>();
    if(tableText == null || tableText.isEmpty()) {
      return out;
    }
    int openBrace = tableText.indexOf('{');
    if(openBrace < 0) {
      return out;
    }
    int closeBrace = findMatchingBrace(tableText, openBrace);
    if(closeBrace < 0) {
      closeBrace = tableText.length() - 1;
    }

    int index = openBrace + 1;
    while(index < closeBrace) {
      index = skipWhitespaceAndComments(tableText, index, closeBrace);
      if(index >= closeBrace) {
        break;
      }
      char ch = tableText.charAt(index);
      if(ch == ',') {
        index++;
        continue;
      }
      if(!isIdentifierStart(ch)) {
        index = skipLuaValue(tableText, index, closeBrace);
        continue;
      }
      int keyStart = index;
      index++;
      while(index < closeBrace && isIdentifierPart(tableText.charAt(index))) {
        index++;
      }
      String key = tableText.substring(keyStart, index);
      int afterKey = skipWhitespaceAndComments(tableText, index, closeBrace);
      if(afterKey >= closeBrace || tableText.charAt(afterKey) != '=') {
        index = skipLuaValue(tableText, keyStart, closeBrace);
        continue;
      }
      int valueStart = skipWhitespaceAndComments(tableText, afterKey + 1, closeBrace);
      int valueEnd = skipLuaValue(tableText, valueStart, closeBrace);
      out.add(new FieldSpan(key, valueStart, valueEnd));
      index = valueEnd;
    }
    return out;
  }

  private int skipLuaValue(String text, int index, int limitExclusive) {
    if(index >= limitExclusive) {
      return limitExclusive;
    }
    char ch = text.charAt(index);
    if(ch == '{') {
      int end = findMatchingBrace(text, index);
      if(end < 0) {
        return limitExclusive;
      }
      return end + 1;
    }
    if(ch == '"' || ch == '\'') {
      return skipLuaString(text, index, limitExclusive);
    }
    int cursor = index;
    while(cursor < limitExclusive) {
      char c = text.charAt(cursor);
      if(c == ',') {
        break;
      }
      if(c == '}') {
        break;
      }
      if(c == ';' || c == '\n' || c == '\r') {
        break;
      }
      if(c == '"' || c == '\'') {
        cursor = skipLuaString(text, cursor, limitExclusive);
        continue;
      }
      if(c == '{') {
        int end = findMatchingBrace(text, cursor);
        if(end < 0) {
          return limitExclusive;
        }
        cursor = end + 1;
        continue;
      }
      if(c == '-' && cursor + 1 < limitExclusive && text.charAt(cursor + 1) == '-') {
        cursor = skipLuaComment(text, cursor + 2, limitExclusive);
        continue;
      }
      cursor++;
    }
    return cursor;
  }

  private int skipLuaString(String text, int start, int limitExclusive) {
    char quote = text.charAt(start);
    int cursor = start + 1;
    while(cursor < limitExclusive) {
      char c = text.charAt(cursor++);
      if(c == '\\') {
        if(cursor < limitExclusive) {
          cursor++;
        }
        continue;
      }
      if(c == quote) {
        break;
      }
    }
    return cursor;
  }

  private int skipLuaComment(String text, int start, int limitExclusive) {
    int cursor = start;
    while(cursor < limitExclusive) {
      char c = text.charAt(cursor);
      if(c == '\n' || c == '\r') {
        break;
      }
      cursor++;
    }
    return cursor;
  }

  private int skipWhitespaceAndComments(String text, int index, int limitExclusive) {
    int cursor = index;
    while(cursor < limitExclusive) {
      char ch = text.charAt(cursor);
      if(Character.isWhitespace(ch)) {
        cursor++;
        continue;
      }
      if(ch == '-' && cursor + 1 < limitExclusive && text.charAt(cursor + 1) == '-') {
        cursor = skipLuaComment(text, cursor + 2, limitExclusive);
        continue;
      }
      break;
    }
    return cursor;
  }

  private boolean isIdentifierStart(char ch) {
    return Character.isLetter(ch) || ch == '_';
  }

  private boolean isIdentifierPart(char ch) {
    return Character.isLetterOrDigit(ch) || ch == '_';
  }

  private String renderStringArray(List<String> values, int indent) {
    StringBuilder sb = new StringBuilder();
    appendStringArray(sb, values, indent);
    return sb.toString();
  }

  private String renderIntArray(List<Integer> values, int indent) {
    StringBuilder sb = new StringBuilder();
    appendIntArray(sb, values, indent);
    return sb.toString();
  }

  private String renderPairArray(List<Pair> values, int indent, String leftKey, String rightKey) {
    StringBuilder sb = new StringBuilder();
    appendPairArray(sb, values, indent, leftKey, rightKey);
    return sb.toString();
  }

  /**
   * 将数据追加到目标容器。
   * @param sb 方法参数
   * @param values 方法参数
   * @param indent 方法参数
   */
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

  /**
   * 将数据追加到目标容器。
   * @param sb 方法参数
   * @param values 方法参数
   * @param indent 方法参数
   */
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

  /**
   * 在保持源顺序的前提下输出 pair 数组 Lua 表。
   */
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

  /**
   * 计算并返回结果。
   * @param count 方法参数
   * @return 计算结果
   */
  private String pad(int count) {
    StringBuilder sb = new StringBuilder();
    for(int i = 0; i < count; i++) {
      sb.append(' ');
    }
    return sb.toString();
  }

  /**
   * 计算并返回结果。
   * @param value 方法参数
   * @return 计算结果
   */
  private String luaIntOrNil(Integer value) {
    return value == null ? "nil" : Integer.toString(value.intValue());
  }

  /**
   * 计算并返回结果。
   * @param value 方法参数
   * @return 计算结果
   */
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

  private boolean hasText(String value) {
    return value != null && !value.isEmpty();
  }

  private boolean isPositive(Integer value) {
    return value != null && value.intValue() > 0;
  }

  private String toLuaValue(Object value, int indent) {
    if(value == null) {
      return "nil";
    }
    if(value instanceof String) {
      return luaStringOrNil((String) value);
    }
    if(value instanceof Number || value instanceof Boolean) {
      return String.valueOf(value);
    }
    if(value instanceof List<?>) {
      @SuppressWarnings("unchecked")
      List<Object> list = (List<Object>) value;
      if(list.isEmpty()) {
        return "{}";
      }
      StringBuilder sb = new StringBuilder();
      sb.append("{\n");
      String pad = pad(indent);
      String childPad = pad(indent + 2);
      for(int i = 0; i < list.size(); i++) {
        sb.append(childPad).append(toLuaValue(list.get(i), indent + 2));
        if(i < list.size() - 1) {
          sb.append(",");
        }
        sb.append("\n");
      }
      sb.append(pad).append("}");
      return sb.toString();
    }
    if(value instanceof Map<?, ?>) {
      @SuppressWarnings("unchecked")
      Map<Object, Object> map = (Map<Object, Object>) value;
      if(map.isEmpty()) {
        return "{}";
      }
      StringBuilder sb = new StringBuilder();
      sb.append("{\n");
      String pad = pad(indent);
      String childPad = pad(indent + 2);
      int index = 0;
      for(Map.Entry<Object, Object> entry : map.entrySet()) {
        sb.append(childPad)
            .append(renderLuaKey(entry.getKey()))
            .append(" = ")
            .append(toLuaValue(entry.getValue(), indent + 2));
        if(index < map.size() - 1) {
          sb.append(",");
        }
        sb.append("\n");
        index++;
      }
      sb.append(pad).append("}");
      return sb.toString();
    }
    return luaStringOrNil(String.valueOf(value));
  }

  private String renderLuaKey(Object key) {
    if(key == null) {
      return "[\"null\"]";
    }
    String text = String.valueOf(key);
    if(text.matches("[A-Za-z_][A-Za-z0-9_]*")) {
      return text;
    }
    if(text.matches("[0-9]+")) {
      return "[" + text + "]";
    }
    return "[" + luaStringOrNil(text) + "]";
  }

  private Object parseJsonValue(String rawJson) {
    if(rawJson == null) {
      return null;
    }
    String trimmed = rawJson.trim();
    if(trimmed.isEmpty() || "null".equals(trimmed)) {
      return null;
    }
    try {
      Map<String, Object> wrapper = QuestSemanticJson.parseObject("{\"value\":" + trimmed + "}", "quest_requst_item.raw_json", 0);
      return wrapper.get("value");
    } catch(Exception ignored) {
      return rawJson;
    }
  }

  private int findMatchingBrace(String text, int openIndex) {
    int depth = 0;
    boolean inString = false;
    char quote = 0;
    for(int i = openIndex; i < text.length(); i++) {
      char ch = text.charAt(i);
      if(inString) {
        if(ch == '\\') {
          i++;
          continue;
        }
        if(ch == quote) {
          inString = false;
          quote = 0;
        }
        continue;
      }

      if(ch == '"' || ch == '\'') {
        inString = true;
        quote = ch;
        continue;
      }

      if(ch == '{') {
        depth++;
      } else if(ch == '}') {
        depth--;
        if(depth == 0) {
          return i;
        }
      }
    }
    return -1;
  }

  private static String normalizeTopField(String key) {
    if(key == null) {
      return null;
    }
    if("requestItem".equals(key)) {
      return "requstItem";
    }
    return key;
  }

  private static String normalizeGoalField(String key) {
    return key;
  }

  private static String normalizeRewardField(String key) {
    if(key == null) {
      return null;
    }
    if("gold".equals(key)) {
      return "money";
    }
    if("items".equals(key)) {
      return "getItem";
    }
    return key;
  }

  private static List<String> listOf(String... values) {
    List<String> out = new ArrayList<String>();
    if(values == null) {
      return out;
    }
    for(String value : values) {
      out.add(value);
    }
    return Collections.unmodifiableList(out);
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

  /**
   * 确保前置条件满足。
   * @throws Exception 处理失败时抛出
   */
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

  private static final class QuestFieldProfile {
    final List<String> topFieldOrder = new ArrayList<String>();
    final Set<String> topFieldSet = new HashSet<String>();
    final List<String> goalFieldOrder = new ArrayList<String>();
    final Set<String> goalFieldSet = new HashSet<String>();
    final List<String> rewardFieldOrder = new ArrayList<String>();
    final Set<String> rewardFieldSet = new HashSet<String>();

    static QuestFieldProfile fromMap(Map<String, Object> map) {
      QuestFieldProfile profile = new QuestFieldProfile();
      if(map != null) {
        for(String key : map.keySet()) {
          String normalized = normalizeTopField(key);
          if(normalized != null && KNOWN_TOP_FIELDS.contains(normalized)) {
            addOrderedUnique(profile.topFieldOrder, profile.topFieldSet, normalized);
          }
        }
        Object goalValue = map.get("goal");
        if(goalValue instanceof Map<?, ?>) {
          @SuppressWarnings("unchecked")
          Map<String, Object> goalMap = (Map<String, Object>) goalValue;
          for(String key : goalMap.keySet()) {
            String normalized = normalizeGoalField(key);
            if(normalized != null && KNOWN_GOAL_FIELDS.contains(normalized)) {
              addOrderedUnique(profile.goalFieldOrder, profile.goalFieldSet, normalized);
            }
          }
        }
        Object rewardValue = map.get("reward");
        if(rewardValue instanceof Map<?, ?>) {
          @SuppressWarnings("unchecked")
          Map<String, Object> rewardMap = (Map<String, Object>) rewardValue;
          for(String key : rewardMap.keySet()) {
            String normalized = normalizeRewardField(key);
            if(normalized != null && KNOWN_REWARD_FIELDS.contains(normalized)) {
              addOrderedUnique(profile.rewardFieldOrder, profile.rewardFieldSet, normalized);
            }
          }
        }
      }
      if(!profile.topFieldSet.contains("id")) {
        profile.topFieldOrder.add(0, "id");
        profile.topFieldSet.add("id");
      }
      return profile;
    }

    void addTopField(String field) {
      addOrderedUnique(topFieldOrder, topFieldSet, field);
    }

    void addGoalField(String field) {
      addOrderedUnique(goalFieldOrder, goalFieldSet, field);
    }

    void addRewardField(String field) {
      addOrderedUnique(rewardFieldOrder, rewardFieldSet, field);
    }

    void ensureIdAsFirstField() {
      if(topFieldSet.contains("id")) {
        if(!topFieldOrder.isEmpty() && "id".equals(topFieldOrder.get(0))) {
          return;
        }
        topFieldOrder.remove("id");
      }
      topFieldOrder.add(0, "id");
      topFieldSet.add("id");
    }

    static QuestFieldProfile defaultProfile() {
      QuestFieldProfile profile = new QuestFieldProfile();
      for(String field : KNOWN_TOP_FIELDS) {
        addOrderedUnique(profile.topFieldOrder, profile.topFieldSet, field);
      }
      for(String field : KNOWN_GOAL_FIELDS) {
        addOrderedUnique(profile.goalFieldOrder, profile.goalFieldSet, field);
      }
      for(String field : KNOWN_REWARD_FIELDS) {
        addOrderedUnique(profile.rewardFieldOrder, profile.rewardFieldSet, field);
      }
      return profile;
    }

    boolean hasTopField(String field) {
      return topFieldSet.contains(field);
    }

    boolean hasGoalField(String field) {
      return goalFieldSet.contains(field);
    }

    boolean hasRewardField(String field) {
      return rewardFieldSet.contains(field);
    }

    private static void addOrderedUnique(List<String> order, Set<String> set, String value) {
      if(value == null || set.contains(value)) {
        return;
      }
      set.add(value);
      order.add(value);
    }
  }

  private static final class LuaTableParser {
    private final String text;
    private int index;

    LuaTableParser(String text) {
      this.text = text == null ? "" : text;
      this.index = 0;
    }

    Object parseValue() {
      skipWhitespace();
      if(index >= text.length()) {
        return null;
      }
      char ch = text.charAt(index);
      if(ch == '{') {
        return parseTable();
      }
      if(ch == '"' || ch == '\'') {
        return parseString();
      }
      if(Character.isDigit(ch) || ch == '-') {
        return parseNumber();
      }
      if(startsWith("nil")) {
        index += 3;
        return null;
      }
      if(startsWith("true")) {
        index += 4;
        return Boolean.TRUE;
      }
      if(startsWith("false")) {
        index += 5;
        return Boolean.FALSE;
      }
      return parseBareword();
    }

    private Object parseTable() {
      expect('{');
      skipWhitespace();
      List<Object> array = new ArrayList<Object>();
      Map<String, Object> object = new LinkedHashMap<String, Object>();
      boolean hasKeyValue = false;

      while(index < text.length()) {
        skipWhitespace();
        if(peek('}')) {
          index++;
          break;
        }

        int save = index;
        String key = tryParseKey();
        if(key != null) {
          hasKeyValue = true;
          skipWhitespace();
          expect('=');
          Object value = parseValue();
          object.put(key, value);
        } else {
          index = save;
          Object value = parseValue();
          array.add(value);
        }

        skipWhitespace();
        if(peek(',')) {
          index++;
        }
      }

      if(hasKeyValue && array.isEmpty()) {
        return object;
      }
      if(hasKeyValue) {
        int i = 1;
        for(Object item : array) {
          object.put(Integer.toString(i++), item);
        }
        return object;
      }
      return array;
    }

    private String tryParseKey() {
      skipWhitespace();
      if(index >= text.length()) {
        return null;
      }
      char ch = text.charAt(index);
      if(ch == '"' || ch == '\'') {
        int save = index;
        String key = parseString();
        skipWhitespace();
        if(peek('=')) {
          return key;
        }
        index = save;
        return null;
      }
      if(Character.isLetter(ch) || ch == '_') {
        int start = index;
        index++;
        while(index < text.length()) {
          char c = text.charAt(index);
          if(Character.isLetterOrDigit(c) || c == '_') {
            index++;
          } else {
            break;
          }
        }
        String key = text.substring(start, index);
        skipWhitespace();
        if(peek('=')) {
          return key;
        }
      }
      return null;
    }

    private Integer parseNumber() {
      int start = index;
      if(peek('-')) {
        index++;
      }
      while(index < text.length() && Character.isDigit(text.charAt(index))) {
        index++;
      }
      String number = text.substring(start, index);
      if(number.trim().isEmpty() || "-".equals(number)) {
        return null;
      }
      return Integer.valueOf(Integer.parseInt(number));
    }

    private String parseString() {
      char quote = text.charAt(index++);
      StringBuilder sb = new StringBuilder();
      while(index < text.length()) {
        char ch = text.charAt(index++);
        if(ch == '\\') {
          if(index >= text.length()) {
            break;
          }
          char esc = text.charAt(index++);
          switch(esc) {
            case 'n': sb.append('\n'); break;
            case 'r': sb.append('\r'); break;
            case 't': sb.append('\t'); break;
            case 'b': sb.append('\b'); break;
            case 'f': sb.append('\f'); break;
            case '\\': sb.append('\\'); break;
            case '"': sb.append('"'); break;
            case '\'': sb.append('\''); break;
            case 'u': {
              if(index + 4 <= text.length()) {
                String hex = text.substring(index, index + 4);
                try {
                  sb.append((char) Integer.parseInt(hex, 16));
                  index += 4;
                } catch(Exception ex) {
                  sb.append('u').append(hex);
                  index += 4;
                }
              } else {
                sb.append('u');
              }
              break;
            }
            default:
              sb.append(esc);
              break;
          }
          continue;
        }
        if(ch == quote) {
          break;
        }
        sb.append(ch);
      }
      return sb.toString();
    }

    private String parseBareword() {
      int start = index;
      while(index < text.length()) {
        char ch = text.charAt(index);
        if(Character.isLetterOrDigit(ch) || ch == '_' || ch == '.') {
          index++;
        } else {
          break;
        }
      }
      return text.substring(start, index);
    }

    private void skipWhitespace() {
      while(index < text.length()) {
        char ch = text.charAt(index);
        if(Character.isWhitespace(ch)) {
          index++;
          continue;
        }
        if(ch == '-' && index + 1 < text.length() && text.charAt(index + 1) == '-') {
          index += 2;
          while(index < text.length() && text.charAt(index) != '\n' && text.charAt(index) != '\r') {
            index++;
          }
          continue;
        }
        break;
      }
    }

    private boolean peek(char ch) {
      return index < text.length() && text.charAt(index) == ch;
    }

    private void expect(char ch) {
      skipWhitespace();
      if(index >= text.length() || text.charAt(index) != ch) {
        throw new IllegalStateException("Expected '" + ch + "' at index=" + index);
      }
      index++;
    }

    private boolean startsWith(String value) {
      return text.regionMatches(index, value, 0, value.length());
    }
  }

  private static final class FieldSpan {
    final String key;
    final int valueStart;
    final int valueEnd;

    FieldSpan(String key, int valueStart, int valueEnd) {
      this.key = key;
      this.valueStart = valueStart;
      this.valueEnd = valueEnd;
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
    REWARD_GET_ITEM
  }

  private static final class Pair {
    Integer id;
    Integer count;
  }

  private static final class QuestRecord {
    int questId;
    String name;
    Integer needLevel;
    Integer needItem;
    Integer bqLoop;
    Integer rewardExp;
    Integer rewardMoney;
    Integer rewardFame;
    Integer rewardPvppoint;
    Integer rewardMileage;
    Object requstItem;
    final List<String> contents = new ArrayList<String>();
    final List<String> answer = new ArrayList<String>();
    final List<String> info = new ArrayList<String>();
    final List<Pair> goalGetItem = new ArrayList<Pair>();
    final List<Pair> goalKillMonster = new ArrayList<Pair>();
    final List<Integer> goalMeetNpc = new ArrayList<Integer>();
    final List<Pair> rewardGetItem = new ArrayList<Pair>();
    final List<Integer> rewardGetSkill = new ArrayList<Integer>();
  }

  public static final class ExportResult {
    int questCount;
    int profileQuestCount;
    int profileMissingQuestCount;
    int suppressedFieldCount;
    Path referenceQuestLua;
    final List<String> suppressedFieldExamples = new ArrayList<String>();
  }
}
