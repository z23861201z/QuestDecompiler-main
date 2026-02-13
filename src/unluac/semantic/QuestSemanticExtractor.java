package unluac.semantic;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeMap;

import unluac.chunk.LuaChunk;
import unluac.decompile.Op;

public class QuestSemanticExtractor {

  private static final String RULE_TABLE_NEW = "R-TABLE-NEW";
  private static final String RULE_FIELD_WRITE = "R-FIELD-WRITE";
  private static final String RULE_ARRAY_WRITE = "R-ARRAY-WRITE";
  private static final String RULE_CALL_EDGE = "R-CALL-EDGE";
  private static final String RULE_QID = "R-QUEST-ID";
  private static final String RULE_TITLE = "R-TITLE";
  private static final String RULE_DESCRIPTION = "R-DESCRIPTION";
  private static final String RULE_PREQUEST = "R-PREQUEST";
  private static final String RULE_REWARD = "R-REWARD";
  private static final String RULE_DIALOG = "R-DIALOG";
  private static final String RULE_CONDITION = "R-CONDITION";
  private static final String RULE_COMPLETION = "R-COMPLETION";
  private static final String RULE_CALL_CONDITION = "R-CALL-CONDITION";

  private static final String OPTION_PREFIX = "ANSWER";

  private static final Set<String> QUEST_KEYS = new LinkedHashSet<String>();
  private static final Set<String> DIALOG_KEYS = new LinkedHashSet<String>();
  private static final Set<String> REWARD_KEYS = new LinkedHashSet<String>();
  private static final Set<String> CONDITION_KEYS = new LinkedHashSet<String>();

  static {
    QUEST_KEYS.add("id");
    QUEST_KEYS.add("name");
    QUEST_KEYS.add("contents");
    QUEST_KEYS.add("answer");
    QUEST_KEYS.add("info");
    QUEST_KEYS.add("npcsay");
    QUEST_KEYS.add("needLevel");
    QUEST_KEYS.add("needQuest");
    QUEST_KEYS.add("needItem");
    QUEST_KEYS.add("goal");
    QUEST_KEYS.add("reward");
    QUEST_KEYS.add("requstItem");

    DIALOG_KEYS.add("contents");
    DIALOG_KEYS.add("answer");
    DIALOG_KEYS.add("info");
    DIALOG_KEYS.add("npcsay");

    REWARD_KEYS.add("money");
    REWARD_KEYS.add("exp");
    REWARD_KEYS.add("fame");
    REWARD_KEYS.add("pvppoint");
    REWARD_KEYS.add("mileage");
    REWARD_KEYS.add("getItem");
    REWARD_KEYS.add("getSkill");
    REWARD_KEYS.add("id");
    REWARD_KEYS.add("count");
    REWARD_KEYS.add("itemid");
    REWARD_KEYS.add("itemcnt");

    CONDITION_KEYS.add("needLevel");
    CONDITION_KEYS.add("needQuest");
    CONDITION_KEYS.add("needItem");
    CONDITION_KEYS.add("requstItem");
    CONDITION_KEYS.add("goal");
    CONDITION_KEYS.add("killMonster");
    CONDITION_KEYS.add("getItem");
  }

  public ExtractionResult extract(LuaChunk chunk) {
    if(chunk == null || chunk.header == null || chunk.mainFunction == null) {
      throw new IllegalStateException("invalid chunk for semantic extraction");
    }

    AnalysisState state = new AnalysisState(chunk);
    analyzeFunction(chunk.mainFunction, state);

    List<QuestSemanticModel> models = buildModels(state);
    Collections.sort(models, new Comparator<QuestSemanticModel>() {
      @Override
      public int compare(QuestSemanticModel a, QuestSemanticModel b) {
        return Integer.compare(a.questId, b.questId);
      }
    });

    ExtractionResult result = new ExtractionResult();
    result.quests.addAll(models);
    result.ruleHits.addAll(state.ruleHits);
    result.fieldBindings.addAll(state.fieldBindings);

    Set<Integer> questIds = new LinkedHashSet<Integer>();
    for(QuestSemanticModel model : result.quests) {
      questIds.add(Integer.valueOf(model.questId));
    }
    QuestDialogTreeExtractor dialogTreeExtractor = new QuestDialogTreeExtractor();
    Map<Integer, QuestDialogTree> trees = dialogTreeExtractor.extractTrees(chunk, questIds);
    for(QuestSemanticModel model : result.quests) {
      QuestDialogTree tree = trees.get(Integer.valueOf(model.questId));
      if(isMeaningfulDialogTree(tree)) {
        model.dialogTree = tree;
        continue;
      }

      QuestDialogTree fallback = buildDialogTreeFromDialogLines(model.dialogLines);
      if(!isMeaningfulDialogTree(fallback) && model.description != null && !model.description.trim().isEmpty()) {
        fallback = new QuestDialogTree();
        DialogNode root = new DialogNode();
        root.text = model.description;
        fallback.nodes.add(root);
      }
      model.dialogTree = fallback;
    }
    return result;
  }

  public FieldCoverageScanResult scanFieldCoverage(LuaChunk chunk) {
    FieldInventoryScanResult inventory = scanFieldInventory(chunk);

    FieldCoverageScanResult out = new FieldCoverageScanResult();
    out.questIds.addAll(inventory.questIds);
    out.questFields.addAll(inventory.questFieldStats.keySet());
    out.goalFields.addAll(inventory.goalFieldStats.keySet());
    out.rewardFields.addAll(inventory.rewardFieldStats.keySet());
    return out;
  }

  public FieldInventoryScanResult scanFieldInventory(LuaChunk chunk) {
    if(chunk == null || chunk.header == null || chunk.mainFunction == null) {
      throw new IllegalStateException("invalid chunk for field scan");
    }

    AnalysisState state = new AnalysisState(chunk);
    analyzeFunction(chunk.mainFunction, state);

    FieldInventoryScanResult out = new FieldInventoryScanResult();
    for(TableState table : state.tables) {
      if(table == null || !looksLikeQuestTable(table)) {
        continue;
      }
      Integer questId = inferQuestId(table);
      if(questId == null || questId.intValue() <= 0) {
        continue;
      }
      out.questIds.add(Integer.valueOf(questId.intValue()));
      collectTopLevelQuestFieldStats(table, questId, out.questFieldStats);

      Value goal = table.fields.get("goal");
      if(goal != null) {
        collectNestedFieldStats(goal, out.goalFieldStats, questId, new HashSet<Integer>());
      }

      Value reward = table.fields.get("reward");
      if(reward != null) {
        collectNestedFieldStats(reward, out.rewardFieldStats, questId, new HashSet<Integer>());
      }
    }
    return out;
  }

  private void collectTopLevelQuestFieldStats(TableState table,
                                              Integer questId,
                                              Map<String, FieldStat> fieldStats) {
    if(table == null || fieldStats == null) {
      return;
    }
    for(Map.Entry<String, Value> entry : table.fields.entrySet()) {
      addFieldStat(fieldStats, entry.getKey(), entry.getValue(), questId);
    }
  }

  private void collectNestedFieldStats(Value value,
                                       Map<String, FieldStat> fieldStats,
                                       Integer questId,
                                       Set<Integer> visited) {
    if(value == null || !value.isTable() || fieldStats == null) {
      return;
    }

    TableState table = value.asTable();
    if(table == null || !visited.add(table.id)) {
      return;
    }

    for(Map.Entry<String, Value> entry : table.fields.entrySet()) {
      addFieldStat(fieldStats, entry.getKey(), entry.getValue(), questId);
      collectNestedFieldStats(entry.getValue(), fieldStats, questId, visited);
    }

    for(Map.Entry<Integer, Value> entry : table.array.entrySet()) {
      collectNestedFieldStats(entry.getValue(), fieldStats, questId, visited);
    }

    visited.remove(table.id);
  }

  private void addFieldStat(Map<String, FieldStat> fieldStats,
                            String fieldName,
                            Value value,
                            Integer questId) {
    if(fieldStats == null || fieldName == null || fieldName.isEmpty()) {
      return;
    }

    FieldStat stat = fieldStats.get(fieldName);
    if(stat == null) {
      stat = new FieldStat(fieldName);
      fieldStats.put(fieldName, stat);
    }
    stat.count++;

    String sample = sampleValue(value);
    if(stat.exampleValue == null || stat.exampleValue.isEmpty()) {
      stat.exampleValue = sample;
      stat.exampleQuestId = questId == null ? 0 : questId.intValue();
    }
  }

