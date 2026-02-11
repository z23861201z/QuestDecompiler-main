package unluac.semantic;

import java.nio.charset.Charset;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.OffsetDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.LinkedHashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

public class Phase5NpcExportValidator {

  private static final Charset UTF8 = Charset.forName("UTF-8");

  public static void main(String[] args) throws Exception {
    Path originalDir = args.length >= 1
        ? Paths.get(args[0])
        : Paths.get("D:/TitanGames/GhostOnline/zChina/Script/npc-lua-generated");
    Path exportedDir = args.length >= 2
        ? Paths.get(args[1])
        : Paths.get("reports", "phase5_exported_npc");
    Path output = args.length >= 3
        ? Paths.get(args[2])
        : Paths.get("reports", "phase5_export_validation.json");

    long start = System.nanoTime();
    Phase5NpcExportValidator validator = new Phase5NpcExportValidator();
    ValidationReport report = validator.validate(originalDir, exportedDir, output);
    long elapsed = (System.nanoTime() - start) / 1_000_000L;

    System.out.println("totalComparedFiles=" + report.totalComparedFiles);
    System.out.println("mismatchFileCount=" + report.mismatchFileCount);
    System.out.println("finalStatus=" + report.finalStatus);
    System.out.println("validateMillis=" + elapsed);
    System.out.println("output=" + output.toAbsolutePath());
  }

  public ValidationReport validate(Path originalDir,
                                   Path exportedDir,
                                   Path output) throws Exception {
    if(originalDir == null || !Files.exists(originalDir) || !Files.isDirectory(originalDir)) {
      throw new IllegalStateException("original npc dir not found: " + originalDir);
    }
    if(exportedDir == null || !Files.exists(exportedDir) || !Files.isDirectory(exportedDir)) {
      throw new IllegalStateException("exported npc dir not found: " + exportedDir);
    }

    List<String> originalFiles = collectNpcFiles(originalDir);
    List<String> exportedFiles = collectNpcFiles(exportedDir);

    ValidationReport report = new ValidationReport();
    report.totalComparedFiles = originalFiles.size();

    Set<String> exportedSet = new LinkedHashSet<String>(exportedFiles);
    for(String rel : originalFiles) {
      Path source = originalDir.resolve(rel);
      Path target = exportedDir.resolve(rel);

      if(!Files.exists(target) || !Files.isRegularFile(target)) {
        report.addMismatchFile(rel, "file", "<present>", "<missing>");
        continue;
      }

      compareOneFile(report, rel, source, target);
      exportedSet.remove(rel);
    }

    for(String rel : exportedSet) {
      report.addMismatchFile(rel, "file", "<missing>", "<present>");
    }

    report.finalStatus = report.mismatchFileCount == 0 ? "SAFE" : "UNSAFE";

    ensureParent(output);
    Files.write(output, report.toJson().getBytes(UTF8));

    if(report.mismatchFileCount > 0) {
      throw new IllegalStateException("Phase5 NPC export validation failed: mismatchFileCount=" + report.mismatchFileCount);
    }
    return report;
  }

