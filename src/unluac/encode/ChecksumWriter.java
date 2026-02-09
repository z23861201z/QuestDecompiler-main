package unluac.encode;

final class ChecksumWriter {

  static final class ChecksumResult {
    final boolean enabled;
    final int length;

    ChecksumResult(boolean enabled, int length) {
      this.enabled = enabled;
      this.length = length;
    }
  }

  ChecksumResult write(BinaryCodec.LittleEndianWriter out, byte[] currentData) {
    // game.exe 的 luc 主链未使用独立 checksum 字段。
    return new ChecksumResult(false, 0);
  }
}