  private String sampleValue(Value value) {
    if(value == null) {
      return "null";
    }
    if(value.isString()) {
      String text = value.asString();
      if(text == null) {
        return "\"\"";
      }
      String sanitized = text.replace("\r", "\\r").replace("\n", "\\n");
      if(sanitized.length() > 120) {
        sanitized = sanitized.substring(0, 120) + "...";
      }
      return "\"" + sanitized + "\"";
    }

    Object object = toObject(value, 0, new HashSet<Integer>());
    if(object == null) {
      return "null";
    }
    String text = String.valueOf(object).replace("\r", "\\r").replace("\n", "\\n");
    if(text.length() > 160) {
      text = text.substring(0, 160) + "...";
    }
    return text;
  }

  private boolean looksLikeQuestTable(TableState table) {
    if(table == null || table.fields.isEmpty()) {
      return false;
    }
    return table.fields.containsKey("contents")
        || table.fields.containsKey("answer")
        || table.fields.containsKey("info")
        || table.fields.containsKey("goal")
        || table.fields.containsKey("reward")
        || table.fields.containsKey("name");
  }

  private void collectFieldKeys(Value value, Set<String> out, Set<Integer> visited) {
    if(value == null || !value.isTable()) {
      return;
    }
    TableState table = value.asTable();
    if(table == null || !visited.add(table.id)) {
      return;
    }
    out.addAll(table.fields.keySet());
    for(Map.Entry<String, Value> entry : table.fields.entrySet()) {
      collectFieldKeys(entry.getValue(), out, visited);
    }
    for(Map.Entry<Integer, Value> entry : table.array.entrySet()) {
      collectFieldKeys(entry.getValue(), out, visited);
    }
    visited.remove(table.id);
  }

  private boolean isMeaningfulDialogTree(QuestDialogTree tree) {
    if(tree == null || tree.nodes == null || tree.nodes.isEmpty()) {
      return false;
    }
    for(DialogNode node : tree.nodes) {
      if(node == null) {
        continue;
      }
      if(node.text != null && !node.text.trim().isEmpty()) {
        return true;
      }
      if(node.options != null && !node.options.isEmpty()) {
        return true;
      }
      if(node.next != null && !node.next.isEmpty()) {
        return true;
      }
    }
    return false;
  }

  private QuestDialogTree buildDialogTreeFromDialogLines(List<String> lines) {
    QuestDialogTree tree = new QuestDialogTree();
    DialogNode root = new DialogNode();
    tree.nodes.add(root);
    if(lines == null || lines.isEmpty()) {
      return tree;
    }

    int currentNodeIndex = 0;
    int pendingBranchTargetIndex = -1;
    for(String raw : lines) {
      String line = normalizeDialogLine(raw);
      if(line.isEmpty()) {
        continue;
      }

      ParsedDialogOption parsed = parseDialogOption(line);
      if(parsed != null) {
        DialogNode current = tree.nodes.get(currentNodeIndex);
        DialogOption option = new DialogOption();
        option.optionText = parsed.optionText;

        DialogNode branch = new DialogNode();
        int branchIndex = tree.nodes.size();
        tree.nodes.add(branch);

        option.nextNodeIndex = branchIndex;
        current.options.add(option);

        if(!current.next.contains(branch)) {
          current.next.add(branch);
        }
        pendingBranchTargetIndex = branchIndex;
        continue;
      }

      if(pendingBranchTargetIndex >= 0 && pendingBranchTargetIndex < tree.nodes.size()) {
        DialogNode branch = tree.nodes.get(pendingBranchTargetIndex);
        if(branch.text == null || branch.text.trim().isEmpty()) {
          branch.text = line;
          currentNodeIndex = pendingBranchTargetIndex;
          pendingBranchTargetIndex = -1;
          continue;
        }
        currentNodeIndex = pendingBranchTargetIndex;
        pendingBranchTargetIndex = -1;
      }

      DialogNode current = tree.nodes.get(currentNodeIndex);
      if(current.text == null || current.text.trim().isEmpty()) {
        current.text = line;
      } else {
        DialogNode next = new DialogNode();
        next.text = line;
        tree.nodes.add(next);
        current.next.add(next);
        currentNodeIndex = tree.nodes.size() - 1;
      }
    }

    return tree;
  }

  private String normalizeDialogLine(String raw) {
    if(raw == null) {
      return "";
    }
    return raw.replace("\u0000", "").trim();
  }

  private ParsedDialogOption parseDialogOption(String line) {
    if(line == null) {
      return null;
    }
    int split = line.indexOf(':');
    int splitCn = line.indexOf('：');
    if(split < 0 || (splitCn >= 0 && splitCn < split)) {
      split = splitCn;
    }
    if(split <= 0) {
      return null;
    }

    String head = line.substring(0, split).trim().toUpperCase();
    if(!head.startsWith(OPTION_PREFIX)) {
      return null;
    }

    String body = line.substring(split + 1).trim();
    ParsedDialogOption option = new ParsedDialogOption();
    option.optionText = body.isEmpty() ? head : body;
    return option;
  }

  private void analyzeFunction(LuaChunk.Function function, AnalysisState state) {
    FunctionFrame frame = new FunctionFrame(state.chunk, function);

    for(int pc = 0; pc < function.code.size(); pc++) {
      LuaChunk.Instruction inst = function.code.get(pc);
      Lua50InstructionCodec.DecodedInstruction decoded = frame.codec.decode(inst.value);
      Op op = decoded.op;
      if(op == null) {
        continue;
      }

      switch(op) {
        case MOVE:
          frame.setRegister(decoded.A, frame.getRegister(decoded.B));
          break;

        case LOADK:
          frame.setRegister(decoded.A, constantValue(function, decoded.Bx, function.path, pc));
          break;

        case LOADBOOL:
          frame.setRegister(decoded.A, Value.bool(decoded.B != 0, function.path, pc));
          break;

        case LOADNIL: {
          int from = decoded.A;
          int to = decoded.B;
          if(to < from) {
            to = from;
          }
          for(int reg = from; reg <= to; reg++) {
            frame.setRegister(reg, Value.nil(function.path, pc));
          }
          break;
        }

        case GETGLOBAL: {
          Value nameVal = constantValue(function, decoded.Bx, function.path, pc);
          String globalName = nameVal.asString();
          Value value = state.globalValues.get(globalName);
          if(value == null) {
            value = Value.global(globalName, function.path, pc, nameVal.constantIndex);
          }
          frame.setRegister(decoded.A, value);
          break;
        }

        case SETGLOBAL: {
          Value nameVal = constantValue(function, decoded.Bx, function.path, pc);
          String globalName = nameVal.asString();
          Value value = frame.getRegister(decoded.A);
          if(globalName != null) {
            state.globalValues.put(globalName, value);
          }
          break;
        }

        case NEWTABLE50: {
          TableState table = new TableState(state.nextTableId++, function.path, pc, inst.offset);
          state.tables.add(table);
          frame.setRegister(decoded.A, Value.table(table, function.path, pc));
          state.ruleHits.add(new RuleHit(
              RULE_TABLE_NEW,
              function.path,
              pc,
              inst.offset,
              "table=Table#" + table.id + " reg=R" + decoded.A));
          break;
        }

        case SETTABLE: {
          Value tableVal = frame.getRegister(decoded.A);
          TableState table = tableVal.asTable();
          Value keyVal = resolveRK(frame, function, pc, decoded.B);
          Value valueVal = resolveRK(frame, function, pc, decoded.C);

          if(table != null) {
            table.put(keyVal, valueVal, pc, inst.offset);
            if(isSemanticKeyValue(keyVal) || keyVal.isNumber()) {
              String detail = "table=Table#" + table.id
                  + " key=" + describeValue(keyVal)
                  + " value=" + describeValue(valueVal)
                  + " value_from_pc=" + valueVal.sourcePc;
              state.ruleHits.add(new RuleHit(RULE_FIELD_WRITE, function.path, pc, inst.offset, detail));
            }
          }
          break;
        }

        case GETTABLE: {
          Value tableVal = frame.getRegister(decoded.B);
          Value keyVal = resolveRK(frame, function, pc, decoded.C);
          TableState table = tableVal.asTable();
          if(table != null) {
            Value extracted = table.get(keyVal);
            if(extracted != null) {
              Value relation = extracted.copy();
              relation.relation = "GETTABLE(" + table.id + "," + describeValue(keyVal) + ")";
              relation.sourceFunctionPath = function.path;
              relation.sourcePc = pc;
              frame.setRegister(decoded.A, relation);
            } else {
              frame.setRegister(decoded.A, Value.unknown(function.path, pc));
            }
          } else {
            frame.setRegister(decoded.A, Value.unknown(function.path, pc));
          }
          break;
        }

        case SETLIST50:
        case SETLISTO: {
          Value tableVal = frame.getRegister(decoded.A);
          TableState table = tableVal.asTable();
          if(table != null) {
            int bx = decoded.Bx;
            int n = bx % 32;
            for(int i = 1; i <= n + 1; i++) {
              int index = bx - n + i;
              Value value = frame.getRegister(decoded.A + i);
              table.array.put(index, value);
              String detail = "table=Table#" + table.id
                  + " index=" + index
                  + " value=" + describeValue(value)
                  + " value_from_pc=" + value.sourcePc;
              state.ruleHits.add(new RuleHit(RULE_ARRAY_WRITE, function.path, pc, inst.offset, detail));
            }
          }
          break;
        }

        case CALL: {
          Value callee = frame.getRegister(decoded.A);
          String callName = callName(callee);
          List<Value> args = new ArrayList<Value>();

          if(decoded.B > 0) {
            for(int i = 1; i < decoded.B; i++) {
              args.add(frame.getRegister(decoded.A + i));
            }
          }

          CallEvent event = new CallEvent(function.path, pc, inst.offset, callName, callee, args);
          state.callEvents.add(event);

          if(isSemanticCall(callName, args)) {
            StringBuilder detail = new StringBuilder();
            detail.append("call=").append(callName);
            detail.append(" args=");
            for(int i = 0; i < args.size(); i++) {
              if(i > 0) {
                detail.append("|");
              }
              detail.append(describeValue(args.get(i)));
            }
            state.ruleHits.add(new RuleHit(RULE_CALL_EDGE, function.path, pc, inst.offset, detail.toString()));
          }

          if(decoded.C == 0) {
            for(int reg = decoded.A; reg < decoded.A + 8; reg++) {
              frame.setRegister(reg, Value.unknown(function.path, pc));
            }
          } else {
            for(int reg = decoded.A; reg < decoded.A + Math.max(decoded.C - 1, 0); reg++) {
              frame.setRegister(reg, Value.unknown(function.path, pc));
            }
          }
          break;
        }

        case CLOSURE:
          frame.setRegister(decoded.A, Value.closure(function.path + "/" + decoded.Bx, function.path, pc));
          break;

        default:
          break;
      }
    }

    for(LuaChunk.Function child : function.prototypes) {
      analyzeFunction(child, state);
    }
  }

