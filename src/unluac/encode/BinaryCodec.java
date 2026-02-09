package unluac.encode;

import java.io.ByteArrayOutputStream;

final class BinaryCodec {

  static final class ByteCursor {
    private final byte[] data;
    private int pos;

    ByteCursor(byte[] data) {
      this.data = data;
      this.pos = 0;
    }

    int position() {
      return pos;
    }

    int remaining() {
      return data.length - pos;
    }

    boolean hasRemaining() {
      return remaining() > 0;
    }

    int readU8() {
      require(1, "u8");
      return data[pos++] & 0xFF;
    }

    byte[] readBytes(int length) {
      if (length < 0) {
        throw new IllegalArgumentException("Negative length: " + length);
      }
      require(length, "bytes[" + length + "]");
      byte[] out = new byte[length];
      System.arraycopy(data, pos, out, 0, length);
      pos += length;
      return out;
    }

    long readUnsignedInt(int byteCount, boolean littleEndian) {
      if (byteCount <= 0 || byteCount > 8) {
        throw new IllegalArgumentException("Unsupported byteCount: " + byteCount);
      }
      require(byteCount, "uint" + (byteCount * 8));
      long value = 0;
      if (littleEndian) {
        for (int i = 0; i < byteCount; i++) {
          value |= (long) (data[pos++] & 0xFF) << (8 * i);
        }
      } else {
        for (int i = 0; i < byteCount; i++) {
          value = (value << 8) | (data[pos++] & 0xFFL);
        }
      }
      return value;
    }

    int readInt32(boolean littleEndian) {
      long value = readUnsignedInt(4, littleEndian);
      return (int) value;
    }

    long readInt64(boolean littleEndian) {
      return readUnsignedInt(8, littleEndian);
    }

    private void require(int length, String what) {
      if (remaining() < length) {
        throw new IllegalStateException(
            "Unexpected EOF while reading " + what + " at offset 0x"
                + Integer.toHexString(pos) + ", remain=" + remaining());
      }
    }
  }

  static final class LittleEndianWriter {
    private final ByteArrayOutputStream out = new ByteArrayOutputStream();

    ByteArrayOutputStream stream() {
      return out;
    }

    int size() {
      return out.size();
    }

    byte[] toByteArray() {
      return out.toByteArray();
    }

    void writeByte(int value) {
      out.write(value & 0xFF);
    }

    void writeBytes(byte[] bytes) {
      out.write(bytes, 0, bytes.length);
    }

    void writeBytes(byte[] bytes, int off, int len) {
      out.write(bytes, off, len);
    }

    void writeIntLE(int value) {
      writeByte(value);
      writeByte(value >>> 8);
      writeByte(value >>> 16);
      writeByte(value >>> 24);
    }

    void writeLongLE(long value) {
      writeByte((int) value);
      writeByte((int) (value >>> 8));
      writeByte((int) (value >>> 16));
      writeByte((int) (value >>> 24));
      writeByte((int) (value >>> 32));
      writeByte((int) (value >>> 40));
      writeByte((int) (value >>> 48));
      writeByte((int) (value >>> 56));
    }

    void writeIntBE(int value) {
      writeByte(value >>> 24);
      writeByte(value >>> 16);
      writeByte(value >>> 8);
      writeByte(value);
    }

    void writeLongBE(long value) {
      writeByte((int) (value >>> 56));
      writeByte((int) (value >>> 48));
      writeByte((int) (value >>> 40));
      writeByte((int) (value >>> 32));
      writeByte((int) (value >>> 24));
      writeByte((int) (value >>> 16));
      writeByte((int) (value >>> 8));
      writeByte((int) value);
    }

    void writeInt(int value, boolean littleEndian) {
      if (littleEndian) {
        writeIntLE(value);
      } else {
        writeIntBE(value);
      }
    }

    void writeLong(long value, boolean littleEndian) {
      if (littleEndian) {
        writeLongLE(value);
      } else {
        writeLongBE(value);
      }
    }

    void writeUIntBySize(long value, int byteCount, boolean littleEndian) {
      if (byteCount <= 0 || byteCount > 8) {
        throw new IllegalArgumentException("Unsupported byteCount: " + byteCount);
      }
      if (littleEndian) {
        for (int i = 0; i < byteCount; i++) {
          writeByte((int) (value >>> (8 * i)));
        }
      } else {
        for (int i = byteCount - 1; i >= 0; i--) {
          writeByte((int) (value >>> (8 * i)));
        }
      }
    }
  }

  private BinaryCodec() {
  }
}

