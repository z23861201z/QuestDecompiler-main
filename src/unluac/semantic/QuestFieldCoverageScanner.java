package unluac.semantic;

import java.nio.charset.Charset;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.LinkedHashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Set;

import unluac.chunk.Lua50ChunkParser;
import unluac.chunk.LuaChunk;

public class QuestFieldCoverageScanner {

  private static final List<String> EDITOR_QUEST_FIELDS = Arrays.asList(
      "id", "name", "contents", "answer", "info", "npcsay", "needLevel", "needQuest", "goal", "reward", "requstItem");
  private static final List<String> EDITOR_GOAL_FIELDS = Arrays.asList(
      "getItem", "killMonster", "id", "itemid", "itemcnt", "count", "meetcnt", "monsterid", "killcount");
  private static final List<String> EDITOR_REWARD_FIELDS = Arrays.asList(
      "exp", "fame", "money", "pvppoint", "getItem", "getSkill", "id", "itemid", "count", "itemcnt");
  private static final List<String> EDITOR_NPC_ACTIONS = Arrays.asList(
      "NPC_SAY", "ADD_QUEST_BTN", "SET_QUEST_STATE", "CHECK_ITEM_CNT");

  public static void main(String[] args) throws Exception {
    if(args.length < 1) {
      printUsage();
      return;
    }
    Path input = Paths.get(args[0]);
    Path outputReport = args.length >= 2 ? Paths.get(args[1]) : Paths.get("documentation", "quest_field_scan_report.md");
    scanAndWrite(input, outputReport);
  }

  public static void scanAndWrite(Path input, Path outputReport) throws Exception {
    ScanSummary summary = scan(input);
    String markdown = buildMarkdown(input, summary);

    Path parent = outputReport.getParent();
    if(parent != null && !Files.exists(parent)) {
      Files.createDirectories(parent);
    }
    Files.write(outputReport, markdown.getBytes(Charset.forName("UTF-8")));

    System.out.println("input=" + input);
    System.out.println("output=" + outputReport);
    System.out.println("quest_script_files=" + summary.quest.scriptFileCount);
    System.out.println("quest_count=" + summary.quest.questIds.size());
    System.out.println("quest_fields=" + summary.quest.questFieldStats.size());
    System.out.println("goal_fields=" + summary.quest.goalFieldStats.size());
    System.out.println("reward_fields=" + summary.quest.rewardFieldStats.size());
    System.out.println("npc_script_files=" + summary.npc.npcFileCount);
    System.out.println("npc_calls_total=" + summary.npc.callCountTotal);
    System.out.println("npc_calls_unresolved=" + summary.npc.unresolvedCallCount);
  }

  public static ScanSummary scan(Path input) throws Exception {
    ScanSummary out = new ScanSummary();
    if(input == null) {
      return out;
    }
    if(Files.isDirectory(input)) {
      scanDirectory(input, out);
      return out;
    }
    scanSingleFile(input, out);
    return out;
  }

  private static void scanDirectory(Path directory, ScanSummary out) throws Exception {
    List<Path> lucFiles = new ArrayList<Path>();
    Files.walk(directory)
        .filter(Files::isRegularFile)
        .filter(path -> path.getFileName().toString().toLowerCase(Locale.ROOT).endsWith(".luc"))
        .forEach(lucFiles::add);
    Collections.sort(lucFiles);
    for(Path luc : lucFiles) {
      scanSingleFile(luc, out);
    }
  }

  private static void scanSingleFile(Path file, ScanSummary out) throws Exception {
    if(file == null || !Files.exists(file) || !Files.isRegularFile(file)) {
      return;
    }
    LuaChunk chunk = new Lua50ChunkParser().parse(Files.readAllBytes(file));
    ScriptTypeDetector detector = new ScriptTypeDetector();
    ScriptTypeDetector.DetectionResult detected = detector.inspect(chunk);

    String fileName = file.getFileName().toString().toLowerCase(Locale.ROOT);
    boolean questLike = detected.scriptType == ScriptTypeDetector.ScriptType.QUEST_DEFINITION || "quest.luc".equals(fileName);
    boolean npcLike = detected.scriptType == ScriptTypeDetector.ScriptType.NPC_SCRIPT || fileName.startsWith("npc_");
    if(questLike) {
      scanQuestFile(file, chunk, out);
    }
    if(npcLike) {
      scanNpcFile(file, chunk, detected, out);
    }
  }

