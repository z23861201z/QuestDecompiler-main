import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import unluac.chunk.Lua50ChunkParser;
import unluac.chunk.LuaChunk;
import unluac.decompile.Op;
import unluac.semantic.Lua50InstructionCodec;

public class LucStructureStatsTool {

  private static final class Stats {
    long fileSize;
    long constantTotal;
    long newtable50Count;
    long settableCount;
    long prototypeTotal;
    long functionTotal;
    long instructionTotal;
  }

  public static void main(String[] args) throws Exception {
    if(args.length != 1) {
      System.err.println("Usage: java -cp <cp> LucStructureStatsTool <input.luc>");
      System.exit(1);
    }

    Path input = Paths.get(args[0]);
    byte[] data = Files.readAllBytes(input);
    LuaChunk chunk = new Lua50ChunkParser().parse(data);
    Lua50InstructionCodec codec = new Lua50InstructionCodec(
        chunk.header.opSize,
        chunk.header.aSize,
        chunk.header.bSize,
        chunk.header.cSize
    );

    Stats stats = new Stats();
    stats.fileSize = data.length;
    walk(chunk.mainFunction, codec, stats);

    System.out.println("file=" + input.toAbsolutePath());
    System.out.println("file_size=" + stats.fileSize);
    System.out.println("constant_total=" + stats.constantTotal);
    System.out.println("newtable50_total=" + stats.newtable50Count);
    System.out.println("settable_total=" + stats.settableCount);
    System.out.println("prototype_total=" + stats.prototypeTotal);
    System.out.println("function_total=" + stats.functionTotal);
    System.out.println("instruction_total=" + stats.instructionTotal);
  }

  private static void walk(LuaChunk.Function function, Lua50InstructionCodec codec, Stats stats) {
    if(function == null) {
      return;
    }

    stats.functionTotal++;
    stats.constantTotal += function.constants.size();
    stats.prototypeTotal += function.prototypes.size();
    stats.instructionTotal += function.code.size();

    for(LuaChunk.Instruction instruction : function.code) {
      Lua50InstructionCodec.DecodedInstruction decoded = codec.decode(instruction.value);
      Op op = decoded.op;
      if(op == Op.NEWTABLE50) {
        stats.newtable50Count++;
      }
      if(op == Op.SETTABLE) {
        stats.settableCount++;
      }
    }

    for(LuaChunk.Function child : function.prototypes) {
      walk(child, codec, stats);
    }
  }
}