  private void compareOneFile(ValidationReport report,
                              String rel,
                              Path source,
                              Path target) throws Exception {
    String sourceText = new String(Files.readAllBytes(source), UTF8);
    String targetText = new String(Files.readAllBytes(target), UTF8);

    LuaTextSignature sourceSignature = analyzeLuaText(sourceText);
    LuaTextSignature targetSignature = analyzeLuaText(targetText);

    if(!sourceSignature.parseError.isEmpty() || !targetSignature.parseError.isEmpty()) {
      if(!sourceSignature.parseError.equals(targetSignature.parseError)) {
        report.addMismatchFile(rel, "parse_error", sourceSignature.parseError, targetSignature.parseError);
      }
      return;
    }

    if(sourceSignature.functionOrder.size() != targetSignature.functionOrder.size()) {
      report.addMismatchFile(rel,
          "function_count",
          Integer.toString(sourceSignature.functionOrder.size()),
          Integer.toString(targetSignature.functionOrder.size()));
    }

    if(!sourceSignature.functionOrder.equals(targetSignature.functionOrder)) {
      report.addMismatchFile(rel,
          "function_order",
          QuestSemanticJson.toJsonArrayString(sourceSignature.functionOrder),
          QuestSemanticJson.toJsonArrayString(targetSignature.functionOrder));
    }

    if(sourceSignature.statementCount != targetSignature.statementCount) {
      report.addMismatchFile(rel,
          "statement_count",
          Integer.toString(sourceSignature.statementCount),
          Integer.toString(targetSignature.statementCount));
    }

    if(sourceSignature.ifCount != targetSignature.ifCount) {
      report.addMismatchFile(rel,
          "if_count",
          Integer.toString(sourceSignature.ifCount),
          Integer.toString(targetSignature.ifCount));
    }

    if(sourceSignature.elseCount != targetSignature.elseCount) {
      report.addMismatchFile(rel,
          "else_count",
          Integer.toString(sourceSignature.elseCount),
          Integer.toString(targetSignature.elseCount));
    }

    if(sourceSignature.returnCount != targetSignature.returnCount) {
      report.addMismatchFile(rel,
          "return_count",
          Integer.toString(sourceSignature.returnCount),
          Integer.toString(targetSignature.returnCount));
    }

    if(!sourceSignature.expressionSignature.equals(targetSignature.expressionSignature)) {
      report.addMismatchFile(rel, "expression_structure", sourceSignature.expressionSignature, targetSignature.expressionSignature);
    }

    if(!sourceSignature.qtAccessSignature.equals(targetSignature.qtAccessSignature)) {
      report.addMismatchFile(rel, "qt_access_structure", sourceSignature.qtAccessSignature, targetSignature.qtAccessSignature);
    }

    if(!sourceSignature.callSignature.equals(targetSignature.callSignature)) {
      report.addMismatchFile(rel, "call_structure", sourceSignature.callSignature, targetSignature.callSignature);
    }

    if(!sourceSignature.semanticSignature().equals(targetSignature.semanticSignature())) {
      report.addMismatchFile(rel, "semantic_structure", sourceSignature.semanticSignature(), targetSignature.semanticSignature());
    }
  }

  private LuaTextSignature analyzeLuaText(String text) {
    LuaTextSignature out = new LuaTextSignature();
    if(text == null) {
      out.parseError = "empty_text";
      return out;
    }

    List<String> tokens = tokenize(text, out);
    if(!out.parseError.isEmpty()) {
      return out;
    }

    out.statementCount = countStatementTokens(tokens);
    out.ifCount = countToken(tokens, "if");
    out.elseCount = countToken(tokens, "else");
    out.returnCount = countToken(tokens, "return");

    buildFunctionOrder(tokens, out.functionOrder);
    out.expressionSignature = buildExpressionSignature(tokens);
    out.qtAccessSignature = buildQtAccessSignature(tokens);
    out.callSignature = buildCallSignature(tokens);
    out.relatedQuestIds = extractQuestIds(tokens);
    return out;
  }

  private List<String> tokenize(String text, LuaTextSignature out) {
    List<String> tokens = new ArrayList<String>();
    StringBuilder current = new StringBuilder();

    boolean inString = false;
    char quoteChar = 0;
    boolean lineComment = false;
    int depthParen = 0;
    int depthBracket = 0;
    int depthBrace = 0;

    for(int i = 0; i < text.length(); i++) {
      char ch = text.charAt(i);
      char next = i + 1 < text.length() ? text.charAt(i + 1) : 0;

      if(ch == '\n' || ch == '\r') {
        lineComment = false;
      }

      if(lineComment) {
        continue;
      }

      if(!inString && ch == '-' && next == '-') {
        flushToken(tokens, current);
        lineComment = true;
        i++;
        continue;
      }

      if(inString) {
        if(ch == '\\') {
          current.append(ch);
          if(i + 1 < text.length()) {
            i++;
            current.append(text.charAt(i));
          }
          continue;
        }
        current.append(ch);
        if(ch == quoteChar) {
          inString = false;
          quoteChar = 0;
          flushToken(tokens, current);
        }
        continue;
      }

      if(ch == '"' || ch == '\'') {
        flushToken(tokens, current);
        inString = true;
        quoteChar = ch;
        current.append(ch);
        continue;
      }

      if(Character.isWhitespace(ch)) {
        flushToken(tokens, current);
        continue;
      }

      if(isDelimiter(ch)) {
        flushToken(tokens, current);
        tokens.add(String.valueOf(ch));
        if(ch == '(') depthParen++;
        if(ch == ')') depthParen--;
        if(ch == '[') depthBracket++;
        if(ch == ']') depthBracket--;
        if(ch == '{') depthBrace++;
        if(ch == '}') depthBrace--;
        continue;
      }

      current.append(ch);
    }
    flushToken(tokens, current);

    if(inString || depthParen != 0 || depthBracket != 0 || depthBrace != 0) {
      out.parseError = "unbalanced_structure";
    }
    return tokens;
  }

