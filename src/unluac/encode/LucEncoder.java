package unluac.encode;

import java.io.IOException;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import unluac.Configuration;
import unluac.Main;
import unluac.parse.LBoolean;
import unluac.parse.LFunction;
import unluac.parse.LLocal;
import unluac.parse.LNil;
import unluac.parse.LNumber;
import unluac.parse.LObject;
import unluac.parse.LString;
import unluac.parse.LUpvalue;

public class LucEncoder {

  public static final class EncodeResult {
    public final byte[] data;
    public final HeaderWriter.HeaderInfo headerInfo;
    public final ChecksumWriter.ChecksumResult checksum;

    EncodeResult(byte[] data, HeaderWriter.HeaderInfo headerInfo, ChecksumWriter.ChecksumResult checksum) {
      this.data = data;
      this.headerInfo = headerInfo;
      this.checksum = checksum;
    }
  }

  public static final class StructureValidationResult {
    public final boolean ok;
    public final List<String> issues;

    StructureValidationResult(boolean ok, List<String> issues) {
      this.ok = ok;
      this.issues = issues;
    }
  }

  public static final class ByteDiff {
    public final int offset;
    public final int expected;
    public final int actual;

    ByteDiff(int offset, int expected, int actual) {
      this.offset = offset;
      this.expected = expected;
      this.actual = actual;
    }
  }

  public static final class CompareReport {
    public final String generatedHex;
    public final String sampleHex;
    public final List<ByteDiff> diffs;

    CompareReport(String generatedHex, String sampleHex, List<ByteDiff> diffs) {
      this.generatedHex = generatedHex;
      this.sampleHex = sampleHex;
      this.diffs = diffs;
    }
  }

  private final HeaderWriter headerWriter = new HeaderWriter();
  private final StringTableWriter stringWriter = new StringTableWriter();
  private final InstructionEncoder instructionEncoder = new InstructionEncoder();
  private final ChecksumWriter checksumWriter = new ChecksumWriter();

  private static final List<String> DEFAULT_LUAC_CANDIDATES = Arrays.asList(
      System.getProperty("luac50", ""),
      System.getenv("LUAC50"),
      "D:\\TitanGames\\lua503\\luac50.exe",
      "luac50.exe",
      "luac50",
      "luac.exe",
      "luac"
  );

  public EncodeResult encode(LFunction function) {
    if(function == null) {
      throw new IllegalArgumentException("function is null");
    }
    if(function.header == null) {
      throw new IllegalArgumentException("function.header is null");
    }

    BinaryCodec.LittleEndianWriter out = new BinaryCodec.LittleEndianWriter();

    // 1) header
    HeaderWriter.HeaderInfo headerInfo = headerWriter.write(out, function.header);

    // 2) string table + function body
    writeFunction(out, function, headerInfo);

    // 3) instruction block（在 writeFunction 内部按 Lua50 结构写入）
    // 4) checksum（如有）
    ChecksumWriter.ChecksumResult checksum = checksumWriter.write(out, out.toByteArray());

    return new EncodeResult(out.toByteArray(), headerInfo, checksum);
  }

