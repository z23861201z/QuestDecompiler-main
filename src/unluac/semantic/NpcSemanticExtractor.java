package unluac.semantic;

import java.nio.file.Files;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

import unluac.chunk.Lua50ChunkParser;
import unluac.chunk.LuaChunk;
import unluac.decompile.Op;

public class NpcSemanticExtractor {

  public NpcScriptModel extract(Path lucPath) throws Exception {
    if(lucPath == null) {
      return new NpcScriptModel();
    }
    byte[] data = Files.readAllBytes(lucPath);
    LuaChunk chunk = new Lua50ChunkParser().parse(data);
    return extract(chunk);
  }

  public NpcScriptModel extract(LuaChunk chunk) {
    NpcScriptModel out = new NpcScriptModel();
    if(chunk == null || chunk.header == null || chunk.mainFunction == null) {
      return out;
    }

    Lua50InstructionCodec codec = new Lua50InstructionCodec(
        chunk.header.opSize,
        chunk.header.aSize,
        chunk.header.bSize,
        chunk.header.cSize);

    Set<Integer> questIds = new LinkedHashSet<Integer>();
    collectNpcId(chunk.mainFunction, codec, out);
    analyzeFunction(chunk.mainFunction, codec, out, questIds);

    out.relatedQuestIds.clear();
    out.relatedQuestIds.addAll(questIds);
    out.collectQuestIdsFromBranches();
    return out;
  }

  private void collectNpcId(LuaChunk.Function function, Lua50InstructionCodec codec, NpcScriptModel model) {
    if(function == null || model.npcId > 0) {
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
        case LOADK:
          setRegister(registers, decoded.A, constantValue(function, decoded.Bx));
          break;
        case GETGLOBAL:
          setRegister(registers, decoded.A, RegisterValue.global(constantString(function, decoded.Bx)));
          break;
        case CALL: {
          RegisterValue callee = getRegister(registers, decoded.A);
          String callName = callee == null ? "" : callee.globalName;
          if("setNPCNo".equalsIgnoreCase(callName) && decoded.B > 1) {
            RegisterValue arg = getRegister(registers, decoded.A + 1);
            if(arg != null && arg.integerValue != null && arg.integerValue.intValue() > 0) {
              model.npcId = arg.integerValue.intValue();
              return;
            }
          }
          break;
        }
        default:
          break;
      }
    }