  private static void scanQuestFile(Path file, LuaChunk chunk, ScanSummary out) {
    QuestSemanticExtractor extractor = new QuestSemanticExtractor();
    QuestSemanticExtractor.FieldInventoryScanResult scan = extractor.scanFieldInventory(chunk);
    out.quest.scriptFileCount++;
    out.quest.scriptFiles.add(file.toString());
    out.quest.questIds.addAll(scan.questIds);
    mergeFieldStats(scan.questFieldStats, out.quest.questFieldStats, "Quest", file);
    mergeFieldStats(scan.goalFieldStats, out.quest.goalFieldStats, "Goal", file);
    mergeFieldStats(scan.rewardFieldStats, out.quest.rewardFieldStats, "Reward", file);
  }

  private static void scanNpcFile(Path file,
                                  LuaChunk chunk,
                                  ScriptTypeDetector.DetectionResult detected,
                                  ScanSummary out) {
    out.npc.npcFileCount++;
    out.npc.scriptFiles.add(file.toString());
    out.npc.globalFunctionNames.addAll(detected.globalFunctionNames);

    NpcSemanticExtractor semanticExtractor = new NpcSemanticExtractor();
    NpcScriptModel semantic = semanticExtractor.extract(chunk);
    out.npc.relatedQuestIds.addAll(semantic.relatedQuestIds);

    NpcCallScanResult callScan = scanNpcCalls(chunk);
    out.npc.callCountTotal += callScan.totalCalls;
    out.npc.unresolvedCallCount += callScan.unresolvedCalls;
    mergeCountMap(callScan.callCounts, out.npc.callCounts);
    mergeCountMap(callScan.recognizedActionCounts, out.npc.recognizedActionCounts);
    mergeCountMap(callScan.unrecognizedMethodCounts, out.npc.unrecognizedMethodCounts);
  }

  private static void mergeFieldStats(Map<String, QuestSemanticExtractor.FieldStat> incoming,
                                      Map<String, FieldSummary> target,
                                      String layer,
                                      Path file) {
    for(Map.Entry<String, QuestSemanticExtractor.FieldStat> entry : incoming.entrySet()) {
      String field = entry.getKey();
      QuestSemanticExtractor.FieldStat src = entry.getValue();
      if(field == null || field.isEmpty() || src == null) {
        continue;
      }
      FieldSummary stat = target.get(field);
      if(stat == null) {
        stat = new FieldSummary(field, layer);
        target.put(field, stat);
      }
      stat.count += src.count;
      if((stat.exampleValue == null || stat.exampleValue.isEmpty()) && src.exampleValue != null && !src.exampleValue.isEmpty()) {
        stat.exampleValue = src.exampleValue;
        stat.exampleQuestId = src.exampleQuestId;
        stat.exampleFile = file == null ? "" : file.toString();
      }
    }
  }

  private static void mergeCountMap(Map<String, Integer> incoming, Map<String, Integer> target) {
    for(Map.Entry<String, Integer> entry : incoming.entrySet()) {
      increment(target, entry.getKey(), entry.getValue() == null ? 0 : entry.getValue().intValue());
    }
  }

  private static void increment(Map<String, Integer> map, String key, int delta) {
    if(key == null || key.isEmpty() || delta <= 0) {
      return;
    }
    Integer old = map.get(key);
    map.put(key, Integer.valueOf((old == null ? 0 : old.intValue()) + delta));
  }

