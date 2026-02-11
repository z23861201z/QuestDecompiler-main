package unluac.semantic;

import java.nio.charset.Charset;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.OffsetDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import unluac.chunk.Lua50ChunkParser;
import unluac.chunk.LuaChunk;

/**
 * Phase4 导出校验器：对比原始 quest.luc 与 Phase4 导出的 quest.lua 语义一致性。
 *
 * <p>所属链路：链路 B 的质量门禁阶段（quest 分支）。</p>
 * <p>输入：原始 quest.luc、phase4_exported_quest.lua。</p>
 * <p>输出：phase4_export_validation.json。</p>
 * <p>数据库副作用：无。</p>
 * <p>文件副作用：写校验报告。</p>
 */
public class Phase4QuestExportValidator {

  private static final Charset UTF8 = Charset.forName("UTF-8");

  /**
   * 命令行入口。
   * @param args 方法参数
   * @throws Exception 处理失败时抛出
   */
  public static void main(String[] args) throws Exception {
    Path originalQuestLuc = args.length >= 1
        ? Paths.get(args[0])
        : Paths.get("D:/TitanGames/GhostOnline/zChina/Script/quest.luc");
    Path exportedQuestLua = args.length >= 2
        ? Paths.get(args[1])
        : Paths.get("reports", "phase4_exported_quest.lua");
    Path output = args.length >= 3
        ? Paths.get(args[2])
        : Paths.get("reports", "phase4_export_validation.json");

    long start = System.nanoTime();
    Phase4QuestExportValidator validator = new Phase4QuestExportValidator();
    ValidationResult result = validator.validate(originalQuestLuc, exportedQuestLua, output);
    long elapsed = (System.nanoTime() - start) / 1_000_000L;

    System.out.println("totalComparedQuests=" + result.totalComparedQuests);
    System.out.println("mismatchCount=" + result.mismatchCount);
    System.out.println("finalStatus=" + result.finalStatus);
    System.out.println("validateMillis=" + elapsed);
    System.out.println("output=" + output.toAbsolutePath());
  }

  /**
   * 执行 quest 导出一致性校验。
   *
   * @param originalQuestLuc 原始 quest.luc
   * @param exportedQuestLua Phase4 导出的 quest.lua
   * @param output 校验报告输出路径
   * @return 校验结果
   * @throws Exception 输入缺失、解析失败或写报告失败时抛出
   */
  public ValidationResult validate(Path originalQuestLuc,
                                   Path exportedQuestLua,
                                   Path output) throws Exception {
    if(originalQuestLuc == null || !Files.exists(originalQuestLuc) || !Files.isRegularFile(originalQuestLuc)) {
      throw new IllegalStateException("original quest.luc not found: " + originalQuestLuc);
    }
    if(exportedQuestLua == null || !Files.exists(exportedQuestLua) || !Files.isRegularFile(exportedQuestLua)) {
      throw new IllegalStateException("exported quest lua not found: " + exportedQuestLua);
    }

    Map<Integer, QuestValue> original = loadQuestValuesFromLuc(originalQuestLuc);
    Map<Integer, QuestValue> exported = loadQuestValuesFromPhase4Lua(exportedQuestLua);

    ValidationResult result = new ValidationResult();
    result.totalComparedQuests = original.size();

    for(Map.Entry<Integer, QuestValue> entry : original.entrySet()) {
      int questId = entry.getKey().intValue();
      QuestValue source = entry.getValue();
      QuestValue target = exported.get(Integer.valueOf(questId));
      if(target == null) {
        result.addMismatch(questId, "quest", source.toJson(), "<missing>");
        continue;
      }

      compareScalar(result, questId, "name", source.name, target.name);
      compareScalar(result, questId, "needLevel", source.needLevel, target.needLevel);
      compareScalar(result, questId, "bQLoop", source.bqLoop, target.bqLoop);
      compareScalar(result, questId, "reward.exp", source.rewardExp, target.rewardExp);
      compareScalar(result, questId, "reward.gold", source.rewardGold, target.rewardGold);

      compareStringList(result, questId, "contents", source.contents, target.contents);
      compareStringList(result, questId, "answer", source.answer, target.answer);
      compareStringList(result, questId, "info", source.info, target.info);

      comparePairList(result, questId, "goal.getItem", source.goalGetItem, target.goalGetItem);
      comparePairList(result, questId, "goal.killMonster", source.goalKillMonster, target.goalKillMonster);
      compareIntegerList(result, questId, "goal.meetNpc", source.goalMeetNpc, target.goalMeetNpc);
      comparePairList(result, questId, "reward.items", source.rewardItems, target.rewardItems);
    }

    for(Integer questId : exported.keySet()) {
      if(!original.containsKey(questId)) {
        QuestValue extra = exported.get(questId);
        result.addMismatch(questId.intValue(), "quest", "<missing>", extra == null ? "null" : extra.toJson());
      }
    }

    result.mismatchCount = result.mismatchDetails.size();
    result.finalStatus = result.mismatchCount == 0 ? "SAFE" : "UNSAFE";

    ensureParent(output);
    Files.write(output, result.toJson().getBytes(UTF8));

    if(result.mismatchCount > 0) {
      throw new IllegalStateException("Phase4 export validation failed: mismatchCount=" + result.mismatchCount);
    }
    return result;
  }

