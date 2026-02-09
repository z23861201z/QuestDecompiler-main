package unluac.chunk;

import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.List;

public class Lua50AstPatcher {

  public static final class PatchDiff {
    public int offset;
    public int before;
    public int after;
  }

  public static final class PatchReport {
    public final List<PatchDiff> diffs = new ArrayList<PatchDiff>();
    public int constantAreaChangeCount;
    public int nonConstantAreaChangeCount;

    public boolean onlyConstantAreaChanged() {
      return nonConstantAreaChangeCount == 0;
    }
  }

  public interface ConstantPredicate {
    boolean matches(LuaChunk.Function function, int constantIndex, LuaChunk.Constant constant);
  }

  public LuaChunk parse(byte[] input) {
    return new Lua50ChunkParser().parse(input);
  }

  public void patchStringConstant(byte[] data, LuaChunk chunk, ConstantPredicate predicate, String replacement, Charset charset) {
    if(data == null || chunk == null || predicate == null || replacement == null) {
      throw new IllegalArgumentException("null argument");
    }
    if(charset == null) {
      charset = Charset.forName("GBK");
    }
    patchStringConstantRecursive(data, chunk, chunk.mainFunction, predicate, replacement, charset);
  }

  public void patchNumberConstantRaw(byte[] data, LuaChunk chunk, ConstantPredicate predicate, byte[] rawNumberBytes) {
    if(data == null || chunk == null || predicate == null || rawNumberBytes == null) {
      throw new IllegalArgumentException("null argument");
    }
    if(rawNumberBytes.length != chunk.header.numberSize) {
      throw new IllegalArgumentException("raw number size mismatch");
    }
    patchNumberConstantRecursive(data, chunk.mainFunction, predicate, rawNumberBytes, chunk.header.numberSize);
  }

  public void patchInstructionValue(byte[] data, LuaChunk chunk, String functionPath, int instructionIndex, int newValue) {
    if(data == null || chunk == null || functionPath == null) {
      throw new IllegalArgumentException("null argument");
    }
    LuaChunk.Function function = findFunction(chunk.mainFunction, functionPath);
    if(function == null) {
      throw new IllegalStateException("function not found: " + functionPath);
    }
    if(instructionIndex < 0 || instructionIndex >= function.code.size()) {
      throw new IllegalArgumentException("instruction index out of range");
    }
    LuaChunk.Instruction instruction = function.code.get(instructionIndex);
    writeIntBytes(data, instruction.offset, instruction.size, newValue, chunk.header.isLittleEndian());
  }

  public PatchReport diff(byte[] before, byte[] after, LuaChunk chunk) {
    if(before == null || after == null || chunk == null) {
      throw new IllegalArgumentException("null argument");
    }
    PatchReport report = new PatchReport();
    int n = Math.min(before.length, after.length);
    for(int i = 0; i < n; i++) {
      if(before[i] != after[i]) {
        PatchDiff diff = new PatchDiff();
        diff.offset = i;
        diff.before = before[i] & 0xFF;
        diff.after = after[i] & 0xFF;
        report.diffs.add(diff);
        if(isInsideAnyConstantArea(chunk.mainFunction, i)) {
          report.constantAreaChangeCount++;
        } else {
          report.nonConstantAreaChangeCount++;
        }
      }
    }
    if(before.length != after.length) {
      int max = Math.max(before.length, after.length);
      for(int i = n; i < max; i++) {
        PatchDiff diff = new PatchDiff();
        diff.offset = i;
        diff.before = i < before.length ? (before[i] & 0xFF) : -1;
        diff.after = i < after.length ? (after[i] & 0xFF) : -1;
        report.diffs.add(diff);
        report.nonConstantAreaChangeCount++;
      }
    }
    return report;
  }

