package unluac.encode;

import unluac.parse.BHeader;

final class HeaderWriter {

  private static final long TEST_NUMBER_BITS = Double.doubleToLongBits(3.14159265358979323846E7);

  static final class HeaderInfo {
    final int endianFlag;
    final int intSize;
    final int sizeTSize;
    final int instructionSize;
    final int sizeOp;
    final int sizeA;
    final int sizeB;
    final int sizeC;
    final int numberSize;
    final boolean littleEndian;

    HeaderInfo(int endianFlag, int intSize, int sizeTSize, int instructionSize,
               int sizeOp, int sizeA, int sizeB, int sizeC, int numberSize) {
      this.endianFlag = endianFlag;
      this.intSize = intSize;
      this.sizeTSize = sizeTSize;
      this.instructionSize = instructionSize;
      this.sizeOp = sizeOp;
      this.sizeA = sizeA;
      this.sizeB = sizeB;
      this.sizeC = sizeC;
      this.numberSize = numberSize;
      this.littleEndian = endianFlag == 1;
    }
  }

  HeaderInfo write(BinaryCodec.LittleEndianWriter out, BHeader parsedHeader) {
    int endianFlag = 1;
    int intSize = 4;
    int sizeTSize = 4;
    int instructionSize = 4;
    int sizeOp = 6;
    int sizeA = 8;
    int sizeB = 9;
    int sizeC = 9;
    int numberSize = 8;

    if(parsedHeader != null && parsedHeader.debug) {
      System.out.println("-- HeaderWriter normalized to game.exe fixed header profile");
    }

    out.writeByte(0x1B); // magic
    out.writeByte(0x50); // version
    out.writeByte(endianFlag); // endian flag
    out.writeByte(intSize); // sizeof(int)
    out.writeByte(sizeTSize); // sizeof(size_t)
    out.writeByte(instructionSize); // sizeof(instruction)
    out.writeByte(sizeOp); // OP bits
    out.writeByte(sizeA); // A bits
    out.writeByte(sizeB); // B bits
    out.writeByte(sizeC); // C bits
    out.writeByte(numberSize); // sizeof(number)
    writeTestNumber(out, true);

    return new HeaderInfo(endianFlag, intSize, sizeTSize, instructionSize, sizeOp, sizeA, sizeB, sizeC, numberSize);
  }

  void writeTestNumber(BinaryCodec.LittleEndianWriter out, boolean littleEndian) {
    out.writeLong(TEST_NUMBER_BITS, littleEndian);
  }
}
