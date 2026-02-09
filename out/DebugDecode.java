import unluac.chunk.*;
import unluac.semantic.*;
import unluac.decompile.*;
import java.nio.file.*;

public class DebugDecode {
  public static void main(String[] args) throws Exception {
    byte[] data = Files.readAllBytes(Paths.get(args[0]));
    Lua50ChunkParser p = new Lua50ChunkParser();
    LuaChunk c = p.parse(data);
    LuaChunk.Function f = c.mainFunction;
    Lua50InstructionCodec codec = new Lua50InstructionCodec(c.header.opSize, c.header.aSize, c.header.bSize, c.header.cSize);
    int limit = Integer.parseInt(args[1]);
    for(int pc=0; pc<limit && pc < f.code.size(); pc++) {
      LuaChunk.Instruction ins = f.code.get(pc);
      Lua50InstructionCodec.DecodedInstruction d = codec.decode(ins.value);
      String op = d.op == null ? "?" : d.op.name();
      System.out.printf("%4d off=%d %-10s A=%d B=%d C=%d Bx=%d sBx=%d", pc, ins.offset, op, d.A,d.B,d.C,d.Bx,d.sBx);
      if(d.op == Op.LOADK || d.op == Op.GETGLOBAL || d.op == Op.SETGLOBAL) {
        if(d.Bx >=0 && d.Bx < f.constants.size()) {
          LuaChunk.Constant k = f.constants.get(d.Bx);
          if(k.type == LuaChunk.Constant.Type.STRING) {
            System.out.print(" K='" + k.stringValue.toDisplayString() + "'");
          } else if(k.type == LuaChunk.Constant.Type.NUMBER) {
            System.out.print(" K=" + k.numberValue);
          } else {
            System.out.print(" KTYPE=" + k.type);
          }
        }
      }
      System.out.println();
    }
  }
}