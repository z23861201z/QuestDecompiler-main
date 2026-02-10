package unluac.semantic;

import java.util.ArrayList;
import java.util.List;

public class FixerResult {

  public String patternType = "";
  public int targetedCount;
  public int fixedCount;
  public int skippedCount;
  public int rewrittenLineCount;
  public final List<String> fixedFiles = new ArrayList<String>();
  public final List<String> skippedFiles = new ArrayList<String>();
  public final List<String> errors = new ArrayList<String>();

  public String toJson(String indent) {
    String next = indent + "  ";
    StringBuilder sb = new StringBuilder();
    sb.append(indent).append("{\n");
    sb.append(next).append("\"patternType\": \"").append(escape(patternType)).append("\",\n");
    sb.append(next).append("\"targetedCount\": ").append(targetedCount).append(",\n");
    sb.append(next).append("\"fixedCount\": ").append(fixedCount).append(",\n");
    sb.append(next).append("\"skippedCount\": ").append(skippedCount).append(",\n");
    sb.append(next).append("\"rewrittenLineCount\": ").append(rewrittenLineCount).append(",\n");
    sb.append(next).append("\"fixedFiles\": ").append(toJsonStringArray(fixedFiles)).append(",\n");
    sb.append(next).append("\"skippedFiles\": ").append(toJsonStringArray(skippedFiles)).append(",\n");
    sb.append(next).append("\"errors\": ").append(toJsonStringArray(errors)).append("\n");
    sb.append(indent).append("}");
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

