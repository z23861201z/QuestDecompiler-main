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
import java.util.TreeSet;

import unluac.chunk.LuaChunk;
import unluac.decompile.Op;

public class QuestDialogTreeExtractor {

  private static final Set<Op> CONDITIONAL_OPS = new HashSet<Op>();

  static {
    CONDITIONAL_OPS.add(Op.EQ);
    CONDITIONAL_OPS.add(Op.LT);
    CONDITIONAL_OPS.add(Op.LE);
    CONDITIONAL_OPS.add(Op.TEST);
    CONDITIONAL_OPS.add(Op.TESTSET);
    CONDITIONAL_OPS.add(Op.TEST50);
  }

  public Map<Integer, QuestDialogTree> extractTrees(LuaChunk chunk, Set<Integer> questIds) {
    Map<Integer, QuestDialogTreeBuilder> builders = new LinkedHashMap<Integer, QuestDialogTreeBuilder>();
    for(Integer questId : questIds) {
      if(questId == null || questId.intValue() <= 0) {
        continue;
      }
      builders.put(questId, new QuestDialogTreeBuilder());
    }

    if(chunk == null || chunk.header == null || chunk.mainFunction == null || builders.isEmpty()) {
      Map<Integer, QuestDialogTree> out = new LinkedHashMap<Integer, QuestDialogTree>();
      for(Map.Entry<Integer, QuestDialogTreeBuilder> entry : builders.entrySet()) {
        out.put(entry.getKey(), entry.getValue().build());
      }
      return out;
    }

    extractFromFunction(chunk, chunk.mainFunction, builders, 0);

    Map<Integer, QuestDialogTree> out = new LinkedHashMap<Integer, QuestDialogTree>();
    for(Map.Entry<Integer, QuestDialogTreeBuilder> entry : builders.entrySet()) {
      out.put(entry.getKey(), entry.getValue().build());
    }
    return out;
  }

  private void extractFromFunction(LuaChunk chunk,
                                   LuaChunk.Function function,
                                   Map<Integer, QuestDialogTreeBuilder> builders,
                                   int depth) {
    if(depth > 4) {
      return;
    }
    if(function == null || function.code == null || function.code.isEmpty()) {
      for(LuaChunk.Function child : function == null ? Collections.<LuaChunk.Function>emptyList() : function.prototypes) {
        extractFromFunction(chunk, child, builders, depth + 1);
      }
      return;
    }

    FunctionFlow flow = analyzeFunctionFlow(chunk, function);
    for(Map.Entry<Integer, QuestDialogTreeBuilder> entry : builders.entrySet()) {
      int questId = entry.getKey().intValue();
      if(!hasAnyCallForQuest(flow, questId)) {
        continue;
      }
      QuestDialogTreeBuilder builder = entry.getValue();
      int entryBlock = findEntryBlockForQuest(flow, questId);
      if(entryBlock < 0) {
        continue;
      }
      Set<VisitState> visited = new HashSet<VisitState>();
      Map<String, Integer> branchEdgeNode = new HashMap<String, Integer>();
      traverseFlow(flow, entryBlock, builder.rootIndex(), questId, builder, visited, branchEdgeNode);
    }

    for(LuaChunk.Function child : function.prototypes) {
      extractFromFunction(chunk, child, builders, depth + 1);
    }
  }

  private boolean hasAnyCallForQuest(FunctionFlow flow, int questId) {
    for(CallAction call : flow.callsByPc.values()) {
      if(call != null && call.questIds.contains(Integer.valueOf(questId))) {
        return true;
      }
    }
    return false;
  }

  private int findEntryBlockForQuest(FunctionFlow flow, int questId) {
    int firstPc = Integer.MAX_VALUE;
    for(CallAction call : flow.callsByPc.values()) {
      if(call == null || !call.questIds.contains(Integer.valueOf(questId))) {
        continue;
      }
      if(call.pc < firstPc) {
        firstPc = call.pc;
      }
    }
    if(firstPc == Integer.MAX_VALUE) {
      return -1;
    }
    Integer blockId = flow.blockByPc.get(Integer.valueOf(firstPc));
    return blockId == null ? -1 : blockId.intValue();
  }