  /**
   * Load load Quest Values From Luc from data source.
   * @param questLuc 方法参数
   * @return 计算结果
   * @throws Exception 处理失败时抛出
   */
  private Map<Integer, QuestValue> loadQuestValuesFromLuc(Path questLuc) throws Exception {
    byte[] data = Files.readAllBytes(questLuc);
    LuaChunk chunk = new Lua50ChunkParser().parse(data);
    QuestSemanticExtractor extractor = new QuestSemanticExtractor();
    QuestSemanticExtractor.ExtractionResult extraction = extractor.extract(chunk);

    Map<Integer, QuestValue> out = new LinkedHashMap<Integer, QuestValue>();
    Map<Integer, DialogArrays> dialogs = collectDialogs(extraction.fieldBindings);
    Map<Integer, Integer> bqLoopMap = collectIntField(extraction.fieldBindings, "condition_json.bQLoop");

    for(QuestSemanticModel model : extraction.quests) {
      if(model == null || model.questId <= 0) {
        continue;
      }

      QuestValue quest = new QuestValue();
      quest.questId = model.questId;
      quest.name = model.title;

      DialogArrays arrays = dialogs.get(Integer.valueOf(model.questId));
      if(arrays != null) {
        quest.contents.addAll(arrays.contents);
        quest.answer.addAll(arrays.answer);
        quest.info.addAll(arrays.info);
      }

      quest.needLevel = Integer.valueOf(model.goal == null ? 0 : model.goal.needLevel);
      quest.bqLoop = bqLoopMap.containsKey(Integer.valueOf(model.questId))
          ? bqLoopMap.get(Integer.valueOf(model.questId))
          : Integer.valueOf(0);

      if(model.goal != null) {
        for(ItemRequirement item : model.goal.items) {
          PairValue pair = new PairValue();
          pair.id = Integer.valueOf(item.itemId);
          pair.count = Integer.valueOf(item.itemCount);
          quest.goalGetItem.add(pair);
        }
        for(KillRequirement kill : model.goal.monsters) {
          PairValue pair = new PairValue();
          pair.id = Integer.valueOf(kill.monsterId);
          pair.count = Integer.valueOf(kill.killCount);
          quest.goalKillMonster.add(pair);
        }
      }

      Object goalObj = model.completionConditions.get("goal");
      if(goalObj instanceof Map<?, ?>) {
        @SuppressWarnings("unchecked")
        Map<String, Object> goalMap = (Map<String, Object>) goalObj;
        appendMeetNpc(quest.goalMeetNpc, goalMap.get("meetNpc"));
      }

      if(model.rewards != null) {
        int rewardExp = 0;
        int rewardGold = 0;
        for(QuestSemanticModel.Reward reward : model.rewards) {
          if(reward == null) {
            continue;
          }
          rewardExp += reward.exp;
          rewardGold += reward.money;
          if(reward.id > 0 && reward.count > 0) {
            PairValue pair = new PairValue();
            pair.id = Integer.valueOf(reward.id);
            pair.count = Integer.valueOf(reward.count);
            quest.rewardItems.add(pair);
          }
        }
        quest.rewardExp = Integer.valueOf(rewardExp);
        quest.rewardGold = Integer.valueOf(rewardGold);
      }

      out.put(Integer.valueOf(quest.questId), quest);
    }

    return out;
  }