  private Value resolveRK(FunctionFrame frame, LuaChunk.Function function, int pc, int raw) {
    if(raw >= frame.rkBase) {
      int constantIndex = raw - frame.rkBase;
      return constantValue(function, constantIndex, function.path, pc);
    }
    return frame.getRegister(raw);
  }

  private Value constantValue(LuaChunk.Function function, int index, String functionPath, int pc) {
    if(index < 0 || index >= function.constants.size()) {
      return Value.unknown(functionPath, pc);
    }

    LuaChunk.Constant constant = function.constants.get(index);
    if(constant.type == LuaChunk.Constant.Type.NIL) {
      Value v = Value.nil(functionPath, pc);
      v.constantIndex = index;
      return v;
    }
    if(constant.type == LuaChunk.Constant.Type.BOOLEAN) {
      Value v = Value.bool(constant.booleanValue, functionPath, pc);
      v.constantIndex = index;
      return v;
    }
    if(constant.type == LuaChunk.Constant.Type.NUMBER) {
      Value v = Value.number(constant.numberValue, functionPath, pc);
      v.constantIndex = index;
      return v;
    }
    if(constant.type == LuaChunk.Constant.Type.STRING) {
      String text = constant.stringValue == null ? "" : constant.stringValue.toDisplayString();
      Value v = Value.string(text, functionPath, pc);
      v.constantIndex = index;
      return v;
    }

    return Value.unknown(functionPath, pc);
  }