  private void patchStringConstantRecursive(byte[] data, LuaChunk chunk, LuaChunk.Function function,
                                            ConstantPredicate predicate, String replacement, Charset charset) {
    for(int i = 0; i < function.constants.size(); i++) {
      LuaChunk.Constant constant = function.constants.get(i);
      if(constant.type != LuaChunk.Constant.Type.STRING || constant.stringValue == null) {
        continue;
      }
      if(!predicate.matches(function, i, constant)) {
        continue;
      }

      byte[] oldDecoded = constant.stringValue.decodedBytes;
      if(oldDecoded == null || oldDecoded.length == 0) {
        throw new IllegalStateException("cannot patch zero-length string constant");
      }

      int length = constant.stringValue.lengthField;
      int contentLength = length - 1;
      byte[] replacementBytes = replacement.getBytes(charset);
      if(replacementBytes.length > contentLength) {
        throw new IllegalStateException("replacement too long for fixed-size patch: " + replacementBytes.length + ">" + contentLength);
      }

      byte[] newDecoded = new byte[length];
      System.arraycopy(oldDecoded, 0, newDecoded, 0, length);

      for(int j = 0; j < contentLength; j++) {
        newDecoded[j] = 0;
      }
      System.arraycopy(replacementBytes, 0, newDecoded, 0, replacementBytes.length);
      newDecoded[length - 1] = 0;

      byte[] newRaw = encodeStringRaw(newDecoded, chunk.header.encodedStrings);
      System.arraycopy(newRaw, 0, data, constant.stringValue.dataOffset, newRaw.length);

      constant.stringValue.decodedBytes = newDecoded;
      constant.stringValue.text = new String(newDecoded, 0, length - 1, charset);
    }

    for(LuaChunk.Function child : function.prototypes) {
      patchStringConstantRecursive(data, chunk, child, predicate, replacement, charset);
    }
  }

  private void patchNumberConstantRecursive(byte[] data, LuaChunk.Function function,
                                            ConstantPredicate predicate, byte[] rawNumberBytes,
                                            int numberSize) {
    for(int i = 0; i < function.constants.size(); i++) {
      LuaChunk.Constant constant = function.constants.get(i);
      if(constant.type != LuaChunk.Constant.Type.NUMBER) {
        continue;
      }
      if(!predicate.matches(function, i, constant)) {
        continue;
      }
      System.arraycopy(rawNumberBytes, 0, data, constant.valueOffset, numberSize);
      byte[] raw = new byte[numberSize];
      System.arraycopy(rawNumberBytes, 0, raw, 0, numberSize);
      constant.rawNumberBytes = raw;
    }

    for(LuaChunk.Function child : function.prototypes) {
      patchNumberConstantRecursive(data, child, predicate, rawNumberBytes, numberSize);
    }
  }

  private LuaChunk.Function findFunction(LuaChunk.Function root, String path) {
    if(root == null) {
      return null;
    }
    if(path.equals(root.path)) {
      return root;
    }
    for(LuaChunk.Function child : root.prototypes) {
      LuaChunk.Function found = findFunction(child, path);
      if(found != null) {
        return found;
      }
    }
    return null;
  }

  private boolean isInsideAnyConstantArea(LuaChunk.Function function, int offset) {
    if(function == null) {
      return false;
    }
    if(offset >= function.constantsStartOffset && offset < function.constantsEndOffset) {
      return true;
    }
    for(LuaChunk.Function child : function.prototypes) {
      if(isInsideAnyConstantArea(child, offset)) {
        return true;
      }
    }
    return false;
  }

  private static byte[] encodeStringRaw(byte[] decoded, boolean encodedStrings) {
    byte[] raw = new byte[decoded.length];
    System.arraycopy(decoded, 0, raw, 0, decoded.length);
    if(encodedStrings && raw.length > 0) {
      for(int i = 0; i < raw.length - 1; i++) {
        raw[i] = (byte) ((raw[i] + (i + 1)) & 0xFF);
      }
    }
    return raw;
  }

  private static void writeIntBytes(byte[] target, int offset, int size, int value, boolean littleEndian) {
    long u = value & 0xFFFFFFFFL;
    if(littleEndian) {
      for(int i = 0; i < size; i++) {
        target[offset + i] = (byte) ((u >> (8 * i)) & 0xFF);
      }
    } else {
      for(int i = 0; i < size; i++) {
        int shift = (size - 1 - i) * 8;
        target[offset + i] = (byte) ((u >> shift) & 0xFF);
      }
    }
  }
}