    for(LuaChunk.Function child : function.prototypes) {
      collectNpcId(child, codec, model);
      if(model.npcId > 0) {
        return;
      }
    }
  }

  private void analyzeFunction(LuaChunk.Function function,
                               Lua50InstructionCodec codec,
                               NpcScriptModel out,
                               Set<Integer> questIds) {
    if(function == null) {
      return;
    }

    RegisterValue[] registers = new RegisterValue[Math.max(128, function.maxStackSize + 64)];
    for(int pc = 0; pc < function.code.size(); pc++) {
      LuaChunk.Instruction inst = function.code.get(pc);
      Lua50InstructionCodec.DecodedInstruction decoded = codec.decode(inst.value);
      Op op = decoded.op;
      if(op == null) {
        continue;
      }

      switch(op) {
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
          int to = decoded.B;
          if(to < from) {
            to = from;
          }
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
          if(table != null && table.globalName != null && key != null && key.stringValue != null) {
            setRegister(registers, decoded.A, RegisterValue.name(table.globalName + "." + key.stringValue));
          } else {
            setRegister(registers, decoded.A, RegisterValue.unknown());
          }
          break;
        }

        case CALL:
          captureNpcCall(function, pc, decoded, registers, out, questIds);
          clearCallResults(registers, decoded, function.maxStackSize + 32);
          break;

        default:
          break;
      }
    }

    for(LuaChunk.Function child : function.prototypes) {
      analyzeFunction(child, codec, out, questIds);
    }
  }

  private void captureNpcCall(LuaChunk.Function function,
                              int pc,
                              Lua50InstructionCodec.DecodedInstruction decoded,
                              RegisterValue[] registers,
                              NpcScriptModel out,
                              Set<Integer> questIds) {
    RegisterValue callee = getRegister(registers, decoded.A);
    if(callee == null || callee.globalName == null || callee.globalName.isEmpty()) {
      return;
    }

    String callName = callee.globalName;
    if(!isTargetNpcCall(callName)) {
      return;
    }

    List<RegisterValue> args = collectCallArgs(decoded, registers);
    NpcScriptModel.DialogBranch branch = new NpcScriptModel.DialogBranch();
    branch.functionPath = function.path == null ? "" : function.path;
    branch.pc = pc;
    branch.action = normalizeCallName(callName);

    if("NPC_SAY".equals(branch.action)) {
      branch.text = argString(args, 0);
      branch.questId = firstQuestId(args);
      if(branch.questId > 0) {
        questIds.add(Integer.valueOf(branch.questId));
      }
    } else if("ADD_QUEST_BTN".equals(branch.action)) {
      branch.questId = firstQuestId(args);
      branch.text = firstString(args);
      if(branch.questId > 0) {
        questIds.add(Integer.valueOf(branch.questId));
      }
    } else if("SET_QUEST_STATE".equals(branch.action)) {
      branch.questId = firstQuestId(args);
      branch.stateValue = secondNumber(args);
      if(branch.questId > 0) {
        questIds.add(Integer.valueOf(branch.questId));
      }
    } else if("CHECK_ITEM_CNT".equals(branch.action)) {
      branch.itemId = firstNumber(args);
      branch.itemCount = secondNumber(args);
      branch.questId = firstQuestId(args);
      if(branch.questId > 0) {
        questIds.add(Integer.valueOf(branch.questId));
      }
    }

    out.branches.add(branch);
  }

  private List<RegisterValue> collectCallArgs(Lua50InstructionCodec.DecodedInstruction decoded, RegisterValue[] registers) {
    List<RegisterValue> args = new ArrayList<RegisterValue>();
    if(decoded.B <= 1) {
      return args;
    }
    for(int i = 1; i < decoded.B; i++) {
      args.add(getRegister(registers, decoded.A + i));
    }
    return args;
  }

  private void clearCallResults(RegisterValue[] registers,
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

  private boolean isTargetNpcCall(String callName) {
    if(callName == null) {
      return false;
    }
    String upper = callName.toUpperCase();
    return upper.contains("NPC_SAY")
        || upper.contains("ADD_QUEST_BTN")
        || upper.contains("SET_QUEST_STATE")
        || upper.contains("CHECK_ITEM_CNT");
  }

  private String normalizeCallName(String callName) {
    String upper = callName == null ? "" : callName.toUpperCase();
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
    return callName == null ? "" : callName;
  }

  private String firstString(List<RegisterValue> args) {
    for(RegisterValue arg : args) {
      if(arg != null && arg.stringValue != null && !arg.stringValue.isEmpty()) {
        return arg.stringValue;
      }
    }
    return "";
  }

  private int firstQuestId(List<RegisterValue> args) {
    for(RegisterValue arg : args) {
      if(arg != null && arg.integerValue != null) {
        int value = arg.integerValue.intValue();
        if(value > 0 && value < 10000000) {
          return value;
        }
      }
      if(arg != null && arg.stringValue != null) {
        Integer parsed = parseQuestLikeNumber(arg.stringValue);
        if(parsed != null) {
          return parsed.intValue();
        }
      }
    }
    return 0;
  }

  private int firstNumber(List<RegisterValue> args) {
    for(RegisterValue arg : args) {
      if(arg != null && arg.integerValue != null) {
        return arg.integerValue.intValue();
      }
    }
    return 0;
  }

  private int secondNumber(List<RegisterValue> args) {
    boolean firstFound = false;
    for(RegisterValue arg : args) {
      if(arg == null || arg.integerValue == null) {
        continue;
      }
      if(!firstFound) {
        firstFound = true;
      } else {
        return arg.integerValue.intValue();
      }
    }
    return Integer.MIN_VALUE;
  }

  private String argString(List<RegisterValue> args, int index) {
    if(index < 0 || index >= args.size()) {
      return "";
    }
    RegisterValue arg = args.get(index);
    if(arg == null || arg.stringValue == null) {
      return "";
    }
    return arg.stringValue;
  }

  private Integer parseQuestLikeNumber(String text) {
    if(text == null) {
      return null;
    }
    String trimmed = text.trim();
    if(trimmed.isEmpty()) {
      return null;
    }
    try {
      int value = Integer.parseInt(trimmed);
      if(value > 0 && value < 10000000) {
        return Integer.valueOf(value);
      }
    } catch(Exception ignored) {
    }
    return null;
  }

  private RegisterValue resolveRK(RegisterValue[] registers, LuaChunk.Function function, int raw) {
    if(raw >= 256) {
      return constantValue(function, raw - 256);
    }
    return getRegister(registers, raw);
  }

  private RegisterValue constantValue(LuaChunk.Function function, int index) {
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
      case BOOLEAN:
        return RegisterValue.number(Integer.valueOf(constant.booleanValue ? 1 : 0));
      default:
        return RegisterValue.unknown();
    }
  }

  private String constantString(LuaChunk.Function function, int index) {
    if(function == null || index < 0 || index >= function.constants.size()) {
      return "";
    }
    LuaChunk.Constant constant = function.constants.get(index);
    if(constant == null || constant.type != LuaChunk.Constant.Type.STRING || constant.stringValue == null) {
      return "";
    }
    return constant.stringValue.toDisplayString();
  }

  private RegisterValue getRegister(RegisterValue[] registers, int index) {
    if(index < 0 || index >= registers.length) {
      return RegisterValue.unknown();
    }
    RegisterValue value = registers[index];
    return value == null ? RegisterValue.unknown() : value;
  }

  private void setRegister(RegisterValue[] registers, int index, RegisterValue value) {
    if(index < 0 || index >= registers.length) {
      return;
    }
    registers[index] = value == null ? RegisterValue.unknown() : value;
  }

  private static final class RegisterValue {
    String globalName;
    String stringValue;
    Integer integerValue;

    static RegisterValue unknown() {
      return new RegisterValue();
    }

    static RegisterValue global(String name) {
      RegisterValue value = new RegisterValue();
      value.globalName = name == null ? "" : name;
      return value;
    }

    static RegisterValue name(String name) {
      RegisterValue value = new RegisterValue();
      value.globalName = name == null ? "" : name;
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
}