  private FunctionFlow analyzeFunctionFlow(LuaChunk chunk, LuaChunk.Function function) {
    FunctionFlow flow = new FunctionFlow();
    flow.functionPath = function.path;

    Lua50InstructionCodec codec = new Lua50InstructionCodec(
        chunk.header.opSize,
        chunk.header.aSize,
        chunk.header.bSize,
        chunk.header.cSize);

    int rkBase = chunk.header.version == 0x50 ? 250
        : (chunk.header.bSize > 1 ? (1 << (chunk.header.bSize - 1)) : 256);

    List<Insn> insns = new ArrayList<Insn>();
    for(int pc = 0; pc < function.code.size(); pc++) {
      LuaChunk.Instruction inst = function.code.get(pc);
      Lua50InstructionCodec.DecodedInstruction decoded = codec.decode(inst.value);
      Insn insn = new Insn();
      insn.pc = pc;
      insn.offset = inst.offset;
      insn.op = decoded.op;
      insn.decoded = decoded;
      insns.add(insn);
    }
    flow.insns = insns;

    Map<Integer, RuntimeValue> registers = new HashMap<Integer, RuntimeValue>();

    for(int pc = 0; pc < insns.size(); pc++) {
      Insn insn = insns.get(pc);
      Lua50InstructionCodec.DecodedInstruction decoded = insn.decoded;
      Op op = insn.op;
      if(op == null) {
        continue;
      }

      if(isConditionalOp(op) && pc + 1 < insns.size() && insns.get(pc + 1).op == Op.JMP) {
        int target = pc + 2 + insns.get(pc + 1).decoded.sBx;
        int fallthrough = pc + 2;
        if(target >= 0 && target < insns.size() && fallthrough >= 0 && fallthrough < insns.size()) {
          ConditionalEdge edge = new ConditionalEdge();
          edge.condPc = pc;
          edge.jmpPc = pc + 1;
          edge.fallthroughPc = fallthrough;
          edge.targetPc = target;
          flow.conditionalByJmpPc.put(Integer.valueOf(edge.jmpPc), edge);
        }
      }

      switch(op) {
        case MOVE:
          setRegister(registers, decoded.A, getRegister(registers, decoded.B));
          break;

        case LOADK:
          setRegister(registers, decoded.A, constantValue(function, decoded.Bx));
          break;

        case LOADBOOL:
          setRegister(registers, decoded.A, RuntimeValue.unknown());
          break;

        case LOADNIL: {
          int from = decoded.A;
          int to = decoded.B;
          if(to < from) {
            to = from;
          }
          for(int reg = from; reg <= to; reg++) {
            setRegister(registers, reg, RuntimeValue.unknown());
          }
          break;
        }

        case GETGLOBAL: {
          RuntimeValue name = constantValue(function, decoded.Bx);
          if(name.isString()) {
            setRegister(registers, decoded.A, RuntimeValue.global(name.stringValue));
          } else {
            setRegister(registers, decoded.A, RuntimeValue.unknown());
          }
          break;
        }

        case NEWTABLE:
        case NEWTABLE50:
          setRegister(registers, decoded.A, RuntimeValue.table(new TableRef()));
          break;

        case SETTABLE: {
          RuntimeValue table = getRegister(registers, decoded.A);
          RuntimeValue key = resolveRK(registers, function, decoded.B, rkBase);
          RuntimeValue value = resolveRK(registers, function, decoded.C, rkBase);
          if(table.isTable()) {
            table.tableRef.put(key, value);
          }
          break;
        }

        case SETLIST50:
        case SETLISTO: {
          RuntimeValue table = getRegister(registers, decoded.A);
          if(table.isTable()) {
            int bx = decoded.Bx;
            int n = bx % 32;
            for(int i = 1; i <= n + 1; i++) {
              int index = bx - n + i;
              RuntimeValue value = getRegister(registers, decoded.A + i);
              table.tableRef.array.put(Integer.valueOf(index), value.copy());
            }
          }
          break;
        }

        case GETTABLE: {
          RuntimeValue table = getRegister(registers, decoded.B);
          RuntimeValue key = resolveRK(registers, function, decoded.C, rkBase);
          if(table.isTable()) {
            RuntimeValue fromTable = table.tableRef.get(key);
            if(fromTable != null) {
              setRegister(registers, decoded.A, fromTable);
              break;
            }
          }
          if(key.isString()) {
            if(table.isGlobal()) {
              setRegister(registers, decoded.A, RuntimeValue.global(table.globalName + "." + key.stringValue));
            } else {
              setRegister(registers, decoded.A, RuntimeValue.global(key.stringValue));
            }
          } else {
            setRegister(registers, decoded.A, RuntimeValue.unknown());
          }
          break;
        }

        case SELF: {
          RuntimeValue table = getRegister(registers, decoded.B);
          RuntimeValue key = resolveRK(registers, function, decoded.C, rkBase);
          setRegister(registers, decoded.A + 1, table);
          if(key.isString()) {
            if(table.isGlobal()) {
              setRegister(registers, decoded.A, RuntimeValue.global(table.globalName + "." + key.stringValue));
            } else {
              setRegister(registers, decoded.A, RuntimeValue.global(key.stringValue));
            }
          } else {
            setRegister(registers, decoded.A, RuntimeValue.unknown());
          }
          break;
        }

        case TESTSET:
          setRegister(registers, decoded.A, getRegister(registers, decoded.B));
          break;

        case TEST50:
          if(decoded.A != decoded.B) {
            setRegister(registers, decoded.A, getRegister(registers, decoded.B));
          }
          break;

        case CALL: {
          CallAction action = new CallAction();
          action.pc = pc;
          action.offset = insn.offset;

          RuntimeValue callee = getRegister(registers, decoded.A);
          action.callName = normalizeCallName(callee);
          action.callBaseName = callBaseName(action.callName);

          if(decoded.B > 0) {
            for(int i = 1; i < decoded.B; i++) {
              RuntimeValue arg = getRegister(registers, decoded.A + i);
              action.args.add(arg);
              if(arg != null && arg.isNumber()) {
                Integer qid = arg.asInteger();
                if(qid != null && qid.intValue() > 0) {
                  action.questIds.add(qid);
                }
              } else if(arg != null && arg.isTable()) {
                Integer qid = inferQuestIdFromTable(arg.tableRef, new HashSet<TableRef>());
                if(qid != null && qid.intValue() > 0) {
                  action.questIds.add(qid);
                }
              }
            }
          }

          flow.callsByPc.put(Integer.valueOf(pc), action);

          if(decoded.C == 0) {
            for(int reg = decoded.A; reg < decoded.A + 8; reg++) {
              setRegister(registers, reg, RuntimeValue.unknown());
            }
          } else {
            for(int reg = decoded.A; reg < decoded.A + Math.max(decoded.C - 1, 0); reg++) {
              setRegister(registers, reg, RuntimeValue.unknown());
            }
          }
          break;
        }

        case CLOSURE:
          setRegister(registers, decoded.A, RuntimeValue.unknown());
          break;

        default:
          if(writesRegisterA(op)) {
            setRegister(registers, decoded.A, RuntimeValue.unknown());
          }
          break;
      }
    }

    buildBasicBlocks(flow);
    return flow;
  }

