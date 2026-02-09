package unluac.semantic;

import java.nio.file.Paths;

public class NpcSemanticExtractorSmoke {

  public static void main(String[] args) throws Exception {
    if(args.length != 1) {
      System.out.println("Usage: java -cp build unluac.semantic.NpcSemanticExtractorSmoke <npc_xxxx.luc>");
      return;
    }

    NpcSemanticExtractor extractor = new NpcSemanticExtractor();
    NpcScriptModel model = extractor.extract(Paths.get(args[0]));

    System.out.println("npcId=" + model.npcId);
    System.out.println("branchCount=" + model.branches.size());
    System.out.println("relatedQuestIds=" + model.relatedQuestIds.size());

    int npcSayCount = 0;
    int addQuestBtnCount = 0;
    int setQuestStateCount = 0;
    int checkItemCntCount = 0;
    for(NpcScriptModel.DialogBranch branch : model.branches) {
      if(branch == null || branch.action == null) {
        continue;
      }
      if("NPC_SAY".equals(branch.action)) {
        npcSayCount++;
      } else if("ADD_QUEST_BTN".equals(branch.action)) {
        addQuestBtnCount++;
      } else if("SET_QUEST_STATE".equals(branch.action)) {
        setQuestStateCount++;
      } else if("CHECK_ITEM_CNT".equals(branch.action)) {
        checkItemCntCount++;
      }
    }

    System.out.println("NPC_SAY=" + npcSayCount);
    System.out.println("ADD_QUEST_BTN=" + addQuestBtnCount);
    System.out.println("SET_QUEST_STATE=" + setQuestStateCount);
    System.out.println("CHECK_ITEM_CNT=" + checkItemCntCount);
  }
}
