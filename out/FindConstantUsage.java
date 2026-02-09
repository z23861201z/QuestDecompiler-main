import java.nio.file.*;
import unluac.chunk.*;
import unluac.semantic.*;
import unluac.decompile.*;

public class FindConstantUsage {
  public static void main(String[] args) throws Exception {
    byte[] data = Files.readAllBytes(Paths.get(args[0]));
    LuaChunk c = new Lua50ChunkParser().parse(data);
    Lua50InstructionCodec codec = new Lua50InstructionCodec(c.header.opSize, c.header.aSize, c.header.bSize, c.header.cSize);
    int rkBase = 1 << c.header.bSize;
    scan(c.mainFunction, codec, rkBase);
  }

  static void scan(LuaChunk.Function f, Lua50InstructionCodec codec, int rkBase) {
    for(int pc=0; pc<f.code.size(); pc++) {
      LuaChunk.Instruction ins = f.code.get(pc);
      Lua50InstructionCodec.DecodedInstruction d = codec.decode(ins.value);
      if(d.op == null) continue;

      boolean hit = false;
      String role = "";

      if(d.op == Op.LOADK || d.op == Op.GETGLOBAL || d.op == Op.SETGLOBAL) {
        if(isMeetcntConstant(f, d.Bx)) {
          hit = true;
          role = "Bx";
        }
      }

      if(!hit && usesRK(d.op)) {
        if(isMeetcntRK(f, d.B, rkBase) || isMeetcntRK(f, d.C, rkBase)) {
          hit = true;
          role = "RK";
        }
      }

      if(hit) {
        System.out.printf("path=%s pc=%d off=%d op=%s A=%d B=%d C=%d Bx=%d sBx=%d role=%s%n",
            f.path, pc, ins.offset, d.op.name(), d.A, d.B, d.C, d.Bx, d.sBx, role);
      }
    }
    for(LuaChunk.Function child : f.prototypes) {
      scan(child, codec, rkBase);
    }
  }

  static boolean usesRK(Op op) {
    return op == Op.GETTABLE || op == Op.SETTABLE || op == Op.SELF || op == Op.EQ || op == Op.LT || op == Op.LE || op == Op.ADD || op == Op.SUB || op == Op.MUL || op == Op.DIV || op == Op.POW || op == Op.CONCAT;
  }

  static boolean isMeetcntRK(LuaChunk.Function f, int rk, int rkBase) {
    if(rk < rkBase) return false;
    int idx = rk - rkBase;
    return isMeetcntConstant(f, idx);
  }

  static boolean isMeetcntConstant(LuaChunk.Function f, int idx) {
    if(idx < 0 || idx >= f.constants.size()) return false;
    LuaChunk.Constant k = f.constants.get(idx);
    if(k.type != LuaChunk.Constant.Type.STRING || k.stringValue == null) return false;
    String s = k.stringValue.toDisplayString();
    return "meetcnt".equals(s);
  }
}