  /**
   * Load load Quest Values From Phase4 Lua from data source.
   * @param exportedQuestLua 方法参数
   * @return 计算结果
   * @throws Exception 处理失败时抛出
   */
  private Map<Integer, QuestValue> loadQuestValuesFromPhase4Lua(Path exportedQuestLua) throws Exception {
    String text = new String(Files.readAllBytes(exportedQuestLua), UTF8);
    Map<Integer, QuestValue> out = new LinkedHashMap<Integer, QuestValue>();

    String marker = "qt[";
    int cursor = 0;
    while(cursor < text.length()) {
      int qStart = text.indexOf(marker, cursor);
      if(qStart < 0) {
        break;
      }
      int idStart = qStart + marker.length();
      int idEnd = idStart;
      while(idEnd < text.length() && Character.isDigit(text.charAt(idEnd))) {
        idEnd++;
      }
      if(idEnd == idStart) {
        cursor = qStart + marker.length();
        continue;
      }

      int questId;
      try {
        questId = Integer.parseInt(text.substring(idStart, idEnd));
      } catch(Exception ex) {
        cursor = idEnd;
        continue;
      }

      int brace = text.indexOf('{', idEnd);
      if(brace < 0) {
        break;
      }
      int endBrace = findMatchingBrace(text, brace);
      if(endBrace < 0) {
        throw new IllegalStateException("Unmatched quest block for questId=" + questId);
      }

      String block = text.substring(brace, endBrace + 1);
      LuaTableParser parser = new LuaTableParser(block);
      Object parsed = parser.parseValue();
      if(!(parsed instanceof Map<?, ?>)) {
        throw new IllegalStateException("Invalid quest table for questId=" + questId);
      }

      @SuppressWarnings("unchecked")
      Map<String, Object> map = (Map<String, Object>) parsed;
      QuestValue quest = fromMapToQuestValue(map, questId);
      out.put(Integer.valueOf(questId), quest);
      cursor = endBrace + 1;
    }

    return out;
  }

  /**
   * 计算并返回结果。
   * @param Map<String 方法参数
   * @param map 方法参数
   * @param fallbackQuestId 方法参数
   * @return 计算结果
   */
  private QuestValue fromMapToQuestValue(Map<String, Object> map, int fallbackQuestId) {
    QuestValue quest = new QuestValue();
    quest.questId = intOrFallback(map.get("id"), fallbackQuestId);
    quest.name = asNullableString(map.get("name"));

    quest.contents.addAll(asStringList(map.get("contents")));
    quest.answer.addAll(asStringList(map.get("answer")));
    quest.info.addAll(asStringList(map.get("info")));

    Map<String, Object> goal = asMap(map.get("goal"));
    quest.goalGetItem.addAll(asPairList(goal.get("getItem"), "id", "count"));
    quest.goalKillMonster.addAll(asPairList(goal.get("killMonster"), "id", "count"));
    quest.goalMeetNpc.addAll(asIntegerList(goal.get("meetNpc")));

    Map<String, Object> reward = asMap(map.get("reward"));
    quest.rewardExp = asNullableInteger(reward.get("exp"));
    quest.rewardGold = asNullableInteger(reward.get("gold"));
    quest.rewardItems.addAll(asPairList(reward.get("items"), "id", "count"));

    quest.needLevel = asNullableInteger(map.get("needLevel"));
    quest.bqLoop = asNullableInteger(map.get("bQLoop"));
    return quest;
  }

  /**
   * 计算并返回结果。
   * @param value 方法参数
   * @param fallback 方法参数
   * @return 计算结果
   */
  private int intOrFallback(Object value, int fallback) {
    Integer parsed = asNullableInteger(value);
    return parsed == null ? fallback : parsed.intValue();
  }