  private void buildBasicBlocks(FunctionFlow flow) {
    int codeSize = flow.insns.size();
    if(codeSize == 0) {
      return;
    }

    TreeSet<Integer> leaders = new TreeSet<Integer>();
    leaders.add(Integer.valueOf(0));

    for(ConditionalEdge edge : flow.conditionalByJmpPc.values()) {
      if(inRange(edge.condPc, codeSize)) {
        leaders.add(Integer.valueOf(edge.condPc));
      }
      if(inRange(edge.fallthroughPc, codeSize)) {
        leaders.add(Integer.valueOf(edge.fallthroughPc));
      }
      if(inRange(edge.targetPc, codeSize)) {
        leaders.add(Integer.valueOf(edge.targetPc));
      }
    }

    for(int pc = 0; pc < codeSize; pc++) {
      Op op = flow.insns.get(pc).op;
      if(op == Op.JMP) {
        if(flow.conditionalByJmpPc.containsKey(Integer.valueOf(pc))) {
          continue;
        }
        int target = pc + 1 + flow.insns.get(pc).decoded.sBx;
        if(inRange(target, codeSize)) {
          leaders.add(Integer.valueOf(target));
        }
        if(inRange(pc + 1, codeSize)) {
          leaders.add(Integer.valueOf(pc + 1));
        }
      } else if(op == Op.RETURN || op == Op.TAILCALL) {
        if(inRange(pc + 1, codeSize)) {
          leaders.add(Integer.valueOf(pc + 1));
        }
      }
    }

    List<Integer> starts = new ArrayList<Integer>(leaders);
    Collections.sort(starts);

    for(int i = 0; i < starts.size(); i++) {
      int start = starts.get(i).intValue();
      int end = i + 1 < starts.size() ? starts.get(i + 1).intValue() - 1 : codeSize - 1;
      if(start < 0 || end < start || start >= codeSize) {
        continue;
      }
      BasicBlock block = new BasicBlock();
      block.id = flow.blocks.size();
      block.startPc = start;
      block.endPc = end;
      flow.blocks.add(block);
      for(int pc = start; pc <= end; pc++) {
        flow.blockByPc.put(Integer.valueOf(pc), Integer.valueOf(block.id));
      }
    }

    for(BasicBlock block : flow.blocks) {
      for(int pc = block.startPc; pc <= block.endPc; pc++) {
        CallAction action = flow.callsByPc.get(Integer.valueOf(pc));
        if(action != null) {
          block.actions.add(action);
        }
        Op op = flow.insns.get(pc).op;
        if(op == Op.RETURN || op == Op.TAILCALL) {
          block.actions.add(BlockAction.returnAction(pc));
        }
      }

      if(block.endPc < 0 || block.endPc >= flow.insns.size()) {
        continue;
      }

      ConditionalEdge cond = flow.conditionalByJmpPc.get(Integer.valueOf(block.endPc));
      if(cond != null && cond.condPc == block.endPc - 1) {
        Integer fallBlock = flow.blockByPc.get(Integer.valueOf(cond.fallthroughPc));
        Integer targetBlock = flow.blockByPc.get(Integer.valueOf(cond.targetPc));
        if(fallBlock != null) {
          block.successorBlockIds.add(fallBlock);
        }
        if(targetBlock != null && !targetBlock.equals(fallBlock)) {
          block.successorBlockIds.add(targetBlock);
        }
        continue;
      }

      Op endOp = flow.insns.get(block.endPc).op;
      if(endOp == Op.JMP) {
        int target = block.endPc + 1 + flow.insns.get(block.endPc).decoded.sBx;
        Integer targetBlock = flow.blockByPc.get(Integer.valueOf(target));
        if(targetBlock != null) {
          block.successorBlockIds.add(targetBlock);
        }
        continue;
      }

      if(endOp == Op.RETURN || endOp == Op.TAILCALL) {
        continue;
      }

      int nextPc = block.endPc + 1;
      Integer nextBlock = flow.blockByPc.get(Integer.valueOf(nextPc));
      if(nextBlock != null) {
        block.successorBlockIds.add(nextBlock);
      }
    }
  }