  private void writeFunction(BinaryCodec.LittleEndianWriter out, LFunction function,
                             HeaderWriter.HeaderInfo headerInfo) {
    boolean le = headerInfo.littleEndian;

    // source (string)
    stringWriter.writeString(out, function.source, headerInfo.sizeTSize, le);

    // line defined (int)
    out.writeInt(function.lineBegin, le);

    // nups, params, vararg, maxstack
    out.writeByte(function.numUpvalues);
    out.writeByte(function.numParams);
    out.writeByte(function.vararg);
    out.writeByte(function.maximumStackSize);

    // lineinfo (sub_9D8260)
    int[] lines = function.lines == null ? new int[0] : function.lines;
    out.writeInt(lines.length, le);
    for(int line : lines) {
      out.writeInt(line, le);
    }

    // locals (sub_9D82A0)
    LLocal[] locals = function.locals == null ? new LLocal[0] : function.locals;
    out.writeInt(locals.length, le);
    for(LLocal local : locals) {
      stringWriter.writeString(out, local.name, headerInfo.sizeTSize, le);
      out.writeInt(local.start, le);
      out.writeInt(local.end, le);
    }

    // upvalue names (sub_9D8360)
    LUpvalue[] upvalues = function.upvalues == null ? new LUpvalue[0] : function.upvalues;
    out.writeInt(upvalues.length, le);
    for(LUpvalue upvalue : upvalues) {
      if(upvalue == null || upvalue.name == null) {
        stringWriter.writeString(out, null, headerInfo.sizeTSize, le);
      } else {
        byte[] raw = upvalue.name.getBytes(java.nio.charset.StandardCharsets.ISO_8859_1);
        byte[] withTerminator = new byte[raw.length + 1];
        System.arraycopy(raw, 0, withTerminator, 0, raw.length);
        withTerminator[withTerminator.length - 1] = 0;
        LString nameString = new LString(new unluac.parse.BSizeT(withTerminator.length), withTerminator);
        stringWriter.writeString(out, nameString, headerInfo.sizeTSize, le);
      }
    }

    // constants (sub_9D83D0)
    LObject[] constants = function.constants == null ? new LObject[0] : function.constants;
    out.writeInt(constants.length, le);
    for(LObject constant : constants) {
      writeConstant(out, constant, headerInfo);
    }

    // child functions (sub_9D83D0)
    LFunction[] children = function.functions == null ? new LFunction[0] : function.functions;
    out.writeInt(children.length, le);
    for(LFunction child : children) {
      writeFunction(out, child, headerInfo);
    }

    // instruction block (sub_9D8320)
    instructionEncoder.writeInstructions(out, function, le);
  }

  private void writeConstant(BinaryCodec.LittleEndianWriter out, LObject constant,
                             HeaderWriter.HeaderInfo headerInfo) {
    boolean le = headerInfo.littleEndian;
    if(constant == null || constant == LNil.NIL) {
      out.writeByte(0);
      return;
    }
    if(constant == LBoolean.LFALSE) {
      out.writeByte(1);
      out.writeByte(0);
      return;
    }
    if(constant == LBoolean.LTRUE) {
      out.writeByte(1);
      out.writeByte(1);
      return;
    }
    if(constant instanceof LNumber) {
      out.writeByte(3);
      long bits = Double.doubleToLongBits(((LNumber) constant).value());
      out.writeLong(bits, le);
      return;
    }
    if(constant instanceof LString) {
      out.writeByte(4);
      stringWriter.writeString(out, (LString) constant, headerInfo.sizeTSize, le);
      return;
    }
    throw new IllegalStateException("Unsupported constant type: " + constant.getClass().getName());
  }

