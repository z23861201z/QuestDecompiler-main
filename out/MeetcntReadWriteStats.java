import java.nio.file.*;
import unluac.chunk.*;
import unluac.semantic.*;
import unluac.decompile.*;

public class MeetcntReadWriteStats {
  public static void main(String[] args) throws Exception {
    byte[] data = Files.readAllBytes(Paths.get(args[0]));
    LuaChunk c = new Lua50ChunkParser().parse(data);
    Lua50InstructionCodec codec = new Lua50InstructionCodec(c.header.opSize, c.header.aSize, c.header.bSize, c.header.cSize);
    int rkBase = 1 << (c.header.bSize - 1);
    scan(c.mainFunction, codec, rkBase);
  }

  static void scan(LuaChunk.Function f, Lua50InstructionCodec codec, int rkBase) {
    int meetIdx = -1;
    for(int i=0;i<f.constants.size();i++) {
      LuaChunk.Constant k=f.constants.get(i);
      if(k.type==LuaChunk.Constant.Type.STRING && k.stringValue != null) {
        if("meetcnt".equals(k.stringValue.toDisplayString())) {
          meetIdx = i;
          break;
        }
      }
    }
    if(meetIdx >= 0) {
      int write = 0;
      int read = 0;
      for(int pc=0; pc<f.code.size(); pc++) {
        LuaChunk.Instruction ins = f.code.get(pc);
        Lua50InstructionCodec.DecodedInstruction d = codec.decode(ins.value);
        if(d.op == Op.SETTABLE) {
          if(d.B >= rkBase && d.B - rkBase == meetIdx) {
            write++;
            System.out.printf("WRITE path=%s pc=%d off=%d A=%d B=%d C=%d%n", f.path, pc, ins.offset, d.A, d.B, d.C);
          }
        }
        if(d.op == Op.GETTABLE) {
          if(d.C >= rkBase && d.C - rkBase == meetIdx) {
            read++;
            System.out.printf("READ path=%s pc=%d off=%d A=%d B=%d C=%d%n", f.path, pc, ins.offset, d.A, d.B, d.C);
          }
        }
      }
      System.out.printf("SUMMARY path=%s meetcntIndex=%d write=%d read=%d%n", f.path, meetIdx, write, read);
    }
    for(LuaChunk.Function child : f.prototypes) {
      scan(child, codec, rkBase);
    }
  }
}