  private void traverseFlow(FunctionFlow flow,
                            int blockId,
                            int currentNodeIndex,
                            int questId,
                            QuestDialogTreeBuilder builder,
                            Set<VisitState> visited,
                            Map<String, Integer> branchEdgeNode) {
    if(blockId < 0 || blockId >= flow.blocks.size()) {
      return;
    }

    VisitState key = new VisitState(blockId, currentNodeIndex, questId);
    if(!visited.add(key)) {
      return;
    }

    BasicBlock block = flow.blocks.get(blockId);
    int nodeIndex = currentNodeIndex;
    boolean terminated = false;
    boolean blockHasSemanticDialogEvent = false;

    for(BlockAction action : block.actions) {
      if(action.type == BlockActionType.RETURN) {
        terminated = true;
        break;
      }
      if(action.call == null) {
        continue;
      }
      CallAction call = action.call;
      if(!belongsToQuest(call, questId)) {
        continue;
      }

      String base = call.callBaseName;
      if(isSpeakCall(base)) {
        String text = firstStringArg(call);
        if(text != null && !text.isEmpty()) {
          nodeIndex = builder.appendSpeak(nodeIndex, text);
          blockHasSemanticDialogEvent = true;
        }
      } else if(isOptionCall(base)) {
        String text = firstStringArg(call);
        if(text == null || text.isEmpty()) {
          if(base.contains("YES")) {
            text = "YES";
          } else if(base.contains("NO")) {
            text = "NO";
          } else {
            text = "OPTION";
          }
        }
        builder.appendOption(nodeIndex, text);
        blockHasSemanticDialogEvent = true;
      } else if(isSetQuestStateCall(base)) {
        terminated = true;
        break;
      } else if(currentNodeLooksRelevant(call, questId)) {
        blockHasSemanticDialogEvent = true;
      }
    }

    if(terminated) {
      visited.remove(key);
      return;
    }

    if(block.successorBlockIds.isEmpty()) {
      visited.remove(key);
      return;
    }

    if(block.successorBlockIds.size() == 1) {
      traverseFlow(flow, block.successorBlockIds.get(0).intValue(), nodeIndex, questId, builder, visited, branchEdgeNode);
      visited.remove(key);
      return;
    }

    DialogNode currentNode = builder.node(nodeIndex);
    if(!blockHasSemanticDialogEvent && currentNode.options.isEmpty() && isBlank(currentNode.text)) {
      for(Integer successor : block.successorBlockIds) {
        traverseFlow(flow, successor.intValue(), nodeIndex, questId, builder, visited, branchEdgeNode);
      }
      visited.remove(key);
      return;
    }

    for(int i = 0; i < block.successorBlockIds.size(); i++) {
      int succ = block.successorBlockIds.get(i).intValue();
      int childNode;
      if(i < currentNode.options.size()) {
        DialogOption option = currentNode.options.get(i);
        if(option.nextNodeIndex >= 0) {
          childNode = option.nextNodeIndex;
        } else {
          childNode = builder.newNodeAndLink(nodeIndex);
          option.nextNodeIndex = childNode;
        }
      } else {
        String edgeKey = nodeIndex + "->" + succ;
        Integer existing = branchEdgeNode.get(edgeKey);
        if(existing != null) {
          childNode = existing.intValue();
        } else {
          childNode = builder.newNodeAndLink(nodeIndex);
          branchEdgeNode.put(edgeKey, Integer.valueOf(childNode));
        }
      }
      traverseFlow(flow, succ, childNode, questId, builder, visited, branchEdgeNode);
    }

    visited.remove(key);
  }

