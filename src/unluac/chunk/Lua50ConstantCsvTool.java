package unluac.chunk;

import java.nio.ByteBuffer;
import java.nio.ByteOrder;
import java.nio.charset.Charset;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Lua50ConstantCsvTool {

  private static final String CSV_HEADER = "function_path,constant_index,constant_value";

  public static void main(String[] args) throws Exception {
    if(args.length < 1) {
      printUsage();
      return;
    }

    String command = args[0];
    if("export".equalsIgnoreCase(command)) {
      if(args.length != 3) {
        printUsage();
        return;
      }
      exportCsv(Paths.get(args[1]), Paths.get(args[2]));
      return;
    }

    if("import".equalsIgnoreCase(command)) {
      if(args.length != 4) {
        printUsage();
        return;
      }
      importCsvAndPatch(Paths.get(args[1]), Paths.get(args[2]), Paths.get(args[3]));
      return;
    }

    throw new IllegalStateException("unknown command: " + command);
  }

  private static void exportCsv(Path inputLuc, Path outputCsv) throws Exception {
    byte[] data = Files.readAllBytes(inputLuc);
    Lua50ChunkParser parser = new Lua50ChunkParser();
    LuaChunk chunk = parser.parse(data);

    List<String> lines = new ArrayList<String>();
    lines.add(CSV_HEADER);

    Charset charset = Charset.forName(System.getProperty("unluac.stringCharset", "GBK"));
    appendFunctionConstants(chunk.mainFunction, lines, charset);

    Files.write(outputCsv, lines, Charset.forName("UTF-8"));

    int totalConstants = countConstants(chunk.mainFunction);
    System.out.println("mode=export");
    System.out.println("input=" + inputLuc);
    System.out.println("output_csv=" + outputCsv);
    System.out.println("function_count=" + countFunctions(chunk.mainFunction));
    System.out.println("constant_count=" + totalConstants);
    System.out.println("instruction_count=" + countInstructions(chunk.mainFunction));
    System.out.println("debug_lineinfo_count=" + countLineinfo(chunk.mainFunction));
  }

  private static void importCsvAndPatch(Path inputLuc, Path inputCsv, Path outputLuc) throws Exception {
    byte[] original = Files.readAllBytes(inputLuc);
    byte[] patched = original.clone();

    Lua50ChunkParser parser = new Lua50ChunkParser();
    LuaChunk chunk = parser.parse(patched);
    Lua50AstPatcher patcher = new Lua50AstPatcher();

    byte[] csvBytes = Files.readAllBytes(inputCsv);
    List<String[]> rows = parseCsv(new String(csvBytes, Charset.forName("UTF-8")));
    if(rows.isEmpty()) {
      throw new IllegalStateException("csv is empty");
    }
    String[] header = rows.get(0);
    if(header.length > 0 && header[0] != null && header[0].startsWith("\uFEFF")) {
      header[0] = header[0].substring(1);
    }
    if(header.length < 3 || !"function_path".equals(header[0]) || !"constant_index".equals(header[1]) || !"constant_value".equals(header[2])) {
      throw new IllegalStateException("csv header must be: " + CSV_HEADER);
    }

    Map<String, LuaChunk.Function> functionByPath = new HashMap<String, LuaChunk.Function>();
    collectFunctions(chunk.mainFunction, functionByPath);

    Charset charset = Charset.forName(System.getProperty("unluac.stringCharset", "GBK"));
    int applied = 0;
    for(int i = 1; i < rows.size(); i++) {
      String[] row = rows.get(i);
      if(row.length == 0) {
        continue;
      }
      if(row.length < 3) {
        throw new IllegalStateException("invalid csv row " + (i + 1));
      }
      String functionPath = row[0];
      String indexText = row[1];
      String valueSpec = row[2];

      if(valueSpec != null && valueSpec.startsWith("numraw:")) {
        String hex = valueSpec.substring("numraw:".length()).trim();
        if(constantHexEquals(functionByPath, functionPath, indexText, hex)) {
          continue;
        }
      }

      LuaChunk.Function function = functionByPath.get(functionPath);
      if(function == null) {
        throw new IllegalStateException("function path not found: " + functionPath);
      }

      int constantIndex = Integer.parseInt(indexText);
      if(constantIndex < 0 || constantIndex >= function.constants.size()) {
        throw new IllegalStateException("constant index out of range: " + functionPath + "#" + constantIndex);
      }

      LuaChunk.Constant constant = function.constants.get(constantIndex);

      String currentValue = constantToCsvValue(constant, charset);
      if(currentValue.equals(valueSpec)) {
        continue;
      }

      applyConstantPatch(patched, chunk, function, constant, valueSpec, charset);
      applied++;
    }

    Files.write(outputLuc, patched);

    LuaChunk patchedChunk = parser.parse(patched);
    boolean instructionUnchanged = compareInstructionTree(chunk.mainFunction, patchedChunk.mainFunction);
    boolean debugUnchanged = compareDebugTree(chunk.mainFunction, patchedChunk.mainFunction);
    boolean structureUnchanged = compareStructureTree(chunk.mainFunction, patchedChunk.mainFunction);

    Lua50AstPatcher.PatchReport report = patcher.diff(original, patched, chunk);

    System.out.println("mode=import");
    System.out.println("input_luc=" + inputLuc);
    System.out.println("input_csv=" + inputCsv);
    System.out.println("output_luc=" + outputLuc);
    System.out.println("orig_size=" + original.length);
    System.out.println("patched_size=" + patched.length);
    System.out.println("applied_rows=" + applied);
    System.out.println("diff_count=" + report.diffs.size());
    System.out.println("constant_area_diff_count=" + report.constantAreaChangeCount);
    System.out.println("non_constant_area_diff_count=" + report.nonConstantAreaChangeCount);
    System.out.println("only_constant_area_changed=" + report.onlyConstantAreaChanged());
    System.out.println("instruction_unchanged=" + instructionUnchanged);
    System.out.println("debug_unchanged=" + debugUnchanged);
    System.out.println("structure_unchanged=" + structureUnchanged);

    int show = Math.min(report.diffs.size(), 128);
    for(int i = 0; i < show; i++) {
      Lua50AstPatcher.PatchDiff d = report.diffs.get(i);
      System.out.println(String.format("diff[%d]=0x%08X %02X->%02X", i, d.offset, d.before, d.after));
    }
    if(report.diffs.size() > show) {
      System.out.println("diff_truncated=true");
    }

    if(!report.onlyConstantAreaChanged() || !instructionUnchanged || !debugUnchanged || !structureUnchanged) {
      throw new IllegalStateException("patch validation failed");
    }
  }

  private static boolean constantHexEquals(Map<String, LuaChunk.Function> functionByPath,
                                           String functionPath,
                                           String constantIndexText,
                                           String hex) {
    LuaChunk.Function function = functionByPath.get(functionPath);
    if(function == null) {
      return false;
    }
    int constantIndex;
    try {
      constantIndex = Integer.parseInt(constantIndexText);
    } catch(Exception e) {
      return false;
    }
    if(constantIndex < 0 || constantIndex >= function.constants.size()) {
      return false;
    }
    LuaChunk.Constant constant = function.constants.get(constantIndex);
    if(constant.type != LuaChunk.Constant.Type.NUMBER || constant.rawNumberBytes == null) {
      return false;
    }
    return toHex(constant.rawNumberBytes).equalsIgnoreCase(hex);
  }

  private static void applyConstantPatch(byte[] target, LuaChunk chunk, LuaChunk.Function function,
                                         LuaChunk.Constant constant, String valueSpec, Charset charset) {
    switch(constant.type) {
      case NIL:
        if(!"nil".equals(valueSpec)) {
          throw new IllegalStateException("nil constant only accepts value 'nil'");
        }
        return;
      case BOOLEAN:
        boolean boolValue;
        if(valueSpec.startsWith("bool:")) {
          boolValue = Boolean.parseBoolean(valueSpec.substring("bool:".length()));
        } else if("1".equals(valueSpec) || "true".equalsIgnoreCase(valueSpec)) {
          boolValue = true;
        } else if("0".equals(valueSpec) || "false".equalsIgnoreCase(valueSpec)) {
          boolValue = false;
        } else {
          throw new IllegalStateException("invalid boolean value: " + valueSpec);
        }
        target[constant.valueOffset] = (byte) (boolValue ? 1 : 0);
        constant.booleanValue = boolValue;
        return;
      case NUMBER:
        byte[] rawNumber = parseNumberRaw(valueSpec, chunk.header);
        if(rawNumber.length != chunk.header.numberSize) {
          throw new IllegalStateException("number raw size mismatch");
        }
        System.arraycopy(rawNumber, 0, target, constant.valueOffset, rawNumber.length);
        constant.rawNumberBytes = rawNumber;
        return;
      case STRING:
        if(valueSpec.startsWith("strhex:")) {
          byte[] replacement = parseHex(valueSpec.substring("strhex:".length()).trim());
          patchStringConstantBytesInPlace(target, chunk.header, constant, replacement);
        } else {
          String replacement = valueSpec.startsWith("str:") ? valueSpec.substring("str:".length()) : valueSpec;
          patchStringConstantInPlace(target, chunk.header, constant, replacement, charset);
        }
        return;
      default:
        throw new IllegalStateException("unsupported constant type");
    }
  }

  private static void patchStringConstantInPlace(byte[] target, LuaChunk.Header header,
                                                 LuaChunk.Constant constant, String replacement,
                                                 Charset charset) {
    if(constant.stringValue == null || constant.stringValue.decodedBytes == null) {
      throw new IllegalStateException("invalid string constant");
    }

    int length = constant.stringValue.lengthField;
    if(length <= 0) {
      throw new IllegalStateException("cannot patch zero-length string");
    }
    int contentLength = length - 1;
    byte[] replacementBytes = replacement.getBytes(charset);
    if(replacementBytes.length > contentLength) {
      throw new IllegalStateException("replacement too long for fixed-size patch: " + replacementBytes.length + ">" + contentLength);
    }

    byte[] decoded = constant.stringValue.decodedBytes.clone();
    for(int i = 0; i < contentLength; i++) {
      decoded[i] = 0;
    }
    System.arraycopy(replacementBytes, 0, decoded, 0, replacementBytes.length);
    decoded[length - 1] = 0;

    byte[] raw = decoded.clone();
    if(header.encodedStrings && raw.length > 0) {
      for(int i = 0; i < raw.length - 1; i++) {
        raw[i] = (byte) ((raw[i] + (i + 1)) & 0xFF);
      }
    }

    System.arraycopy(raw, 0, target, constant.stringValue.dataOffset, raw.length);
    constant.stringValue.decodedBytes = decoded;
    constant.stringValue.text = replacement;
  }

  private static void patchStringConstantBytesInPlace(byte[] target, LuaChunk.Header header,
                                                      LuaChunk.Constant constant, byte[] replacementBytes) {
    if(constant.stringValue == null || constant.stringValue.decodedBytes == null) {
      throw new IllegalStateException("invalid string constant");
    }

    int length = constant.stringValue.lengthField;
    if(length <= 0) {
      throw new IllegalStateException("cannot patch zero-length string");
    }
    int contentLength = length - 1;
    if(replacementBytes.length > contentLength) {
      throw new IllegalStateException("replacement too long for fixed-size patch: " + replacementBytes.length + ">" + contentLength);
    }

    byte[] decoded = constant.stringValue.decodedBytes.clone();
    for(int i = 0; i < contentLength; i++) {
      decoded[i] = 0;
    }
    System.arraycopy(replacementBytes, 0, decoded, 0, replacementBytes.length);
    decoded[length - 1] = 0;

    byte[] raw = decoded.clone();
    if(header.encodedStrings && raw.length > 0) {
      for(int i = 0; i < raw.length - 1; i++) {
        raw[i] = (byte) ((raw[i] + (i + 1)) & 0xFF);
      }
    }

    System.arraycopy(raw, 0, target, constant.stringValue.dataOffset, raw.length);
    constant.stringValue.decodedBytes = decoded;
  }

  private static byte[] parseNumberRaw(String valueSpec, LuaChunk.Header header) {
    if(valueSpec.startsWith("numraw:")) {
      String hex = valueSpec.substring("numraw:".length()).trim();
      if(hex.length() != header.numberSize * 2) {
        throw new IllegalStateException("numraw length mismatch");
      }
      byte[] out = new byte[header.numberSize];
      for(int i = 0; i < out.length; i++) {
        int idx = i * 2;
        out[i] = (byte) Integer.parseInt(hex.substring(idx, idx + 2), 16);
      }
      return out;
    }

    if(valueSpec.startsWith("num:")) {
      String value = valueSpec.substring("num:".length()).trim();
      return encodeNumber(value, header);
    }

    return encodeNumber(valueSpec.trim(), header);
  }

  private static byte[] encodeNumber(String valueText, LuaChunk.Header header) {
    ByteBuffer bb = ByteBuffer.allocate(header.numberSize);
    bb.order(header.isLittleEndian() ? ByteOrder.LITTLE_ENDIAN : ByteOrder.BIG_ENDIAN);
    if(header.numberIntegral) {
      long value = Long.parseLong(valueText);
      if(header.numberSize == 4) {
        bb.putInt((int) value);
      } else if(header.numberSize == 8) {
        bb.putLong(value);
      } else {
        throw new IllegalStateException("unsupported integral number size: " + header.numberSize);
      }
    } else {
      double value = Double.parseDouble(valueText);
      if(header.numberSize == 4) {
        bb.putFloat((float) value);
      } else if(header.numberSize == 8) {
        bb.putDouble(value);
      } else {
        throw new IllegalStateException("unsupported float number size: " + header.numberSize);
      }
    }
    return bb.array();
  }

  private static void appendFunctionConstants(LuaChunk.Function function, List<String> lines, Charset charset) {
    for(int i = 0; i < function.constants.size(); i++) {
      LuaChunk.Constant constant = function.constants.get(i);
      String value = constantToCsvValue(constant, charset);
      lines.add(csv(function.path) + "," + csv(Integer.toString(i)) + "," + csv(value));
    }
    for(LuaChunk.Function child : function.prototypes) {
      appendFunctionConstants(child, lines, charset);
    }
  }

  private static String constantToCsvValue(LuaChunk.Constant constant, Charset charset) {
    switch(constant.type) {
      case NIL:
        return "nil";
      case BOOLEAN:
        return "bool:" + (constant.booleanValue ? "true" : "false");
      case NUMBER:
        return "numraw:" + toHex(constant.rawNumberBytes);
      case STRING:
        return "strhex:" + toHex(constant.stringValue.bodyBytes());
      default:
        throw new IllegalStateException("unsupported constant type");
    }
  }

  private static byte[] parseHex(String hex) {
    if((hex.length() & 1) != 0) {
      throw new IllegalStateException("hex length must be even");
    }
    byte[] out = new byte[hex.length() / 2];
    for(int i = 0; i < out.length; i++) {
      int idx = i * 2;
      out[i] = (byte) Integer.parseInt(hex.substring(idx, idx + 2), 16);
    }
    return out;
  }

  private static String toHex(byte[] bytes) {
    StringBuilder sb = new StringBuilder();
    for(byte b : bytes) {
      int v = b & 0xFF;
      if(v < 16) sb.append('0');
      sb.append(Integer.toHexString(v).toUpperCase());
    }
    return sb.toString();
  }

  private static void collectFunctions(LuaChunk.Function function, Map<String, LuaChunk.Function> map) {
    map.put(function.path, function);
    for(LuaChunk.Function child : function.prototypes) {
      collectFunctions(child, map);
    }
  }

  private static int countFunctions(LuaChunk.Function function) {
    int count = 1;
    for(LuaChunk.Function child : function.prototypes) {
      count += countFunctions(child);
    }
    return count;
  }

  private static int countConstants(LuaChunk.Function function) {
    int count = function.constants.size();
    for(LuaChunk.Function child : function.prototypes) {
      count += countConstants(child);
    }
    return count;
  }

  private static int countInstructions(LuaChunk.Function function) {
    int count = function.code.size();
    for(LuaChunk.Function child : function.prototypes) {
      count += countInstructions(child);
    }
    return count;
  }

  private static int countLineinfo(LuaChunk.Function function) {
    int count = function.debug.lineinfo.size();
    for(LuaChunk.Function child : function.prototypes) {
      count += countLineinfo(child);
    }
    return count;
  }

  private static boolean compareStructureTree(LuaChunk.Function a, LuaChunk.Function b) {
    if(a.prototypes.size() != b.prototypes.size()) {
      return false;
    }
    if(a.constants.size() != b.constants.size()) {
      return false;
    }
    if(a.code.size() != b.code.size()) {
      return false;
    }
    if(a.debug.lineinfo.size() != b.debug.lineinfo.size()) {
      return false;
    }
    if(a.debug.localvars.size() != b.debug.localvars.size()) {
      return false;
    }
    if(a.debug.upvalueNames.size() != b.debug.upvalueNames.size()) {
      return false;
    }
    for(int i = 0; i < a.prototypes.size(); i++) {
      if(!compareStructureTree(a.prototypes.get(i), b.prototypes.get(i))) {
        return false;
      }
    }
    return true;
  }

  private static boolean compareInstructionTree(LuaChunk.Function a, LuaChunk.Function b) {
    if(a.code.size() != b.code.size()) {
      return false;
    }
    for(int i = 0; i < a.code.size(); i++) {
      if(a.code.get(i).value != b.code.get(i).value) {
        return false;
      }
    }
    if(a.prototypes.size() != b.prototypes.size()) {
      return false;
    }
    for(int i = 0; i < a.prototypes.size(); i++) {
      if(!compareInstructionTree(a.prototypes.get(i), b.prototypes.get(i))) {
        return false;
      }
    }
    return true;
  }

  private static boolean compareDebugTree(LuaChunk.Function a, LuaChunk.Function b) {
    if(a.debug.lineinfo.size() != b.debug.lineinfo.size()) {
      return false;
    }
    for(int i = 0; i < a.debug.lineinfo.size(); i++) {
      if(!a.debug.lineinfo.get(i).equals(b.debug.lineinfo.get(i))) {
        return false;
      }
    }
    if(a.debug.localvars.size() != b.debug.localvars.size()) {
      return false;
    }
    for(int i = 0; i < a.debug.localvars.size(); i++) {
      LuaChunk.LocalVar la = a.debug.localvars.get(i);
      LuaChunk.LocalVar lb = b.debug.localvars.get(i);
      if(la.startPc != lb.startPc || la.endPc != lb.endPc) {
        return false;
      }
      String na = la.nameString == null ? "" : la.nameString.toDisplayString();
      String nb = lb.nameString == null ? "" : lb.nameString.toDisplayString();
      if(!na.equals(nb)) {
        return false;
      }
    }
    if(a.debug.upvalueNames.size() != b.debug.upvalueNames.size()) {
      return false;
    }
    for(int i = 0; i < a.debug.upvalueNames.size(); i++) {
      if(!a.debug.upvalueNames.get(i).equals(b.debug.upvalueNames.get(i))) {
        return false;
      }
    }
    if(a.prototypes.size() != b.prototypes.size()) {
      return false;
    }
    for(int i = 0; i < a.prototypes.size(); i++) {
      if(!compareDebugTree(a.prototypes.get(i), b.prototypes.get(i))) {
        return false;
      }
    }
    return true;
  }

  private static String csv(String value) {
    if(value == null) {
      value = "";
    }
    boolean quote = false;
    for(int i = 0; i < value.length(); i++) {
      char c = value.charAt(i);
      if(c == ',' || c == '"' || c == '\r' || c == '\n') {
        quote = true;
        break;
      }
    }
    if(!quote) {
      return value;
    }
    String escaped = value.replace("\"", "\"\"");
    return "\"" + escaped + "\"";
  }

  private static List<String[]> parseCsv(String text) {
    List<String[]> rows = new ArrayList<String[]>();
    List<String> fields = new ArrayList<String>();
    StringBuilder current = new StringBuilder();
    boolean inQuotes = false;

    for(int i = 0; i < text.length(); i++) {
      char ch = text.charAt(i);
      if(inQuotes) {
        if(ch == '"') {
          if(i + 1 < text.length() && text.charAt(i + 1) == '"') {
            current.append('"');
            i++;
          } else {
            inQuotes = false;
          }
        } else {
          current.append(ch);
        }
      } else {
        if(ch == '"') {
          inQuotes = true;
        } else if(ch == ',') {
          fields.add(current.toString());
          current.setLength(0);
        } else if(ch == '\n') {
          fields.add(current.toString());
          current.setLength(0);
          rows.add(fields.toArray(new String[0]));
          fields = new ArrayList<String>();
        } else if(ch == '\r') {
          continue;
        } else {
          current.append(ch);
        }
      }
    }

    if(inQuotes) {
      throw new IllegalStateException("unterminated quote in csv");
    }

    if(current.length() > 0 || !fields.isEmpty()) {
      fields.add(current.toString());
      rows.add(fields.toArray(new String[0]));
    }
    return rows;
  }

  private static void printUsage() {
    System.out.println("Usage:");
    System.out.println("  export: java -cp build unluac.chunk.Lua50ConstantCsvTool export <input.luc> <output.csv>");
    System.out.println("  import: java -cp build unluac.chunk.Lua50ConstantCsvTool import <input.luc> <input.csv> <output.luc>");
    System.out.println("CSV header:");
    System.out.println("  " + CSV_HEADER);
    System.out.println("constant_value format:");
    System.out.println("  string  : strhex:<HEX> (export default) or str:<text>");
    System.out.println("  number  : numraw:<HEX> or num:<decimal>");
    System.out.println("  boolean : bool:true|false");
    System.out.println("  nil     : nil");
  }
}
