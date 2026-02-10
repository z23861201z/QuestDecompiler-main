package unluac.semantic;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class QuestNode {

  public int questId;
  public QuestGoal goal = new QuestGoal();
  public final List<QuestSemanticModel.Reward> reward = new ArrayList<QuestSemanticModel.Reward>();
  public int needLevel;
  public final List<String> referencedNpcFiles = new ArrayList<String>();
  public final List<String> dependencyTypes = new ArrayList<String>();
  public String riskLevel = "LOW";
  public boolean propagationRequired;

  public final List<NpcNode> referencedNpcs = new ArrayList<NpcNode>();

  void linkNpc(NpcNode npcNode) {
    if(npcNode == null) {
      return;
    }
    if(!referencedNpcs.contains(npcNode)) {
      referencedNpcs.add(npcNode);
    }
    if(npcNode.filePath != null && !npcNode.filePath.isEmpty() && !referencedNpcFiles.contains(npcNode.filePath)) {
      referencedNpcFiles.add(npcNode.filePath);
      Collections.sort(referencedNpcFiles, String.CASE_INSENSITIVE_ORDER);
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

  void mergeRiskLevel(String candidate) {
    this.riskLevel = highestRisk(this.riskLevel, candidate);
  }

  static String highestRisk(String left, String right) {
    int l = riskRank(left);
    int r = riskRank(right);
    return l >= r ? normalizeRisk(left) : normalizeRisk(right);
  }

  static int riskRank(String risk) {
    String normalized = normalizeRisk(risk);
    if("HIGH".equals(normalized)) {
      return 3;
    }
    if("MEDIUM".equals(normalized)) {
      return 2;
    }
    return 1;
  }

  static String normalizeRisk(String risk) {
    if(risk == null) {
      return "LOW";
    }
    String up = risk.trim().toUpperCase();
    if("HIGH".equals(up) || "MEDIUM".equals(up)) {
      return up;
    }
    return "LOW";
  }
}