  private List<QuestSemanticModel> buildModels(AnalysisState state) {
    Map<Integer, QuestSemanticModel> byQuestId = new LinkedHashMap<Integer, QuestSemanticModel>();
    Map<Integer, Set<String>> dialogSeen = new HashMap<Integer, Set<String>>();
    Map<Integer, Set<Integer>> preQuestSeen = new HashMap<Integer, Set<Integer>>();
    Map<Integer, Set<String>> rewardSeen = new HashMap<Integer, Set<String>>();

    for(TableState table : state.tables) {
      Integer questId = inferQuestId(table);
      if(questId == null || questId.intValue() <= 0) {
        continue;
      }
      if(!isQuestSemanticTable(table)) {
        continue;
      }

      QuestSemanticModel model = byQuestId.get(questId);
      if(model == null) {
        model = new QuestSemanticModel();
        model.questId = questId.intValue();
        byQuestId.put(questId, model);
      }

      state.ruleHits.add(new RuleHit(
          RULE_QID,
          table.functionPath,
          table.createPc,
          table.createOffset,
          "questId=" + questId + " source=Table#" + table.id));

      String title = stringField(table, "name");
      if(title != null && !title.isEmpty() && (model.title == null || model.title.isEmpty())) {
        model.title = title;
        state.ruleHits.add(new RuleHit(
            RULE_TITLE,
            table.functionPath,
            table.createPc,
            table.createOffset,
            "questId=" + questId + " title_from=Table#" + table.id));
        Value titleValue = table.fields.get("name");
        if(titleValue != null) {
          state.fieldBindings.add(FieldBinding.stringBinding(
              model.questId,
              "title",
              table.functionPath,
              titleValue.constantIndex,
              titleValue.sourcePc,
              titleValue.sourceFunctionPath,
              titleValue.stringValue));
        }
      }

      String description = firstStringFromField(table, "contents");
      if(description != null && !description.isEmpty() && (model.description == null || model.description.isEmpty())) {
        model.description = description;
        state.ruleHits.add(new RuleHit(
            RULE_DESCRIPTION,
            table.functionPath,
            table.createPc,
            table.createOffset,
            "questId=" + questId + " description_from=contents[1]"));

        Value contentsValue = table.fields.get("contents");
        if(contentsValue != null && contentsValue.isTable()) {
          TableState contentsTable = contentsValue.asTable();
          Value line1 = contentsTable.array.get(Integer.valueOf(1));
          if(line1 != null && line1.isString()) {
            state.fieldBindings.add(FieldBinding.stringBinding(
                model.questId,
                "description",
                table.functionPath,
                line1.constantIndex,
                line1.sourcePc,
                line1.sourceFunctionPath,
                line1.stringValue));
          }
        }
      }

      Set<String> dialogMark = ensureStringSet(dialogSeen, questId);
      for(String field : DIALOG_KEYS) {
        Value value = table.fields.get(field);
        if(value == null) {
          continue;
        }
        List<Value> lineValues = extractStringLeafValues(value, 0, new HashSet<Integer>());
        for(Value lineValue : lineValues) {
          String line = lineValue == null ? null : lineValue.asString();
          if(line == null || line.isEmpty()) {
            continue;
          }
          if(dialogMark.add(line)) {
            model.dialogLines.add(line);

            state.ruleHits.add(new RuleHit(
                RULE_DIALOG,
                table.functionPath,
                table.createPc,
                table.createOffset,
                "questId=" + questId + " field=" + field));
          }

          if(lineValue.constantIndex >= 0) {
            int dialogIndex = model.dialogLines.size() - 1;
            state.fieldBindings.add(FieldBinding.stringBinding(
                model.questId,
                "dialog_lines_json[" + dialogIndex + "]." + field,
                table.functionPath,
                lineValue.constantIndex,
                lineValue.sourcePc,
                lineValue.sourceFunctionPath,
                line));
          }
        }
      }

      Set<Integer> preQuestMark = ensureIntSet(preQuestSeen, questId);
      Value preQuestValue = table.fields.get("needQuest");
      if(preQuestValue != null) {
        List<Integer> preQuestIds = extractIntegerLeaves(preQuestValue, 0, new HashSet<Integer>());
        for(Integer pre : preQuestIds) {
          if(pre == null) {
            continue;
          }
          if(pre.intValue() <= 0) {
            continue;
          }
          if(preQuestMark.add(pre)) {
            model.preQuestIds.add(pre);
            state.ruleHits.add(new RuleHit(
                RULE_PREQUEST,
                table.functionPath,
                table.createPc,
                table.createOffset,
                "questId=" + questId + " needQuest=" + pre));
          }
        }
        putCondition(model.conditions, "needQuest", toObject(preQuestValue, 0, new HashSet<Integer>()));

        if(preQuestValue.isNumber()) {
          Integer pre = preQuestValue.asInteger();
          if(pre != null && pre.intValue() > 0) {
            state.fieldBindings.add(FieldBinding.numberBinding(
                model.questId,
                "pre_quest_ids",
                table.functionPath,
                preQuestValue.constantIndex,
                preQuestValue.sourcePc,
                preQuestValue.sourceFunctionPath,
                pre.doubleValue()));
          }
        }
      }

      Value needLevel = table.fields.get("needLevel");
      if(needLevel != null) {
        putCondition(model.conditions, "needLevel", toObject(needLevel, 0, new HashSet<Integer>()));
        Integer levelValue = needLevel.asInteger();
        if(levelValue != null && levelValue.intValue() > 0) {
          model.goal.needLevel = levelValue.intValue();
        }
        state.ruleHits.add(new RuleHit(
            RULE_CONDITION,
            table.functionPath,
            table.createPc,
            table.createOffset,
            "questId=" + questId + " condition=needLevel"));

        if(needLevel.isNumber()) {
          state.fieldBindings.add(FieldBinding.numberBinding(
              model.questId,
              "condition_json.needLevel",
              table.functionPath,
              needLevel.constantIndex,
              needLevel.sourcePc,
              needLevel.sourceFunctionPath,
              needLevel.numberValue));
        }
      }

      Value needItem = table.fields.get("needItem");
      if(needItem != null) {
        putCondition(model.conditions, "needItem", toObject(needItem, 0, new HashSet<Integer>()));
        state.ruleHits.add(new RuleHit(
            RULE_CONDITION,
            table.functionPath,
            table.createPc,
            table.createOffset,
            "questId=" + questId + " condition=needItem"));
        if(needItem.isNumber()) {
          state.fieldBindings.add(FieldBinding.numberBinding(
              model.questId,
              "condition_json.needItem",
              table.functionPath,
              needItem.constantIndex,
              needItem.sourcePc,
              needItem.sourceFunctionPath,
              needItem.numberValue));
        }
      }

      Value requestItem = table.fields.get("requstItem");
      if(requestItem != null) {
        putCondition(model.conditions, "requstItem", toObject(requestItem, 0, new HashSet<Integer>()));
        state.ruleHits.add(new RuleHit(
            RULE_CONDITION,
            table.functionPath,
            table.createPc,
            table.createOffset,
            "questId=" + questId + " condition=requstItem"));
      }

      Value goal = table.fields.get("goal");
      if(goal != null) {
        putCondition(model.completionConditions, "goal", toObject(goal, 0, new HashSet<Integer>()));
        fillQuestGoalFromValue(model.goal, goal);
        state.ruleHits.add(new RuleHit(
            RULE_COMPLETION,
            table.functionPath,
            table.createPc,
            table.createOffset,
            "questId=" + questId + " completion=goal"));
      }

      Set<String> rewardMark = ensureStringSet(rewardSeen, questId);
      Value rewardValue = table.fields.get("reward");
      if(rewardValue != null) {
        List<QuestSemanticModel.Reward> rewards = extractRewards(rewardValue, 0, new HashSet<Integer>());

        collectRewardBindings(state, model.questId, table.functionPath, rewardValue, new HashSet<Integer>());

        for(QuestSemanticModel.Reward reward : rewards) {
          String signature = rewardSignature(reward);
          if(rewardMark.add(signature)) {
            model.rewards.add(reward);
            state.ruleHits.add(new RuleHit(
                RULE_REWARD,
                table.functionPath,
                table.createPc,
                table.createOffset,
                "questId=" + questId + " reward=" + signature));
          }
        }
      }

      List<QuestSemanticModel.Reward> selfRewards = extractRewardsFromTable(table);
      for(QuestSemanticModel.Reward reward : selfRewards) {
        String signature = rewardSignature(reward);
        if(rewardMark.add(signature)) {
          model.rewards.add(reward);
          state.ruleHits.add(new RuleHit(
              RULE_REWARD,
              table.functionPath,
              table.createPc,
              table.createOffset,
              "questId=" + questId + " reward=self:" + signature));
        }
      }
    }

    for(CallEvent event : state.callEvents) {
      Integer questId = firstQuestIdFromArgs(event.args);
      if(questId == null) {
        continue;
      }
      QuestSemanticModel model = byQuestId.get(questId);
      if(model == null) {
        continue;
      }
      if(event.callName == null) {
        continue;
      }
      if(!event.callName.toLowerCase().contains("quest")
          && !event.callName.toLowerCase().contains("npc")
          && !event.callName.toLowerCase().contains("dialog")) {
        continue;
      }

      List<Object> argObjects = new ArrayList<Object>();
      for(Value arg : event.args) {
        argObjects.add(toObject(arg, 0, new HashSet<Integer>()));
      }
      model.conditions.put("call:" + event.callName + "@" + event.functionPath + ":" + event.pc, argObjects);
      state.ruleHits.add(new RuleHit(
          RULE_CALL_CONDITION,
          event.functionPath,
          event.pc,
          event.offset,
          "questId=" + questId + " call=" + event.callName));
    }

    return new ArrayList<QuestSemanticModel>(byQuestId.values());
  }

  private boolean isSemanticKeyValue(Value key) {
    if(key == null || !key.isString()) {
      return false;
    }
    return QUEST_KEYS.contains(key.asString())
        || REWARD_KEYS.contains(key.asString())
        || CONDITION_KEYS.contains(key.asString());
  }

