package unluac.editor;

import java.util.ArrayList;
import java.util.List;

import unluac.semantic.QuestSemanticJson;

public class QuestEditorValidator {

  public static void validateJsonIntArray(String json, String fieldName) {
    QuestSemanticJson.parseIntArray(nonNull(json), fieldName, 0);
  }

  public static List<Integer> parseIntArray(String json) {
    return new ArrayList<Integer>(QuestSemanticJson.parseIntArray(nonNull(json), "array", 0));
  }

  private static String nonNull(String text) {
    return text == null ? "[]" : text.trim();
  }
}

