package unluac.chunk;

import java.io.ByteArrayOutputStream;

public class Lua50ChunkSerializer {

  public byte[] serialize(LuaChunk chunk) {
    if(chunk == null || chunk.header == null || chunk.mainFunction == null) {
      throw new IllegalArgumentException("chunk/header/mainFunction is null");
    }

    ByteArrayOutputStream out = new ByteArrayOutputStream();

    writeBytes(out, chunk.header.signature);
    out.write(chunk.header.version & 0xFF);
    out.write(chunk.header.endianFlag & 0xFF);
    out.write(chunk.header.intSize & 0xFF);
    out.write(chunk.header.sizeTSize & 0xFF);
    out.write(chunk.header.instructionSize & 0xFF);
    out.write(chunk.header.opSize & 0xFF);
    out.write(chunk.header.aSize & 0xFF);
    out.write(chunk.header.bSize & 0xFF);
    out.write(chunk.header.cSize & 0xFF);
    out.write(chunk.header.numberSize & 0xFF);
    writeBytes(out, chunk.header.testNumberRaw);

    writeFunction(out, chunk.header, chunk.mainFunction);
    return out.toByteArray();
  }

  private void writeFunction(ByteArrayOutputStream out, LuaChunk.Header header, LuaChunk.Function function) {
    writeString(out, header, function.sourceString);

    writeInt(out, header.intSize, function.lineDefined, header.isLittleEndian());
    out.write(function.nUpvalues & 0xFF);
    out.write(function.numParams & 0xFF);
    out.write(function.isVararg & 0xFF);
    out.write(function.maxStackSize & 0xFF);

    writeInt(out, header.intSize, function.debug.lineinfo.size(), header.isLittleEndian());
    for(Integer line : function.debug.lineinfo) {
      writeInt(out, header.intSize, line == null ? 0 : line.intValue(), header.isLittleEndian());
    }

    writeInt(out, header.intSize, function.debug.localvars.size(), header.isLittleEndian());
    for(LuaChunk.LocalVar local : function.debug.localvars) {
      writeString(out, header, local.nameString);
      writeInt(out, header.intSize, local.startPc, header.isLittleEndian());
      writeInt(out, header.intSize, local.endPc, header.isLittleEndian());
    }

    writeInt(out, header.intSize, function.debug.upvalueNameStrings.size(), header.isLittleEndian());
    for(LuaChunk.LuaString upvalue : function.debug.upvalueNameStrings) {
      writeString(out, header, upvalue);
    }

    writeInt(out, header.intSize, function.constants.size(), header.isLittleEndian());
    for(LuaChunk.Constant constant : function.constants) {
      writeConstant(out, header, constant);
    }

    writeInt(out, header.intSize, function.prototypes.size(), header.isLittleEndian());
    for(LuaChunk.Function child : function.prototypes) {
      writeFunction(out, header, child);
    }

    writeInt(out, header.intSize, function.code.size(), header.isLittleEndian());
    for(LuaChunk.Instruction instruction : function.code) {
      writeInt(out, header.instructionSize, instruction.value, header.isLittleEndian());
    }
  }

  private void writeConstant(ByteArrayOutputStream out, LuaChunk.Header header, LuaChunk.Constant constant) {
    switch(constant.type) {
      case NIL:
        out.write(0);
        break;
      case BOOLEAN:
        out.write(1);
        out.write(constant.booleanValue ? 1 : 0);
        break;
      case NUMBER:
        out.write(3);
        if(constant.rawNumberBytes == null || constant.rawNumberBytes.length != header.numberSize) {
          throw new IllegalStateException("invalid raw number bytes");
        }
        writeBytes(out, constant.rawNumberBytes);
        break;
      case STRING:
        out.write(4);
        writeString(out, header, constant.stringValue);
        break;
      default:
        throw new IllegalStateException("unsupported constant type");
    }
  }

  private void writeString(ByteArrayOutputStream out, LuaChunk.Header header, LuaChunk.LuaString value) {
    if(value == null) {
      writeInt(out, header.sizeTSize, 0, header.isLittleEndian());
      return;
    }

    int length = value.lengthField;
    writeInt(out, header.sizeTSize, length, header.isLittleEndian());
    if(length == 0) {
      return;
    }
    if(value.decodedBytes == null || value.decodedBytes.length != length) {
      throw new IllegalStateException("string decoded bytes length mismatch");
    }

    byte[] raw = new byte[length];
    System.arraycopy(value.decodedBytes, 0, raw, 0, length);
    if(header.encodedStrings && length > 0) {
      for(int i = 0; i < length - 1; i++) {
        raw[i] = (byte) ((raw[i] + (i + 1)) & 0xFF);
      }
    }
    writeBytes(out, raw);
  }

  private void writeInt(ByteArrayOutputStream out, int size, int value, boolean littleEndian) {
    byte[] bytes = new byte[size];
    long u = value & 0xFFFFFFFFL;
    if(littleEndian) {
      for(int i = 0; i < size; i++) {
        bytes[i] = (byte) ((u >> (8 * i)) & 0xFF);
      }
    } else {
      for(int i = 0; i < size; i++) {
        int shift = (size - 1 - i) * 8;
        bytes[i] = (byte) ((u >> shift) & 0xFF);
      }
    }
    writeBytes(out, bytes);
  }

  private void writeBytes(ByteArrayOutputStream out, byte[] bytes) {
    if(bytes == null) {
      return;
    }
    out.write(bytes, 0, bytes.length);
  }
}