  private void collectRewardBindings(AnalysisState state,
                                     int questId,
                                     String ownerFunctionPath,
                                     Value rewardValue,
                                     Set<Integer> visited) {
    if(rewardValue == null || !rewardValue.isTable()) {
      return;
    }
    TableState table = rewardValue.asTable();
    if(table == null || !visited.add(table.id)) {
      return;
    }

    Value exp = table.fields.get("exp");
    if(exp != null && exp.isNumber()) {
      state.fieldBindings.add(FieldBinding.numberBinding(
          questId,
          "reward_exp",
          ownerFunctionPath,
          exp.constantIndex,
          exp.sourcePc,
          exp.sourceFunctionPath,
          exp.numberValue));
    }

    Value fame = table.fields.get("fame");
    if(fame != null && fame.isNumber()) {
      state.fieldBindings.add(FieldBinding.numberBinding(
          questId,
          "reward_fame",
          ownerFunctionPath,
          fame.constantIndex,
          fame.sourcePc,
          fame.sourceFunctionPath,
          fame.numberValue));
    }

    Value money = table.fields.get("money");
    if(money != null && money.isNumber()) {
      state.fieldBindings.add(FieldBinding.numberBinding(
          questId,
          "reward_money",
          ownerFunctionPath,
          money.constantIndex,
          money.sourcePc,
          money.sourceFunctionPath,
          money.numberValue));
    }

    Value pvpPoint = table.fields.get("pvppoint");
    if(pvpPoint != null && pvpPoint.isNumber()) {
      state.fieldBindings.add(FieldBinding.numberBinding(
          questId,
          "reward_pvppoint",
          ownerFunctionPath,
          pvpPoint.constantIndex,
          pvpPoint.sourcePc,
          pvpPoint.sourceFunctionPath,
          pvpPoint.numberValue));
    }

    Value mileage = table.fields.get("mileage");
    if(mileage != null && mileage.isNumber()) {
      state.fieldBindings.add(FieldBinding.numberBinding(
          questId,
          "reward_mileage",
          ownerFunctionPath,
          mileage.constantIndex,
          mileage.sourcePc,
          mileage.sourceFunctionPath,
          mileage.numberValue));
    }

    Value getSkill = table.fields.get("getSkill");
    if(getSkill != null) {
      collectRewardSkillBindings(state, questId, ownerFunctionPath, getSkill, new HashSet<Integer>(), new int[] { 0 });
    }

    Value itemId = table.fields.get("itemid");
    if(itemId != null && itemId.isNumber()) {
      state.fieldBindings.add(FieldBinding.numberBinding(
          questId,
          "reward_item_id",
          ownerFunctionPath,
          itemId.constantIndex,
          itemId.sourcePc,
          itemId.sourceFunctionPath,
          itemId.numberValue));
    }

    Value count = table.fields.get("count");
    if(count != null && count.isNumber()) {
      state.fieldBindings.add(FieldBinding.numberBinding(
          questId,
          "reward_item_count",
          ownerFunctionPath,
          count.constantIndex,
          count.sourcePc,
          count.sourceFunctionPath,
          count.numberValue));
    }

    Value itemCount = table.fields.get("itemcnt");
    if(itemCount != null && itemCount.isNumber()) {
      state.fieldBindings.add(FieldBinding.numberBinding(
          questId,
          "reward_item_count",
          ownerFunctionPath,
          itemCount.constantIndex,
          itemCount.sourcePc,
          itemCount.sourceFunctionPath,
          itemCount.numberValue));
    }

    for(Map.Entry<String, Value> entry : table.fields.entrySet()) {
      String key = entry.getKey();
      Value value = entry.getValue();
      if(isKnownRewardFieldKey(key) || value == null) {
        continue;
      }
      if(value.isString() && value.constantIndex >= 0) {
        state.fieldBindings.add(FieldBinding.stringBinding(
            questId,
            "reward_extra." + key,
            ownerFunctionPath,
            value.constantIndex,
            value.sourcePc,
            value.sourceFunctionPath,
            value.stringValue));
      } else if(value.isNumber() && value.constantIndex >= 0) {
        state.fieldBindings.add(FieldBinding.numberBinding(
            questId,
            "reward_extra." + key,
            ownerFunctionPath,
            value.constantIndex,
            value.sourcePc,
            value.sourceFunctionPath,
            value.numberValue));
      }
    }

    for(Map.Entry<Integer, Value> entry : table.array.entrySet()) {
      collectRewardBindings(state, questId, ownerFunctionPath, entry.getValue(), visited);
    }
    for(Map.Entry<String, Value> entry : table.fields.entrySet()) {
      collectRewardBindings(state, questId, ownerFunctionPath, entry.getValue(), visited);
    }

    visited.remove(table.id);
  }

  private boolean isKnownRewardFieldKey(String key) {
    return "itemid".equals(key)
        || "id".equals(key)
        || "count".equals(key)
        || "itemcnt".equals(key)
        || "money".equals(key)
        || "exp".equals(key)
        || "fame".equals(key)
        || "pvppoint".equals(key)
        || "mileage".equals(key)
        || "getSkill".equals(key)
        || "getItem".equals(key);
  }

  private Integer inferQuestId(TableState table) {
    if(table == null) {
      return null;
    }
    Value id = table.fields.get("id");
    if(id == null) {
      return null;
    }
    if(id.isNumber()) {
      Integer v = id.asInteger();
      return v;
    }
    return null;
  }

  private void fillQuestGoalFromValue(QuestGoal goal, Value value) {
    if(goal == null || value == null || !value.isTable()) {
      return;
    }
    TableState table = value.asTable();
    Value getItem = table.fields.get("getItem");
    if(getItem != null) {
      fillQuestItemRequirements(goal, getItem);
    }
    Value killMonster = table.fields.get("killMonster");
    if(killMonster != null) {
      fillQuestKillRequirements(goal, killMonster);
    }
  }

  private void fillQuestItemRequirements(QuestGoal goal, Value value) {
    if(goal == null || value == null) {
      return;
    }
    List<TableState> tables = collectRequirementTables(value, new HashSet<Integer>());
    for(TableState table : tables) {
      Integer itemId = readIntField(table, "itemid");
      if(itemId == null || itemId.intValue() <= 0) {
        itemId = readIntField(table, "id");
      }
      Integer itemCount = readIntField(table, "itemcnt");
      if(itemCount == null || itemCount.intValue() <= 0) {
        itemCount = readIntField(table, "count");
      }
      if(itemId == null || itemId.intValue() <= 0) {
        continue;
      }
      if(itemCount == null || itemCount.intValue() <= 0) {
        itemCount = Integer.valueOf(1);
      }

      Integer meetCount = readIntField(table, "meetcnt");
      if(meetCount == null) {
        meetCount = Integer.valueOf(0);
      }

      if(hasSameItemRequirement(goal.items, itemId.intValue(), itemCount.intValue(), meetCount.intValue())) {
        continue;
      }

      ItemRequirement req = new ItemRequirement();
      req.itemId = itemId.intValue();
      req.itemCount = itemCount.intValue();
      req.meetCount = meetCount.intValue();
      goal.items.add(req);
    }
  }

  private void fillQuestKillRequirements(QuestGoal goal, Value value) {
    if(goal == null || value == null) {
      return;
    }
    List<TableState> tables = collectRequirementTables(value, new HashSet<Integer>());
    for(TableState table : tables) {
      Integer monsterId = readIntField(table, "id");
      if(monsterId == null || monsterId.intValue() <= 0) {
        monsterId = readIntField(table, "monsterid");
      }
      Integer killCount = readIntField(table, "count");
      if(killCount == null || killCount.intValue() <= 0) {
        killCount = readIntField(table, "killcount");
      }
      if(monsterId == null || monsterId.intValue() <= 0 || killCount == null || killCount.intValue() <= 0) {
        continue;
      }
      if(hasSameKillRequirement(goal.monsters, monsterId.intValue(), killCount.intValue())) {
        continue;
      }
      KillRequirement req = new KillRequirement();
      req.monsterId = monsterId.intValue();
      req.killCount = killCount.intValue();
      goal.monsters.add(req);
    }
  }

  private List<TableState> collectRequirementTables(Value value, Set<Integer> visited) {
    List<TableState> out = new ArrayList<TableState>();
    if(value == null || !value.isTable()) {
      return out;
    }
    TableState table = value.asTable();
    if(table == null || !visited.add(table.id)) {
      return out;
    }

    boolean looksLikeLeaf = hasRequirementLeaf(table);
    if(looksLikeLeaf) {
      out.add(table);
    }

    for(Map.Entry<Integer, Value> entry : table.array.entrySet()) {
      out.addAll(collectRequirementTables(entry.getValue(), visited));
    }
    for(Map.Entry<String, Value> entry : table.fields.entrySet()) {
      out.addAll(collectRequirementTables(entry.getValue(), visited));
    }

    visited.remove(table.id);
    return out;
  }

  private boolean hasRequirementLeaf(TableState table) {
    if(table == null) {
      return false;
    }
    return table.fields.containsKey("itemid")
        || table.fields.containsKey("itemcnt")
        || table.fields.containsKey("meetcnt")
        || table.fields.containsKey("monsterid")
        || (table.fields.containsKey("id") && table.fields.containsKey("count"));
  }

  private Integer readIntField(TableState table, String key) {
    if(table == null || key == null) {
      return null;
    }
    Value value = table.fields.get(key);
    if(value == null || !value.isNumber()) {
      return null;
    }
    return value.asInteger();
  }

  private boolean hasSameItemRequirement(List<ItemRequirement> items, int itemId, int itemCount, int meetCount) {
    for(ItemRequirement req : items) {
      if(req.itemId == itemId && req.itemCount == itemCount && req.meetCount == meetCount) {
        return true;
      }
    }
    return false;
  }

  private boolean hasSameKillRequirement(List<KillRequirement> monsters, int monsterId, int killCount) {
    for(KillRequirement req : monsters) {
      if(req.monsterId == monsterId && req.killCount == killCount) {
        return true;
      }
    }
    return false;
  }

  private boolean isQuestSemanticTable(TableState table) {
    if(table == null) {
      return false;
    }
    if(!table.fields.containsKey("id")) {
      return false;
    }
    for(String key : QUEST_KEYS) {
      if("id".equals(key)) {
        continue;
      }
      if(table.fields.containsKey(key)) {
        return true;
      }
    }
    return false;
  }

  private String stringField(TableState table, String key) {
    Value v = table.fields.get(key);
    if(v == null || !v.isString()) {
      return null;
    }
    return v.asString();
  }