  private static String buildMarkdown(Path input, ScanSummary summary) {
    Set<String> questFieldNames = summary.quest.questFieldStats.keySet();
    Set<String> goalFieldNames = summary.quest.goalFieldStats.keySet();
    Set<String> rewardFieldNames = summary.quest.rewardFieldStats.keySet();

    DiffResult questDiff = diff(questFieldNames, new LinkedHashSet<String>(EDITOR_QUEST_FIELDS));
    DiffResult goalDiff = diff(goalFieldNames, new LinkedHashSet<String>(EDITOR_GOAL_FIELDS));
    DiffResult rewardDiff = diff(rewardFieldNames, new LinkedHashSet<String>(EDITOR_REWARD_FIELDS));
    DiffResult npcActionDiff = diff(summary.npc.recognizedActionCounts.keySet(), new LinkedHashSet<String>(EDITOR_NPC_ACTIONS));

    StringBuilder sb = new StringBuilder();
    sb.append("# Quest/NPC 字段全量穷举扫描报告\n\n");
    sb.append("- 输入目录: `").append(input).append("`\n");
    sb.append("- Quest 脚本文件数: `").append(summary.quest.scriptFileCount).append("`\n");
    sb.append("- Quest ID 数量: `").append(summary.quest.questIds.size()).append("`\n");
    sb.append("- NPC 脚本文件数: `").append(summary.npc.npcFileCount).append("`\n");
    sb.append("- NPC 函数调用总数: `").append(summary.npc.callCountTotal).append("`\n");
    sb.append("- NPC 未解析调用数: `").append(summary.npc.unresolvedCallCount).append("`\n\n");

    sb.append("## 第一部分：Quest 结构字段穷举\n\n");
    appendFieldTable(sb, "Quest 层字段", sortFieldSummaries(summary.quest.questFieldStats));
    appendFieldTable(sb, "Goal 层字段", sortFieldSummaries(summary.quest.goalFieldStats));
    appendFieldTable(sb, "Reward 层字段", sortFieldSummaries(summary.quest.rewardFieldStats));

    sb.append("### 指定字段命中统计\n\n");
    appendRequiredQuestFieldLine(sb, summary.quest.questFieldStats, "goal");
    appendRequiredQuestFieldLine(sb, summary.quest.questFieldStats, "reward");
    appendRequiredQuestFieldLine(sb, summary.quest.questFieldStats, "requstItem");
    appendRequiredQuestFieldLine(sb, summary.quest.questFieldStats, "needItem");
    appendRequiredQuestFieldLine(sb, summary.quest.questFieldStats, "deleteItem");
    appendRequiredQuestFieldLine(sb, summary.quest.questFieldStats, "needQuest");
    sb.append("\n");

    sb.append("## 第二部分：NPC 行为字段穷举\n\n");
    sb.append("### 指定方法调用统计\n\n");
    for(String action : EDITOR_NPC_ACTIONS) {
      int count = summary.npc.recognizedActionCounts.getOrDefault(action, Integer.valueOf(0)).intValue();
      sb.append("- `").append(action).append("`: `").append(count).append("`\n");
    }
    sb.append("\n");

    sb.append("### 全部函数调用统计\n\n");
    appendCountTable(sb, sortCountEntries(summary.npc.callCounts), "function_name", "count");

    sb.append("### 未识别方法列表\n\n");
    appendCountTable(sb, sortCountEntries(summary.npc.unrecognizedMethodCounts), "method_name", "count");

    sb.append("## 第三部分：字段标准化\n\n");
    List<VariantGroup> questVariants = findVariantGroups(questFieldNames, new LinkedHashSet<String>(EDITOR_QUEST_FIELDS));
    List<VariantGroup> goalVariants = findVariantGroups(goalFieldNames, new LinkedHashSet<String>(EDITOR_GOAL_FIELDS));
    List<VariantGroup> rewardVariants = findVariantGroups(rewardFieldNames, new LinkedHashSet<String>(EDITOR_REWARD_FIELDS));
    List<VariantGroup> npcVariants = findVariantGroups(summary.npc.callCounts.keySet(), new LinkedHashSet<String>(EDITOR_NPC_ACTIONS));
    appendVariantSection(sb, "Quest 字段大小写归一", questVariants);
    appendVariantSection(sb, "Goal 字段大小写归一", goalVariants);
    appendVariantSection(sb, "Reward 字段大小写归一", rewardVariants);
    appendVariantSection(sb, "NPC 方法命名归一", npcVariants);

    sb.append("## 第四部分：字段覆盖率报告\n\n");
    sb.append("```json\n");
    sb.append(buildCoverageJson(summary));
    sb.append("\n```\n\n");

    sb.append("### 缺失字段建议\n\n");
    sb.append("- Quest 缺失字段: ").append(listText(questDiff.missing)).append("\n");
    sb.append("- Goal 缺失字段: ").append(listText(goalDiff.missing)).append("\n");
    sb.append("- Reward 缺失字段: ").append(listText(rewardDiff.missing)).append("\n");
    sb.append("- NPC Action 缺失字段: ").append(listText(npcActionDiff.missing)).append("\n");
    sb.append("- NPC 未识别方法（需新增语义解析）: ").append(listText(summary.npc.unrecognizedMethodCounts.keySet())).append("\n\n");

    sb.append("### 字段分类建议\n\n");
    appendClassificationSection(sb, "Quest", questFieldNames);
    appendClassificationSection(sb, "Goal", goalFieldNames);
    appendClassificationSection(sb, "Reward", rewardFieldNames);
    appendNpcClassificationSection(sb, summary.npc.callCounts.keySet());

    return sb.toString();
  }

  private static NpcCallScanResult scanNpcCalls(LuaChunk chunk) {
    NpcCallScanResult out = new NpcCallScanResult();
    if(chunk == null || chunk.header == null || chunk.mainFunction == null) {
      return out;
    }

    Lua50InstructionCodec codec = new Lua50InstructionCodec(
        chunk.header.opSize,
        chunk.header.aSize,
        chunk.header.bSize,
        chunk.header.cSize);
    scanNpcFunctionRecursive(chunk.mainFunction, codec, out);
    return out;
  }

