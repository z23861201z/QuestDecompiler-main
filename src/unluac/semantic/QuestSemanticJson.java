package unluac.semantic;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public class QuestSemanticJson {

  public static String toJson(List<QuestSemanticModel> quests) {
    StringBuilder sb = new StringBuilder();
    sb.append("[\n");
    for(int i = 0; i < quests.size(); i++) {
      QuestSemanticModel model = quests.get(i);
      if(i > 0) {
        sb.append(",\n");
      }
      appendQuest(sb, model, "  ");
    }
    sb.append("\n]\n");
    return sb.toString();
  }

  public static String toJsonArrayInt(List<Integer> values) {
    StringBuilder sb = new StringBuilder();
    sb.append('[');
    for(int i = 0; i < values.size(); i++) {
      if(i > 0) {
        sb.append(',');
      }
      sb.append(values.get(i).intValue());
    }
    sb.append(']');
    return sb.toString();
  }

  public static String toJsonArrayString(List<String> values) {
    StringBuilder sb = new StringBuilder();
    sb.append('[');
    for(int i = 0; i < values.size(); i++) {
      if(i > 0) {
        sb.append(',');
      }
      sb.append(jsonString(values.get(i)));
    }
    sb.append(']');
    return sb.toString();
  }

  public static String toJsonObject(Map<String, Object> map) {
    StringBuilder sb = new StringBuilder();
    appendObject(sb, map, "");
    return sb.toString();
  }

  private static void appendQuest(StringBuilder sb, QuestSemanticModel model, String indent) {
    sb.append(indent).append("{\n");
    sb.append(indent).append("  \"questId\": ").append(model.questId).append(",\n");
    sb.append(indent).append("  \"title\": ").append(jsonString(model.title)).append(",\n");
    sb.append(indent).append("  \"description\": ").append(jsonString(model.description)).append(",\n");
    sb.append(indent).append("  \"preQuestIds\": ").append(toJsonArrayInt(model.preQuestIds)).append(",\n");

    sb.append(indent).append("  \"rewards\": [\n");
    for(int i = 0; i < model.rewards.size(); i++) {
      QuestSemanticModel.Reward reward = model.rewards.get(i);
      if(i > 0) {
        sb.append(",\n");
      }
      sb.append(indent).append("    {\n");
      sb.append(indent).append("      \"type\": ").append(jsonString(reward.type)).append(",\n");
      sb.append(indent).append("      \"id\": ").append(reward.id).append(",\n");
      sb.append(indent).append("      \"count\": ").append(reward.count).append(",\n");
      sb.append(indent).append("      \"money\": ").append(reward.money).append(",\n");
      sb.append(indent).append("      \"exp\": ").append(reward.exp).append(",\n");
      sb.append(indent).append("      \"fame\": ").append(reward.fame).append(",\n");
      sb.append(indent).append("      \"pvppoint\": ").append(reward.pvppoint).append(",\n");
      sb.append(indent).append("      \"skillIds\": ").append(toJsonArrayInt(reward.skillIds)).append(",\n");
      sb.append(indent).append("      \"fieldOrder\": ").append(toJsonArrayString(reward.fieldOrder)).append(",\n");
      sb.append(indent).append("      \"extraFields\": ");
      appendObject(sb, reward.extraFields, indent + "      ");
      sb.append("\n");
      sb.append(indent).append("    }");
    }
    sb.append("\n").append(indent).append("  ],\n");

    sb.append(indent).append("  \"dialogLines\": ").append(toJsonArrayString(model.dialogLines)).append(",\n");
    sb.append(indent).append("  \"dialogTree\": ");
    appendDialogTree(sb, model.dialogTree, indent + "  ");
    sb.append(",\n");
    sb.append(indent).append("  \"goalSemantic\": ");
    appendGoal(sb, model.goal, indent + "  ");
    sb.append(",\n");
    sb.append(indent).append("  \"conditions\": ");
    appendObject(sb, model.conditions, indent + "  ");
    sb.append(",\n");
    sb.append(indent).append("  \"completionConditions\": ");
    appendObject(sb, model.completionConditions, indent + "  ");
    sb.append("\n");
    sb.append(indent).append("}");
  }

  private static void appendObject(StringBuilder sb, Object value, String indent) {
    if(value == null) {
      sb.append("null");
      return;
    }
    if(value instanceof String) {
      sb.append(jsonString((String) value));
      return;
    }
    if(value instanceof Number || value instanceof Boolean) {
      sb.append(String.valueOf(value));
      return;
    }
    if(value instanceof List<?>) {
      @SuppressWarnings("unchecked")
      List<Object> list = (List<Object>) value;
      sb.append('[');
      for(int i = 0; i < list.size(); i++) {
        if(i > 0) {
          sb.append(',');
        }
        appendObject(sb, list.get(i), indent + "  ");
      }
      sb.append(']');
      return;
    }
    if(value instanceof Map<?, ?>) {
      @SuppressWarnings("unchecked")
      Map<String, Object> map = (Map<String, Object>) value;
      sb.append('{');
      int i = 0;
      for(Map.Entry<String, Object> entry : map.entrySet()) {
        if(i > 0) {
          sb.append(',');
        }
        sb.append(jsonString(entry.getKey())).append(':');
        appendObject(sb, entry.getValue(), indent + "  ");
        i++;
      }
      sb.append('}');
      return;
    }
    sb.append(jsonString(String.valueOf(value)));
  }

  private static void appendDialogTree(StringBuilder sb, QuestDialogTree tree, String indent) {
    if(tree == null || tree.nodes == null || tree.nodes.isEmpty()) {
      sb.append("{\"nodes\":[]}");
      return;
    }
    sb.append("{\n");
    sb.append(indent).append("\"nodes\": [\n");
    for(int i = 0; i < tree.nodes.size(); i++) {
      DialogNode node = tree.nodes.get(i);
      if(i > 0) {
        sb.append(",\n");
      }
      sb.append(indent).append("  {\n");
      sb.append(indent).append("    \"index\": ").append(i).append(",\n");
      sb.append(indent).append("    \"text\": ").append(jsonString(node == null ? "" : node.text)).append(",\n");

      sb.append(indent).append("    \"options\": [");
      if(node != null && node.options != null && !node.options.isEmpty()) {
        sb.append("\n");
        for(int opt = 0; opt < node.options.size(); opt++) {
          DialogOption option = node.options.get(opt);
          if(opt > 0) {
            sb.append(",\n");
          }
          sb.append(indent).append("      {")
              .append("\"optionText\": ").append(jsonString(option == null ? "" : option.optionText)).append(", ")
              .append("\"nextNodeIndex\": ").append(option == null ? -1 : option.nextNodeIndex)
              .append("}");
        }
        sb.append("\n").append(indent).append("    ");
      }
      sb.append("]\n");

      sb.append(indent).append("  }");
    }
    sb.append("\n").append(indent).append("]\n");
    sb.append(indent.substring(0, Math.max(indent.length() - 2, 0))).append("}");
  }

  private static void appendGoal(StringBuilder sb, QuestGoal goal, String indent) {
    if(goal == null) {
      sb.append("{\"needLevel\":0,\"items\":[],\"monsters\":[]}");
      return;
    }
    sb.append("{\n");
    sb.append(indent).append("\"needLevel\": ").append(goal.needLevel).append(",\n");

    sb.append(indent).append("\"items\": [");
    if(goal.items.isEmpty()) {
      sb.append("],\n");
    } else {
      sb.append("\n");
      for(int i = 0; i < goal.items.size(); i++) {
        ItemRequirement item = goal.items.get(i);
        if(i > 0) {
          sb.append(",\n");
        }
        sb.append(indent).append("  {")
            .append("\"meetCount\": ").append(item.meetCount).append(", ")
            .append("\"itemId\": ").append(item.itemId).append(", ")
            .append("\"itemCount\": ").append(item.itemCount)
            .append("}");
      }
      sb.append("\n").append(indent).append("],\n");
    }

    sb.append(indent).append("\"monsters\": [");
    if(goal.monsters.isEmpty()) {
      sb.append("]\n");
    } else {
      sb.append("\n");
      for(int i = 0; i < goal.monsters.size(); i++) {
        KillRequirement monster = goal.monsters.get(i);
        if(i > 0) {
          sb.append(",\n");
        }
        sb.append(indent).append("  {")
            .append("\"monsterId\": ").append(monster.monsterId).append(", ")
            .append("\"killCount\": ").append(monster.killCount)
            .append("}");
      }
      sb.append("\n").append(indent).append("]\n");
    }
    sb.append(indent.substring(0, Math.max(indent.length() - 2, 0))).append("}");
  }

  public static String jsonString(String value) {
    if(value == null) {
      return "null";
    }
    StringBuilder sb = new StringBuilder();
    sb.append('"');
    for(int i = 0; i < value.length(); i++) {
      char ch = value.charAt(i);
      switch(ch) {
        case '"':
          sb.append("\\\"");
          break;
        case '\\':
          sb.append("\\\\");
          break;
        case '\b':
          sb.append("\\b");
          break;
        case '\f':
          sb.append("\\f");
          break;
        case '\n':
          sb.append("\\n");
          break;
        case '\r':
          sb.append("\\r");
          break;
        case '\t':
          sb.append("\\t");
          break;
        default:
          if(ch < 0x20) {
            sb.append(String.format("\\u%04X", (int) ch));
          } else {
            sb.append(ch);
          }
      }
    }
    sb.append('"');
    return sb.toString();
  }

  public static List<Integer> parseIntArray(String json, String field, int row) {
    JsonTok tok = new JsonTok(json, field, row);
    Object value = tok.parseValue();
    if(!(value instanceof List<?>)) {
      throw new IllegalStateException("row " + row + " " + field + " must be JSON array<int>");
    }
    List<?> raw = (List<?>) value;
    List<Integer> out = new ArrayList<Integer>();
    for(Object item : raw) {
      if(!(item instanceof Number)) {
        throw new IllegalStateException("row " + row + " " + field + " element must be number");
      }
      out.add(Integer.valueOf(((Number) item).intValue()));
    }
    return out;
  }

  public static List<String> parseStringArray(String json, String field, int row) {
    JsonTok tok = new JsonTok(json, field, row);
    Object value = tok.parseValue();
    if(!(value instanceof List<?>)) {
      throw new IllegalStateException("row " + row + " " + field + " must be JSON array<string>");
    }
    List<?> raw = (List<?>) value;
    List<String> out = new ArrayList<String>();
    for(Object item : raw) {
      if(!(item instanceof String)) {
        throw new IllegalStateException("row " + row + " " + field + " element must be string");
      }
      out.add((String) item);
    }
    return out;
  }

  public static Map<String, Object> parseObject(String json, String field, int row) {
    JsonTok tok = new JsonTok(json, field, row);
    Object value = tok.parseValue();
    if(!(value instanceof Map<?, ?>)) {
      throw new IllegalStateException("row " + row + " " + field + " must be JSON object");
    }
    @SuppressWarnings("unchecked")
    Map<String, Object> map = (Map<String, Object>) value;
    return map;
  }

  private static final class JsonTok {
    private final String text;
    private final String field;
    private final int row;
    private int index;

    JsonTok(String text, String field, int row) {
      this.text = text == null ? "" : text.trim();
      this.field = field;
      this.row = row;
      this.index = 0;
    }

    Object parseValue() {
      skipWs();
      Object v = readValue();
      skipWs();
      if(index != text.length()) {
        fail("trailing JSON content");
      }
      return v;
    }

    private Object readValue() {
      if(index >= text.length()) {
        fail("unexpected end");
      }
      char ch = text.charAt(index);
      if(ch == '"') {
        return readString();
      }
      if(ch == '{') {
        return readObject();
      }
      if(ch == '[') {
        return readArray();
      }
      if(ch == 't' && text.startsWith("true", index)) {
        index += 4;
        return Boolean.TRUE;
      }
      if(ch == 'f' && text.startsWith("false", index)) {
        index += 5;
        return Boolean.FALSE;
      }
      if(ch == 'n' && text.startsWith("null", index)) {
        index += 4;
        return null;
      }
      return readNumber();
    }

    private Map<String, Object> readObject() {
      expect('{');
      skipWs();
      Map<String, Object> map = new LinkedHashMap<String, Object>();
      if(peek('}')) {
        expect('}');
        return map;
      }
      while(true) {
        skipWs();
        String key = readString();
        skipWs();
        expect(':');
        skipWs();
        Object value = readValue();
        map.put(key, value);
        skipWs();
        if(peek(',')) {
          expect(',');
          continue;
        }
        expect('}');
        break;
      }
      return map;
    }

    private List<Object> readArray() {
      expect('[');
      skipWs();
      List<Object> list = new ArrayList<Object>();
      if(peek(']')) {
        expect(']');
        return list;
      }
      while(true) {
        skipWs();
        list.add(readValue());
        skipWs();
        if(peek(',')) {
          expect(',');
          continue;
        }
        expect(']');
        break;
      }
      return list;
    }

    private String readString() {
      expect('"');
      StringBuilder sb = new StringBuilder();
      while(index < text.length()) {
        char ch = text.charAt(index++);
        if(ch == '"') {
          return sb.toString();
        }
        if(ch == '\\') {
          if(index >= text.length()) {
            fail("bad string escape");
          }
          char esc = text.charAt(index++);
          switch(esc) {
            case '"': sb.append('"'); break;
            case '\\': sb.append('\\'); break;
            case '/': sb.append('/'); break;
            case 'b': sb.append('\b'); break;
            case 'f': sb.append('\f'); break;
            case 'n': sb.append('\n'); break;
            case 'r': sb.append('\r'); break;
            case 't': sb.append('\t'); break;
            case 'u': {
              if(index + 4 > text.length()) {
                fail("bad unicode escape");
              }
              String hex = text.substring(index, index + 4);
              index += 4;
              sb.append((char) Integer.parseInt(hex, 16));
              break;
            }
            default:
              fail("unknown escape: " + esc);
          }
        } else {
          sb.append(ch);
        }
      }
      fail("unterminated string");
      return "";
    }

    private Number readNumber() {
      int start = index;
      if(peek('-')) {
        index++;
      }
      while(index < text.length() && Character.isDigit(text.charAt(index))) {
        index++;
      }
      if(peek('.')) {
        index++;
        while(index < text.length() && Character.isDigit(text.charAt(index))) {
          index++;
        }
      }
      if(peek('e') || peek('E')) {
        index++;
        if(peek('+') || peek('-')) {
          index++;
        }
        while(index < text.length() && Character.isDigit(text.charAt(index))) {
          index++;
        }
      }
      if(start == index) {
        fail("bad number");
      }
      String n = text.substring(start, index);
      if(n.indexOf('.') >= 0 || n.indexOf('e') >= 0 || n.indexOf('E') >= 0) {
        return Double.valueOf(n);
      }
      try {
        return Integer.valueOf(n);
      } catch(NumberFormatException ex) {
        return Long.valueOf(n);
      }
    }

    private void expect(char ch) {
      if(index >= text.length() || text.charAt(index) != ch) {
        fail("expected '" + ch + "'");
      }
      index++;
    }

    private boolean peek(char ch) {
      return index < text.length() && text.charAt(index) == ch;
    }

    private void skipWs() {
      while(index < text.length()) {
        char ch = text.charAt(index);
        if(ch == ' ' || ch == '\t' || ch == '\r' || ch == '\n') {
          index++;
        } else {
          break;
        }
      }
    }

    private void fail(String msg) {
      throw new IllegalStateException("row " + row + " field " + field + " json parse error at " + index + ": " + msg);
    }
  }
}