  private String firstStringFromField(TableState table, String key) {
    Value value = table.fields.get(key);
    if(value == null) {
      return null;
    }
    List<String> values = extractStringLeaves(value, 0, new HashSet<Integer>());
    if(values.isEmpty()) {
      return null;
    }
    return values.get(0);
  }

  private List<String> extractStringLeaves(Value value, int depth, Set<Integer> visitedTables) {
    List<String> out = new ArrayList<String>();
    if(value == null || depth > 10) {
      return out;
    }
    if(value.isString()) {
      out.add(value.asString());
      return out;
    }
    if(!value.isTable()) {
      return out;
    }

    TableState table = value.asTable();
    if(table == null || !visitedTables.add(table.id)) {
      return out;
    }

    for(Map.Entry<Integer, Value> entry : table.array.entrySet()) {
      out.addAll(extractStringLeaves(entry.getValue(), depth + 1, visitedTables));
    }
    for(Map.Entry<String, Value> entry : table.fields.entrySet()) {
      out.addAll(extractStringLeaves(entry.getValue(), depth + 1, visitedTables));
    }

    visitedTables.remove(table.id);
    return out;
  }

  private List<Value> extractStringLeafValues(Value value, int depth, Set<Integer> visitedTables) {
    List<Value> out = new ArrayList<Value>();
    if(value == null || depth > 10) {
      return out;
    }
    if(value.isString()) {
      out.add(value);
      return out;
    }
    if(!value.isTable()) {
      return out;
    }

    TableState table = value.asTable();
    if(table == null || !visitedTables.add(table.id)) {
      return out;
    }

    for(Map.Entry<Integer, Value> entry : table.array.entrySet()) {
      out.addAll(extractStringLeafValues(entry.getValue(), depth + 1, visitedTables));
    }
    for(Map.Entry<String, Value> entry : table.fields.entrySet()) {
      out.addAll(extractStringLeafValues(entry.getValue(), depth + 1, visitedTables));
    }

    visitedTables.remove(table.id);
    return out;
  }

  private List<Integer> extractIntegerLeaves(Value value, int depth, Set<Integer> visitedTables) {
    List<Integer> out = new ArrayList<Integer>();
    if(value == null || depth > 10) {
      return out;
    }
    if(value.isNumber()) {
      Integer i = value.asInteger();
      if(i != null) {
        out.add(i);
      }
      return out;
    }
    if(!value.isTable()) {
      return out;
    }

    TableState table = value.asTable();
    if(table == null || !visitedTables.add(table.id)) {
      return out;
    }

    for(Map.Entry<Integer, Value> entry : table.array.entrySet()) {
      out.addAll(extractIntegerLeaves(entry.getValue(), depth + 1, visitedTables));
    }
    for(Map.Entry<String, Value> entry : table.fields.entrySet()) {
      out.addAll(extractIntegerLeaves(entry.getValue(), depth + 1, visitedTables));
    }

    visitedTables.remove(table.id);
    return out;
  }

  private List<QuestSemanticModel.Reward> extractRewards(Value value, int depth, Set<Integer> visitedTables) {
    List<QuestSemanticModel.Reward> out = new ArrayList<QuestSemanticModel.Reward>();
    if(value == null || depth > 10) {
      return out;
    }

    if(value.isTable()) {
      TableState table = value.asTable();
      if(table == null || !visitedTables.add(table.id)) {
        return out;
      }

      QuestSemanticModel.Reward direct = rewardFromTable(table);
      if(direct != null) {
        out.add(direct);
      }

      for(Map.Entry<Integer, Value> entry : table.array.entrySet()) {
        out.addAll(extractRewards(entry.getValue(), depth + 1, visitedTables));
      }
      for(Map.Entry<String, Value> entry : table.fields.entrySet()) {
        out.addAll(extractRewards(entry.getValue(), depth + 1, visitedTables));
      }

      visitedTables.remove(table.id);
    }
    return out;
  }

  private List<QuestSemanticModel.Reward> extractRewardsFromTable(TableState table) {
    List<QuestSemanticModel.Reward> rewards = new ArrayList<QuestSemanticModel.Reward>();
    QuestSemanticModel.Reward direct = rewardFromTable(table);
    if(direct != null) {
      rewards.add(direct);
    }
    return rewards;
  }

  private QuestSemanticModel.Reward rewardFromTable(TableState table) {
    boolean hasRewardField = false;
    for(String key : REWARD_KEYS) {
      if(table.fields.containsKey(key)) {
        hasRewardField = true;
        break;
      }
    }
    if(!hasRewardField) {
      return null;
    }

    QuestSemanticModel.Reward reward = new QuestSemanticModel.Reward();
    reward.type = "table";

    for(Map.Entry<String, Value> entry : table.fields.entrySet()) {
      String key = entry.getKey();
      Value value = entry.getValue();
      reward.fieldOrder.add(key);

      if("itemid".equals(key)) {
        Integer itemId = value == null ? null : value.asInteger();
        if(itemId != null) {
          reward.id = itemId.intValue();
          reward.type = "item";
        }
        continue;
      }
      if("id".equals(key)) {
        Integer rid = value == null ? null : value.asInteger();
        if(rid != null && reward.id == 0) {
          reward.id = rid.intValue();
        }
        continue;
      }
      if("count".equals(key) || "itemcnt".equals(key)) {
        Integer countValue = value == null ? null : value.asInteger();
        if(countValue != null) {
          reward.count = countValue.intValue();
          reward.type = "item";
        }
        continue;
      }
      if("money".equals(key)) {
        Integer number = value == null ? null : value.asInteger();
        if(number != null) {
          reward.money = number.intValue();
          if("table".equals(reward.type)) {
            reward.type = "currency";
          }
        }
        continue;
      }
      if("fame".equals(key)) {
        Integer number = value == null ? null : value.asInteger();
        if(number != null) {
          reward.fame = number.intValue();
          if("table".equals(reward.type)) {
            reward.type = "fame";
          }
        }
        continue;
      }
      if("pvppoint".equals(key)) {
        Integer number = value == null ? null : value.asInteger();
        if(number != null) {
          reward.pvppoint = number.intValue();
          if("table".equals(reward.type)) {
            reward.type = "pvppoint";
          }
        }
        continue;
      }
      if("mileage".equals(key)) {
        Integer number = value == null ? null : value.asInteger();
        if(number != null) {
          reward.extraFields.put("mileage", number);
          if("table".equals(reward.type)) {
            reward.type = "mileage";
          }
        }
        continue;
      }
      if("exp".equals(key)) {
        Integer number = value == null ? null : value.asInteger();
        if(number != null) {
          reward.exp = number.intValue();
          if("table".equals(reward.type)) {
            reward.type = "exp";
          }
        }
        continue;
      }
      if("getSkill".equals(key)) {
        if(value != null) {
          reward.skillIds.addAll(extractIntegerLeaves(value, 0, new HashSet<Integer>()));
          if(!reward.skillIds.isEmpty() && "table".equals(reward.type)) {
            reward.type = "skill";
          }
        }
        continue;
      }
      reward.extraFields.put(key, toObject(value, 0, new HashSet<Integer>()));
    }

    return reward;
  }

  private Integer numberField(TableState table, String key) {
    Value value = table.fields.get(key);
    if(value == null || !value.isNumber()) {
      return null;
    }
    return value.asInteger();
  }

  private void collectRewardSkillBindings(AnalysisState state,
                                          int questId,
                                          String ownerFunctionPath,
                                          Value value,
                                          Set<Integer> visited,
                                          int[] indexRef) {
    if(value == null) {
      return;
    }
    if(value.isNumber()) {
      if(value.constantIndex >= 0) {
        int index = indexRef[0];
        state.fieldBindings.add(FieldBinding.numberBinding(
            questId,
            "reward_skill_ids[" + index + "]",
            ownerFunctionPath,
            value.constantIndex,
            value.sourcePc,
            value.sourceFunctionPath,
            value.numberValue));
      }
      indexRef[0] = indexRef[0] + 1;
      return;
    }
    if(!value.isTable()) {
      return;
    }

    TableState table = value.asTable();
    if(table == null || !visited.add(table.id)) {
      return;
    }
    for(Map.Entry<Integer, Value> entry : table.array.entrySet()) {
      collectRewardSkillBindings(state, questId, ownerFunctionPath, entry.getValue(), visited, indexRef);
    }
    for(Map.Entry<String, Value> entry : table.fields.entrySet()) {
      collectRewardSkillBindings(state, questId, ownerFunctionPath, entry.getValue(), visited, indexRef);
    }
    visited.remove(table.id);
  }

