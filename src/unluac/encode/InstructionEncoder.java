package unluac.encode;

import unluac.parse.LFunction;

final class InstructionEncoder {

  void writeInstructions(BinaryCodec.LittleEndianWriter out, LFunction function, boolean littleEndian) {
    int[] code = function.code;
    out.writeInt(code.length, littleEndian);
    for(int instruction : code) {
      out.writeInt(instruction, littleEndian);
    }
  }
}

