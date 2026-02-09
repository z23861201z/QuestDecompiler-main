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

public class ScriptTypeDetector {

  public enum ScriptType {
    QUEST_DEFINITION,
    NPC_SCRIPT,
    UNKNOWN
  }

  public static final class DetectionResult {
    public ScriptType scriptType = ScriptType.UNKNOWN;
    public boolean hasNpcSayFunction;
    public boolean hasChkQStateFunction;
    public boolean hasQtAssignment;
    public final Set<String> globalFunctionNames = new LinkedHashSet<String>();
  }

  public ScriptType detect(Path lucPath) throws Exception {
    return inspect(lucPath).scriptType;
  }

  public DetectionResult inspect(Path lucPath) throws Exception {
    if(lucPath == null) {
      return new DetectionResult();
    }
    byte[] data = Files.readAllBytes(lucPath);
    LuaChunk chunk = new Lua50ChunkParser().parse(data);
    return inspect(chunk);
  }

  public ScriptType detect(LuaChunk chunk) {
    return inspect(chunk).scriptType;
  }

  public DetectionResult inspect(LuaChunk chunk) {
    DetectionResult result = new DetectionResult();
    if(chunk == null || chunk.header == null || chunk.mainFunction == null) {
      return result;
    }

    Lua50InstructionCodec codec = new Lua50InstructionCodec(
        chunk.header.opSize,
        chunk.header.aSize,
        chunk.header.bSize,
        chunk.header.cSize);

    collectGlobalFunctions(chunk.mainFunction, codec, result);
    result.hasQtAssignment = hasQtAssignment(chunk.mainFunction, codec);

    result.hasNpcSayFunction = hasGlobal(result.globalFunctionNames, "npcsay");
    result.hasChkQStateFunction = hasGlobal(result.globalFunctionNames, "chkQState");

    if(result.hasNpcSayFunction && result.hasChkQStateFunction) {
      result.scriptType = ScriptType.NPC_SCRIPT;
    } else if(result.hasQtAssignment) {
      result.scriptType = ScriptType.QUEST_DEFINITION;
    } else {
      result.scriptType = ScriptType.UNKNOWN;
    }

    return result;
  }

  private void collectGlobalFunctions(LuaChunk.Function function,
                                      Lua50InstructionCodec codec,
                                      DetectionResult result) {
    if(function == null) {
      return;
    }

    for(int pc = 0; pc < function.code.size(); pc++) {
      LuaChunk.Instruction inst = function.code.get(pc);
      Lua50InstructionCodec.DecodedInstruction decoded = codec.decode(inst.value);
      Op op = decoded.op;
      if(op == Op.SETGLOBAL) {
        String globalName = constantString(function, decoded.Bx);
        if(globalName != null && !globalName.isEmpty()) {
          result.globalFunctionNames.add(globalName);
        }
      }
    }

    for(LuaChunk.Function child : function.prototypes) {
      collectGlobalFunctions(child, codec, result);
    }
  }

  private boolean hasQtAssignment(LuaChunk.Function function, Lua50InstructionCodec codec) {
    if(function == null) {
      return false;
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
          setRegister(registers, decoded.A, constantRegisterValue(function, decoded.Bx));
          break;

        case GETGLOBAL:
          setRegister(registers, decoded.A, RegisterValue.global(constantString(function, decoded.Bx)));
          break;

        case NEWTABLE50:
          setRegister(registers, decoded.A, RegisterValue.table());
          break;

        case GETTABLE: {
          RegisterValue table = getRegister(registers, decoded.B);
          RegisterValue key = resolveRK(registers, function, decoded.C);
          if(key != null && key.stringValue != null) {
            if(table != null && table.globalName != null) {
              setRegister(registers, decoded.A, RegisterValue.name(table.globalName + "." + key.stringValue));
            } else {
              setRegister(registers, decoded.A, RegisterValue.name(key.stringValue));
            }
          } else {
            setRegister(registers, decoded.A, RegisterValue.unknown());
          }
          break;
        }

        case SETTABLE: {
          RegisterValue table = getRegister(registers, decoded.A);
          if(table != null && "qt".equals(table.globalName)) {
            RegisterValue key = resolveRK(registers, function, decoded.B);
            RegisterValue value = resolveRK(registers, function, decoded.C);
            if(key != null && key.integerValue != null && value != null && value.tableMarker) {
              return true;
            }
          }
          break;
        }

        default:
          break;
      }
    }

    for(LuaChunk.Function child : function.prototypes) {
      if(hasQtAssignment(child, codec)) {
        return true;
      }
    }
    return false;
  }

  private RegisterValue resolveRK(RegisterValue[] registers, LuaChunk.Function function, int raw) {
    if(raw >= 256) {
      return constantRegisterValue(function, raw - 256);
    }
    return getRegister(registers, raw);
  }

  private RegisterValue constantRegisterValue(LuaChunk.Function function, int index) {
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
          return RegisterValue.number(integer);
        }
        return RegisterValue.number(null);
      }
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

  private boolean hasGlobal(Set<String> names, String target) {
    if(names == null || target == null) {
      return false;
    }
    for(String name : names) {
      if(name != null && name.equalsIgnoreCase(target)) {
        return true;
      }
    }
    return false;
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
    String rawName;
    String globalName;
    String stringValue;
    Integer integerValue;
    boolean tableMarker;

    static RegisterValue unknown() {
      return new RegisterValue();
    }

    static RegisterValue global(String name) {
      RegisterValue value = new RegisterValue();
      value.globalName = name == null ? "" : name;
      value.rawName = value.globalName;
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

    static RegisterValue name(String name) {
      RegisterValue value = new RegisterValue();
      value.rawName = name == null ? "" : name;
      return value;
    }

    static RegisterValue table() {
      RegisterValue value = new RegisterValue();
      value.tableMarker = true;
      return value;
    }
  }
}