  private Object toObject(Value value, int depth, Set<Integer> visitedTables) {
    if(value == null || depth > 12) {
      return null;
    }
    if(value.isNil()) {
      return null;
    }
    if(value.isBoolean()) {
      return Boolean.valueOf(value.boolValue);
    }
    if(value.isNumber()) {
      Integer i = value.asInteger();
      if(i != null) {
        return i;
      }
      return Double.valueOf(value.numberValue);
    }
    if(value.isString()) {
      return value.stringValue;
    }
    if(value.isGlobal()) {
      return "$global:" + value.globalName;
    }
    if(value.isClosure()) {
      return "$closure:" + value.closurePath;
    }
    if(!value.isTable()) {
      return null;
    }

    TableState table = value.asTable();
    if(table == null || !visitedTables.add(table.id)) {
      return "$cycle:" + (table == null ? -1 : table.id);
    }

    boolean arrayOnly = table.fields.isEmpty();
    List<Object> arrayValues = new ArrayList<Object>();
    for(Map.Entry<Integer, Value> entry : table.array.entrySet()) {
      arrayValues.add(toObject(entry.getValue(), depth + 1, visitedTables));
    }

    Object result;
    if(arrayOnly) {
      result = arrayValues;
    } else {
      Map<String, Object> map = new LinkedHashMap<String, Object>();
      for(Map.Entry<String, Value> entry : table.fields.entrySet()) {
        map.put(entry.getKey(), toObject(entry.getValue(), depth + 1, visitedTables));
      }
      if(!arrayValues.isEmpty()) {
        map.put("__array", arrayValues);
      }
      result = map;
    }

    visitedTables.remove(table.id);
    return result;
  }

  private Integer firstQuestIdFromArgs(List<Value> args) {
    if(args == null) {
      return null;
    }
    for(Value arg : args) {
      if(arg == null) {
        continue;
      }
      if(arg.isTable()) {
        Integer qid = inferQuestId(arg.asTable());
        if(qid != null && qid.intValue() > 0) {
          return qid;
        }
      }
      if(arg.isNumber()) {
        Integer i = arg.asInteger();
        if(i != null && i.intValue() > 0 && i.intValue() < 1000000) {
          return i;
        }
      }
    }
    return null;
  }

  private String callName(Value callee) {
    if(callee == null) {
      return null;
    }
    if(callee.isGlobal()) {
      return callee.globalName;
    }
    if(callee.isString()) {
      return callee.stringValue;
    }
    return null;
  }

  private boolean isSemanticCall(String callName, List<Value> args) {
    if(callName != null) {
      String low = callName.toLowerCase();
      if(low.contains("quest") || low.contains("npc") || low.contains("dialog")) {
        return true;
      }
    }
    for(Value arg : args) {
      if(arg != null && arg.isTable()) {
        Integer qid = inferQuestId(arg.asTable());
        if(qid != null && qid.intValue() > 0) {
          return true;
        }
      }
    }
    return false;
  }

  private String describeValue(Value value) {
    if(value == null) {
      return "null";
    }
    if(value.isNil()) {
      return "nil";
    }
    if(value.isBoolean()) {
      return "bool:" + value.boolValue;
    }
    if(value.isNumber()) {
      Integer integer = value.asInteger();
      if(integer != null) {
        return "num:" + integer;
      }
      return "num:" + value.numberValue;
    }
    if(value.isString()) {
      String s = value.stringValue;
      if(s == null) {
        s = "";
      }
      if(s.length() > 40) {
        s = s.substring(0, 40) + "...";
      }
      if(value.constantIndex >= 0) {
        return "str[K" + value.constantIndex + "]:" + s;
      }
      return "str:" + s;
    }
    if(value.isTable()) {
      return "Table#" + value.tableRef.id;
    }
    if(value.isGlobal()) {
      return "Global:" + value.globalName;
    }
    if(value.isClosure()) {
      return "Closure:" + value.closurePath;
    }
    return "unknown";
  }

  private String rewardSignature(QuestSemanticModel.Reward reward) {
    StringBuilder sb = new StringBuilder();
    sb.append(reward.type).append("|")
      .append(reward.id).append("|")
      .append(reward.count).append("|")
      .append(reward.money).append("|")
      .append(reward.exp).append("|")
      .append(reward.fame).append("|")
      .append(reward.pvppoint).append("|")
      .append(reward.skillIds).append("|");

    List<String> keys = new ArrayList<String>(reward.extraFields.keySet());
    Collections.sort(keys);
    for(String key : keys) {
      sb.append(key).append("=").append(String.valueOf(reward.extraFields.get(key))).append(";");
    }
    sb.append("|order=").append(reward.fieldOrder);
    return sb.toString();
  }

  private void putCondition(Map<String, Object> conditions, String key, Object value) {
    if(value == null) {
      return;
    }
    if(!conditions.containsKey(key)) {
      conditions.put(key, value);
      return;
    }

    Object current = conditions.get(key);
    if(current == null) {
      conditions.put(key, value);
      return;
    }

    if(current instanceof List<?>) {
      @SuppressWarnings("unchecked")
      List<Object> list = (List<Object>) current;
      if(!list.contains(value)) {
        list.add(value);
      }
      return;
    }

    if(current.equals(value)) {
      return;
    }

    List<Object> list = new ArrayList<Object>();
    list.add(current);
    list.add(value);
    conditions.put(key, list);
  }

  private Set<String> ensureStringSet(Map<Integer, Set<String>> map, Integer key) {
    Set<String> set = map.get(key);
    if(set == null) {
      set = new LinkedHashSet<String>();
      map.put(key, set);
    }
    return set;
  }

  private Set<Integer> ensureIntSet(Map<Integer, Set<Integer>> map, Integer key) {
    Set<Integer> set = map.get(key);
    if(set == null) {
      set = new LinkedHashSet<Integer>();
      map.put(key, set);
    }
    return set;
  }

  public static final class ExtractionResult {
    public final List<QuestSemanticModel> quests = new ArrayList<QuestSemanticModel>();
    public final List<RuleHit> ruleHits = new ArrayList<RuleHit>();
    public final List<FieldBinding> fieldBindings = new ArrayList<FieldBinding>();
  }

  public static final class FieldCoverageScanResult {
    public final Set<Integer> questIds = new LinkedHashSet<Integer>();
    public final Set<String> questFields = new LinkedHashSet<String>();
    public final Set<String> goalFields = new LinkedHashSet<String>();
    public final Set<String> rewardFields = new LinkedHashSet<String>();
  }

  public static final class FieldInventoryScanResult {
    public final Set<Integer> questIds = new LinkedHashSet<Integer>();
    public final Map<String, FieldStat> questFieldStats = new LinkedHashMap<String, FieldStat>();
    public final Map<String, FieldStat> goalFieldStats = new LinkedHashMap<String, FieldStat>();
    public final Map<String, FieldStat> rewardFieldStats = new LinkedHashMap<String, FieldStat>();
  }

  public static final class FieldStat {
    public final String fieldName;
    public int count;
    public String exampleValue = "";
    public int exampleQuestId;

    public FieldStat(String fieldName) {
      this.fieldName = fieldName == null ? "" : fieldName;
    }
  }

  public static final class FieldBinding {
    public final int questId;
    public final String fieldKey;
    public final String ownerFunctionPath;
    public final int constantIndex;
    public final int sourcePc;
    public final String sourceFunctionPath;

    public final String valueType;
    public final String stringValue;
    public final Double numberValue;

    private FieldBinding(int questId,
                         String fieldKey,
                         String ownerFunctionPath,
                         int constantIndex,
                         int sourcePc,
                         String sourceFunctionPath,
                         String valueType,
                         String stringValue,
                         Double numberValue) {
      this.questId = questId;
      this.fieldKey = fieldKey;
      this.ownerFunctionPath = ownerFunctionPath;
      this.constantIndex = constantIndex;
      this.sourcePc = sourcePc;
      this.sourceFunctionPath = sourceFunctionPath;
      this.valueType = valueType;
      this.stringValue = stringValue;
      this.numberValue = numberValue;
    }