  private static void scanNpcFunctionRecursive(LuaChunk.Function function,
                                               Lua50InstructionCodec codec,
                                               NpcCallScanResult out) {
    if(function == null) {
      return;
    }

    RegisterValue[] registers = new RegisterValue[Math.max(128, function.maxStackSize + 64)];
    for(int pc = 0; pc < function.code.size(); pc++) {
      LuaChunk.Instruction inst = function.code.get(pc);
      Lua50InstructionCodec.DecodedInstruction decoded = codec.decode(inst.value);
      if(decoded.op == null) {
        continue;
      }

      switch(decoded.op) {
        case MOVE:
          setRegister(registers, decoded.A, getRegister(registers, decoded.B));
          break;

        case LOADK:
          setRegister(registers, decoded.A, constantValue(function, decoded.Bx));
          break;

        case LOADBOOL:
          setRegister(registers, decoded.A, RegisterValue.number(Integer.valueOf(decoded.B != 0 ? 1 : 0)));
          break;

        case LOADNIL: {
          int from = decoded.A;
          int to = decoded.B < decoded.A ? decoded.A : decoded.B;
          for(int reg = from; reg <= to; reg++) {
            setRegister(registers, reg, RegisterValue.unknown());
          }
          break;
        }

        case GETGLOBAL:
          setRegister(registers, decoded.A, RegisterValue.global(constantString(function, decoded.Bx)));
          break;

        case GETTABLE: {
          RegisterValue table = getRegister(registers, decoded.B);
          RegisterValue key = resolveRK(registers, function, decoded.C);
          if(table != null && !isEmpty(table.globalName) && key != null && !isEmpty(key.stringValue)) {
            setRegister(registers, decoded.A, RegisterValue.name(table.globalName + "." + key.stringValue));
          } else if(key != null && !isEmpty(key.stringValue)) {
            setRegister(registers, decoded.A, RegisterValue.name(key.stringValue));
          } else {
            setRegister(registers, decoded.A, RegisterValue.unknown());
          }
          break;
        }

        case CLOSURE:
          setRegister(registers, decoded.A, RegisterValue.name("closure@" + function.path + "/" + decoded.Bx));
          break;

        case CALL:
        case TAILCALL: {
          RegisterValue callee = getRegister(registers, decoded.A);
          String callName = resolveCallName(callee);

          out.totalCalls++;
          if(isEmpty(callName)) {
            out.unresolvedCalls++;
            increment(out.callCounts, "<UNRESOLVED_CALL>", 1);
          } else {
            increment(out.callCounts, callName, 1);
            String action = normalizeNpcAction(callName);
            if(action != null) {
              increment(out.recognizedActionCounts, action, 1);
            } else {
              increment(out.unrecognizedMethodCounts, callName, 1);
            }
          }
          clearCallResults(registers, decoded, 16);
          break;
        }

        default:
          break;
      }
    }

    for(LuaChunk.Function child : function.prototypes) {
      scanNpcFunctionRecursive(child, codec, out);
    }
  }

  private static RegisterValue resolveRK(RegisterValue[] registers, LuaChunk.Function function, int raw) {
    if(raw >= 256) {
      return constantValue(function, raw - 256);
    }
    return getRegister(registers, raw);
  }

  private static RegisterValue constantValue(LuaChunk.Function function, int index) {
    if(function == null || index < 0 || index >= function.constants.size()) {
      return RegisterValue.unknown();
    }
    LuaChunk.Constant constant = function.constants.get(index);
    if(constant == null) {
      return RegisterValue.unknown();
    }
    switch(constant.type) {
      case STRING:
        return RegisterValue.string(constant.stringValue == null ? "" : constant.stringValue.toDisplayString());
      case NUMBER: {
        int integer = (int) Math.round(constant.numberValue);
        if(Math.abs(constant.numberValue - integer) < 0.000001D) {
          return RegisterValue.number(Integer.valueOf(integer));
        }
        return RegisterValue.number(Integer.valueOf(integer));
      }
      default:
        return RegisterValue.unknown();
    }
  }

  private static String constantString(LuaChunk.Function function, int index) {
    if(function == null || index < 0 || index >= function.constants.size()) {
      return "";
    }
    LuaChunk.Constant constant = function.constants.get(index);
    if(constant == null || constant.type != LuaChunk.Constant.Type.STRING || constant.stringValue == null) {
      return "";
    }
    return constant.stringValue.toDisplayString();
  }

  private static RegisterValue getRegister(RegisterValue[] registers, int index) {
    if(index < 0 || index >= registers.length) {
      return RegisterValue.unknown();
    }
    RegisterValue value = registers[index];
    return value == null ? RegisterValue.unknown() : value;
  }

  private static void setRegister(RegisterValue[] registers, int index, RegisterValue value) {
    if(index < 0 || index >= registers.length) {
      return;
    }
    registers[index] = value == null ? RegisterValue.unknown() : value;
  }

