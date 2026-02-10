package unluac.semantic;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class NpcNode {

  public int npcId;
  public String filePath = "";
  public final List<Integer> referencedQuestIds = new ArrayList<Integer>();
  public final List<Integer> hardcodedGoalIndexes = new ArrayList<Integer>();
  public final List<String> dependencyTypes = new ArrayList<String>();
  public String riskLevel = "LOW";

  public final List<QuestNode> referencedQuests = new ArrayList<QuestNode>();

  void linkQuest(QuestNode questNode) {
    if(questNode == null) {
      return;
    }
    if(!referencedQuests.contains(questNode)) {
      referencedQuests.add(questNode);
    }
    if(!referencedQuestIds.contains(Integer.valueOf(questNode.questId))) {
      referencedQuestIds.add(Integer.valueOf(questNode.questId));
      Collections.sort(referencedQuestIds);
    }
  }

  void addDependencyType(String dependencyType) {
    if(dependencyType == null || dependencyType.trim().isEmpty()) {
      return;
    }
    if(!dependencyTypes.contains(dependencyType)) {
      dependencyTypes.add(dependencyType);
      Collections.sort(dependencyTypes, String.CASE_INSENSITIVE_ORDER);
    }
  }

  void addHardcodedGoalIndex(int index) {
    if(index <= 0) {
      return;
    }
    Integer boxed = Integer.valueOf(index);
    if(!hardcodedGoalIndexes.contains(boxed)) {
      hardcodedGoalIndexes.add(boxed);
      Collections.sort(hardcodedGoalIndexes);
    }
  }

  void mergeRiskLevel(String candidate) {
    this.riskLevel = QuestNode.highestRisk(this.riskLevel, candidate);
  }
}