  /**
   * Compare scalar field values and record mismatch detail.
   */
  private void compareScalar(ValidationResult result,
                             int questId,
                             String path,
                             Object original,
                             Object exported) {
    if(original == null && exported == null) {
      return;
    }
    if(original == null || exported == null || !original.equals(exported)) {
      result.addMismatch(questId, path, stringify(original), stringify(exported));
    }
  }

  /**
   * Compare ordered string array values.
   */
  private void compareStringList(ValidationResult result,
                                 int questId,
                                 String path,
                                 List<String> original,
                                 List<String> exported) {
    int size = Math.max(original.size(), exported.size());
    for(int i = 0; i < size; i++) {
      String left = i < original.size() ? original.get(i) : null;
      String right = i < exported.size() ? exported.get(i) : null;
      if(left == null && right == null) {
        continue;
      }
      if(left == null || right == null || !left.equals(right)) {
        result.addMismatch(questId, path + "[" + i + "]", stringify(left), stringify(right));
      }
    }
  }

  /**
   * Compare ordered integer array values.
   */
  private void compareIntegerList(ValidationResult result,
                                  int questId,
                                  String path,
                                  List<Integer> original,
                                  List<Integer> exported) {
    int size = Math.max(original.size(), exported.size());
    for(int i = 0; i < size; i++) {
      Integer left = i < original.size() ? original.get(i) : null;
      Integer right = i < exported.size() ? exported.get(i) : null;
      if(left == null && right == null) {
        continue;
      }
      if(left == null || right == null || left.intValue() != right.intValue()) {
        result.addMismatch(questId, path + "[" + i + "]", stringify(left), stringify(right));
      }
    }
  }

  /**
   * Compare ordered pair-array values.
   */
  private void comparePairList(ValidationResult result,
                               int questId,
                               String path,
                               List<PairValue> original,
                               List<PairValue> exported) {
    int size = Math.max(original.size(), exported.size());
    for(int i = 0; i < size; i++) {
      PairValue left = i < original.size() ? original.get(i) : null;
      PairValue right = i < exported.size() ? exported.get(i) : null;
      if(left == null && right == null) {
        continue;
      }
      boolean same = left != null && right != null
          && equalsNullable(left.id, right.id)
          && equalsNullable(left.count, right.count);
      if(!same) {
        result.addMismatch(questId, path + "[" + i + "]", pairText(left), pairText(right));
      }
    }
  }

  /**
   * 计算并返回结果。
   * @param left 方法参数
   * @param right 方法参数
   * @return 计算结果
   */
  private boolean equalsNullable(Integer left, Integer right) {
    if(left == null && right == null) {
      return true;
    }
    if(left == null || right == null) {
      return false;
    }
    return left.intValue() == right.intValue();
  }

  /**
   * 计算并返回结果。
   * @param value 方法参数
   * @return 计算结果
   */
  private String pairText(PairValue value) {
    if(value == null) {
      return "null";
    }
    return "{id=" + stringify(value.id) + ",count=" + stringify(value.count) + "}";
  }

  /**
   * 计算并返回结果。
   * @param value 方法参数
   * @return 计算结果
   */
  private String stringify(Object value) {
    return value == null ? "null" : String.valueOf(value);
  }

  /**
   * 将数据追加到目标容器。
   * @param out 方法参数
   * @param value 方法参数
   */
  private void appendMeetNpc(List<Integer> out, Object value) {
    if(value == null) {
      return;
    }
    if(value instanceof Number) {
      out.add(Integer.valueOf(((Number) value).intValue()));
      return;
    }
    if(value instanceof List<?>) {
      @SuppressWarnings("unchecked")
      List<Object> list = (List<Object>) value;
      for(Object item : list) {
        appendMeetNpc(out, item);
      }
    }
  }