  private boolean isDelimiter(char ch) {
    return ch == '(' || ch == ')'
        || ch == '[' || ch == ']'
        || ch == '{' || ch == '}'
        || ch == ',' || ch == ';'
        || ch == '='
        || ch == '+' || ch == '-' || ch == '*' || ch == '/'
        || ch == '<' || ch == '>'
        || ch == ':';
  }

  private void flushToken(List<String> tokens, StringBuilder current) {
    if(current.length() == 0) {
      return;
    }
    tokens.add(current.toString());
    current.setLength(0);
  }

  private int countStatementTokens(List<String> tokens) {
    int count = 0;
    for(String token : tokens) {
      if("if".equals(token)
          || "elseif".equals(token)
          || "else".equals(token)
          || "for".equals(token)
          || "while".equals(token)
          || "repeat".equals(token)
          || "return".equals(token)
          || "function".equals(token)) {
        count++;
      }
    }
    return count;
  }

  private int countToken(List<String> tokens, String expected) {
    int count = 0;
    for(String token : tokens) {
      if(expected.equals(token)) {
        count++;
      }
    }
    return count;
  }

  private void buildFunctionOrder(List<String> tokens, List<String> out) {
    for(int i = 0; i + 1 < tokens.size(); i++) {
      if("function".equals(tokens.get(i))) {
        out.add(tokens.get(i + 1));
      }
    }
  }

  private String buildExpressionSignature(List<String> tokens) {
    StringBuilder sb = new StringBuilder();
    for(int i = 0; i < tokens.size(); i++) {
      String token = tokens.get(i);
      if("if".equals(token) || "elseif".equals(token) || "while".equals(token)) {
        int j = i + 1;
        while(j < tokens.size()) {
          String t = tokens.get(j);
          if("then".equals(t) || "do".equals(t)) {
            break;
          }
          sb.append(t).append(' ');
          j++;
        }
        sb.append('|');
      }
    }
    return sb.toString();
  }

  private String buildQtAccessSignature(List<String> tokens) {
    StringBuilder sb = new StringBuilder();
    for(int i = 0; i < tokens.size(); i++) {
      String token = tokens.get(i);
      if(!"qt".equals(token) && !"qData".equals(token)) {
        continue;
      }
      int end = Math.min(tokens.size(), i + 24);
      for(int j = i; j < end; j++) {
        String t = tokens.get(j);
        if(";".equals(t) || "then".equals(t) || "do".equals(t)) {
          break;
        }
        sb.append(t);
      }
      sb.append('|');
    }
    return sb.toString();
  }

  private String buildCallSignature(List<String> tokens) {
    StringBuilder sb = new StringBuilder();
    for(int i = 0; i + 1 < tokens.size(); i++) {
      String t = tokens.get(i);
      if(!("CHECK_ITEM_CNT".equals(t)
          || "SET_QUEST_STATE".equals(t)
          || "NPC_SAY".equals(t)
          || "ADD_QUEST_BTN".equals(t)
          || "__QUEST_HAS_ALL_ITEMS".equals(t))) {
        continue;
      }

      sb.append(t).append('(');
      int depth = 0;
      int j = i + 1;
      for(; j < tokens.size(); j++) {
        String c = tokens.get(j);
        if("(".equals(c)) {
          depth++;
        } else if(")".equals(c)) {
          depth--;
          if(depth == 0) {
            sb.append(')');
            break;
          }
        }
        if(depth > 0) {
          sb.append(c);
        }
      }
      sb.append('|');
      i = j;
    }
    return sb.toString();
  }

  private List<Integer> extractQuestIds(List<String> tokens) {
    Set<Integer> ids = new LinkedHashSet<Integer>();
    for(int i = 0; i + 3 < tokens.size(); i++) {
      if(!"qt".equals(tokens.get(i)) && !"qData".equals(tokens.get(i))) {
        continue;
      }
      if(!"[".equals(tokens.get(i + 1))) {
        continue;
      }
      String n = tokens.get(i + 2);
      if(!isIntegerToken(n)) {
        continue;
      }
      if(!"]".equals(tokens.get(i + 3))) {
        continue;
      }
      ids.add(Integer.valueOf(Integer.parseInt(n)));
    }
    List<Integer> out = new ArrayList<Integer>(ids);
    Collections.sort(out);
    return out;
  }