  private boolean isBlank(String text) {
    return text == null || text.trim().isEmpty();
  }

  private boolean belongsToQuest(CallAction call, int questId) {
    if(call == null) {
      return false;
    }
    if(call.questIds.isEmpty()) {
      return false;
    }
    return call.questIds.contains(Integer.valueOf(questId));
  }

  private boolean isSpeakCall(String baseName) {
    if(baseName == null || baseName.isEmpty()) {
      return false;
    }
    return baseName.contains("NPC_SAY")
        || baseName.equals("NPCSAY")
        || baseName.equals("SAY")
        || baseName.contains("DIALOG_SAY")
        || baseName.contains("CHAT_SAY");
  }

  private boolean isOptionCall(String baseName) {
    if(baseName == null || baseName.isEmpty()) {
      return false;
    }
    return baseName.contains("ANSWER_YES")
        || baseName.contains("ANSWER_NO")
        || baseName.startsWith("ANSWER")
        || baseName.contains("OPTION");
  }

  private boolean isSetQuestStateCall(String baseName) {
    if(baseName == null || baseName.isEmpty()) {
      return false;
    }
    return baseName.contains("SET_QUEST_STATE")
        || baseName.contains("SETQUESTSTATE")
        || (baseName.contains("QUEST_STATE") && baseName.contains("SET"));
  }

  private String firstStringArg(CallAction call) {
    if(call == null) {
      return null;
    }
    for(RuntimeValue arg : call.args) {
      if(arg != null && arg.isString()) {
        return arg.stringValue;
      }
    }
    return null;
  }

  private boolean currentNodeLooksRelevant(CallAction call, int questId) {
    if(call == null || !call.questIds.contains(Integer.valueOf(questId))) {
      return false;
    }
    String base = call.callBaseName;
    if(base == null || base.isEmpty()) {
      return false;
    }
    return base.contains("NPC") || base.contains("DIALOG") || base.contains("CHAT") || base.contains("ANSWER");
  }

  private boolean isConditionalOp(Op op) {
    return op != null && CONDITIONAL_OPS.contains(op);
  }

