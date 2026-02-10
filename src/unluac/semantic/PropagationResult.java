package unluac.semantic;

import java.util.ArrayList;
import java.util.List;

public class PropagationResult {

  public String generatedAt = "";
  public int totalPropagationNodes;
  public final List<QuestPropagationItem> quests = new ArrayList<QuestPropagationItem>();

  public static final class QuestPropagationItem {
    public int questId;
    public final List<String> modificationTypes = new ArrayList<String>();
    public final List<String> affectedNpcFiles = new ArrayList<String>();
    public final List<PropagationEdge> propagationChains = new ArrayList<PropagationEdge>();
    public String highestRiskLevel = "LOW";
    public boolean rewriteRequired;
  }

  public String toJson() {
    StringBuilder sb = new StringBuilder();
    sb.append("{\n");
    sb.append("  \"generatedAt\": \"").append(escapeJson(generatedAt)).append("\",\n");
    sb.append("  \"totalPropagationNodes\": ").append(totalPropagationNodes).append(",\n");
    sb.append("  \"quests\": [");
    if(!quests.isEmpty()) {
      sb.append("\n");
    }
    for(int i = 0; i < quests.size(); i++) {
      if(i > 0) {
        sb.append(",\n");
      }
      QuestPropagationItem item = quests.get(i);
      sb.append("    {\n");
      sb.append("      \"questId\": ").append(item.questId).append(",\n");
      sb.append("      \"modificationTypes\": ").append(toJsonStringArray(item.modificationTypes)).append(",\n");
      sb.append("      \"affectedNpcFiles\": ").append(toJsonStringArray(item.affectedNpcFiles)).append(",\n");
      sb.append("      \"propagationChains\": [");
      if(!item.propagationChains.isEmpty()) {
        sb.append("\n");
      }
      for(int j = 0; j < item.propagationChains.size(); j++) {
        if(j > 0) {
          sb.append(",\n");
        }
        PropagationEdge edge = item.propagationChains.get(j);
        sb.append("        {\n");
        sb.append("          \"questId\": ").append(edge.questId).append(",\n");
        sb.append("          \"fromNode\": \"").append(escapeJson(edge.fromNode)).append("\",\n");
        sb.append("          \"toNode\": \"").append(escapeJson(edge.toNode)).append("\",\n");
        sb.append("          \"rule\": \"").append(escapeJson(edge.rule)).append("\",\n");
        sb.append("          \"riskLevel\": \"").append(escapeJson(edge.riskLevel)).append("\"\n");
        sb.append("        }");
      }
      if(!item.propagationChains.isEmpty()) {
        sb.append("\n      ");
      }
      sb.append("],\n");
      sb.append("      \"highestRiskLevel\": \"").append(escapeJson(item.highestRiskLevel)).append("\",\n");
      sb.append("      \"rewriteRequired\": ").append(item.rewriteRequired).append("\n");
      sb.append("    }");
    }
    if(!quests.isEmpty()) {
      sb.append("\n");
    }
    sb.append("  ]\n");
    sb.append("}\n");
    return sb.toString();
  }

  private static String toJsonStringArray(List<String> values) {
    StringBuilder sb = new StringBuilder();
    sb.append('[');
    for(int i = 0; i < values.size(); i++) {
      if(i > 0) {
        sb.append(", ");
      }
      sb.append('"').append(escapeJson(values.get(i))).append('"');
    }
    sb.append(']');
    return sb.toString();
  }

  private static String escapeJson(String text) {
    if(text == null) {
      return "";
    }
    return text
        .replace("\\", "\\\\")
        .replace("\"", "\\\"")
        .replace("\r", "\\r")
        .replace("\n", "\\n");
  }
}