  private boolean isIntegerToken(String token) {
    if(token == null || token.isEmpty()) {
      return false;
    }
    int start = token.charAt(0) == '-' ? 1 : 0;
    if(start == token.length()) {
      return false;
    }
    for(int i = start; i < token.length(); i++) {
      if(!Character.isDigit(token.charAt(i))) {
        return false;
      }
    }
    return true;
  }

  private List<String> collectNpcFiles(Path root) throws Exception {
    List<String> out = new ArrayList<String>();
    Files.walk(root)
        .filter(Files::isRegularFile)
        .forEach(path -> {
          String rel = normalizePath(root.relativize(path).toString());
          String lower = rel.toLowerCase();
          if(lower.startsWith("npc_") && lower.endsWith(".lua")) {
            out.add(rel);
          }
        });
    Collections.sort(out, String.CASE_INSENSITIVE_ORDER);
    return out;
  }

  private String normalizePath(String path) {
    if(path == null) {
      return "";
    }
    return path.replace('\\', '/').trim();
  }

  private void ensureParent(Path output) throws Exception {
    if(output.getParent() != null && !Files.exists(output.getParent())) {
      Files.createDirectories(output.getParent());
    }
  }

  private static final class LuaTextSignature {
    String parseError = "";
    final List<String> functionOrder = new ArrayList<String>();
    int statementCount;
    int ifCount;
    int elseCount;
    int returnCount;
    String expressionSignature = "";
    String qtAccessSignature = "";
    String callSignature = "";
    List<Integer> relatedQuestIds = new ArrayList<Integer>();

    String semanticSignature() {
      StringBuilder sb = new StringBuilder();
      sb.append("functions=").append(QuestSemanticJson.toJsonArrayString(functionOrder)).append(';');
      sb.append("stmt=").append(statementCount).append(';');
      sb.append("if=").append(ifCount).append(';');
      sb.append("else=").append(elseCount).append(';');
      sb.append("return=").append(returnCount).append(';');
      sb.append("quests=").append(QuestSemanticJson.toJsonArrayInt(relatedQuestIds)).append(';');
      return sb.toString();
    }
  }

  public static final class ValidationReport {
    String generatedAt = OffsetDateTime.now().format(DateTimeFormatter.ISO_OFFSET_DATE_TIME);
    int totalComparedFiles;
    int mismatchFileCount;
    final List<Map<String, Object>> mismatchDetails = new ArrayList<Map<String, Object>>();
    String finalStatus = "UNSAFE";

    void addMismatchFile(String file,
                         String astPath,
                         String originalExpression,
                         String exportedExpression) {
      Map<String, Object> row = new LinkedHashMap<String, Object>();
      row.put("file", file);
      row.put("astPath", astPath);
      row.put("originalExpression", originalExpression);
      row.put("exportedExpression", exportedExpression);
      mismatchDetails.add(row);

      Set<String> files = new LinkedHashSet<String>();
      for(Map<String, Object> item : mismatchDetails) {
        files.add(String.valueOf(item.get("file")));
      }
      mismatchFileCount = files.size();
    }

    String toJson() {
      StringBuilder sb = new StringBuilder();
      sb.append("{\n");
      sb.append("  \"generatedAt\": ").append(QuestSemanticJson.jsonString(generatedAt)).append(",\n");
      sb.append("  \"totalComparedFiles\": ").append(totalComparedFiles).append(",\n");
      sb.append("  \"mismatchFileCount\": ").append(mismatchFileCount).append(",\n");
      sb.append("  \"mismatchDetails\": ").append(toJsonArrayOfObject(mismatchDetails)).append(",\n");
      sb.append("  \"finalStatus\": ").append(QuestSemanticJson.jsonString(finalStatus)).append("\n");
      sb.append("}\n");
      return sb.toString();
    }

    private String toJsonArrayOfObject(List<Map<String, Object>> list) {
      StringBuilder sb = new StringBuilder();
      sb.append('[');
      for(int i = 0; i < list.size(); i++) {
        if(i > 0) {
          sb.append(',');
        }
        sb.append(QuestSemanticJson.toJsonObject(list.get(i)));
      }
      sb.append(']');
      return sb.toString();
    }
  }
}