  private boolean writesRegisterA(Op op) {
    if(op == null) {
      return false;
    }
    switch(op) {
      case GETGLOBAL:
      case GETTABLE:
      case SELF:
      case MOVE:
      case LOADK:
      case LOADBOOL:
      case LOADNIL:
      case NEWTABLE:
      case NEWTABLE50:
      case ADD:
      case SUB:
      case MUL:
      case DIV:
      case MOD:
      case POW:
      case UNM:
      case NOT:
      case LEN:
      case CONCAT:
      case CLOSURE:
      case VARARG:
      case TESTSET:
      case TEST50:
        return true;
      default:
        return false;
    }
  }

  private RuntimeValue constantValue(LuaChunk.Function function, int index) {
    if(function == null || index < 0 || index >= function.constants.size()) {
      return RuntimeValue.unknown();
    }
    LuaChunk.Constant constant = function.constants.get(index);
    if(constant.type == LuaChunk.Constant.Type.STRING) {
      String text = constant.stringValue == null ? "" : constant.stringValue.toDisplayString();
      return RuntimeValue.string(text);
    }
    if(constant.type == LuaChunk.Constant.Type.NUMBER) {
      return RuntimeValue.number(constant.numberValue);
    }
    return RuntimeValue.unknown();
  }

  private RuntimeValue resolveRK(Map<Integer, RuntimeValue> registers,
                                 LuaChunk.Function function,
                                 int raw,
                                 int rkBase) {
    if(raw >= rkBase) {
      return constantValue(function, raw - rkBase);
    }
    return getRegister(registers, raw);
  }

  private Integer inferQuestIdFromTable(TableRef table, Set<TableRef> visited) {
    if(table == null || !visited.add(table)) {
      return null;
    }
    RuntimeValue direct = table.fields.get("id");
    if(direct != null && direct.isNumber()) {
      Integer value = direct.asInteger();
      if(value != null && value.intValue() > 0) {
        return value;
      }
    }
    for(RuntimeValue value : table.fields.values()) {
      if(value != null && value.isTable()) {
        Integer nested = inferQuestIdFromTable(value.tableRef, visited);
        if(nested != null && nested.intValue() > 0) {
          return nested;
        }
      }
    }
    for(RuntimeValue value : table.array.values()) {
      if(value != null && value.isTable()) {
        Integer nested = inferQuestIdFromTable(value.tableRef, visited);
        if(nested != null && nested.intValue() > 0) {
          return nested;
        }
      }
      if(value != null && value.isNumber()) {
        Integer numeric = value.asInteger();
        if(numeric != null && numeric.intValue() > 0) {
          return numeric;
        }
      }
    }
    return null;
  }

  private RuntimeValue getRegister(Map<Integer, RuntimeValue> registers, int index) {
    RuntimeValue value = registers.get(Integer.valueOf(index));
    return value == null ? RuntimeValue.unknown() : value;
  }

  private void setRegister(Map<Integer, RuntimeValue> registers, int index, RuntimeValue value) {
    registers.put(Integer.valueOf(index), value == null ? RuntimeValue.unknown() : value.copy());
  }

