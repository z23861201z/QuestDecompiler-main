package unluac.semantic;

import java.nio.file.Paths;

public class ScriptTypeDetectorSmoke {

  public static void main(String[] args) throws Exception {
    if(args.length != 2) {
      System.out.println("Usage: java -cp build unluac.semantic.ScriptTypeDetectorSmoke <quest.luc> <npc_xxxx.luc>");
      return;
    }

    ScriptTypeDetector detector = new ScriptTypeDetector();
    ScriptTypeDetector.DetectionResult quest = detector.inspect(Paths.get(args[0]));
    ScriptTypeDetector.DetectionResult npc = detector.inspect(Paths.get(args[1]));

    System.out.println("quest.type=" + quest.scriptType);
    System.out.println("quest.hasQtAssignment=" + quest.hasQtAssignment);
    System.out.println("npc.type=" + npc.scriptType);
    System.out.println("npc.hasNpcSayFunction=" + npc.hasNpcSayFunction);
    System.out.println("npc.hasChkQStateFunction=" + npc.hasChkQStateFunction);

    if(quest.scriptType != ScriptTypeDetector.ScriptType.QUEST_DEFINITION) {
      throw new IllegalStateException("quest script type mismatch: " + quest.scriptType);
    }
    if(npc.scriptType != ScriptTypeDetector.ScriptType.NPC_SCRIPT) {
      throw new IllegalStateException("npc script type mismatch: " + npc.scriptType);
    }
  }
}
