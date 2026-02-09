import java.nio.file.*;
import unluac.chunk.*;

public class FindConstStrings {
  public static void main(String[] args) throws Exception {
    byte[] data = Files.readAllBytes(Paths.get(args[0]));
    LuaChunk c = new Lua50ChunkParser().parse(data);
    LuaChunk.Function f = c.mainFunction;
    for(int i=0;i<f.constants.size();i++) {
      LuaChunk.Constant k=f.constants.get(i);
      if(k.type==LuaChunk.Constant.Type.STRING && k.stringValue!=null) {
        String s=k.stringValue.toDisplayString();
        if(s.toLowerCase().contains("meet") || s.toLowerCase().contains("item") || s.toLowerCase().contains("goal") || s.toLowerCase().contains("kill")) {
          System.out.println(i+":"+s);
        }
      }
    }
  }
}
