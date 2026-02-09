package unluac.chunk;

import java.nio.ByteBuffer;
import java.nio.ByteOrder;
import java.nio.charset.Charset;

public class Lua50ChunkParser {

  private static final byte[] SIGNATURE_FULL = new byte[] { 0x1B, 0x4C, 0x75, 0x61 };
  private static final byte[] SIGNATURE_SHORT = new byte[] { 0x1B };
  private static final double TEST_NUMBER = 3.14159265358979323846E7;

  private final Charset displayCharset;

  public Lua50ChunkParser() {
    this(Charset.forName(System.getProperty("unluac.stringCharset", "GBK")));
  }

  public Lua50ChunkParser(Charset displayCharset) {
    this.displayCharset = displayCharset;
  }

  public LuaChunk parse(byte[] data) {
    if(data == null || data.length < 20) {
      throw new IllegalStateException("invalid chunk size");
    }
    ByteBuffer buffer = ByteBuffer.wrap(data);
    LuaChunk chunk = new LuaChunk();
    chunk.header = parseHeader(buffer);
    chunk.mainFunction = parseFunction(buffer, chunk, "root");
    if(buffer.hasRemaining()) {
      throw new IllegalStateException("trailing bytes not consumed: " + buffer.remaining());
    }
    return chunk;
  }

  private LuaChunk.Header parseHeader(ByteBuffer buffer) {
    LuaChunk.Header header = new LuaChunk.Header();

    buffer.mark();
    byte h1 = buffer.get();
    byte h2 = buffer.get();
    buffer.reset();

    if(h1 == 0x1B && h2 == 0x50) {
      header.signature = SIGNATURE_SHORT.clone();
      header.encodedStrings = true;
    } else {
      header.signature = SIGNATURE_FULL.clone();
      header.encodedStrings = false;
    }

    for(int i = 0; i < header.signature.length; i++) {
      byte actual = buffer.get();
      if(actual != header.signature[i]) {
        throw new IllegalStateException("bad chunk signature");
      }
    }

    header.version = u8(buffer.get());
    if(header.version != 0x50) {
      throw new IllegalStateException("unsupported lua version: " + Integer.toHexString(header.version));
    }

    header.endianFlag = u8(buffer.get());
    if(header.endianFlag == 1) {
      buffer.order(ByteOrder.LITTLE_ENDIAN);
    } else if(header.endianFlag == 0) {
      buffer.order(ByteOrder.BIG_ENDIAN);
    } else {
      throw new IllegalStateException("invalid endian flag: " + header.endianFlag);
    }

    header.intSize = u8(buffer.get());
    header.sizeTSize = u8(buffer.get());
    header.instructionSize = u8(buffer.get());
    header.opSize = u8(buffer.get());
    header.aSize = u8(buffer.get());
    header.bSize = u8(buffer.get());
    header.cSize = u8(buffer.get());
    header.numberSize = u8(buffer.get());

    if(header.intSize <= 0 || header.sizeTSize <= 0 || header.instructionSize <= 0 || header.numberSize <= 0) {
      throw new IllegalStateException("invalid size field in header");
    }

    header.testNumberRaw = new byte[header.numberSize];
    buffer.get(header.testNumberRaw);
    NumberProbe probe = probeNumberType(header.testNumberRaw, header.isLittleEndian(), header.numberSize);
    header.numberIntegral = probe.integral;
    header.testNumberValue = probe.value;

    return header;
  }

  private LuaChunk.Function parseFunction(ByteBuffer buffer, LuaChunk chunk, String path) {
    LuaChunk.Function function = new LuaChunk.Function();
    function.path = path;
    function.startOffset = buffer.position();

    function.sourceString = parseString(buffer, chunk.header, chunk);
    function.source = function.sourceString.toDisplayString();

    function.scalarOffset = buffer.position();
    function.lineDefined = readInt(buffer, chunk.header.intSize, chunk.header.isLittleEndian());
    function.lastLineDefined = 0;
    function.nUpvalues = u8(buffer.get());
    function.numParams = u8(buffer.get());
    function.isVararg = u8(buffer.get());
    function.maxStackSize = u8(buffer.get());
    function.scalarEndOffset = buffer.position();

    function.debugStartOffset = buffer.position();
    parseDebug(buffer, chunk.header, chunk, function);
    function.debugEndOffset = buffer.position();

    parseConstantsAndPrototypes(buffer, chunk, function);
    parseCode(buffer, chunk.header, function);

    function.endOffset = buffer.position();

    return function;
  }

