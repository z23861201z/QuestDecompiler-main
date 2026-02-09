package unluac.chunk;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public class Lua50StructureValidator {

  private final Lua50ChunkParser parser;
  private final LuaChunk reference;

  public Lua50StructureValidator(byte[] referenceData) {
    this.parser = new Lua50ChunkParser();
    this.reference = parser.parse(referenceData);
  }

  public ValidationReport validateLuc(byte[] data) {
    LuaChunk actual = parser.parse(data);
    ValidationReport report = new ValidationReport();

    report.referenceSize = reference == null ? 0 : 1;
    report.targetSize = actual == null ? 0 : 1;

    report.headerSame = compareHeader(reference.header, actual.header, report.details);

    Map<String, LuaChunk.Function> refFunctions = new LinkedHashMap<String, LuaChunk.Function>();
    Map<String, LuaChunk.Function> actFunctions = new LinkedHashMap<String, LuaChunk.Function>();
    collectFunctions(reference.mainFunction, refFunctions);
    collectFunctions(actual.mainFunction, actFunctions);

    report.functionCountReference = refFunctions.size();
    report.functionCountTarget = actFunctions.size();

    report.instructionCountSame = true;
    report.constantCountSame = true;
    report.prototypeCountSame = true;
    report.debugCountSame = true;

    report.totalInstructionReference = 0;
    report.totalInstructionTarget = 0;
    report.totalConstantReference = 0;
    report.totalConstantTarget = 0;
    report.totalPrototypeReference = 0;
    report.totalPrototypeTarget = 0;
    report.totalLineinfoReference = 0;
    report.totalLineinfoTarget = 0;
    report.totalLocalvarsReference = 0;
    report.totalLocalvarsTarget = 0;
    report.totalUpvalueNamesReference = 0;
    report.totalUpvalueNamesTarget = 0;

    for(Map.Entry<String, LuaChunk.Function> entry : refFunctions.entrySet()) {
      String path = entry.getKey();
      LuaChunk.Function ref = entry.getValue();
      LuaChunk.Function act = actFunctions.get(path);
      if(act == null) {
        report.instructionCountSame = false;
        report.constantCountSame = false;
        report.prototypeCountSame = false;
        report.debugCountSame = false;
        report.details.add("missing function in target: " + path);
        continue;
      }

      int refInstruction = ref.code.size();
      int actInstruction = act.code.size();
      report.totalInstructionReference += refInstruction;
      report.totalInstructionTarget += actInstruction;
      if(refInstruction != actInstruction) {
        report.instructionCountSame = false;
        report.details.add("instruction count mismatch at " + path + ": " + refInstruction + " -> " + actInstruction);
      }

      int refConstant = ref.constants.size();
      int actConstant = act.constants.size();
      report.totalConstantReference += refConstant;
      report.totalConstantTarget += actConstant;
      if(refConstant != actConstant) {
        report.constantCountSame = false;
        report.details.add("constant count mismatch at " + path + ": " + refConstant + " -> " + actConstant);
      }

      int refPrototype = ref.prototypes.size();
      int actPrototype = act.prototypes.size();
      report.totalPrototypeReference += refPrototype;
      report.totalPrototypeTarget += actPrototype;
      if(refPrototype != actPrototype) {
        report.prototypeCountSame = false;
        report.details.add("prototype count mismatch at " + path + ": " + refPrototype + " -> " + actPrototype);
      }

      int refLineinfo = ref.debug.lineinfo.size();
      int actLineinfo = act.debug.lineinfo.size();
      int refLocalvars = ref.debug.localvars.size();
      int actLocalvars = act.debug.localvars.size();
      int refUpvalues = ref.debug.upvalueNames.size();
      int actUpvalues = act.debug.upvalueNames.size();

      report.totalLineinfoReference += refLineinfo;
      report.totalLineinfoTarget += actLineinfo;
      report.totalLocalvarsReference += refLocalvars;
      report.totalLocalvarsTarget += actLocalvars;
      report.totalUpvalueNamesReference += refUpvalues;
      report.totalUpvalueNamesTarget += actUpvalues;

      if(refLineinfo != actLineinfo || refLocalvars != actLocalvars || refUpvalues != actUpvalues) {
        report.debugCountSame = false;
        report.details.add(
            "debug count mismatch at " + path
                + ": lineinfo " + refLineinfo + " -> " + actLineinfo
                + ", localvars " + refLocalvars + " -> " + actLocalvars
                + ", upvalueNames " + refUpvalues + " -> " + actUpvalues);
      }
    }

    for(String path : actFunctions.keySet()) {
      if(!refFunctions.containsKey(path)) {
        report.instructionCountSame = false;
        report.constantCountSame = false;
        report.prototypeCountSame = false;
        report.debugCountSame = false;
        report.details.add("extra function in target: " + path);
      }
    }

    if(report.totalInstructionReference != report.totalInstructionTarget) {
      report.instructionCountSame = false;
      report.details.add("total instruction count mismatch: " + report.totalInstructionReference + " -> " + report.totalInstructionTarget);
    }
    if(report.totalConstantReference != report.totalConstantTarget) {
      report.constantCountSame = false;
      report.details.add("total constant count mismatch: " + report.totalConstantReference + " -> " + report.totalConstantTarget);
    }
    if(report.totalPrototypeReference != report.totalPrototypeTarget) {
      report.prototypeCountSame = false;
      report.details.add("total prototype count mismatch: " + report.totalPrototypeReference + " -> " + report.totalPrototypeTarget);
    }
    if(report.totalLineinfoReference != report.totalLineinfoTarget
        || report.totalLocalvarsReference != report.totalLocalvarsTarget
        || report.totalUpvalueNamesReference != report.totalUpvalueNamesTarget) {
      report.debugCountSame = false;
      report.details.add(
          "total debug count mismatch: lineinfo " + report.totalLineinfoReference + " -> " + report.totalLineinfoTarget
              + ", localvars " + report.totalLocalvarsReference + " -> " + report.totalLocalvarsTarget
              + ", upvalueNames " + report.totalUpvalueNamesReference + " -> " + report.totalUpvalueNamesTarget);
    }

    report.structureConsistent = report.headerSame
        && report.instructionCountSame
        && report.constantCountSame
        && report.prototypeCountSame
        && report.debugCountSame;

    return report;
  }

  private static void collectFunctions(LuaChunk.Function function, Map<String, LuaChunk.Function> out) {
    out.put(function.path, function);
    for(LuaChunk.Function child : function.prototypes) {
      collectFunctions(child, out);
    }
  }

  private static boolean compareHeader(LuaChunk.Header ref, LuaChunk.Header target, List<String> details) {
    boolean ok = true;
    if(!Arrays.equals(ref.signature, target.signature)) {
      ok = false;
      details.add("header.signature mismatch");
    }
    if(ref.version != target.version) {
      ok = false;
      details.add("header.version mismatch: " + ref.version + " -> " + target.version);
    }
    if(ref.endianFlag != target.endianFlag) {
      ok = false;
      details.add("header.endianFlag mismatch: " + ref.endianFlag + " -> " + target.endianFlag);
    }
    if(ref.intSize != target.intSize) {
      ok = false;
      details.add("header.intSize mismatch: " + ref.intSize + " -> " + target.intSize);
    }
    if(ref.sizeTSize != target.sizeTSize) {
      ok = false;
      details.add("header.sizeTSize mismatch: " + ref.sizeTSize + " -> " + target.sizeTSize);
    }
    if(ref.instructionSize != target.instructionSize) {
      ok = false;
      details.add("header.instructionSize mismatch: " + ref.instructionSize + " -> " + target.instructionSize);
    }
    if(ref.opSize != target.opSize || ref.aSize != target.aSize || ref.bSize != target.bSize || ref.cSize != target.cSize) {
      ok = false;
      details.add("header opcode field mismatch: OP/A/B/C "
          + ref.opSize + "/" + ref.aSize + "/" + ref.bSize + "/" + ref.cSize
          + " -> " + target.opSize + "/" + target.aSize + "/" + target.bSize + "/" + target.cSize);
    }
    if(ref.numberSize != target.numberSize) {
      ok = false;
      details.add("header.numberSize mismatch: " + ref.numberSize + " -> " + target.numberSize);
    }
    if(!Arrays.equals(ref.testNumberRaw, target.testNumberRaw)) {
      ok = false;
      details.add("header.testNumberRaw mismatch");
    }
    return ok;
  }

  public static final class ValidationReport {
    public boolean headerSame;
    public boolean instructionCountSame;
    public boolean constantCountSame;
    public boolean prototypeCountSame;
    public boolean debugCountSame;
    public boolean structureConsistent;

    public int referenceSize;
    public int targetSize;

    public int functionCountReference;
    public int functionCountTarget;

    public int totalInstructionReference;
    public int totalInstructionTarget;

    public int totalConstantReference;
    public int totalConstantTarget;

    public int totalPrototypeReference;
    public int totalPrototypeTarget;

    public int totalLineinfoReference;
    public int totalLineinfoTarget;

    public int totalLocalvarsReference;
    public int totalLocalvarsTarget;

    public int totalUpvalueNamesReference;
    public int totalUpvalueNamesTarget;

    public final List<String> details = new ArrayList<String>();

    public String toTextReport() {
      StringBuilder sb = new StringBuilder();
      sb.append("structure_consistent=").append(structureConsistent).append('\n');
      sb.append("header_same=").append(headerSame).append('\n');
      sb.append("instruction_count_same=").append(instructionCountSame).append('\n');
      sb.append("constant_count_same=").append(constantCountSame).append('\n');
      sb.append("prototype_count_same=").append(prototypeCountSame).append('\n');
      sb.append("debug_count_same=").append(debugCountSame).append('\n');

      sb.append("function_count=").append(functionCountReference).append(" -> ").append(functionCountTarget).append('\n');
      sb.append("instruction_total=").append(totalInstructionReference).append(" -> ").append(totalInstructionTarget).append('\n');
      sb.append("constant_total=").append(totalConstantReference).append(" -> ").append(totalConstantTarget).append('\n');
      sb.append("prototype_total=").append(totalPrototypeReference).append(" -> ").append(totalPrototypeTarget).append('\n');
      sb.append("debug_lineinfo_total=").append(totalLineinfoReference).append(" -> ").append(totalLineinfoTarget).append('\n');
      sb.append("debug_localvars_total=").append(totalLocalvarsReference).append(" -> ").append(totalLocalvarsTarget).append('\n');
      sb.append("debug_upvalue_names_total=").append(totalUpvalueNamesReference).append(" -> ").append(totalUpvalueNamesTarget).append('\n');

      if(details.isEmpty()) {
        sb.append("details=none").append('\n');
      } else {
        sb.append("details_count=").append(details.size()).append('\n');
        for(int i = 0; i < details.size(); i++) {
          sb.append("detail[").append(i).append("]=").append(details.get(i)).append('\n');
        }
      }
      return sb.toString();
    }
  }
}