  public StructureValidationResult validateLucStructure(byte[] data) {
    List<String> issues = new ArrayList<String>();
    if(data == null || data.length < 32) {
      issues.add("data too short");
      return new StructureValidationResult(false, issues);
    }

    BinaryCodec.ByteCursor cursor = new BinaryCodec.ByteCursor(data);

    int magic = cursor.readU8();
    int version = cursor.readU8();
    int endian = cursor.readU8();
    int intSize = cursor.readU8();
    int sizeTSize = cursor.readU8();
    int instructionSize = cursor.readU8();
    int opSize = cursor.readU8();
    int aSize = cursor.readU8();
    int bSize = cursor.readU8();
    int cSize = cursor.readU8();
    int numberSize = cursor.readU8();

    if(magic != 0x1B) issues.add("magic mismatch: " + hex(magic));
    if(version != 0x50) issues.add("version mismatch: " + hex(version));
    if(endian != 0x01) issues.add("endian flag mismatch: " + hex(endian));
    if(intSize != 4) issues.add("int size mismatch: " + intSize);
    if(sizeTSize != 4) issues.add("size_t size mismatch: " + sizeTSize);
    if(instructionSize != 4) issues.add("instruction size mismatch: " + instructionSize);
    if(opSize != 6) issues.add("OP size mismatch: " + opSize);
    if(aSize != 8) issues.add("A size mismatch: " + aSize);
    if(bSize != 9) issues.add("B size mismatch: " + bSize);
    if(cSize != 9) issues.add("C size mismatch: " + cSize);
    if(numberSize != 8) issues.add("number size mismatch: " + numberSize);

    long testBits = cursor.readInt64(true);
    int testInt = (int)Double.longBitsToDouble(testBits);
    if(testInt != 31415926) {
      issues.add("test number mismatch: " + testInt);
    }

    if(cursor.remaining() < 4) {
      issues.add("missing first string length");
      return new StructureValidationResult(false, issues);
    }

    int firstStringLen = cursor.readInt32(true);
    if(firstStringLen < 0) {
      issues.add("first string length negative: " + firstStringLen);
      return new StructureValidationResult(false, issues);
    }

    if(firstStringLen > cursor.remaining()) {
      issues.add("first string length exceeds file: len=" + firstStringLen + ", remain=" + cursor.remaining());
      return new StructureValidationResult(false, issues);
    }

    if(firstStringLen > 0) {
      byte[] encoded = cursor.readBytes(firstStringLen);
      byte[] decoded = stringWriter.decodeStringBody(encoded);
      if(decoded[decoded.length - 1] != 0) {
        issues.add("first string missing terminator");
      }
    }

    if(cursor.remaining() >= 4) {
      int maybeLineDefined = cursor.readInt32(true);
      if(maybeLineDefined < 0) {
        issues.add("lineDefined negative: " + maybeLineDefined);
      }
      if(cursor.remaining() >= 4) {
        int alignment = cursor.position() % 4;
        if(alignment != 0) {
          issues.add("instruction region not 4-byte aligned at offset 0x" + Integer.toHexString(cursor.position()));
        }
      }
    }

    return new StructureValidationResult(issues.isEmpty(), issues);
  }

  public CompareReport compareFirst32(byte[] generated, byte[] sample) {
    int n = Math.min(32, Math.min(generated.length, sample.length));
    List<ByteDiff> diffs = new ArrayList<ByteDiff>();
    for(int i = 0; i < n; i++) {
      int g = generated[i] & 0xFF;
      int s = sample[i] & 0xFF;
      if(g != s) {
        diffs.add(new ByteDiff(i, s, g));
      }
    }
    return new CompareReport(toHex(generated, 32), toHex(sample, 32), diffs);
  }

  public static String toHex(byte[] data, int maxBytes) {
    int n = Math.min(maxBytes, data.length);
    StringBuilder sb = new StringBuilder();
    for(int i = 0; i < n; i++) {
      if(i > 0) sb.append(' ');
      int v = data[i] & 0xFF;
      if(v < 0x10) sb.append('0');
      sb.append(Integer.toHexString(v).toUpperCase());
    }
    return sb.toString();
  }

  private static String hex(int value) {
    String h = Integer.toHexString(value & 0xFF).toUpperCase();
    return h.length() == 1 ? ("0" + h) : h;
  }

