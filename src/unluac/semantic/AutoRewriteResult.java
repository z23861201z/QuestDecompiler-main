package unluac.semantic;

import java.util.ArrayList;
import java.util.List;

public class AutoRewriteResult {

  public String generatedAt = "";
  public String sourceNpcDir = "";
  public String rewrittenNpcDir = "";
  public int scannedFiles;
  public int rewrittenFiles;
  public int rewrittenLineCount;
  public int targetedQuestCount;
  public int targetedNpcCount;

  public final List<Integer> targetedQuestIds = new ArrayList<Integer>();
  public final List<String> targetedNpcFiles = new ArrayList<String>();
  public final List<String> unmatchedQuestIds = new ArrayList<String>();
  public final List<String> brokenReferences = new ArrayList<String>();
  public final List<String> remainingHardcodedGoalIndexes = new ArrayList<String>();
  public String validationStatus = "PASS";

  public String toJson() {
    StringBuilder sb = new StringBuilder();
    sb.append("{\n");
    sb.append("  \"generatedAt\": \"").append(escape(generatedAt)).append("\",\n");
    sb.append("  \"sourceNpcDir\": \"").append(escape(sourceNpcDir)).append("\",\n");
    sb.append("  \"rewrittenNpcDir\": \"").append(escape(rewrittenNpcDir)).append("\",\n");
    sb.append("  \"scannedFiles\": ").append(scannedFiles).append(",\n");
    sb.append("  \"rewrittenFiles\": ").append(rewrittenFiles).append(",\n");
    sb.append("  \"rewrittenLineCount\": ").append(rewrittenLineCount).append(",\n");
    sb.append("  \"targetedQuestCount\": ").append(targetedQuestCount).append(",\n");
    sb.append("  \"targetedNpcCount\": ").append(targetedNpcCount).append(",\n");
    sb.append("  \"targetedQuestIds\": ").append(toJsonIntArray(targetedQuestIds)).append(",\n");
    sb.append("  \"targetedNpcFiles\": ").append(toJsonStringArray(targetedNpcFiles)).append(",\n");
    sb.append("  \"remainingHardcodedGoalIndexes\": ").append(toJsonStringArray(remainingHardcodedGoalIndexes)).append(",\n");
    sb.append("  \"brokenReferences\": ").append(toJsonStringArray(brokenReferences)).append(",\n");
    sb.append("  \"unmatchedQuestIds\": ").append(toJsonStringArray(unmatchedQuestIds)).append(",\n");
    sb.append("  \"validationStatus\": \"").append(escape(validationStatus)).append("\"\n");
    sb.append("}\n");
    return sb.toString();
  }

  private static String toJsonIntArray(List<Integer> values) {
    StringBuilder sb = new StringBuilder();
    sb.append('[');
    for(int i = 0; i < values.size(); i++) {
      if(i > 0) {
        sb.append(", ");
      }
      sb.append(values.get(i).intValue());
    }
    sb.append(']');
    return sb.toString();
  }

  private static String toJsonStringArray(List<String> values) {
    StringBuilder sb = new StringBuilder();
    sb.append('[');
    for(int i = 0; i < values.size(); i++) {
      if(i > 0) {
        sb.append(", ");
      }
      sb.append('"').append(escape(values.get(i))).append('"');
    }
    sb.append(']');
    return sb.toString();
  }

  private static String escape(String text) {
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