  /**
   * 收集数据，供后续处理使用。
   * @param bindings 方法参数
   * @return 计算结果
   */
  private Map<Integer, DialogArrays> collectDialogs(List<QuestSemanticExtractor.FieldBinding> bindings) {
    Map<Integer, DialogArrays> out = new LinkedHashMap<Integer, DialogArrays>();
    for(QuestSemanticExtractor.FieldBinding binding : bindings) {
      if(binding == null || !"string".equals(binding.valueType) || binding.fieldKey == null) {
        continue;
      }
      if(!binding.fieldKey.startsWith("dialog_lines_json[")) {
        continue;
      }
      int close = binding.fieldKey.indexOf(']');
      if(close < 0 || close + 2 > binding.fieldKey.length()) {
        continue;
      }
      if(binding.fieldKey.charAt(close + 1) != '.') {
        continue;
      }
      String field = binding.fieldKey.substring(close + 2);
      DialogArrays arrays = out.get(Integer.valueOf(binding.questId));
      if(arrays == null) {
        arrays = new DialogArrays();
        out.put(Integer.valueOf(binding.questId), arrays);
      }
      if("contents".equals(field)) {
        arrays.contents.add(binding.stringValue);
      } else if("answer".equals(field)) {
        arrays.answer.add(binding.stringValue);
      } else if("info".equals(field)) {
        arrays.info.add(binding.stringValue);
      }
    }
    return out;
  }

  /**
   * Collect integer binding value by quest id.
   */
  private Map<Integer, Integer> collectIntField(List<QuestSemanticExtractor.FieldBinding> bindings,
                                                String fieldKey) {
    Map<Integer, Integer> out = new LinkedHashMap<Integer, Integer>();
    for(QuestSemanticExtractor.FieldBinding binding : bindings) {
      if(binding == null || binding.fieldKey == null) {
        continue;
      }
      if(!fieldKey.equals(binding.fieldKey)) {
        continue;
      }
      if(!"number".equals(binding.valueType) || binding.numberValue == null) {
        continue;
      }
      out.put(Integer.valueOf(binding.questId), Integer.valueOf(binding.numberValue.intValue()));
    }
    return out;
  }

  /**
   * 计算并返回结果。
   * @param value 方法参数
   * @return 计算结果
   */
  private Integer asNullableInteger(Object value) {
    if(value == null) {
      return null;
    }
    if(value instanceof Number) {
      return Integer.valueOf(((Number) value).intValue());
    }
    String text = String.valueOf(value).trim();
    if(text.isEmpty()) {
      return null;
    }
    try {
      return Integer.valueOf(Integer.parseInt(text));
    } catch(Exception ex) {
      return null;
    }
  }