  private static void clearCallResults(RegisterValue[] registers,
                                       Lua50InstructionCodec.DecodedInstruction decoded,
                                       int clearSpan) {
    int limit = Math.max(clearSpan, 16);
    if(decoded.C == 0) {
      for(int i = 0; i < limit; i++) {
        setRegister(registers, decoded.A + i, RegisterValue.unknown());
      }
      return;
    }
    int resultCount = Math.max(decoded.C - 1, 0);
    for(int i = 0; i < resultCount; i++) {
      setRegister(registers, decoded.A + i, RegisterValue.unknown());
    }
  }

  private static String resolveCallName(RegisterValue callee) {
    if(callee == null) {
      return "";
    }
    if(!isEmpty(callee.globalName)) {
      return callee.globalName;
    }
    if(!isEmpty(callee.rawName)) {
      return callee.rawName;
    }
    if(!isEmpty(callee.stringValue)) {
      return callee.stringValue;
    }
    return "";
  }

  private static void printUsage() {
    System.out.println("Usage:");
    System.out.println("  java -cp build unluac.semantic.QuestFieldCoverageScanner <quest.luc | script_dir> [output.md]");
  }

  private static DiffResult diff(Set<String> scanned, Set<String> supported) {
    DiffResult out = new DiffResult();
    out.scanned.addAll(scanned);
    out.supported.addAll(supported);
    for(String key : scanned) {
      if(!supported.contains(key)) {
        out.missing.add(key);
      }
    }
    return out;
  }

  private static List<FieldSummary> sortFieldSummaries(Map<String, FieldSummary> map) {
    List<FieldSummary> list = new ArrayList<FieldSummary>(map.values());
    Collections.sort(list, (a, b) -> {
      int cmp = Integer.compare(b.count, a.count);
      if(cmp != 0) {
        return cmp;
      }
      return a.name.compareToIgnoreCase(b.name);
    });
    return list;
  }

  private static List<Map.Entry<String, Integer>> sortCountEntries(Map<String, Integer> map) {
    List<Map.Entry<String, Integer>> list = new ArrayList<Map.Entry<String, Integer>>(map.entrySet());
    Collections.sort(list, (a, b) -> {
      int cmp = Integer.compare(b.getValue().intValue(), a.getValue().intValue());
      if(cmp != 0) {
        return cmp;
      }
      return a.getKey().compareToIgnoreCase(b.getKey());
    });
    return list;
  }

  private static void appendFieldTable(StringBuilder sb, String title, List<FieldSummary> rows) {
    sb.append("### ").append(title).append("\n\n");
    sb.append("| field | count | layer | example | example_quest_id | example_file |\n");
    sb.append("|---|---:|---|---|---:|---|\n");
    if(rows.isEmpty()) {
      sb.append("| (none) | 0 | - | - | 0 | - |\n\n");
      return;
    }
    for(FieldSummary row : rows) {
      sb.append("| ")
          .append(escapeMd(row.name)).append(" | ")
          .append(row.count).append(" | ")
          .append(escapeMd(row.layer)).append(" | ")
          .append(escapeMd(row.exampleValue)).append(" | ")
          .append(row.exampleQuestId).append(" | ")
          .append(escapeMd(row.exampleFile)).append(" |\n");
    }
    sb.append("\n");
  }

  private static void appendRequiredQuestFieldLine(StringBuilder sb,
                                                   Map<String, FieldSummary> map,
                                                   String field) {
    FieldSummary stat = map.get(field);
    if(stat == null) {
      sb.append("- `").append(field).append("`: count=`0`, example=`(none)`\n");
      return;
    }
    sb.append("- `").append(field).append("`: count=`").append(stat.count).append("`, example=`")
        .append(escapeInlineCode(stat.exampleValue)).append("`\n");
  }

  private static void appendCountTable(StringBuilder sb,
                                       List<Map.Entry<String, Integer>> rows,
                                       String nameHeader,
                                       String countHeader) {
    sb.append("| ").append(nameHeader).append(" | ").append(countHeader).append(" |\n");
    sb.append("|---|---:|\n");
    if(rows.isEmpty()) {
      sb.append("| (none) | 0 |\n\n");
      return;
    }
    for(Map.Entry<String, Integer> entry : rows) {
      sb.append("| ").append(escapeMd(entry.getKey())).append(" | ").append(entry.getValue()).append(" |\n");
    }
    sb.append("\n");
  }

