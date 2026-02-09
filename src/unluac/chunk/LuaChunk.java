package unluac.chunk;

import java.nio.charset.Charset;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;

public class LuaChunk {

  public static final Charset BYTE_CHARSET = StandardCharsets.ISO_8859_1;

  public Header header;
  public Function mainFunction;
  public final List<LuaString> stringTable = new ArrayList<LuaString>();

  public static final class Header {
    public byte[] signature;
    public int version;
    public int endianFlag;
    public int intSize;
    public int sizeTSize;
    public int instructionSize;
    public int opSize;
    public int aSize;
    public int bSize;
    public int cSize;
    public int numberSize;
    public byte[] testNumberRaw;
    public double testNumberValue;
    public boolean numberIntegral;
    public boolean encodedStrings;

    public boolean isLittleEndian() {
      return endianFlag == 1;
    }
  }

  public static final class Function {
    public String path;
    public int startOffset;
    public int endOffset;

    public String source;
    public LuaString sourceString;
    public int lineDefined;
    public int lastLineDefined;
    public int nUpvalues;
    public int numParams;
    public int isVararg;
    public int maxStackSize;
    public final List<Instruction> code = new ArrayList<Instruction>();
    public final List<Constant> constants = new ArrayList<Constant>();
    public final List<Function> prototypes = new ArrayList<Function>();
    public DebugInfo debug = new DebugInfo();

    public int codeCountOffset;
    public int codeStartOffset;
    public int codeEndOffset;

    public int constantsCountOffset;
    public int constantsStartOffset;
    public int constantsEndOffset;

    public int prototypesCountOffset;
    public int prototypesStartOffset;
    public int prototypesEndOffset;

    public int debugStartOffset;
    public int debugEndOffset;

    public int scalarOffset;
    public int scalarEndOffset;
  }

  public static final class Instruction {
    public int value;
    public int offset;
    public int size;

    public Instruction(int value) {
      this.value = value;
    }
  }

  public static final class Constant {

    public enum Type {
      NIL,
      BOOLEAN,
      NUMBER,
      STRING
    }

    public Type type;

    public int tagOffset;
    public int valueOffset;
    public int endOffset;
    public int indexInFunction;

    public boolean booleanValue;
    public double numberValue;
    public byte[] rawNumberBytes;
    public LuaString stringValue;
  }

  public static final class DebugInfo {
    public final List<Integer> lineinfo = new ArrayList<Integer>();
    public final List<LocalVar> localvars = new ArrayList<LocalVar>();
    public final List<String> upvalueNames = new ArrayList<String>();
    public final List<LuaString> upvalueNameStrings = new ArrayList<LuaString>();
  }

  public static final class LocalVar {
    public String name;
    public LuaString nameString;
    public int startPc;
    public int endPc;
  }

  public static final class LuaString {
    public int lengthOffset;
    public int dataOffset;
    public int endOffset;

    public int lengthField;
    public byte[] decodedBytes;
    public boolean nullTerminated;
    public String text;

    public static LuaString empty() {
      LuaString value = new LuaString();
      value.lengthField = 0;
      value.decodedBytes = new byte[0];
      value.nullTerminated = true;
      value.text = "";
      return value;
    }

    public byte[] bodyBytes() {
      if(decodedBytes == null || decodedBytes.length == 0) {
        return new byte[0];
      }
      if(nullTerminated && decodedBytes[decodedBytes.length - 1] == 0) {
        byte[] body = new byte[decodedBytes.length - 1];
        System.arraycopy(decodedBytes, 0, body, 0, body.length);
        return body;
      }
      byte[] body = new byte[decodedBytes.length];
      System.arraycopy(decodedBytes, 0, body, 0, body.length);
      return body;
    }

    public String toDisplayString() {
      if(text != null) {
        return text;
      }
      return new String(bodyBytes(), BYTE_CHARSET);
    }
  }
}