  private void parseDebug(ByteBuffer buffer, LuaChunk.Header header, LuaChunk chunk, LuaChunk.Function function) {
    int lineCount = readInt(buffer, header.intSize, header.isLittleEndian());
    for(int i = 0; i < lineCount; i++) {
      function.debug.lineinfo.add(readInt(buffer, header.intSize, header.isLittleEndian()));
    }

    int localCount = readInt(buffer, header.intSize, header.isLittleEndian());
    for(int i = 0; i < localCount; i++) {
      LuaChunk.LocalVar local = new LuaChunk.LocalVar();
      local.nameString = parseString(buffer, header, chunk);
      local.name = local.nameString.toDisplayString();
      local.startPc = readInt(buffer, header.intSize, header.isLittleEndian());
      local.endPc = readInt(buffer, header.intSize, header.isLittleEndian());
      function.debug.localvars.add(local);
    }

    int upvalueCount = readInt(buffer, header.intSize, header.isLittleEndian());
    for(int i = 0; i < upvalueCount; i++) {
      LuaChunk.LuaString upvalueName = parseString(buffer, header, chunk);
      function.debug.upvalueNameStrings.add(upvalueName);
      function.debug.upvalueNames.add(upvalueName.toDisplayString());
    }
  }

  private void parseConstantsAndPrototypes(ByteBuffer buffer, LuaChunk chunk, LuaChunk.Function function) {
    LuaChunk.Header header = chunk.header;

    function.constantsCountOffset = buffer.position();
    int constantCount = readInt(buffer, header.intSize, header.isLittleEndian());
    function.constantsStartOffset = buffer.position();
    for(int i = 0; i < constantCount; i++) {
      LuaChunk.Constant constant = parseConstant(buffer, chunk);
      constant.indexInFunction = i;
      function.constants.add(constant);
    }
    function.constantsEndOffset = buffer.position();

    function.prototypesCountOffset = buffer.position();
    int prototypeCount = readInt(buffer, header.intSize, header.isLittleEndian());
    function.prototypesStartOffset = buffer.position();
    for(int i = 0; i < prototypeCount; i++) {
      function.prototypes.add(parseFunction(buffer, chunk, function.path + "/" + i));
    }
    function.prototypesEndOffset = buffer.position();
  }

  private LuaChunk.Constant parseConstant(ByteBuffer buffer, LuaChunk chunk) {
    LuaChunk.Header header = chunk.header;
    int tagOffset = buffer.position();
    int tag = u8(buffer.get());
    LuaChunk.Constant constant = new LuaChunk.Constant();
    constant.tagOffset = tagOffset;
    constant.valueOffset = buffer.position();
    if(tag == 0) {
      constant.type = LuaChunk.Constant.Type.NIL;
    } else if(tag == 1) {
      constant.type = LuaChunk.Constant.Type.BOOLEAN;
      constant.booleanValue = u8(buffer.get()) != 0;
    } else if(tag == 3) {
      constant.type = LuaChunk.Constant.Type.NUMBER;
      constant.rawNumberBytes = new byte[header.numberSize];
      buffer.get(constant.rawNumberBytes);
      constant.numberValue = decodeNumber(constant.rawNumberBytes, header.numberSize, header.numberIntegral, header.isLittleEndian());
    } else if(tag == 4) {
      constant.type = LuaChunk.Constant.Type.STRING;
      constant.stringValue = parseString(buffer, header, chunk);
    } else {
      throw new IllegalStateException("bad constant type: " + tag);
    }
    constant.endOffset = buffer.position();
    return constant;
  }

  private void parseCode(ByteBuffer buffer, LuaChunk.Header header, LuaChunk.Function function) {
    function.codeCountOffset = buffer.position();
    int codeCount = readInt(buffer, header.intSize, header.isLittleEndian());
    function.codeStartOffset = buffer.position();
    for(int i = 0; i < codeCount; i++) {
      int offset = buffer.position();
      int value = readUnsignedInt(buffer, header.instructionSize, header.isLittleEndian());
      LuaChunk.Instruction instruction = new LuaChunk.Instruction(value);
      instruction.offset = offset;
      instruction.size = header.instructionSize;
      function.code.add(instruction);
    }
    function.codeEndOffset = buffer.position();
  }

