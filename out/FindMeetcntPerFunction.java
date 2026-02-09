import java.nio.file.*;
import unluac.chunk.*;
import unluac.semantic.*;
import unluac.decompile.*;

public class FindMeetcntPerFunction {
  public static void main(String[] args) throws Exception {
    byte[] data = Files.readAllBytes(Paths.get(args[0]));
    LuaChunk c = new Lua50ChunkParser().parse(data);
    Lua50InstructionCodec codec = new Lua50InstructionCodec(c.header.opSize, c.header.aSize, c.header.bSize, c.header.cSize);
    int rkBase = 1 << (c.header.bSize - 1);
    scan(c.mainFunction, codec, rkBase);
  }

  static void scan(LuaChunk.Function f, Lua50InstructionCodec codec, int rkBase) {
    java.util.List<Integer> meetIdx = new java.util.ArrayList<Integer>();
    for(int i=0;i<f.constants.size();i++) {
      LuaChunk.Constant k=f.constants.get(i);
      if(k.type==LuaChunk.Constant.Type.STRING && k.stringValue != null) {
        String s=k.stringValue.toDisplayString();
        if("meetcnt".equals(s)) {
          meetIdx.add(i);
        }
      }
    }
    if(!meetIdx.isEmpty()) {
      System.out.println("function=" + f.path + " meetcntConstIndexes=" + meetIdx);
      for(int pc=0; pc<f.code.size(); pc++) {
        LuaChunk.Instruction ins=f.code.get(pc);
        Lua50InstructionCodec.DecodedInstruction d=codec.decode(ins.value);
        if(d.op==null) continue;
        for(Integer idxObj : meetIdx) {
          int idx=idxObj.intValue();
          boolean hit=false;
          String where="";
          if(d.Bx==idx) {hit=true; where+="Bx ";}
          if(d.B>=rkBase && d.B-rkBase==idx) {hit=true; where+="B(RK) ";}
          if(d.C>=rkBase && d.C-rkBase==idx) {hit=true; where+="C(RK) ";}
          if(hit) {
            System.out.printf("  pc=%d off=%d op=%s A=%d B=%d C=%d Bx=%d sBx=%d where=%s%n", pc, ins.offset, d.op.name(), d.A,d.B,d.C,d.Bx,d.sBx, where);
          }
        }
      }
    }
    for(LuaChunk.Function child : f.prototypes) scan(child, codec, rkBase);
  }
}