  private static List<VariantGroup> findVariantGroups(Set<String> fields, Set<String> preferredNames) {
    Map<String, Set<String>> groups = new LinkedHashMap<String, Set<String>>();
    for(String field : fields) {
      if(field == null || field.isEmpty()) {
        continue;
      }
      String key = field.toLowerCase(Locale.ROOT);
      Set<String> set = groups.get(key);
      if(set == null) {
        set = new LinkedHashSet<String>();
        groups.put(key, set);
      }
      set.add(field);
    }

    List<VariantGroup> out = new ArrayList<VariantGroup>();
    for(Map.Entry<String, Set<String>> entry : groups.entrySet()) {
      if(entry.getValue().size() <= 1) {
        continue;
      }
      VariantGroup group = new VariantGroup();
      group.key = entry.getKey();
      group.variants.addAll(entry.getValue());
      group.recommended = suggestCanonicalName(entry.getValue(), preferredNames);
      out.add(group);
    }

    Collections.sort(out, (a, b) -> a.key.compareToIgnoreCase(b.key));
    return out;
  }

  private static String suggestCanonicalName(Set<String> variants, Set<String> preferredNames) {
    for(String preferred : preferredNames) {
      for(String variant : variants) {
        if(preferred.equalsIgnoreCase(variant)) {
          return preferred;
        }
      }
    }

    String best = null;
    for(String variant : variants) {
      if(best == null) {
        best = variant;
        continue;
      }
      boolean variantCamel = hasCamelCase(variant);
      boolean bestCamel = hasCamelCase(best);
      if(variantCamel && !bestCamel) {
        best = variant;
        continue;
      }
      if(variantCamel == bestCamel && variant.length() < best.length()) {
        best = variant;
      }
    }
    return best == null ? "" : best;
  }

  private static boolean hasCamelCase(String text) {
    if(text == null) {
      return false;
    }
    boolean hasLower = false;
    boolean hasUpper = false;
    for(int i = 0; i < text.length(); i++) {
      char ch = text.charAt(i);
      if(Character.isLowerCase(ch)) {
        hasLower = true;
      } else if(Character.isUpperCase(ch)) {
        hasUpper = true;
      }
    }
    return hasLower && hasUpper;
  }

  private static void appendVariantSection(StringBuilder sb, String title, List<VariantGroup> groups) {
    sb.append("### ").append(title).append("\n\n");
    if(groups.isEmpty()) {
      sb.append("- 无大小写冲突字段\n\n");
      return;
    }
    sb.append("| normalized_key | variants | suggested_standard |\n");
    sb.append("|---|---|---|\n");
    for(VariantGroup group : groups) {
      sb.append("| ").append(escapeMd(group.key)).append(" | ")
          .append(escapeMd(joinList(group.variants))).append(" | ")
          .append(escapeMd(group.recommended)).append(" |\n");
    }
    sb.append("\n");
  }

  private static String buildCoverageJson(ScanSummary summary) {
    StringBuilder sb = new StringBuilder();
    sb.append("{");
    sb.append("\n  \"QuestFields\": ").append(fieldArrayJson(sortFieldSummaries(summary.quest.questFieldStats))).append(',');
    sb.append("\n  \"GoalFields\": ").append(fieldArrayJson(sortFieldSummaries(summary.quest.goalFieldStats))).append(',');
    sb.append("\n  \"RewardFields\": ").append(fieldArrayJson(sortFieldSummaries(summary.quest.rewardFieldStats))).append(',');
    sb.append("\n  \"NpcFields\": ").append(npcFieldArrayJson(sortCountEntries(summary.npc.callCounts), summary.npc.recognizedActionCounts.keySet()));
    sb.append("\n}");
    return sb.toString();
  }

  private static String fieldArrayJson(List<FieldSummary> rows) {
    StringBuilder sb = new StringBuilder();
    sb.append('[');
    for(int i = 0; i < rows.size(); i++) {
      FieldSummary row = rows.get(i);
      if(i > 0) {
        sb.append(',');
      }
      sb.append("{\"name\":\"").append(escapeJson(row.name)).append("\"")
          .append(",\"count\":").append(row.count)
          .append(",\"layer\":\"").append(escapeJson(row.layer)).append("\"")
          .append(",\"example\":\"").append(escapeJson(row.exampleValue)).append("\"")
          .append(",\"exampleQuestId\":").append(row.exampleQuestId)
          .append('}');
    }
    sb.append(']');
    return sb.toString();
  }

  private static String npcFieldArrayJson(List<Map.Entry<String, Integer>> rows, Set<String> recognized) {
    StringBuilder sb = new StringBuilder();
    sb.append('[');
    for(int i = 0; i < rows.size(); i++) {
      Map.Entry<String, Integer> row = rows.get(i);
      if(i > 0) {
        sb.append(',');
      }
      String action = normalizeNpcAction(row.getKey());
      boolean recognizedCall = action != null || recognized.contains(row.getKey());
      sb.append("{\"name\":\"").append(escapeJson(row.getKey())).append("\"")
          .append(",\"count\":").append(row.getValue().intValue())
          .append(",\"recognized\":").append(recognizedCall)
          .append('}');
    }
    sb.append(']');
    return sb.toString();
  }