  private LuaChunk.LuaString parseString(ByteBuffer buffer, LuaChunk.Header header, LuaChunk chunk) {
    int lengthOffset = buffer.position();
    int length = readInt(buffer, header.sizeTSize, header.isLittleEndian());
    if(length == 0) {
      LuaChunk.LuaString empty = LuaChunk.LuaString.empty();
      empty.lengthOffset = lengthOffset;
      empty.dataOffset = buffer.position();
      empty.endOffset = buffer.position();
      chunk.stringTable.add(empty);
      return empty;
    }
    if(length < 0) {
      throw new IllegalStateException("negative string length: " + length);
    }

    int dataOffset = buffer.position();
    byte[] raw = new byte[length];
    buffer.get(raw);

    byte[] decoded = new byte[length];
    System.arraycopy(raw, 0, decoded, 0, length);

    if(header.encodedStrings && length > 0) {
      for(int i = 0; i < length - 1; i++) {
        decoded[i] = (byte) ((decoded[i] - (i + 1)) & 0xFF);
      }
    }

    LuaChunk.LuaString value = new LuaChunk.LuaString();
    value.lengthOffset = lengthOffset;
    value.dataOffset = dataOffset;
    value.endOffset = buffer.position();
    value.lengthField = length;
    value.decodedBytes = decoded;
    value.nullTerminated = decoded.length == 0 || decoded[decoded.length - 1] == 0;

    int bodyLen = decoded.length;
    if(value.nullTerminated && bodyLen > 0) {
      bodyLen--;
    }
    byte[] body = new byte[bodyLen];
    System.arraycopy(decoded, 0, body, 0, bodyLen);
    value.text = new String(body, displayCharset);

    chunk.stringTable.add(value);
    return value;
  }

  private static NumberProbe probeNumberType(byte[] raw, boolean littleEndian, int size) {
    double floatValue = decodeNumber(raw, size, false, littleEndian);
    double integralValue = decodeNumber(raw, size, true, littleEndian);
    double floatCheck = toNumberType(TEST_NUMBER, size, false);
    double integralCheck = toNumberType(TEST_NUMBER, size, true);
    if(floatValue == floatCheck) {
      return new NumberProbe(false, floatValue);
    }
    if(integralValue == integralCheck) {
      return new NumberProbe(true, integralValue);
    }
    throw new IllegalStateException("unrecognized number format");
  }

  private static double toNumberType(double value, int size, boolean integral) {
    if(integral) {
      if(size == 4) {
        return (int) value;
      }
      if(size == 8) {
        return (long) value;
      }
    } else {
      if(size == 4) {
        return (float) value;
      }
      if(size == 8) {
        return value;
      }
    }
    throw new IllegalStateException("unsupported number size: " + size);
  }

  private static double decodeNumber(byte[] raw, int size, boolean integral, boolean littleEndian) {
    ByteBuffer bb = ByteBuffer.wrap(raw.clone());
    bb.order(littleEndian ? ByteOrder.LITTLE_ENDIAN : ByteOrder.BIG_ENDIAN);
    if(integral) {
      if(size == 4) {
        return bb.getInt();
      }
      if(size == 8) {
        return bb.getLong();
      }
    } else {
      if(size == 4) {
        return bb.getFloat();
      }
      if(size == 8) {
        return bb.getDouble();
      }
    }
    throw new IllegalStateException("unsupported number size: " + size);
  }

  private static int readInt(ByteBuffer buffer, int size, boolean littleEndian) {
    byte[] bytes = new byte[size];
    buffer.get(bytes);
    long v = readUnsigned(bytes, littleEndian);
    if(size < 4) {
      return (int) v;
    }
    int shift = (4 - Math.min(4, size)) * 8;
    return (int) (v << shift >> shift);
  }

  private static int readUnsignedInt(ByteBuffer buffer, int size, boolean littleEndian) {
    byte[] bytes = new byte[size];
    buffer.get(bytes);
    long v = readUnsigned(bytes, littleEndian);
    return (int) (v & 0xFFFFFFFFL);
  }

  private static long readUnsigned(byte[] bytes, boolean littleEndian) {
    long value = 0;
    if(littleEndian) {
      for(int i = bytes.length - 1; i >= 0; i--) {
        value = (value << 8) | (bytes[i] & 0xFFL);
      }
    } else {
      for(int i = 0; i < bytes.length; i++) {
        value = (value << 8) | (bytes[i] & 0xFFL);
      }
    }
    return value;
  }

  private static int u8(byte value) {
    return value & 0xFF;
  }

  private static final class NumberProbe {
    final boolean integral;
    final double value;

    NumberProbe(boolean integral, double value) {
      this.integral = integral;
      this.value = value;
    }
  }
}
