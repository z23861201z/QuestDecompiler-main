package unluac.semantic;

import unluac.decompile.Code50;
import unluac.decompile.Op;
import unluac.decompile.OpcodeMap;

public class Lua50InstructionCodec {

  private final Code50 extractor;
  private final OpcodeMap opMap;

  public Lua50InstructionCodec(int opSize, int aSize, int bSize, int cSize) {
    this.extractor = new Code50(opSize, aSize, bSize, cSize);
    this.opMap = new OpcodeMap(0x50);
  }

  public DecodedInstruction decode(int codepoint) {
    DecodedInstruction d = new DecodedInstruction();
    d.codepoint = codepoint;
    d.opcode = extractor.extract_op(codepoint);
    d.op = opMap.get(d.opcode);
    d.A = extractor.extract_A(codepoint);
    d.B = extractor.extract_B(codepoint);
    d.C = extractor.extract_C(codepoint);
    d.Bx = extractor.extract_Bx(codepoint);
    d.sBx = extractor.extract_sBx(codepoint);
    return d;
  }

  public static final class DecodedInstruction {
    public int codepoint;
    public int opcode;
    public Op op;
    public int A;
    public int B;
    public int C;
    public int Bx;
    public int sBx;

    public boolean isK(int value) {
      return value >= 256;
    }

    public int kIndex(int value) {
      return value - 256;
    }
  }
}