  public static void main(String[] args) throws Exception {
    if(args.length < 2) {
      System.out.println("Usage:");
      System.out.println("  java unluac.encode.LucEncoder <input.luc> <output.luc> [sample_for_compare]");
      System.out.println("  java unluac.encode.LucEncoder <input.lua> <output.luc> [sample_for_compare] [luac50_path]");
      return;
    }
    Path input = Paths.get(args[0]);
    Path output = Paths.get(args[1]);
    Path sample = args.length >= 3 ? Paths.get(args[2]) : input;
    String luacPath = args.length >= 4 ? args[3] : null;

    byte[] generated;
    if(input.toString().toLowerCase().endsWith(".lua")) {
      generated = compileLuaToLuc(input, output, luacPath);
    } else {
      generated = encodeFile(input, output);
    }

    LucEncoder encoder = new LucEncoder();
    byte[] sampleBytes = Files.readAllBytes(sample);
    CompareReport report = encoder.compareFirst32(generated, sampleBytes);
    StructureValidationResult validation = encoder.validateLucStructure(generated);

    System.out.println("generated_file=" + output);
    System.out.println("generated_size=" + generated.length);
    System.out.println("sample_size=" + sampleBytes.length);
    System.out.println("header_hex=" + toHex(generated, 19));
    System.out.println("generated_first32=" + report.generatedHex);
    System.out.println("sample_first32=" + report.sampleHex);
    System.out.println("bytes_header=19");
    System.out.println("bytes_first32=32");
    if(report.diffs.isEmpty()) {
      System.out.println("first32_compare=equal");
    } else {
      System.out.println("first32_compare=not_equal");
      for(ByteDiff diff : report.diffs) {
        System.out.println(String.format("diff_offset=0x%02X expected=%02X actual=%02X", diff.offset, diff.expected, diff.actual));
      }
      System.out.println("diff_reason=header may match while payload differs (source string, constants, debug info, instructions)");
    }
    System.out.println("validation_ok=" + validation.ok);
    if(!validation.ok) {
      for(String issue : validation.issues) {
        System.out.println("validation_issue=" + issue);
      }
    }
  }

  public static byte[] encodeFile(Path input, Path output) throws IOException {
    Configuration configuration = new Configuration();
    LFunction function = Main.fileToFunction(input.toString(), configuration);
    LucEncoder encoder = new LucEncoder();
    EncodeResult result = encoder.encode(function);
    Files.write(output, result.data);
    return result.data;
  }

  public static byte[] compileLuaToLuc(Path luaFile, Path outputLuc, String luacPath)
      throws IOException, InterruptedException {
    if(luaFile == null || !Files.exists(luaFile)) {
      throw new IllegalArgumentException("Lua input does not exist: " + luaFile);
    }

    String resolvedLuac = resolveLuac(luacPath);
    Path tempLuac = Files.createTempFile("lua_to_luc_", ".luac");
    try {
      ProcessBuilder pb = new ProcessBuilder(resolvedLuac, "-o", tempLuac.toString(), luaFile.toString());
      pb.redirectErrorStream(true);
      Process process = pb.start();
      byte[] output = readAll(process.getInputStream());
      int code = process.waitFor();
      if(code != 0) {
        throw new IOException("luac50 failed (exit=" + code + "): " + new String(output));
      }
      return encodeFile(tempLuac, outputLuc);
    } finally {
      try {
        Files.deleteIfExists(tempLuac);
      } catch(IOException ignored) {
      }
    }
  }

  private static String resolveLuac(String explicit) {
    if(explicit != null && !explicit.isEmpty()) {
      return explicit;
    }
    for(String candidate : DEFAULT_LUAC_CANDIDATES) {
      if(candidate == null || candidate.isEmpty()) {
        continue;
      }
      try {
        ProcessBuilder pb = new ProcessBuilder(candidate, "-v");
        pb.redirectErrorStream(true);
        Process p = pb.start();
        p.waitFor();
        return candidate;
      } catch(Exception ignored) {
      }
    }
    throw new IllegalStateException("No luac50 found. Provide path as 4th arg or set LUAC50 / -Dluac50");
  }

  private static byte[] readAll(InputStream in) throws IOException {
    ByteArrayOutputStream out = new ByteArrayOutputStream();
    byte[] buf = new byte[4096];
    int r;
    while((r = in.read(buf)) >= 0) {
      out.write(buf, 0, r);
    }
    return out.toByteArray();
  }
}
