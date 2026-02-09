package unluac.encode;

import java.nio.charset.StandardCharsets;

import unluac.parse.LString;

final class StringTableWriter {

  byte[] encodeStringBody(byte[] plainWithTerminator) {
    if(plainWithTerminator == null || plainWithTerminator.length == 0) {
      return new byte[0];
    }
    byte[] encoded = new byte[plainWithTerminator.length];
    for(int i = 0; i < plainWithTerminator.length - 1; i++) {
      encoded[i] = (byte)((plainWithTerminator[i] + (i + 1)) & 0xFF);
    }
    encoded[plainWithTerminator.length - 1] = plainWithTerminator[plainWithTerminator.length - 1];
    return encoded;
  }

  byte[] decodeStringBody(byte[] encodedWithTerminator) {
    if(encodedWithTerminator == null || encodedWithTerminator.length == 0) {
      return new byte[0];
    }
    byte[] plain = new byte[encodedWithTerminator.length];
    for(int i = 0; i < encodedWithTerminator.length - 1; i++) {
      plain[i] = (byte)((encodedWithTerminator[i] - (i + 1)) & 0xFF);
    }
    plain[encodedWithTerminator.length - 1] = encodedWithTerminator[encodedWithTerminator.length - 1];
    return plain;
  }

  void writeString(BinaryCodec.LittleEndianWriter out, LString value,
                   int sizeTSize, boolean littleEndian) {
    if(value == null) {
      out.writeUIntBySize(0, sizeTSize, littleEndian);
      return;
    }
    byte[] raw = toPlainBytesWithTerminator(value);
    out.writeUIntBySize(raw.length, sizeTSize, littleEndian);
    byte[] encoded = encodeStringBody(raw);
    out.writeBytes(encoded);
  }

  byte[] toPlainBytesWithTerminator(LString value) {
    if(value == null) {
      return new byte[0];
    }
    byte[] plain = value.bytes;
    if(plain == null) {
      plain = value.deref().getBytes(StandardCharsets.ISO_8859_1);
    }
    byte[] withTerminator = new byte[plain.length + 1];
    System.arraycopy(plain, 0, withTerminator, 0, plain.length);
    withTerminator[withTerminator.length - 1] = 0;
    return withTerminator;
  }
}
