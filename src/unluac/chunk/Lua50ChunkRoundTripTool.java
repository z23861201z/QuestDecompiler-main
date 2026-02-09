package unluac.chunk;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

public class Lua50ChunkRoundTripTool {

  public static void main(String[] args) throws Exception {
    if(args.length < 1) {
      System.out.println("Usage: java -cp build unluac.chunk.Lua50ChunkRoundTripTool <input.luc> [output.luc]");
      return;
    }

    Path input = Paths.get(args[0]);
    Path output = args.length >= 2 ? Paths.get(args[1]) : input.resolveSibling(input.getFileName().toString() + ".roundtrip.luc");

    byte[] original = Files.readAllBytes(input);

    Lua50ChunkParser parser = new Lua50ChunkParser();
    LuaChunk chunk = parser.parse(original);

    Lua50ChunkSerializer serializer = new Lua50ChunkSerializer();
    byte[] rebuilt = serializer.serialize(chunk);

    Files.write(output, rebuilt);

    int diff = firstDiff(original, rebuilt);
    boolean same = diff < 0;

    System.out.println("input=" + input);
    System.out.println("output=" + output);
    System.out.println("orig_size=" + original.length);
    System.out.println("rebuilt_size=" + rebuilt.length);
    System.out.println("byte_perfect=" + same);
    if(!same) {
      int ov = original[diff] & 0xFF;
      int rv = rebuilt[diff] & 0xFF;
      System.out.println(String.format("first_diff_offset=0x%08X orig=%02X rebuilt=%02X", diff, ov, rv));
    }

    printAstSummary(chunk);

    if(!same) {
      throw new IllegalStateException("roundtrip is not byte-perfect");
    }
  }

  private static void printAstSummary(LuaChunk chunk) {
    Counter counter = new Counter();
    walk(chunk.mainFunction, counter);

    System.out.println("header.version=0x" + Integer.toHexString(chunk.header.version));
    System.out.println("header.endianFlag=" + chunk.header.endianFlag);
    System.out.println("header.intSize=" + chunk.header.intSize);
    System.out.println("header.sizeTSize=" + chunk.header.sizeTSize);
    System.out.println("header.instructionSize=" + chunk.header.instructionSize);
    System.out.println("header.numberSize=" + chunk.header.numberSize);
    System.out.println("header.encodedStrings=" + chunk.header.encodedStrings);

    System.out.println("ast.functionCount=" + counter.functionCount);
    System.out.println("ast.instructionCount=" + counter.instructionCount);
    System.out.println("ast.constantCount=" + counter.constantCount);
    System.out.println("ast.prototypeCount=" + counter.prototypeCount);
    System.out.println("ast.lineinfoCount=" + counter.lineinfoCount);
    System.out.println("ast.localvarCount=" + counter.localvarCount);
    System.out.println("ast.upvalueNameCount=" + counter.upvalueNameCount);
    System.out.println("ast.stringTableCount=" + chunk.stringTable.size());
  }

  private static void walk(LuaChunk.Function function, Counter counter) {
    counter.functionCount++;
    counter.instructionCount += function.code.size();
    counter.constantCount += function.constants.size();
    counter.prototypeCount += function.prototypes.size();
    counter.lineinfoCount += function.debug.lineinfo.size();
    counter.localvarCount += function.debug.localvars.size();
    counter.upvalueNameCount += function.debug.upvalueNames.size();

    for(LuaChunk.Function child : function.prototypes) {
      walk(child, counter);
    }
  }

  private static int firstDiff(byte[] a, byte[] b) {
    int n = Math.min(a.length, b.length);
    for(int i = 0; i < n; i++) {
      if(a[i] != b[i]) {
        return i;
      }
    }
    if(a.length != b.length) {
      return n;
    }
    return -1;
  }

  private static final class Counter {
    int functionCount;
    int instructionCount;
    int constantCount;
    int prototypeCount;
    int lineinfoCount;
    int localvarCount;
    int upvalueNameCount;
  }
}

