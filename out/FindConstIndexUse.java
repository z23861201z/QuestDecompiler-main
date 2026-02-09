import java.nio.file.*;
import unluac.chunk.*;
import unluac.semantic.*;
import unluac.decompile.*;

public class FindConstIndexUse {
  public static void main(String[] args) throws Exception {
    byte[] data = Files.readAllBytes(Paths.get(args[0]));
    LuaChunk c = new Lua50ChunkParser().parse(data);
    Lua50InstructionCodec codec = new Lua50InstructionCodec(c.header.opSize, c.header.aSize, c.header.bSize, c.header.cSize);
    int rkBase = 1 << c.header.bSize;
    int target = Integer.parseInt(args[1]);
    scan(c.mainFunction, codec, rkBase, target);
  }

  static void scan(LuaChunk.Function f, Lua50InstructionCodec codec, int rkBase, int target) {
    for(int pc=0; pc<f.code.size(); pc++) {
      LuaChunk.Instruction ins = f.code.get(pc);
      Lua50InstructionCodec.DecodedInstruction d = codec.decode(ins.value);
      if(d.op == null) continue;
      boolean hit=false;
      String where="";
      if(d.Bx == target) {hit=true; where+="Bx ";}
      if(d.B >= rkBase && d.B-rkBase==target) {hit=true; where+="B(RK) ";}
      if(d.C >= rkBase && d.C-rkBase==target) {hit=true; where+="C(RK) ";}
      if(hit) {
        System.out.printf("%s pc=%d off=%d op=%s A=%d B=%d C=%d Bx=%d sBx=%d %s%n", f.path, pc, ins.offset, d.op.name(), d.A,d.B,d.C,d.Bx,d.sBx, where);
      }
    }
    for(LuaChunk.Function child : f.prototypes) scan(child, codec, rkBase, target);
  }
}
