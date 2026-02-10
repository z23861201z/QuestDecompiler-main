package unluac.semantic;

import java.io.File;
import java.nio.ByteBuffer;
import java.nio.CharBuffer;
import java.nio.charset.CharacterCodingException;
import java.nio.charset.Charset;
import java.nio.charset.CharsetDecoder;
import java.nio.charset.CodingErrorAction;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.time.OffsetDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.LinkedHashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class QuestGetItemStructureRewriter {

  private static final Charset UTF8 = Charset.forName("UTF-8");
  private static final Set<String> TARGET_CLUSTERS = new LinkedHashSet<String>(Arrays.asList("X1", "X2", "X3"));
  private static final Pattern INDEXED_ACCESS_PATTERN = Pattern.compile(
      "qt\\s*\\[\\s*\\d+\\s*\\]\\s*\\.\\s*goal\\s*\\.\\s*getItem\\s*\\[\\s*\\d+\\s*\\]\\s*\\.\\s*(id|count)",
      Pattern.CASE_INSENSITIVE);
  private static final Pattern HELPER_DEF_PATTERN = Pattern.compile(
      "(?:^|\\n)\\s*(?:local\\s+)?function\\s+__QUEST_HAS_ALL_ITEMS\\s*\\(",
      Pattern.CASE_INSENSITIVE);

  public static void main(String[] args) throws Exception {
    Path clusterReport = args.length >= 1
        ? Paths.get(args[0])
        : Paths.get("reports", "round_5_structure_deep_analysis.json");

    Path sourceDir = args.length >= 2
        ? Paths.get(args[1])
        : resolveSourceDirFromReport(clusterReport);

    Path outputDir = args.length >= 3
        ? Paths.get(args[2])
        : Paths.get("npc-lua-regression", "round_7A_rewritten");
    Path diffOut = args.length >= 4
        ? Paths.get(args[3])
        : Paths.get("reports", "rewrite_round_7A_diff.txt");
    Path statsOut = args.length >= 5
        ? Paths.get(args[4])
        : Paths.get("reports", "rewrite_round_7A_stats.json");

    QuestGetItemStructureRewriter rewriter = new QuestGetItemStructureRewriter();
    RewriteStats stats = rewriter.rewrite(clusterReport, sourceDir, outputDir, diffOut, statsOut);

    System.out.println("cluster_report=" + clusterReport.toAbsolutePath());
    System.out.println("source_dir=" + sourceDir.toAbsolutePath());
    System.out.println("output_dir=" + outputDir.toAbsolutePath());
    System.out.println("diff_out=" + diffOut.toAbsolutePath());
    System.out.println("stats_out=" + statsOut.toAbsolutePath());
    System.out.println("totalScannedFiles=" + stats.totalScannedFiles);
    System.out.println("totalRewrittenFiles=" + stats.totalRewrittenFiles);
    System.out.println("totalRewrittenBlocks=" + stats.totalRewrittenBlocks);
    System.out.println("totalRemovedIndexedAccess=" + stats.totalRemovedIndexedAccess);
  }

  public RewriteStats rewrite(Path clusterReport,
                              Path sourceDir,
                              Path outputDir,
                              Path diffOut,
                              Path statsOut) throws Exception {
    if(clusterReport == null || !Files.exists(clusterReport)) {
      throw new IllegalStateException("cluster report not found: " + clusterReport);
    }
    if(sourceDir == null || !Files.exists(sourceDir) || !Files.isDirectory(sourceDir)) {
      throw new IllegalStateException("source dir not found: " + sourceDir);
    }

    String clusterText = new String(Files.readAllBytes(clusterReport), UTF8);
    Map<String, Object> clusterRoot = QuestSemanticJson.parseObject(clusterText, "round_5_structure_deep_analysis", 0);
    Map<String, Set<Integer>> targetsByFile = collectTargets(clusterRoot);

    if(!Files.exists(outputDir)) {
      Files.createDirectories(outputDir);
    }

    RewriteStats stats = new RewriteStats();
    stats.generatedAt = OffsetDateTime.now().format(DateTimeFormatter.ISO_OFFSET_DATE_TIME);
    stats.clusterReportPath = clusterReport.toAbsolutePath().toString();
    stats.sourceDir = sourceDir.toAbsolutePath().toString();
    stats.outputDir = outputDir.toAbsolutePath().toString();

    List<String> orderedFiles = new ArrayList<String>(targetsByFile.keySet());
    Collections.sort(orderedFiles, String.CASE_INSENSITIVE_ORDER);

    List<String> diffBlocks = new ArrayList<String>();
    for(String relativeFile : orderedFiles) {
      stats.totalScannedFiles++;
      Path source = sourceDir.resolve(relativeFile.replace('/', File.separatorChar));
      Path output = outputDir.resolve(relativeFile.replace('/', File.separatorChar));
      ensureParent(output);

      if(!Files.exists(source) || !Files.isRegularFile(source)) {
        stats.missingFiles.add(relativeFile);
        continue;
      }

      Set<Integer> questIds = targetsByFile.get(relativeFile);
      FileRewriteResult fileResult = rewriteOneFile(source, relativeFile, questIds);

      if(fileResult.changed) {
        Files.write(output, fileResult.bytes);
        stats.totalRewrittenFiles++;
        stats.totalRewrittenBlocks += fileResult.rewrittenBlocks;
        stats.totalRemovedIndexedAccess += fileResult.removedIndexedAccess;
        for(ConditionDiff diff : fileResult.conditionDiffs) {
          diffBlocks.add(toDiffBlock(relativeFile, diff));
        }
      } else {
        Files.copy(source, output, StandardCopyOption.REPLACE_EXISTING);
      }
    }

    writeDiff(diffOut, diffBlocks);
    writeStats(statsOut, stats);
    return stats;
  }

  private static Path resolveSourceDirFromReport(Path clusterReport) throws Exception {
    Map<String, Object> clusterRoot = QuestSemanticJson.parseObject(
        new String(Files.readAllBytes(clusterReport), UTF8), "round_5_structure_deep_analysis", 0);
    String remainingPath = stringOf(clusterRoot.get("sourceRemainingFailuresPath"));
    if(remainingPath != null && !remainingPath.trim().isEmpty()) {
      Path remaining = Paths.get(remainingPath.trim());
      if(Files.exists(remaining)) {
        Map<String, Object> remainingRoot = QuestSemanticJson.parseObject(
            new String(Files.readAllBytes(remaining), UTF8), "round_5_remaining_failures", 0);
        String sourceNpcDir = stringOf(remainingRoot.get("sourceNpcDir"));
        if(sourceNpcDir != null && !sourceNpcDir.trim().isEmpty()) {
          Path candidate = Paths.get(sourceNpcDir.trim());
          if(Files.exists(candidate) && Files.isDirectory(candidate)) {
            return candidate;
          }
        }
      }
    }
    return Paths.get("npc-lua-regression", "round_5");
  }

  @SuppressWarnings("unchecked")
  private Map<String, Set<Integer>> collectTargets(Map<String, Object> clusterRoot) {
    Map<String, Set<Integer>> targets = new LinkedHashMap<String, Set<Integer>>();
    Object clustersObj = clusterRoot.get("patternClusters");
    if(!(clustersObj instanceof List<?>)) {
      return targets;
    }

    for(Object clusterItem : (List<Object>) clustersObj) {
      if(!(clusterItem instanceof Map<?, ?>)) {
        continue;
      }
      Map<String, Object> cluster = (Map<String, Object>) clusterItem;
      String patternId = stringOf(cluster.get("patternId"));
      if(!TARGET_CLUSTERS.contains(patternId)) {
        continue;
      }

      Object membersObj = cluster.get("members");
      if(!(membersObj instanceof List<?>)) {
        continue;
      }
      for(Object memberObj : (List<Object>) membersObj) {
        if(!(memberObj instanceof Map<?, ?>)) {
          continue;
        }
        Map<String, Object> member = (Map<String, Object>) memberObj;
        String file = normalizePath(stringOf(member.get("npcFile")));
        int questId = intOf(member.get("questId"));
        if(file.isEmpty() || questId <= 0) {
          continue;
        }
        Set<Integer> set = targets.get(file);
        if(set == null) {
          set = new LinkedHashSet<Integer>();
          targets.put(file, set);
        }
        set.add(Integer.valueOf(questId));
      }
    }
    return targets;
  }

  private FileRewriteResult rewriteOneFile(Path source,
                                           String relativeFile,
                                           Set<Integer> scopedQuestIds) throws Exception {
    byte[] raw = Files.readAllBytes(source);
    DecodedText decoded = decode(raw);
    String originalText = decoded.text;

    List<Token> tokens = tokenize(originalText);
    List<IfSpan> spans = findIfSpans(tokens);
    int[] lineOffsets = computeLineOffsets(originalText);

    List<ConditionReplacement> replacements = new ArrayList<ConditionReplacement>();
    int rewrittenBlocks = 0;
    int removedIndexedAccess = 0;

    for(IfSpan span : spans) {
      List<Token> conditionTokens = new ArrayList<Token>();
      for(int i = span.conditionStartTokenIndex; i < span.thenTokenIndex; i++) {
        conditionTokens.add(tokens.get(i));
      }
      ExpressionParser parser = new ExpressionParser(conditionTokens);
      Expr expression = parser.parseExpression();
      if(expression == null || !parser.isAtEnd()) {
        continue;
      }

      RewriteOutcome outcome = rewriteConditionExpression(expression, scopedQuestIds);
      if(!outcome.changed) {
        continue;
      }

      String before = originalText.substring(span.conditionStartOffset, span.conditionEndOffset);
      String after = renderExpression(outcome.expression).trim();
      if(after.isEmpty() || before.equals(after)) {
        continue;
      }

      ConditionReplacement replacement = new ConditionReplacement();
      replacement.startOffset = span.conditionStartOffset;
      replacement.endOffset = span.conditionEndOffset;
      replacement.startLine = lineNumberOfOffset(lineOffsets, span.conditionStartOffset);
      replacement.endLine = lineNumberOfOffset(lineOffsets, span.conditionEndOffset);
      replacement.before = before;
      replacement.after = after;
      replacement.removedIndexedAccess = Math.max(countIndexedAccess(before) - countIndexedAccess(after), 0);
      replacements.add(replacement);
      rewrittenBlocks++;
      removedIndexedAccess += replacement.removedIndexedAccess;
    }

    FileRewriteResult result = new FileRewriteResult();
    result.rewrittenBlocks = rewrittenBlocks;
    result.removedIndexedAccess = removedIndexedAccess;

    if(replacements.isEmpty()) {
      result.changed = false;
      result.bytes = raw;
      return result;
    }

    Collections.sort(replacements, (a, b) -> Integer.compare(b.startOffset, a.startOffset));
    StringBuilder mutable = new StringBuilder(originalText);
    for(ConditionReplacement replacement : replacements) {
      mutable.replace(replacement.startOffset, replacement.endOffset, replacement.after);
    }

    String rewritten = mutable.toString();
    String lineEnding = detectLineEnding(originalText);
    boolean finalNewline = hasFinalNewline(originalText);
    if(!hasHelperFunction(rewritten)) {
      HelperInsertion insertion = insertHelperFunction(rewritten, lineEnding, finalNewline);
      rewritten = insertion.text;
      result.conditionDiffs.add(insertion.diff);
    }

    for(ConditionReplacement replacement : replacements) {
      ConditionDiff diff = new ConditionDiff();
      diff.lineStart = replacement.startLine;
      diff.lineEnd = replacement.endLine;
      diff.before = replacement.before;
      diff.after = replacement.after;
      result.conditionDiffs.add(diff);
    }

    result.changed = !rewritten.equals(originalText);
    result.bytes = result.changed ? encode(rewritten, decoded.charset, decoded.bom) : raw;
    return result;
  }

  private RewriteOutcome rewriteConditionExpression(Expr expression, Set<Integer> scopedQuestIds) {
    if(expression == null) {
      return RewriteOutcome.unchanged(new RawExpr(""));
    }

    if(expression instanceof ParenExpr) {
      ParenExpr paren = (ParenExpr) expression;
      RewriteOutcome inner = rewriteConditionExpression(paren.expression, scopedQuestIds);
      if(!inner.changed) {
        return RewriteOutcome.unchanged(expression);
      }
      return new RewriteOutcome(new ParenExpr(inner.expression), true, inner.removedPairCount);
    }

    if(expression instanceof UnaryExpr) {
      UnaryExpr unary = (UnaryExpr) expression;
      RewriteOutcome inner = rewriteConditionExpression(unary.expression, scopedQuestIds);
      if(!inner.changed) {
        return RewriteOutcome.unchanged(expression);
      }
      return new RewriteOutcome(new UnaryExpr(unary.operator, inner.expression), true, inner.removedPairCount);
    }

    if(expression instanceof BinaryExpr) {
      BinaryExpr binary = (BinaryExpr) expression;
      RewriteOutcome left = rewriteConditionExpression(binary.left, scopedQuestIds);
      RewriteOutcome right = rewriteConditionExpression(binary.right, scopedQuestIds);

      Expr merged = new BinaryExpr(binary.operator, left.expression, right.expression);
      int removed = left.removedPairCount + right.removedPairCount;
      boolean changed = left.changed || right.changed;

      MatchPair pair = matchGetItemPair(merged, scopedQuestIds);
      if(pair != null) {
        return new RewriteOutcome(new HelperExpr(pair.questId), true, removed + 1);
      }

      if(isLogicalOperator(binary.operator)) {
        Expr simplified = simplifyLogical((BinaryExpr) merged);
        if(simplified != merged) {
          changed = true;
          merged = simplified;
        }
      }

      if(!changed) {
        return RewriteOutcome.unchanged(expression);
      }
      return new RewriteOutcome(merged, true, removed);
    }

    if(expression instanceof CallExpr) {
      CallExpr call = (CallExpr) expression;
      RewriteOutcome callee = rewriteConditionExpression(call.callee, scopedQuestIds);
      int removed = callee.removedPairCount;
      boolean changed = callee.changed;
      List<Expr> args = new ArrayList<Expr>(call.arguments.size());
      for(Expr arg : call.arguments) {
        RewriteOutcome out = rewriteConditionExpression(arg, scopedQuestIds);
        args.add(out.expression);
        changed = changed || out.changed;
        removed += out.removedPairCount;
      }

      if(!changed) {
        return RewriteOutcome.unchanged(expression);
      }
      return new RewriteOutcome(new CallExpr(callee.expression, args), true, removed);
    }

    if(expression instanceof FieldExpr) {
      FieldExpr field = (FieldExpr) expression;
      RewriteOutcome base = rewriteConditionExpression(field.base, scopedQuestIds);
      if(!base.changed) {
        return RewriteOutcome.unchanged(expression);
      }
      return new RewriteOutcome(new FieldExpr(base.expression, field.field), true, base.removedPairCount);
    }

    if(expression instanceof IndexExpr) {
      IndexExpr index = (IndexExpr) expression;
      RewriteOutcome base = rewriteConditionExpression(index.base, scopedQuestIds);
      RewriteOutcome key = rewriteConditionExpression(index.index, scopedQuestIds);
      if(!base.changed && !key.changed) {
        return RewriteOutcome.unchanged(expression);
      }
      return new RewriteOutcome(new IndexExpr(base.expression, key.expression), true,
          base.removedPairCount + key.removedPairCount);
    }

    return RewriteOutcome.unchanged(expression);
  }

  private List<IfSpan> findIfSpans(List<Token> tokens) {
    List<IfSpan> spans = new ArrayList<IfSpan>();
    for(int i = 0; i < tokens.size(); i++) {
      Token token = tokens.get(i);
      if(!token.isKeyword("if") && !token.isKeyword("elseif")) {
        continue;
      }

      int conditionStart = i + 1;
      if(conditionStart >= tokens.size()) {
        continue;
      }

      int parenDepth = 0;
      int bracketDepth = 0;
      int braceDepth = 0;
      int thenIndex = -1;
      for(int j = conditionStart; j < tokens.size(); j++) {
        Token current = tokens.get(j);
        if(current.isSymbol("(")) {
          parenDepth++;
          continue;
        }
        if(current.isSymbol(")")) {
          parenDepth = Math.max(parenDepth - 1, 0);
          continue;
        }
        if(current.isSymbol("[")) {
          bracketDepth++;
          continue;
        }
        if(current.isSymbol("]")) {
          bracketDepth = Math.max(bracketDepth - 1, 0);
          continue;
        }
        if(current.isSymbol("{")) {
          braceDepth++;
          continue;
        }
        if(current.isSymbol("}")) {
          braceDepth = Math.max(braceDepth - 1, 0);
          continue;
        }
        if(current.isKeyword("then") && parenDepth == 0 && bracketDepth == 0 && braceDepth == 0) {
          thenIndex = j;
          break;
        }
      }
      if(thenIndex <= conditionStart) {
        continue;
      }

      IfSpan span = new IfSpan();
      span.conditionStartTokenIndex = conditionStart;
      span.thenTokenIndex = thenIndex;
      span.conditionStartOffset = tokens.get(conditionStart).startOffset;
      span.conditionEndOffset = tokens.get(thenIndex - 1).endOffset;
      spans.add(span);
    }
    return spans;
  }

  private List<Token> tokenize(String text) {
    List<Token> tokens = new ArrayList<Token>();
    int index = 0;
    int length = text.length();
    while(index < length) {
      char ch = text.charAt(index);
      if(Character.isWhitespace(ch)) {
        index++;
        continue;
      }

      if(ch == '-' && index + 1 < length && text.charAt(index + 1) == '-') {
        int longCommentEq = longBracketEquals(text, index + 2);
        if(longCommentEq >= 0) {
          int commentEnd = findLongBracketEnd(text, index + 2, longCommentEq);
          index = commentEnd >= 0 ? commentEnd : length;
        } else {
          index = skipLine(text, index);
        }
        continue;
      }

      if(ch == '\'' || ch == '"') {
        int start = index;
        index = consumeQuotedString(text, index, ch);
        tokens.add(new Token(TokenKind.STRING, text.substring(start, index), start, index));
        continue;
      }

      int longStringEq = longBracketEquals(text, index);
      if(longStringEq >= 0) {
        int start = index;
        int end = findLongBracketEnd(text, index, longStringEq);
        index = end >= 0 ? end : length;
        tokens.add(new Token(TokenKind.STRING, text.substring(start, index), start, index));
        continue;
      }

      if(isIdentifierStart(ch)) {
        int start = index;
        index++;
        while(index < length && isIdentifierPart(text.charAt(index))) {
          index++;
        }
        String ident = text.substring(start, index);
        TokenKind kind = isKeyword(ident) ? TokenKind.KEYWORD : TokenKind.IDENT;
        tokens.add(new Token(kind, ident, start, index));
        continue;
      }

      if(Character.isDigit(ch)) {
        int start = index;
        index = consumeNumber(text, index);
        tokens.add(new Token(TokenKind.NUMBER, text.substring(start, index), start, index));
        continue;
      }

      String two = index + 1 < length ? text.substring(index, index + 2) : "";
      if(">=".equals(two) || "<=".equals(two) || "==".equals(two) || "~=".equals(two) || "..".equals(two)) {
        tokens.add(new Token(TokenKind.SYMBOL, two, index, index + 2));
        index += 2;
        continue;
      }

      tokens.add(new Token(TokenKind.SYMBOL, String.valueOf(ch), index, index + 1));
      index++;
    }
    return tokens;
  }

  private String renderExpression(Expr expression) {
    return renderExpression(expression, 0);
  }

  private String renderExpression(Expr expression, int parentPrecedence) {
    if(expression == null) {
      return "";
    }
    if(expression instanceof RawExpr) {
      return ((RawExpr) expression).text;
    }
    if(expression instanceof NameExpr) {
      return ((NameExpr) expression).name;
    }
    if(expression instanceof NumberExpr) {
      return ((NumberExpr) expression).text;
    }
    if(expression instanceof StringExpr) {
      return ((StringExpr) expression).text;
    }
    if(expression instanceof HelperExpr) {
      int questId = ((HelperExpr) expression).questId;
      return "__QUEST_HAS_ALL_ITEMS(qt[" + questId + "].goal.getItem)";
    }
    if(expression instanceof ParenExpr) {
      return "(" + renderExpression(((ParenExpr) expression).expression, 0) + ")";
    }
    if(expression instanceof UnaryExpr) {
      UnaryExpr unary = (UnaryExpr) expression;
      int precedence = precedenceOf(unary);
      String rendered = unary.operator + " " + renderExpression(unary.expression, precedence);
      if(precedence < parentPrecedence) {
        return "(" + rendered + ")";
      }
      return rendered;
    }
    if(expression instanceof FieldExpr) {
      FieldExpr field = (FieldExpr) expression;
      return renderExpression(field.base, precedenceOf(field)) + "." + field.field;
    }
    if(expression instanceof IndexExpr) {
      IndexExpr index = (IndexExpr) expression;
      return renderExpression(index.base, precedenceOf(index)) + "[" + renderExpression(index.index, 0) + "]";
    }
    if(expression instanceof CallExpr) {
      CallExpr call = (CallExpr) expression;
      StringBuilder sb = new StringBuilder();
      sb.append(renderExpression(call.callee, precedenceOf(call))).append("(");
      for(int i = 0; i < call.arguments.size(); i++) {
        if(i > 0) {
          sb.append(", ");
        }
        sb.append(renderExpression(call.arguments.get(i), 0));
      }
      sb.append(")");
      return sb.toString();
    }
    if(expression instanceof BinaryExpr) {
      BinaryExpr binary = (BinaryExpr) expression;
      int precedence = precedenceOf(binary);
      String left = renderExpression(binary.left, precedence);
      String right = renderExpression(binary.right, precedence + 1);
      String rendered = left + " " + binary.operator + " " + right;
      if(precedence < parentPrecedence) {
        return "(" + rendered + ")";
      }
      return rendered;
    }
    return "";
  }

  private int countIndexedAccess(String text) {
    if(text == null || text.isEmpty()) {
      return 0;
    }
    Matcher matcher = INDEXED_ACCESS_PATTERN.matcher(text);
    int count = 0;
    while(matcher.find()) {
      count++;
    }
    return count;
  }

  private boolean hasHelperFunction(String text) {
    if(text == null || text.isEmpty()) {
      return false;
    }
    return HELPER_DEF_PATTERN.matcher(text).find();
  }

  private HelperInsertion insertHelperFunction(String text,
                                               String lineEnding,
                                               boolean finalNewline) {
    List<String> lines = splitLines(text);
    int insertLine = findHelperInsertLine(lines);
    List<String> helper = buildHelperBlock();
    for(int i = 0; i < helper.size(); i++) {
      lines.add(insertLine + i, helper.get(i));
    }

    HelperInsertion insertion = new HelperInsertion();
    insertion.text = joinLines(lines, lineEnding, finalNewline);
    insertion.diff = new ConditionDiff();
    insertion.diff.lineStart = insertLine + 1;
    insertion.diff.lineEnd = insertLine + helper.size();
    insertion.diff.before = "";
    insertion.diff.after = joinLines(helper, "\n", false);
    return insertion;
  }

  private List<String> buildHelperBlock() {
    List<String> helper = new ArrayList<String>();
    helper.add("local function __QUEST_HAS_ALL_ITEMS(goalItems)");
    helper.add("  for i, v in ipairs(goalItems) do");
    helper.add("    if CHECK_ITEM_CNT(v.id) < v.count then");
    helper.add("      return false");
    helper.add("    end");
    helper.add("  end");
    helper.add("  return true");
    helper.add("end");
    helper.add("");
    return helper;
  }

  private int findHelperInsertLine(List<String> lines) {
    int index = 0;
    while(index < lines.size()) {
      String trim = lines.get(index).trim();
      if(trim.isEmpty() || trim.startsWith("--")) {
        index++;
      } else {
        break;
      }
    }
    return index;
  }

  private int[] computeLineOffsets(String text) {
    List<Integer> starts = new ArrayList<Integer>();
    starts.add(Integer.valueOf(0));
    for(int i = 0; i < text.length(); i++) {
      char ch = text.charAt(i);
      if(ch == '\r') {
        if(i + 1 < text.length() && text.charAt(i + 1) == '\n') {
          i++;
        }
        starts.add(Integer.valueOf(i + 1));
      } else if(ch == '\n') {
        starts.add(Integer.valueOf(i + 1));
      }
    }
    int[] offsets = new int[starts.size()];
    for(int i = 0; i < starts.size(); i++) {
      offsets[i] = starts.get(i).intValue();
    }
    return offsets;
  }

  private int lineNumberOfOffset(int[] offsets, int offset) {
    if(offsets == null || offsets.length == 0) {
      return 1;
    }
    int low = 0;
    int high = offsets.length - 1;
    while(low <= high) {
      int mid = (low + high) >>> 1;
      int value = offsets[mid];
      if(value <= offset) {
        low = mid + 1;
      } else {
        high = mid - 1;
      }
    }
    return high + 1;
  }

  private void writeDiff(Path diffOut, List<String> diffBlocks) throws Exception {
    ensureParent(diffOut);
    StringBuilder sb = new StringBuilder();
    sb.append("# rewrite_round_7A_diff\n");
    sb.append("# generatedAt=").append(OffsetDateTime.now().format(DateTimeFormatter.ISO_OFFSET_DATE_TIME)).append("\n\n");
    for(String block : diffBlocks) {
      sb.append(block).append("\n");
    }
    Files.write(diffOut, sb.toString().getBytes(UTF8));
  }

  private String toDiffBlock(String relativeFile, ConditionDiff diff) {
    StringBuilder sb = new StringBuilder();
    sb.append("--- ").append(relativeFile).append("\n");
    sb.append("+++ ").append(relativeFile).append(" (round_7A_rewritten)\n");
    sb.append("@@ lines ").append(diff.lineStart).append("-").append(diff.lineEnd).append(" @@\n");
    appendDiffLines(sb, '-', diff.before);
    appendDiffLines(sb, '+', diff.after);
    return sb.toString();
  }

  private void appendDiffLines(StringBuilder sb, char prefix, String text) {
    String normalized = text == null ? "" : text.replace("\r\n", "\n").replace('\r', '\n');
    String[] lines = normalized.split("\n", -1);
    for(String line : lines) {
      sb.append(prefix).append(' ').append(line).append("\n");
    }
  }

  private void writeStats(Path statsOut, RewriteStats stats) throws Exception {
    ensureParent(statsOut);
    StringBuilder sb = new StringBuilder();
    sb.append("{\n");
    sb.append("  \"generatedAt\": ").append(QuestSemanticJson.jsonString(stats.generatedAt)).append(",\n");
    sb.append("  \"clusterReportPath\": ").append(QuestSemanticJson.jsonString(stats.clusterReportPath)).append(",\n");
    sb.append("  \"sourceDir\": ").append(QuestSemanticJson.jsonString(stats.sourceDir)).append(",\n");
    sb.append("  \"outputDir\": ").append(QuestSemanticJson.jsonString(stats.outputDir)).append(",\n");
    sb.append("  \"totalScannedFiles\": ").append(stats.totalScannedFiles).append(",\n");
    sb.append("  \"totalRewrittenFiles\": ").append(stats.totalRewrittenFiles).append(",\n");
    sb.append("  \"totalRewrittenBlocks\": ").append(stats.totalRewrittenBlocks).append(",\n");
    sb.append("  \"totalRemovedIndexedAccess\": ").append(stats.totalRemovedIndexedAccess).append(",\n");
    sb.append("  \"missingFiles\": ").append(QuestSemanticJson.toJsonArrayString(stats.missingFiles)).append("\n");
    sb.append("}\n");
    Files.write(statsOut, sb.toString().getBytes(UTF8));
  }

  private void ensureParent(Path path) throws Exception {
    if(path.getParent() != null && !Files.exists(path.getParent())) {
      Files.createDirectories(path.getParent());
    }
  }

  private static String normalizePath(String path) {
    if(path == null) {
      return "";
    }
    return path.replace('\\', '/').trim();
  }

  private static String stringOf(Object value) {
    return value == null ? "" : String.valueOf(value);
  }

  private static int intOf(Object value) {
    if(value instanceof Number) {
      return ((Number) value).intValue();
    }
    return parseIntSafe(stringOf(value));
  }

  private static int parseIntSafe(String text) {
    if(text == null) {
      return -1;
    }
    String trimmed = text.trim();
    if(trimmed.isEmpty()) {
      return -1;
    }
    try {
      return Integer.parseInt(trimmed);
    } catch(Exception ex) {
      return -1;
    }
  }

  private DecodedText decode(byte[] raw) throws Exception {
    byte[] bom = new byte[0];
    byte[] content = raw;
    if(raw.length >= 3 && (raw[0] & 0xFF) == 0xEF && (raw[1] & 0xFF) == 0xBB && (raw[2] & 0xFF) == 0xBF) {
      bom = new byte[] {(byte) 0xEF, (byte) 0xBB, (byte) 0xBF};
      content = new byte[raw.length - 3];
      System.arraycopy(raw, 3, content, 0, content.length);
    }

    Charset[] charsets = new Charset[] {
        Charset.forName("UTF-8"),
        Charset.forName("GB18030"),
        Charset.forName("GBK"),
        Charset.forName("Big5")
    };
    for(Charset charset : charsets) {
      try {
        CharsetDecoder decoder = charset.newDecoder();
        decoder.onMalformedInput(CodingErrorAction.REPORT);
        decoder.onUnmappableCharacter(CodingErrorAction.REPORT);
        CharBuffer chars = decoder.decode(ByteBuffer.wrap(content));
        DecodedText decoded = new DecodedText();
        decoded.charset = charset;
        decoded.bom = bom;
        decoded.text = chars.toString();
        return decoded;
      } catch(CharacterCodingException ignored) {
      }
    }

    DecodedText decoded = new DecodedText();
    decoded.charset = UTF8;
    decoded.bom = bom;
    decoded.text = new String(content, UTF8);
    return decoded;
  }

  private byte[] encode(String text, Charset charset, byte[] bom) {
    byte[] body = text.getBytes(charset);
    if(bom == null || bom.length == 0) {
      return body;
    }
    byte[] out = new byte[bom.length + body.length];
    System.arraycopy(bom, 0, out, 0, bom.length);
    System.arraycopy(body, 0, out, bom.length, body.length);
    return out;
  }

  private String detectLineEnding(String text) {
    if(text.contains("\r\n")) {
      return "\r\n";
    }
    if(text.contains("\n")) {
      return "\n";
    }
    if(text.contains("\r")) {
      return "\r";
    }
    return "\r\n";
  }

  private boolean hasFinalNewline(String text) {
    if(text == null || text.isEmpty()) {
      return false;
    }
    return text.endsWith("\r\n") || text.endsWith("\n") || text.endsWith("\r");
  }

  private List<String> splitLines(String text) {
    String normalized = text.replace("\r\n", "\n").replace('\r', '\n');
    String[] arr = normalized.split("\n", -1);
    List<String> lines = new ArrayList<String>(arr.length);
    Collections.addAll(lines, arr);
    if(!lines.isEmpty() && lines.get(lines.size() - 1).isEmpty()) {
      lines.remove(lines.size() - 1);
    }
    return lines;
  }

  private String joinLines(List<String> lines, String lineEnding, boolean finalNewline) {
    StringBuilder sb = new StringBuilder();
    for(int i = 0; i < lines.size(); i++) {
      if(i > 0) {
        sb.append(lineEnding);
      }
      sb.append(lines.get(i));
    }
    if(finalNewline && !lines.isEmpty()) {
      sb.append(lineEnding);
    }
    return sb.toString();
  }

  private int precedenceOf(Expr expression) {
    if(expression instanceof BinaryExpr) {
      String op = ((BinaryExpr) expression).operator;
      if("or".equals(op)) {
        return 1;
      }
      if("and".equals(op)) {
        return 2;
      }
      return 3;
    }
    if(expression instanceof UnaryExpr) {
      return 4;
    }
    if(expression instanceof CallExpr || expression instanceof FieldExpr || expression instanceof IndexExpr) {
      return 5;
    }
    return 6;
  }

  private Expr simplifyLogical(BinaryExpr expression) {
    if(expression == null || !isLogicalOperator(expression.operator)) {
      return expression;
    }

    List<Expr> flattened = new ArrayList<Expr>();
    flattenByOperator(expression, expression.operator, flattened);

    List<Expr> normalized = new ArrayList<Expr>();
    Set<Integer> seenHelpers = new LinkedHashSet<Integer>();
    Set<String> seenRendered = new LinkedHashSet<String>();
    for(Expr term : flattened) {
      int helperQuest = helperQuestId(term);
      if(helperQuest > 0) {
        if(seenHelpers.contains(Integer.valueOf(helperQuest))) {
          continue;
        }
        seenHelpers.add(Integer.valueOf(helperQuest));
        normalized.add(new HelperExpr(helperQuest));
        continue;
      }

      String rendered = renderExpression(term);
      if(!seenRendered.contains(rendered)) {
        seenRendered.add(rendered);
        normalized.add(term);
      }
    }

    if(normalized.isEmpty()) {
      return expression;
    }
    if(normalized.size() == 1) {
      return normalized.get(0);
    }

    Expr current = normalized.get(0);
    for(int i = 1; i < normalized.size(); i++) {
      current = new BinaryExpr(expression.operator, current, normalized.get(i));
    }
    return current;
  }

  private void flattenByOperator(Expr expression,
                                 String operator,
                                 List<Expr> out) {
    Expr unwrapped = unwrapParen(expression);
    if(unwrapped instanceof BinaryExpr) {
      BinaryExpr binary = (BinaryExpr) unwrapped;
      if(operator.equals(binary.operator)) {
        flattenByOperator(binary.left, operator, out);
        flattenByOperator(binary.right, operator, out);
        return;
      }
    }
    out.add(unwrapped);
  }

  private MatchPair matchGetItemPair(Expr expression,
                                     Set<Integer> scopedQuestIds) {
    Expr unwrapped = unwrapParen(expression);
    if(!(unwrapped instanceof BinaryExpr)) {
      return null;
    }

    BinaryExpr compare = (BinaryExpr) unwrapped;
    if(!">=".equals(compare.operator)) {
      return null;
    }

    Expr leftExpr = unwrapParen(compare.left);
    Expr rightExpr = unwrapParen(compare.right);
    if(!(leftExpr instanceof CallExpr)) {
      return null;
    }

    CallExpr call = (CallExpr) leftExpr;
    String functionName = simpleName(call.callee);
    if(functionName == null || !"CHECK_ITEM_CNT".equalsIgnoreCase(functionName)) {
      return null;
    }
    if(call.arguments.size() != 1) {
      return null;
    }

    QtGetItemPath leftPath = parseQtGoalGetItemPath(call.arguments.get(0), "id");
    QtGetItemPath rightPath = parseQtGoalGetItemPath(rightExpr, "count");
    if(leftPath == null || rightPath == null) {
      return null;
    }
    if(leftPath.questId != rightPath.questId || leftPath.itemIndex != rightPath.itemIndex) {
      return null;
    }
    if(leftPath.itemIndex <= 0) {
      return null;
    }

    if(scopedQuestIds != null && !scopedQuestIds.isEmpty()
        && !scopedQuestIds.contains(Integer.valueOf(leftPath.questId))) {
      return null;
    }

    MatchPair pair = new MatchPair();
    pair.questId = leftPath.questId;
    pair.itemIndex = leftPath.itemIndex;
    return pair;
  }

  private QtGetItemPath parseQtGoalGetItemPath(Expr expression,
                                               String fieldName) {
    Expr current = unwrapParen(expression);
    if(!(current instanceof FieldExpr)) {
      return null;
    }
    FieldExpr field = (FieldExpr) current;
    if(!fieldName.equals(field.field)) {
      return null;
    }

    Expr getItemNode = unwrapParen(field.base);
    if(!(getItemNode instanceof IndexExpr)) {
      return null;
    }
    IndexExpr getItemIndex = (IndexExpr) getItemNode;
    int itemIndex = intValue(getItemIndex.index);
    if(itemIndex <= 0) {
      return null;
    }

    Expr getItemFieldNode = unwrapParen(getItemIndex.base);
    if(!(getItemFieldNode instanceof FieldExpr)) {
      return null;
    }
    FieldExpr getItemField = (FieldExpr) getItemFieldNode;
    if(!"getItem".equals(getItemField.field)) {
      return null;
    }

    Expr goalFieldNode = unwrapParen(getItemField.base);
    if(!(goalFieldNode instanceof FieldExpr)) {
      return null;
    }
    FieldExpr goalField = (FieldExpr) goalFieldNode;
    if(!"goal".equals(goalField.field)) {
      return null;
    }

    Expr qtIndexNode = unwrapParen(goalField.base);
    if(!(qtIndexNode instanceof IndexExpr)) {
      return null;
    }
    IndexExpr qtIndex = (IndexExpr) qtIndexNode;

    Expr qtBase = unwrapParen(qtIndex.base);
    if(!(qtBase instanceof NameExpr)) {
      return null;
    }
    NameExpr qtName = (NameExpr) qtBase;
    if(!"qt".equals(qtName.name)) {
      return null;
    }

    int questId = intValue(qtIndex.index);
    if(questId <= 0) {
      return null;
    }

    QtGetItemPath path = new QtGetItemPath();
    path.questId = questId;
    path.itemIndex = itemIndex;
    path.field = fieldName;
    return path;
  }

  private int intValue(Expr expression) {
    Expr current = unwrapParen(expression);
    if(current instanceof NumberExpr) {
      return parseIntSafe(((NumberExpr) current).text);
    }
    if(current instanceof RawExpr) {
      return parseIntSafe(((RawExpr) current).text);
    }
    return -1;
  }

  private String simpleName(Expr expression) {
    Expr current = unwrapParen(expression);
    if(current instanceof NameExpr) {
      return ((NameExpr) current).name;
    }
    return null;
  }

  private boolean isLogicalOperator(String operator) {
    return "and".equals(operator) || "or".equals(operator);
  }

  private int helperQuestId(Expr expression) {
    Expr current = unwrapParen(expression);
    if(current instanceof HelperExpr) {
      return ((HelperExpr) current).questId;
    }
    return -1;
  }

  private Expr unwrapParen(Expr expression) {
    Expr current = expression;
    while(current instanceof ParenExpr) {
      current = ((ParenExpr) current).expression;
    }
    return current;
  }

  private boolean isIdentifierStart(char ch) {
    return ch == '_' || Character.isLetter(ch);
  }

  private boolean isIdentifierPart(char ch) {
    return ch == '_' || Character.isLetterOrDigit(ch);
  }

  private boolean isKeyword(String ident) {
    if(ident == null) {
      return false;
    }
    return "if".equals(ident)
        || "then".equals(ident)
        || "elseif".equals(ident)
        || "and".equals(ident)
        || "or".equals(ident)
        || "not".equals(ident)
        || "true".equals(ident)
        || "false".equals(ident)
        || "nil".equals(ident);
  }

  private int consumeQuotedString(String text,
                                  int start,
                                  char quote) {
    int index = start + 1;
    while(index < text.length()) {
      char ch = text.charAt(index++);
      if(ch == '\\') {
        if(index < text.length()) {
          index++;
        }
        continue;
      }
      if(ch == quote) {
        return index;
      }
    }
    return text.length();
  }

  private int consumeNumber(String text,
                            int start) {
    int index = start;
    while(index < text.length() && Character.isDigit(text.charAt(index))) {
      index++;
    }

    if(index + 1 < text.length() && text.charAt(index) == '.' && Character.isDigit(text.charAt(index + 1))) {
      index += 2;
      while(index < text.length() && Character.isDigit(text.charAt(index))) {
        index++;
      }
    }

    if(index < text.length() && (text.charAt(index) == 'e' || text.charAt(index) == 'E')) {
      index++;
      if(index < text.length() && (text.charAt(index) == '+' || text.charAt(index) == '-')) {
        index++;
      }
      while(index < text.length() && Character.isDigit(text.charAt(index))) {
        index++;
      }
    }
    return index;
  }

  private int skipLine(String text,
                       int start) {
    int index = start;
    while(index < text.length()) {
      char ch = text.charAt(index);
      if(ch == '\r') {
        if(index + 1 < text.length() && text.charAt(index + 1) == '\n') {
          return index + 2;
        }
        return index + 1;
      }
      if(ch == '\n') {
        return index + 1;
      }
      index++;
    }
    return text.length();
  }

  private int longBracketEquals(String text,
                                int start) {
    if(start < 0 || start >= text.length() || text.charAt(start) != '[') {
      return -1;
    }
    int index = start + 1;
    int equals = 0;
    while(index < text.length() && text.charAt(index) == '=') {
      equals++;
      index++;
    }
    if(index < text.length() && text.charAt(index) == '[') {
      return equals;
    }
    return -1;
  }

  private int findLongBracketEnd(String text,
                                 int start,
                                 int equals) {
    int index = start + 2 + equals;
    while(index < text.length()) {
      if(text.charAt(index) == ']') {
        int cursor = index + 1;
        int matched = 0;
        while(matched < equals && cursor < text.length() && text.charAt(cursor) == '=') {
          matched++;
          cursor++;
        }
        if(matched == equals && cursor < text.length() && text.charAt(cursor) == ']') {
          return cursor + 1;
        }
      }
      index++;
    }
    return -1;
  }

  private static final class ExpressionParser {

    private final List<Token> tokens;
    private int index;

    ExpressionParser(List<Token> tokens) {
      this.tokens = tokens == null ? Collections.<Token>emptyList() : tokens;
      this.index = 0;
    }

    Expr parseExpression() {
      if(tokens.isEmpty()) {
        return null;
      }
      return parseOr();
    }

    boolean isAtEnd() {
      return index >= tokens.size();
    }

    private Expr parseOr() {
      Expr left = parseAnd();
      while(matchKeyword("or")) {
        Expr right = parseAnd();
        left = new BinaryExpr("or", left, right);
      }
      return left;
    }

    private Expr parseAnd() {
      Expr left = parseCompare();
      while(matchKeyword("and")) {
        Expr right = parseCompare();
        left = new BinaryExpr("and", left, right);
      }
      return left;
    }

    private Expr parseCompare() {
      Expr left = parseUnary();
      if(matchSymbol("==") || matchSymbol("~=") || matchSymbol(">=")
          || matchSymbol("<=") || matchSymbol(">") || matchSymbol("<")) {
        String op = previous().text;
        Expr right = parseUnary();
        return new BinaryExpr(op, left, right);
      }
      return left;
    }

    private Expr parseUnary() {
      if(matchKeyword("not")) {
        Expr child = parseUnary();
        return new UnaryExpr("not", child);
      }
      return parsePrimary();
    }

    private Expr parsePrimary() {
      if(matchSymbol("(")) {
        Expr expression = parseExpression();
        matchSymbol(")");
        return parsePostfix(new ParenExpr(expression));
      }

      if(matchKind(TokenKind.IDENT)) {
        return parsePostfix(new NameExpr(previous().text));
      }
      if(matchKind(TokenKind.NUMBER)) {
        return parsePostfix(new NumberExpr(previous().text));
      }
      if(matchKind(TokenKind.STRING)) {
        return parsePostfix(new StringExpr(previous().text));
      }
      if(matchKeyword("true") || matchKeyword("false") || matchKeyword("nil")) {
        return parsePostfix(new RawExpr(previous().text));
      }

      if(!isAtEnd()) {
        return new RawExpr(advance().text);
      }
      return new RawExpr("");
    }

    private Expr parsePostfix(Expr base) {
      Expr current = base;
      while(!isAtEnd()) {
        if(matchSymbol(".")) {
          Token name = consumeIdentifierLike();
          if(name == null) {
            break;
          }
          current = new FieldExpr(current, name.text);
          continue;
        }

        if(matchSymbol("[")) {
          Expr key = parseExpression();
          if(!matchSymbol("]")) {
            break;
          }
          current = new IndexExpr(current, key);
          continue;
        }

        if(matchSymbol("(")) {
          List<Expr> args = new ArrayList<Expr>();
          if(!matchSymbol(")")) {
            while(true) {
              args.add(parseExpression());
              if(matchSymbol(",")) {
                continue;
              }
              matchSymbol(")");
              break;
            }
          }
          current = new CallExpr(current, args);
          continue;
        }
        break;
      }
      return current;
    }

    private Token consumeIdentifierLike() {
      if(isAtEnd()) {
        return null;
      }
      Token token = peek();
      if(token.kind == TokenKind.IDENT || token.kind == TokenKind.KEYWORD) {
        return advance();
      }
      return null;
    }

    private boolean matchKind(TokenKind kind) {
      if(isAtEnd()) {
        return false;
      }
      if(peek().kind != kind) {
        return false;
      }
      advance();
      return true;
    }

    private boolean matchKeyword(String keyword) {
      if(isAtEnd()) {
        return false;
      }
      Token token = peek();
      if(token.kind == TokenKind.KEYWORD && keyword.equals(token.text)) {
        advance();
        return true;
      }
      return false;
    }

    private boolean matchSymbol(String symbol) {
      if(isAtEnd()) {
        return false;
      }
      Token token = peek();
      if(token.kind == TokenKind.SYMBOL && symbol.equals(token.text)) {
        advance();
        return true;
      }
      return false;
    }

    private Token peek() {
      return tokens.get(index);
    }

    private Token advance() {
      return tokens.get(index++);
    }

    private Token previous() {
      return tokens.get(index - 1);
    }
  }

  private interface Expr {
  }

  private static final class RawExpr implements Expr {
    final String text;
    RawExpr(String text) {
      this.text = text == null ? "" : text;
    }
  }

  private static final class NameExpr implements Expr {
    final String name;
    NameExpr(String name) {
      this.name = name == null ? "" : name;
    }
  }

  private static final class NumberExpr implements Expr {
    final String text;
    NumberExpr(String text) {
      this.text = text == null ? "0" : text;
    }
  }

  private static final class StringExpr implements Expr {
    final String text;
    StringExpr(String text) {
      this.text = text == null ? "\"\"" : text;
    }
  }

  private static final class ParenExpr implements Expr {
    final Expr expression;
    ParenExpr(Expr expression) {
      this.expression = expression;
    }
  }

  private static final class UnaryExpr implements Expr {
    final String operator;
    final Expr expression;
    UnaryExpr(String operator, Expr expression) {
      this.operator = operator;
      this.expression = expression;
    }
  }

  private static final class BinaryExpr implements Expr {
    final String operator;
    final Expr left;
    final Expr right;
    BinaryExpr(String operator, Expr left, Expr right) {
      this.operator = operator;
      this.left = left;
      this.right = right;
    }
  }

  private static final class CallExpr implements Expr {
    final Expr callee;
    final List<Expr> arguments;
    CallExpr(Expr callee, List<Expr> arguments) {
      this.callee = callee;
      this.arguments = arguments == null ? Collections.<Expr>emptyList() : arguments;
    }
  }

  private static final class FieldExpr implements Expr {
    final Expr base;
    final String field;
    FieldExpr(Expr base, String field) {
      this.base = base;
      this.field = field == null ? "" : field;
    }
  }

  private static final class IndexExpr implements Expr {
    final Expr base;
    final Expr index;
    IndexExpr(Expr base, Expr index) {
      this.base = base;
      this.index = index;
    }
  }

  private static final class HelperExpr implements Expr {
    final int questId;
    HelperExpr(int questId) {
      this.questId = questId;
    }
  }

  private enum TokenKind {
    IDENT,
    NUMBER,
    STRING,
    SYMBOL,
    KEYWORD
  }

  private static final class Token {
    final TokenKind kind;
    final String text;
    final int startOffset;
    final int endOffset;
    Token(TokenKind kind, String text, int startOffset, int endOffset) {
      this.kind = kind;
      this.text = text;
      this.startOffset = startOffset;
      this.endOffset = endOffset;
    }
    boolean isKeyword(String keyword) {
      return kind == TokenKind.KEYWORD && keyword.equals(text);
    }
    boolean isSymbol(String symbol) {
      return kind == TokenKind.SYMBOL && symbol.equals(text);
    }
  }

  private static final class IfSpan {
    int conditionStartTokenIndex;
    int thenTokenIndex;
    int conditionStartOffset;
    int conditionEndOffset;
  }

  private static final class MatchPair {
    int questId;
    int itemIndex;
  }

  private static final class QtGetItemPath {
    int questId;
    int itemIndex;
    String field;
  }

  private static final class RewriteOutcome {
    final Expr expression;
    final boolean changed;
    final int removedPairCount;
    RewriteOutcome(Expr expression, boolean changed, int removedPairCount) {
      this.expression = expression;
      this.changed = changed;
      this.removedPairCount = removedPairCount;
    }
    static RewriteOutcome unchanged(Expr expression) {
      return new RewriteOutcome(expression, false, 0);
    }
  }

  private static final class ConditionReplacement {
    int startOffset;
    int endOffset;
    int startLine;
    int endLine;
    String before;
    String after;
    int removedIndexedAccess;
  }

  private static final class ConditionDiff {
    int lineStart;
    int lineEnd;
    String before;
    String after;
  }

  private static final class HelperInsertion {
    String text;
    ConditionDiff diff;
  }

  private static final class FileRewriteResult {
    boolean changed;
    byte[] bytes;
    int rewrittenBlocks;
    int removedIndexedAccess;
    final List<ConditionDiff> conditionDiffs = new ArrayList<ConditionDiff>();
  }

  public static final class RewriteStats {
    public String generatedAt = "";
    public String clusterReportPath = "";
    public String sourceDir = "";
    public String outputDir = "";
    public int totalScannedFiles;
    public int totalRewrittenFiles;
    public int totalRewrittenBlocks;
    public int totalRemovedIndexedAccess;
    public final List<String> missingFiles = new ArrayList<String>();
  }

  private static final class DecodedText {
    Charset charset;
    byte[] bom;
    String text;
  }
}