  /**
   * 计算并返回结果。
   * @param value 方法参数
   * @return 计算结果
   */
  private String asNullableString(Object value) {
    if(value == null) {
      return null;
    }
    return String.valueOf(value);
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
      out.add(item == null ? null : String.valueOf(item));
    }
    return out;
  }

  /**
   * 计算并返回结果。
   * @param value 方法参数
   * @return 计算结果
   */
  private List<Integer> asIntegerList(Object value) {
    List<Integer> out = new ArrayList<Integer>();
    if(!(value instanceof List<?>)) {
      return out;
    }
    @SuppressWarnings("unchecked")
    List<Object> list = (List<Object>) value;
    for(Object item : list) {
      out.add(asNullableInteger(item));
    }
    return out;
  }

  /**
   * 计算并返回结果。
   * @param value 方法参数
   * @param idKey 方法参数
   * @param countKey 方法参数
   * @return 计算结果
   */
  private List<PairValue> asPairList(Object value, String idKey, String countKey) {
    List<PairValue> out = new ArrayList<PairValue>();
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
      PairValue pair = new PairValue();
      pair.id = asNullableInteger(map.get(idKey));
      pair.count = asNullableInteger(map.get(countKey));
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
   * @param text 方法参数
   * @param openIndex 方法参数
   * @return 计算结果
   */
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

  private static final class DialogArrays {
    final List<String> contents = new ArrayList<String>();
    final List<String> answer = new ArrayList<String>();
    final List<String> info = new ArrayList<String>();
  }

  private static final class PairValue {
    Integer id;
    Integer count;
  }

  private static final class QuestValue {
    int questId;
    String name;
    Integer needLevel;
    Integer bqLoop;
    Integer rewardExp;
    Integer rewardGold;
    final List<String> contents = new ArrayList<String>();
    final List<String> answer = new ArrayList<String>();
    final List<String> info = new ArrayList<String>();
    final List<PairValue> goalGetItem = new ArrayList<PairValue>();
    final List<PairValue> goalKillMonster = new ArrayList<PairValue>();
    final List<Integer> goalMeetNpc = new ArrayList<Integer>();
    final List<PairValue> rewardItems = new ArrayList<PairValue>();

    String toJson() {
      StringBuilder sb = new StringBuilder();
      sb.append("{")
          .append("\"questId\":").append(questId)
          .append(",\"name\":").append(QuestSemanticJson.jsonString(name))
          .append(",\"needLevel\":").append(needLevel == null ? "null" : needLevel)
          .append(",\"bQLoop\":").append(bqLoop == null ? "null" : bqLoop)
          .append(",\"rewardExp\":").append(rewardExp == null ? "null" : rewardExp)
          .append(",\"rewardGold\":").append(rewardGold == null ? "null" : rewardGold)
          .append("}");
      return sb.toString();
    }
  }

  public static final class ValidationResult {
    int totalComparedQuests;
    int mismatchCount;
    final List<Map<String, Object>> mismatchDetails = new ArrayList<Map<String, Object>>();
    String finalStatus = "UNSAFE";

    void addMismatch(int questId, String fieldPath, String originalValue, String exportedValue) {
      Map<String, Object> item = new LinkedHashMap<String, Object>();
      item.put("questId", Integer.valueOf(questId));
      item.put("fieldPath", fieldPath);
      item.put("originalValue", originalValue);
      item.put("exportedValue", exportedValue);
      mismatchDetails.add(item);
    }

    String toJson() {
      StringBuilder sb = new StringBuilder();
      sb.append("{\n");
      sb.append("  \"generatedAt\": ").append(QuestSemanticJson.jsonString(OffsetDateTime.now().format(DateTimeFormatter.ISO_OFFSET_DATE_TIME))).append(",\n");
      sb.append("  \"totalComparedQuests\": ").append(totalComparedQuests).append(",\n");
      sb.append("  \"mismatchCount\": ").append(mismatchCount).append(",\n");
      sb.append("  \"mismatchDetails\": ").append(toJsonArrayOfObject(mismatchDetails)).append(",\n");
      sb.append("  \"finalStatus\": ").append(QuestSemanticJson.jsonString(finalStatus)).append("\n");
      sb.append("}\n");
      return sb.toString();
    }

    /**
     * 将to Json Array Of Object序列化为 JSON 文本。
     * @param List<Map<String 方法参数
     * @param list 方法参数
     * @return 计算结果
     */
    private String toJsonArrayOfObject(List<Map<String, Object>> list) {
      StringBuilder sb = new StringBuilder();
      sb.append('[');
      for(int i = 0; i < list.size(); i++) {
        if(i > 0) {
          sb.append(',');
        }
        sb.append(QuestSemanticJson.toJsonObject(list.get(i)));
      }
      sb.append(']');
      return sb.toString();
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

    /**
     * 解析来源数据。
     * @return 计算结果
     */
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

    /**
     * 计算并返回结果。
     * @return 计算结果
     */
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

    /**
     * 解析来源数据。
     * @return 计算结果
     */
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

    /**
     * 解析来源数据。
     * @return 计算结果
     */
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

    /**
     * 解析来源数据。
     * @return 计算结果
     */
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

    /**
     * 处理skip Whitespace辅助逻辑。
     */
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

    /**
     * 计算并返回结果。
     * @param ch 方法参数
     * @return 计算结果
     */
    private boolean peek(char ch) {
      return index < text.length() && text.charAt(index) == ch;
    }

    /**
     * 处理expect辅助逻辑。
     * @param ch 方法参数
     */
    private void expect(char ch) {
      skipWhitespace();
      if(index >= text.length() || text.charAt(index) != ch) {
        throw new IllegalStateException("Expected '" + ch + "' at index=" + index);
      }
      index++;
    }

    /**
     * 计算并返回结果。
     * @param value 方法参数
     * @return 计算结果
     */
    private boolean startsWith(String value) {
      return text.regionMatches(index, value, 0, value.length());
    }
  }
}