  private String normalizeCallName(RuntimeValue callee) {
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

  private String callBaseName(String callName) {
    if(callName == null) {
      return "";
    }
    String normalized = callName.trim();
    if(normalized.isEmpty()) {
      return "";
    }
    int dot = normalized.lastIndexOf('.');
    if(dot >= 0 && dot + 1 < normalized.length()) {
      normalized = normalized.substring(dot + 1);
    }
    return normalized.toUpperCase();
  }

  private boolean inRange(int pc, int codeSize) {
    return pc >= 0 && pc < codeSize;
  }

  private static final class FunctionFlow {
    String functionPath;
    List<Insn> insns = new ArrayList<Insn>();
    List<BasicBlock> blocks = new ArrayList<BasicBlock>();
    Map<Integer, Integer> blockByPc = new HashMap<Integer, Integer>();
    Map<Integer, ConditionalEdge> conditionalByJmpPc = new HashMap<Integer, ConditionalEdge>();
    Map<Integer, CallAction> callsByPc = new HashMap<Integer, CallAction>();
  }

  private static final class Insn {
    int pc;
    int offset;
    Op op;
    Lua50InstructionCodec.DecodedInstruction decoded;
  }

  private static final class ConditionalEdge {
    int condPc;
    int jmpPc;
    int fallthroughPc;
    int targetPc;
  }

  private static final class BasicBlock {
    int id;
    int startPc;
    int endPc;
    List<Integer> successorBlockIds = new ArrayList<Integer>();
    List<BlockAction> actions = new ArrayList<BlockAction>();
  }

  private static class BlockAction {
    BlockActionType type;
    int pc;
    CallAction call;

    static BlockAction returnAction(int pc) {
      BlockAction action = new BlockAction();
      action.type = BlockActionType.RETURN;
      action.pc = pc;
      return action;
    }
  }

  private enum BlockActionType {
    RETURN
  }

  private static final class CallAction extends BlockAction {
    int offset;
    String callName;
    String callBaseName;
    List<RuntimeValue> args = new ArrayList<RuntimeValue>();
    Set<Integer> questIds = new LinkedHashSet<Integer>();

    CallAction() {
      this.type = null;
      this.call = this;
    }
  }

  private static final class RuntimeValue {
    private enum Kind {
      UNKNOWN,
      STRING,
      NUMBER,
      GLOBAL,
      TABLE
    }

    private Kind kind;
    private String stringValue;
    private double numberValue;
    private String globalName;
    private TableRef tableRef;

    static RuntimeValue unknown() {
      RuntimeValue out = new RuntimeValue();
      out.kind = Kind.UNKNOWN;
      return out;
    }

    static RuntimeValue string(String value) {
      RuntimeValue out = new RuntimeValue();
      out.kind = Kind.STRING;
      out.stringValue = value == null ? "" : value;
      return out;
    }

    static RuntimeValue number(double value) {
      RuntimeValue out = new RuntimeValue();
      out.kind = Kind.NUMBER;
      out.numberValue = value;
      return out;
    }

    static RuntimeValue global(String name) {
      RuntimeValue out = new RuntimeValue();
      out.kind = Kind.GLOBAL;
      out.globalName = name == null ? "" : name;
      return out;
    }

    static RuntimeValue table(TableRef tableRef) {
      RuntimeValue out = new RuntimeValue();
      out.kind = Kind.TABLE;
      out.tableRef = tableRef;
      return out;
    }

    RuntimeValue copy() {
      RuntimeValue out = new RuntimeValue();
      out.kind = this.kind;
      out.stringValue = this.stringValue;
      out.numberValue = this.numberValue;
      out.globalName = this.globalName;
      out.tableRef = this.tableRef;
      return out;
    }

    boolean isString() {
      return kind == Kind.STRING;
    }

    boolean isNumber() {
      return kind == Kind.NUMBER;
    }

    boolean isGlobal() {
      return kind == Kind.GLOBAL;
    }

    boolean isTable() {
      return kind == Kind.TABLE && tableRef != null;
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
  }

  private static final class TableRef {
    final Map<String, RuntimeValue> fields = new LinkedHashMap<String, RuntimeValue>();
    final Map<Integer, RuntimeValue> array = new LinkedHashMap<Integer, RuntimeValue>();

    void put(RuntimeValue key, RuntimeValue value) {
      if(key == null) {
        return;
      }
      RuntimeValue write = value == null ? RuntimeValue.unknown() : value.copy();
      if(key.isString()) {
        fields.put(key.stringValue, write);
      } else if(key.isNumber()) {
        Integer idx = key.asInteger();
        if(idx != null && idx.intValue() >= 1) {
          array.put(idx, write);
        }
      }
    }

    RuntimeValue get(RuntimeValue key) {
      if(key == null) {
        return null;
      }
      if(key.isString()) {
        return fields.get(key.stringValue);
      }
      if(key.isNumber()) {
        Integer idx = key.asInteger();
        if(idx != null) {
          return array.get(idx);
        }
      }
      return null;
    }
  }

  private static final class VisitState {
    final int blockId;
    final int nodeId;
    final int questId;

    VisitState(int blockId, int nodeId, int questId) {
      this.blockId = blockId;
      this.nodeId = nodeId;
      this.questId = questId;
    }

    @Override
    public int hashCode() {
      int h = 17;
      h = h * 31 + blockId;
      h = h * 31 + nodeId;
      h = h * 31 + questId;
      return h;
    }

    @Override
    public boolean equals(Object obj) {
      if(this == obj) {
        return true;
      }
      if(!(obj instanceof VisitState)) {
        return false;
      }
      VisitState other = (VisitState) obj;
      return this.blockId == other.blockId
          && this.nodeId == other.nodeId
          && this.questId == other.questId;
    }
  }

  private static final class QuestDialogTreeBuilder {
    private final List<DialogNode> nodes = new ArrayList<DialogNode>();

    QuestDialogTreeBuilder() {
      nodes.add(new DialogNode());
    }

    int rootIndex() {
      return 0;
    }

    DialogNode node(int index) {
      return nodes.get(index);
    }

    int appendSpeak(int currentIndex, String text) {
      DialogNode current = node(currentIndex);
      if((current.text == null || current.text.isEmpty()) && current.options.isEmpty() && current.next.isEmpty()) {
        current.text = text;
        return currentIndex;
      }
      int nextIndex = newNodeAndLink(currentIndex);
      node(nextIndex).text = text;
      return nextIndex;
    }

    void appendOption(int currentIndex, String optionText) {
      DialogNode current = node(currentIndex);
      DialogOption option = new DialogOption();
      option.optionText = optionText == null ? "" : optionText;
      option.nextNodeIndex = -1;
      current.options.add(option);
    }

    int ensureLinearNode(int currentIndex) {
      DialogNode current = node(currentIndex);
      if((current.text == null || current.text.isEmpty()) && current.options.isEmpty() && current.next.isEmpty()) {
        return currentIndex;
      }
      if(!current.next.isEmpty()) {
        DialogNode first = current.next.get(0);
        int idx = indexOfNode(first);
        if(idx >= 0) {
          return idx;
        }
      }
      return newNodeAndLink(currentIndex);
    }

    int newNodeAndLink(int fromIndex) {
      DialogNode nextNode = new DialogNode();
      int nextIndex = nodes.size();
      nodes.add(nextNode);
      DialogNode from = node(fromIndex);
      from.next.add(nextNode);
      return nextIndex;
    }

    private int indexOfNode(DialogNode target) {
      for(int i = 0; i < nodes.size(); i++) {
        if(nodes.get(i) == target) {
          return i;
        }
      }
      return -1;
    }

    QuestDialogTree build() {
      QuestDialogTree tree = new QuestDialogTree();
      if(nodes.isEmpty()) {
        tree.nodes.add(new DialogNode());
        return tree;
      }

      Map<DialogNode, Integer> remap = new HashMap<DialogNode, Integer>();
      List<Integer> order = new ArrayList<Integer>();
      Set<DialogNode> visited = new HashSet<DialogNode>();
      collectDfs(nodes.get(0), visited, order);

      if(order.isEmpty()) {
        order.add(Integer.valueOf(0));
      }

      for(int i = 0; i < order.size(); i++) {
        remap.put(nodes.get(order.get(i).intValue()), Integer.valueOf(i));
        tree.nodes.add(nodes.get(order.get(i).intValue()).copyShallowWithoutNext());
      }

      for(int i = 0; i < order.size(); i++) {
        DialogNode oldNode = nodes.get(order.get(i).intValue());
        DialogNode newNode = tree.nodes.get(i);
        for(DialogNode oldNext : oldNode.next) {
          Integer mapped = remap.get(oldNext);
          if(mapped == null) {
            continue;
          }
          newNode.next.add(tree.nodes.get(mapped.intValue()));
        }
      }

      for(DialogNode node : tree.nodes) {
        for(DialogOption option : node.options) {
          if(option == null || option.nextNodeIndex < 0 || option.nextNodeIndex >= nodes.size()) {
            continue;
          }
          DialogNode oldTarget = nodes.get(option.nextNodeIndex);
          Integer mapped = remap.get(oldTarget);
          if(mapped != null) {
            option.nextNodeIndex = mapped.intValue();
          } else {
            option.nextNodeIndex = -1;
          }
        }
      }

      return tree;
    }

    private void collectDfs(DialogNode node,
                            Set<DialogNode> visited,
                            List<Integer> out) {
      if(node == null || !visited.add(node)) {
        return;
      }
      int idx = indexOfNode(node);
      if(idx >= 0) {
        out.add(Integer.valueOf(idx));
      }
      List<DialogNode> ordered = new ArrayList<DialogNode>(node.next);
      Collections.sort(ordered, new Comparator<DialogNode>() {
        @Override
        public int compare(DialogNode a, DialogNode b) {
          return Integer.compare(indexOfNode(a), indexOfNode(b));
        }
      });
      for(DialogNode next : ordered) {
        collectDfs(next, visited, out);
      }
    }
  }
}