  private static void appendClassificationSection(StringBuilder sb, String layer, Set<String> fields) {
    Map<String, List<String>> categories = new LinkedHashMap<String, List<String>>();
    categories.put("Identity", new ArrayList<String>());
    categories.put("Dialog", new ArrayList<String>());
    categories.put("Condition", new ArrayList<String>());
    categories.put("Goal/Reward Link", new ArrayList<String>());
    categories.put("Other", new ArrayList<String>());

    for(String field : fields) {
      String category = classifyField(layer, field);
      List<String> list = categories.get(category);
      if(list == null) {
        list = categories.get("Other");
      }
      list.add(field);
    }

    sb.append("#### ").append(layer).append(" 分类\n\n");
    for(Map.Entry<String, List<String>> entry : categories.entrySet()) {
      Collections.sort(entry.getValue(), String.CASE_INSENSITIVE_ORDER);
      sb.append("- ").append(entry.getKey()).append(": ").append(listText(entry.getValue())).append("\n");
    }
    sb.append("\n");
  }

  private static String classifyField(String layer, String field) {
    String low = field == null ? "" : field.toLowerCase(Locale.ROOT);
    if("quest".equalsIgnoreCase(layer)) {
      if("id".equals(low) || "name".equals(low) || "bqloop".equals(low)) {
        return "Identity";
      }
      if("contents".equals(low) || "answer".equals(low) || "info".equals(low) || "npcsay".equals(low)) {
        return "Dialog";
      }
      if(low.startsWith("need") || low.contains("item") || "requstitem".equals(low)) {
        return "Condition";
      }
      if("goal".equals(low) || "reward".equals(low)) {
        return "Goal/Reward Link";
      }
      return "Other";
    }
    if("goal".equalsIgnoreCase(layer)) {
      if(low.contains("item") || "id".equals(low) || "count".equals(low) || "meetcnt".equals(low)) {
        return "Condition";
      }
      if(low.contains("kill") || low.contains("monster")) {
        return "Goal/Reward Link";
      }
      if(low.contains("npc")) {
        return "Dialog";
      }
      return "Other";
    }
    if("reward".equalsIgnoreCase(layer)) {
      if("exp".equals(low) || "fame".equals(low) || "money".equals(low) || "pvppoint".equals(low) || "mileage".equals(low)) {
        return "Identity";
      }
      if(low.contains("item") || "id".equals(low) || "count".equals(low)) {
        return "Goal/Reward Link";
      }
      if(low.contains("skill")) {
        return "Condition";
      }
      return "Other";
    }
    return "Other";
  }

  private static void appendNpcClassificationSection(StringBuilder sb, Set<String> methods) {
    Map<String, List<String>> categories = new LinkedHashMap<String, List<String>>();
    categories.put("Dialog", new ArrayList<String>());
    categories.put("Quest State", new ArrayList<String>());
    categories.put("Item Check", new ArrayList<String>());
    categories.put("Other", new ArrayList<String>());

    for(String method : methods) {
      String action = normalizeNpcAction(method);
      if("NPC_SAY".equals(action)) {
        categories.get("Dialog").add(method);
      } else if("SET_QUEST_STATE".equals(action) || "ADD_QUEST_BTN".equals(action)) {
        categories.get("Quest State").add(method);
      } else if("CHECK_ITEM_CNT".equals(action)) {
        categories.get("Item Check").add(method);
      } else {
        categories.get("Other").add(method);
      }
    }

    sb.append("#### NPC 分类\n\n");
    for(Map.Entry<String, List<String>> entry : categories.entrySet()) {
      Collections.sort(entry.getValue(), String.CASE_INSENSITIVE_ORDER);
      sb.append("- ").append(entry.getKey()).append(": ").append(listText(entry.getValue())).append("\n");
    }
    sb.append("\n");
  }

  private static String normalizeNpcAction(String callName) {
    String upper = callName == null ? "" : callName.toUpperCase(Locale.ROOT);
    if(upper.contains("NPC_SAY")) {
      return "NPC_SAY";
    }
    if(upper.contains("ADD_QUEST_BTN")) {
      return "ADD_QUEST_BTN";
    }
    if(upper.contains("SET_QUEST_STATE")) {
      return "SET_QUEST_STATE";
    }
    if(upper.contains("CHECK_ITEM_CNT")) {
      return "CHECK_ITEM_CNT";
    }
    return null;
  }

  private static boolean isEmpty(String text) {
    return text == null || text.trim().isEmpty();
  }

