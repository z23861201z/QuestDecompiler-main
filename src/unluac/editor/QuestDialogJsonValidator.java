package unluac.editor;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import unluac.semantic.QuestSemanticJson;

public class QuestDialogJsonValidator {

  private static final String INDENT = "  ";


  public static QuestDialogJsonModel parseAndValidate(String jsonText) {
    String text = jsonText == null ? "" : jsonText.trim();
    if(text.isEmpty()) {
      throw new IllegalStateException("dialog json is empty");
    }

    Map<String, Object> root = QuestSemanticJson.parseObject(text, "dialog_json", 0);

    QuestDialogJsonModel model = new QuestDialogJsonModel();
    model.start.addAll(parseSection(root, "start"));
    model.progress.addAll(parseSection(root, "progress"));
    model.complete.addAll(parseSection(root, "complete"));

    validateAnswerIds(model.start, "start");
    validateNoAnswer(model.progress, "progress");
    validateNoAnswer(model.complete, "complete");
    validateTextBranches(model.start, "start");
    validateTextBranches(model.progress, "progress");
    validateTextBranches(model.complete, "complete");

    return model;
  }

  public static String toJson(QuestDialogJsonModel model) {
    StringBuilder sb = new StringBuilder();
    sb.append("{\n");
    sb.append(INDENT).append("\"start\": ");
    appendSectionPretty(sb, model == null ? null : model.start, 1);
    sb.append(",\n");
    sb.append(INDENT).append("\"progress\": ");
    appendSectionPretty(sb, model == null ? null : model.progress, 1);
    sb.append(",\n");
    sb.append(INDENT).append("\"complete\": ");
    appendSectionPretty(sb, model == null ? null : model.complete, 1);
    sb.append("\n}");
    return sb.toString();
  }

  private static List<DialogLine> parseSection(Map<String, Object> root, String key) {
    Object value = root.get(key);
    if(value == null) {
      throw new IllegalStateException("dialog json missing section: " + key);
    }
    if(!(value instanceof List<?>)) {
      throw new IllegalStateException("dialog json section is not array: " + key);
    }

    List<DialogLine> out = new ArrayList<DialogLine>();
    List<?> items = (List<?>) value;
    for(int i = 0; i < items.size(); i++) {
      Object item = items.get(i);
      if(!(item instanceof Map<?, ?>)) {
        throw new IllegalStateException("dialog json line is not object: " + key + "[" + i + "]");
      }
      @SuppressWarnings("unchecked")
      Map<String, Object> map = (Map<String, Object>) item;

      Object typeObj = map.get("type");
      Object textObj = map.get("text");
      Object branchObj = map.get("branch");

      if(!(typeObj instanceof String)) {
        throw new IllegalStateException("dialog json missing type: " + key + "[" + i + "]");
      }
      if(!(textObj instanceof String)) {
        throw new IllegalStateException("dialog json missing text: " + key + "[" + i + "]");
      }

      String type = ((String) typeObj).trim();
      String text = (String) textObj;
      String branch = branchObj == null ? "" : String.valueOf(branchObj).trim();

      if(!DialogLine.TYPE_TEXT.equals(type) && !DialogLine.TYPE_ANSWER.equals(type)) {
        throw new IllegalStateException("dialog json invalid type: " + key + "[" + i + "] type=" + type);
      }

      DialogLine line = new DialogLine();
      line.type = type;
      line.text = text;
      line.branch = branch;
      out.add(line);
    }
    return out;
  }

  private static void validateAnswerIds(List<DialogLine> lines, String section) {
    for(int i = 0; i < lines.size(); i++) {
      DialogLine line = lines.get(i);
      if(line == null) {
        continue;
      }
      if(DialogLine.TYPE_ANSWER.equals(line.type)) {
        if(line.branch == null || line.branch.trim().isEmpty()) {
          throw new IllegalStateException("ANSWER line requires branch: " + section + "[" + i + "]");
        }
        String branch = line.branch.trim();
        if(!isAllowedAnswerBranch(branch)) {
          throw new IllegalStateException("ANSWER line branch must be YES/NO/IF_NO: " + section + "[" + i + "]");
        }
      }
    }
  }

  private static boolean isAllowedAnswerBranch(String branch) {
    return DialogLine.BRANCH_YES.equals(branch)
        || DialogLine.BRANCH_NO.equals(branch)
        || DialogLine.BRANCH_IF_NO.equals(branch);
  }

  private static void validateTextBranches(List<DialogLine> lines, String section) {
    for(int i = 0; i < lines.size(); i++) {
      DialogLine line = lines.get(i);
      if(line == null || !DialogLine.TYPE_TEXT.equals(line.type)) {
        continue;
      }
      String branch = line.branch == null ? "" : line.branch.trim();
      if(branch.isEmpty()) {
        continue;
      }
      if(!isAllowedTextBranch(branch)) {
        throw new IllegalStateException("TEXT line branch must be LAST_INFO or LAST_ANSWER_N: " + section + "[" + i + "]");
      }
    }
  }

  private static boolean isAllowedTextBranch(String branch) {
    if(DialogLine.BRANCH_LAST_INFO.equals(branch)) {
      return true;
    }
    if(branch.startsWith(DialogLine.BRANCH_LAST_ANSWER_PREFIX)) {
      String suffix = branch.substring(DialogLine.BRANCH_LAST_ANSWER_PREFIX.length());
      if(suffix.isEmpty()) {
        return false;
      }
      for(int i = 0; i < suffix.length(); i++) {
        char ch = suffix.charAt(i);
        if(ch < '0' || ch > '9') {
          return false;
        }
      }
      return true;
    }
    return false;
  }

  private static void validateNoAnswer(List<DialogLine> lines, String section) {
    for(int i = 0; i < lines.size(); i++) {
      DialogLine line = lines.get(i);
      if(line == null) {
        continue;
      }
      if(DialogLine.TYPE_ANSWER.equals(line.type)) {
        throw new IllegalStateException("section does not allow ANSWER type: " + section + "[" + i + "]");
      }
    }
  }

  private static void appendSectionPretty(StringBuilder sb, List<DialogLine> lines, int level) {
    String indent = indent(level);
    String childIndent = indent(level + 1);
    sb.append("[\n");
    if(lines != null) {
      for(int i = 0; i < lines.size(); i++) {
        if(i > 0) {
          sb.append(",\n");
        }
        DialogLine line = lines.get(i);
        String type = line == null ? DialogLine.TYPE_TEXT : line.type;
        String text = line == null ? "" : line.text;
        String branch = line == null ? "" : line.branch;

        sb.append(childIndent).append("{\n");
        sb.append(indent(level + 2)).append("\"type\": ").append(QuestSemanticJson.jsonString(type)).append(",\n");
        if(branch != null && !branch.trim().isEmpty()) {
          sb.append(indent(level + 2)).append("\"branch\": ").append(QuestSemanticJson.jsonString(branch)).append(",\n");
        }
        sb.append(indent(level + 2)).append("\"text\": ").append(QuestSemanticJson.jsonString(text)).append("\n");
        sb.append(childIndent).append('}');
      }
      if(!lines.isEmpty()) {
        sb.append("\n");
      }
    }
    sb.append(indent).append(']');
  }

  private static String indent(int level) {
    StringBuilder sb = new StringBuilder();
    for(int i = 0; i < level; i++) {
      sb.append(INDENT);
    }
    return sb.toString();
  }
}