    public static FieldBinding stringBinding(int questId,
                                             String fieldKey,
                                             String ownerFunctionPath,
                                             int constantIndex,
                                             int sourcePc,
                                             String sourceFunctionPath,
                                             String value) {
      return new FieldBinding(
          questId,
          fieldKey,
          ownerFunctionPath,
          constantIndex,
          sourcePc,
          sourceFunctionPath,
          "string",
          value,
          null);
    }

    public static FieldBinding numberBinding(int questId,
                                             String fieldKey,
                                             String ownerFunctionPath,
                                             int constantIndex,
                                             int sourcePc,
                                             String sourceFunctionPath,
                                             double value) {
      return new FieldBinding(
          questId,
          fieldKey,
          ownerFunctionPath,
          constantIndex,
          sourcePc,
          sourceFunctionPath,
          "number",
          null,
          Double.valueOf(value));
    }
  }

  public static final class RuleHit {
    public final String ruleId;
    public final String functionPath;
    public final int pc;
    public final int offset;
    public final String detail;

    public RuleHit(String ruleId, String functionPath, int pc, int offset, String detail) {
      this.ruleId = ruleId;
      this.functionPath = functionPath;
      this.pc = pc;
      this.offset = offset;
      this.detail = detail;
    }
  }

  private static final class AnalysisState {
    final LuaChunk chunk;
    final Map<String, Value> globalValues = new HashMap<String, Value>();
    final List<TableState> tables = new ArrayList<TableState>();
    final List<CallEvent> callEvents = new ArrayList<CallEvent>();
    final List<RuleHit> ruleHits = new ArrayList<RuleHit>();
    final List<FieldBinding> fieldBindings = new ArrayList<FieldBinding>();
    int nextTableId = 1;

    AnalysisState(LuaChunk chunk) {
      this.chunk = chunk;
    }
  }

  private static final class FunctionFrame {
    final LuaChunk.Function function;
    final Lua50InstructionCodec codec;
    final int rkBase;
    final Map<Integer, Value> registers = new HashMap<Integer, Value>();

    FunctionFrame(LuaChunk chunk, LuaChunk.Function function) {
      this.function = function;
      this.codec = new Lua50InstructionCodec(chunk.header.opSize, chunk.header.aSize, chunk.header.bSize, chunk.header.cSize);
      if(chunk.header.version == 0x50) {
        this.rkBase = 250;
      } else if(chunk.header.bSize > 1) {
        this.rkBase = 1 << (chunk.header.bSize - 1);
      } else {
        this.rkBase = 256;
      }
    }

    Value getRegister(int index) {
      Value value = registers.get(index);
      if(value == null) {
        return Value.unknown(function.path, -1);
      }
      return value;
    }

    void setRegister(int index, Value value) {
      registers.put(index, value == null ? Value.unknown(function.path, -1) : value);
    }
  }

  private static final class TableState {
    final int id;
    final String functionPath;
    final int createPc;
    final int createOffset;
    final Map<String, Value> fields = new LinkedHashMap<String, Value>();
    final Map<Integer, Value> array = new TreeMap<Integer, Value>();

    TableState(int id, String functionPath, int createPc, int createOffset) {
      this.id = id;
      this.functionPath = functionPath;
      this.createPc = createPc;
      this.createOffset = createOffset;
    }

    void put(Value key, Value value, int pc, int offset) {
      if(key == null) {
        return;
      }
      if(key.isString()) {
        fields.put(key.asString(), value.copyWithSource(pc));
      } else if(key.isNumber()) {
        Integer index = key.asInteger();
        if(index != null && index.intValue() >= 1) {
          array.put(index, value.copyWithSource(pc));
        }
      }
    }

    Value get(Value key) {
      if(key == null) {
        return null;
      }
      if(key.isString()) {
        return fields.get(key.asString());
      }
      if(key.isNumber()) {
        Integer index = key.asInteger();
        if(index != null) {
          return array.get(index);
        }
      }
      return null;
    }
  }

  private static final class CallEvent {
    final String functionPath;
    final int pc;
    final int offset;
    final String callName;
    final Value callee;
    final List<Value> args;

    CallEvent(String functionPath, int pc, int offset, String callName, Value callee, List<Value> args) {
      this.functionPath = functionPath;
      this.pc = pc;
      this.offset = offset;
      this.callName = callName;
      this.callee = callee;
      this.args = args;
    }
  }

  private static final class ParsedDialogOption {
    String optionText;
  }

  private static final class Value {
    enum Kind {
      UNKNOWN,
      NIL,
      BOOLEAN,
      NUMBER,
      STRING,
      TABLE,
      GLOBAL,
      CLOSURE
    }

    Kind kind;
    boolean boolValue;
    double numberValue;
    String stringValue;
    TableState tableRef;
    String globalName;
    String closurePath;

    String sourceFunctionPath;
    int sourcePc;
    int constantIndex = -1;
    String relation;

    static Value unknown(String functionPath, int pc) {
      Value v = new Value();
      v.kind = Kind.UNKNOWN;
      v.sourceFunctionPath = functionPath;
      v.sourcePc = pc;
      return v;
    }

    static Value nil(String functionPath, int pc) {
      Value v = new Value();
      v.kind = Kind.NIL;
      v.sourceFunctionPath = functionPath;
      v.sourcePc = pc;
      return v;
    }

    static Value bool(boolean value, String functionPath, int pc) {
      Value v = new Value();
      v.kind = Kind.BOOLEAN;
      v.boolValue = value;
      v.sourceFunctionPath = functionPath;
      v.sourcePc = pc;
      return v;
    }

    static Value number(double value, String functionPath, int pc) {
      Value v = new Value();
      v.kind = Kind.NUMBER;
      v.numberValue = value;
      v.sourceFunctionPath = functionPath;
      v.sourcePc = pc;
      return v;
    }

    static Value string(String value, String functionPath, int pc) {
      Value v = new Value();
      v.kind = Kind.STRING;
      v.stringValue = value;
      v.sourceFunctionPath = functionPath;
      v.sourcePc = pc;
      return v;
    }

    static Value table(TableState table, String functionPath, int pc) {
      Value v = new Value();
      v.kind = Kind.TABLE;
      v.tableRef = table;
      v.sourceFunctionPath = functionPath;
      v.sourcePc = pc;
      return v;
    }

    static Value global(String name, String functionPath, int pc, int constantIndex) {
      Value v = new Value();
      v.kind = Kind.GLOBAL;
      v.globalName = name;
      v.sourceFunctionPath = functionPath;
      v.sourcePc = pc;
      v.constantIndex = constantIndex;
      return v;
    }

    static Value closure(String closurePath, String functionPath, int pc) {
      Value v = new Value();
      v.kind = Kind.CLOSURE;
      v.closurePath = closurePath;
      v.sourceFunctionPath = functionPath;
      v.sourcePc = pc;
      return v;
    }

    Value copy() {
      Value v = new Value();
      v.kind = this.kind;
      v.boolValue = this.boolValue;
      v.numberValue = this.numberValue;
      v.stringValue = this.stringValue;
      v.tableRef = this.tableRef;
      v.globalName = this.globalName;
      v.closurePath = this.closurePath;
      v.sourceFunctionPath = this.sourceFunctionPath;
      v.sourcePc = this.sourcePc;
      v.constantIndex = this.constantIndex;
      v.relation = this.relation;
      return v;
    }

    Value copyWithSource(int pc) {
      Value v = copy();
      v.sourcePc = pc;
      return v;
    }

    boolean isNil() {
      return kind == Kind.NIL;
    }

    boolean isBoolean() {
      return kind == Kind.BOOLEAN;
    }

    boolean isNumber() {
      return kind == Kind.NUMBER;
    }

    boolean isString() {
      return kind == Kind.STRING;
    }

    boolean isTable() {
      return kind == Kind.TABLE && tableRef != null;
    }

    boolean isGlobal() {
      return kind == Kind.GLOBAL;
    }

    boolean isClosure() {
      return kind == Kind.CLOSURE;
    }

    String asString() {
      return isString() ? stringValue : null;
    }

    Integer asInteger() {
      if(!isNumber()) {
        return null;
      }
      double rounded = Math.rint(numberValue);
      if(Math.abs(numberValue - rounded) > 0.0000001D) {
        return null;
      }
      if(rounded > Integer.MAX_VALUE || rounded < Integer.MIN_VALUE) {
        return null;
      }
      return Integer.valueOf((int) rounded);
    }

    TableState asTable() {
      return isTable() ? tableRef : null;
    }
  }

}
