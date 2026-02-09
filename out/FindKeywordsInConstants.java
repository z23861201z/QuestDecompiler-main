import java.nio.file.*;
import unluac.chunk.*;

public class FindKeywordsInConstants {
  public static void main(String[] args) throws Exception {
    String[] keys = {"chkQState", "QState", "SET_QUEST_STATE", "quest_state", "setQuestState"};
    byte[] data = Files.readAllBytes(Paths.get(args[0]));
    LuaChunk c = new Lua50ChunkParser().parse(data);
    LuaChunk.Function f = c.mainFunction;
    for(int i=0;i<f.constants.size();i++) {
      LuaChunk.Constant k=f.constants.get(i);
      if(k.type != LuaChunk.Constant.Type.STRING || k.stringValue == null) continue;
      String s = k.stringValue.toDisplayString();
      for(String key : keys) {
        if(s.contains(key)) {
          System.out.println(i + ":" + s);
        }
      }
    }
  }
}