  private static String joinList(List<String> values) {
    StringBuilder sb = new StringBuilder();
    int i = 0;
    for(String value : values) {
      if(i > 0) {
        sb.append(", ");
      }
      sb.append(value);
      i++;
    }
    return sb.toString();
  }

  private static String listText(Set<?> values) {
    if(values == null || values.isEmpty()) {
      return "(none)";
    }
    StringBuilder sb = new StringBuilder();
    int i = 0;
    for(Object value : values) {
      if(i > 0) {
        sb.append(", ");
      }
      sb.append('`').append(String.valueOf(value)).append('`');
      i++;
    }
    return sb.toString();
  }

  private static String listText(List<?> values) {
    if(values == null || values.isEmpty()) {
      return "(none)";
    }
    StringBuilder sb = new StringBuilder();
    int i = 0;
    for(Object value : values) {
      if(i > 0) {
        sb.append(", ");
      }
      sb.append('`').append(String.valueOf(value)).append('`');
      i++;
    }
    return sb.toString();
  }

  private static String escapeMd(String text) {
    if(text == null) {
      return "";
    }
    return text.replace("|", "\\|").replace("\r", " ").replace("\n", "<br>");
  }

  private static String escapeJson(String text) {
    if(text == null) {
      return "";
    }
    return text
        .replace("\\", "\\\\")
        .replace("\"", "\\\"")
        .replace("\r", "\\r")
        .replace("\n", "\\n");
  }

  private static String escapeInlineCode(String text) {
    if(text == null) {
      return "";
    }
    return text.replace("`", "'");
  }

  public static final class ScanSummary {
    public final QuestSummary quest = new QuestSummary();
    public final NpcSummary npc = new NpcSummary();
  }

  public static final class QuestSummary {
    public int scriptFileCount;
    public final Set<Integer> questIds = new LinkedHashSet<Integer>();
    public final Map<String, FieldSummary> questFieldStats = new LinkedHashMap<String, FieldSummary>();
    public final Map<String, FieldSummary> goalFieldStats = new LinkedHashMap<String, FieldSummary>();
    public final Map<String, FieldSummary> rewardFieldStats = new LinkedHashMap<String, FieldSummary>();
    public final List<String> scriptFiles = new ArrayList<String>();
  }

  public static final class NpcSummary {
    public int npcFileCount;
    public int callCountTotal;
    public int unresolvedCallCount;
    public final Set<String> globalFunctionNames = new LinkedHashSet<String>();
    public final Set<Integer> relatedQuestIds = new LinkedHashSet<Integer>();
    public final Map<String, Integer> callCounts = new LinkedHashMap<String, Integer>();
    public final Map<String, Integer> recognizedActionCounts = new LinkedHashMap<String, Integer>();
    public final Map<String, Integer> unrecognizedMethodCounts = new LinkedHashMap<String, Integer>();
    public final List<String> scriptFiles = new ArrayList<String>();
  }

  public static final class FieldSummary {
    public final String name;
    public final String layer;
    public int count;
    public String exampleValue = "";
    public int exampleQuestId;
    public String exampleFile = "";

    public FieldSummary(String name, String layer) {
      this.name = name == null ? "" : name;
      this.layer = layer == null ? "" : layer;
    }
  }

  private static final class DiffResult {
    final Set<String> scanned = new LinkedHashSet<String>();
    final Set<String> supported = new LinkedHashSet<String>();
    final Set<String> missing = new LinkedHashSet<String>();
  }

  private static final class VariantGroup {
    String key;
    final List<String> variants = new ArrayList<String>();
    String recommended;
  }

  private static final class RegisterValue {
    String rawName;
    String globalName;
    String stringValue;
    Integer integerValue;

    static RegisterValue unknown() {
      return new RegisterValue();
    }

    static RegisterValue global(String name) {
      RegisterValue value = new RegisterValue();
      value.globalName = name == null ? "" : name;
      value.rawName = value.globalName;
      return value;
    }

    static RegisterValue name(String name) {
      RegisterValue value = new RegisterValue();
      value.rawName = name == null ? "" : name;
      value.globalName = value.rawName;
      return value;
    }

    static RegisterValue string(String text) {
      RegisterValue value = new RegisterValue();
      value.stringValue = text == null ? "" : text;
      return value;
    }

    static RegisterValue number(Integer integer) {
      RegisterValue value = new RegisterValue();
      value.integerValue = integer;
      return value;
    }
  }

  private static final class NpcCallScanResult {
    int totalCalls;
    int unresolvedCalls;
    final Map<String, Integer> callCounts = new LinkedHashMap<String, Integer>();
    final Map<String, Integer> recognizedActionCounts = new LinkedHashMap<String, Integer>();
    final Map<String, Integer> unrecognizedMethodCounts = new LinkedHashMap<String, Integer>();
  }
}
