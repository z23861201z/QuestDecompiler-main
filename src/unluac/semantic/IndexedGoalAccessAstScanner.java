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
import java.time.OffsetDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.LinkedHashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Set;

public class IndexedGoalAccessAstScanner {

  private static final Charset UTF8 = Charset.forName("UTF-8");

  public static void main(String[] args) throws Exception {
    Path inputDir = args.length >= 1
        ? Paths.get(args[0])
        : Paths.get("npc-lua-regression", "round_7A_rewritten");
    Path output = args.length >= 2
        ? Paths.get(args[1])
        : Paths.get("reports", "indexed_goal_access_full_scan.json");

    IndexedGoalAccessAstScanner scanner = new IndexedGoalAccessAstScanner();
    ScanReport report = scanner.scan(inputDir, output);

    System.out.println("inputDir=" + inputDir.toAbsolutePath());
    System.out.println("output=" + output.toAbsolutePath());
    System.out.println("totalIndexedAccess=" + report.totalIndexedAccess);
    System.out.println("getItemIndexedCount=" + report.getItemIndexedCount);
    System.out.println("killMonsterIndexedCount=" + report.killMonsterIndexedCount);
    System.out.println("meetNpcIndexedCount=" + report.meetNpcIndexedCount);
  }

  public ScanReport scan(Path inputDir, Path output) throws Exception {
    if(inputDir == null || !Files.exists(inputDir) || !Files.isDirectory(inputDir)) {
      throw new IllegalStateException("input dir not found: " + inputDir);
    }

    List<Path> files = new ArrayList<Path>();
    Files.walk(inputDir)
        .filter(Files::isRegularFile)
        .filter(path -> {
          String lower = path.getFileName().toString().toLowerCase(Locale.ROOT);
          return lower.startsWith("npc_") && lower.endsWith(".lua");
        })
        .forEach(files::add);
    Collections.sort(files);

    ScanReport report = new ScanReport();
    report.generatedAt = OffsetDateTime.now().format(DateTimeFormatter.ISO_OFFSET_DATE_TIME);
    report.sourceDir = inputDir.toAbsolutePath().toString();
    report.scannedFiles = files.size();

    for(Path file : files) {
      String rel = normalizePath(inputDir.relativize(file).toString());
      scanOneFile(file, rel, report);
    }

    report.totalIndexedAccess = report.getItemIndexedCount + report.killMonsterIndexedCount + report.meetNpcIndexedCount;
    writeReport(output, report);
    return report;
  }

  private void scanOneFile(Path file, String relativeFile, ScanReport report) throws Exception {
    byte[] raw = Files.readAllBytes(file);
    DecodedText decoded = decode(raw);
    String text = decoded.text;

    List<Token> tokens = tokenize(text);
    for(int i = 0; i < tokens.size(); i++) {
      Token token = tokens.get(i);
      if(token.kind != TokenKind.IDENT || !"qt".equals(token.text)) {
        continue;
      }

      ParseResult parsed = parsePostfixChain(tokens, i);
      if(parsed == null || parsed.node == null) {
        continue;
      }

      List<IndexAccessNode> indexNodes = new ArrayList<IndexAccessNode>();
      collectIndexNodes(parsed.node, indexNodes);
      for(IndexAccessNode indexNode : indexNodes) {
        AccessMatch match = matchGoalIndexedAccess(indexNode);
        if(match == null) {
          continue;
        }

        NodeLocation location = new NodeLocation();
        location.npcFile = relativeFile;
        location.questId = match.questId;
        location.accessType = match.accessType;
        location.index = match.index;
        location.line = indexNode.line;
        location.column = indexNode.column;
        location.fullExpressionText = safeSlice(text, indexNode.startOffset, indexNode.endOffset);
        report.nodeLocation.add(location);

        CountTriple fileCounter = report.byNpcFile.get(relativeFile);
        if(fileCounter == null) {
          fileCounter = new CountTriple();
          report.byNpcFile.put(relativeFile, fileCounter);
        }
        fileCounter.add(match.accessType);

        String questKey = Integer.toString(match.questId);
        CountTriple questCounter = report.byQuestId.get(questKey);
        if(questCounter == null) {
          questCounter = new CountTriple();
          report.byQuestId.put(questKey, questCounter);
        }
        questCounter.add(match.accessType);

        if("getItem".equals(match.accessType)) {
          report.getItemIndexedCount++;
        } else if("killMonster".equals(match.accessType)) {
          report.killMonsterIndexedCount++;
        } else if("meetNpc".equals(match.accessType)) {
          report.meetNpcIndexedCount++;
        }
      }
    }
  }

  private AccessMatch matchGoalIndexedAccess(IndexAccessNode indexNode) {
    if(indexNode == null || !(indexNode.indexExpr instanceof NumberNode)) {
      return null;
    }

    ExprNode tableExpr = unwrapParen(indexNode.base);
    if(!(tableExpr instanceof FieldAccessNode)) {
      return null;
    }

    FieldAccessNode targetField = (FieldAccessNode) tableExpr;
    String accessType = targetField.field;
    if(!"getItem".equals(accessType) && !"killMonster".equals(accessType) && !"meetNpc".equals(accessType)) {
      return null;
    }

    ExprNode goalExpr = unwrapParen(targetField.base);
    if(!(goalExpr instanceof FieldAccessNode)) {
      return null;
    }
    FieldAccessNode goalField = (FieldAccessNode) goalExpr;
    if(!"goal".equals(goalField.field)) {
      return null;
    }

    ExprNode qtIndexExpr = unwrapParen(goalField.base);
    if(!(qtIndexExpr instanceof IndexAccessNode)) {
      return null;
    }
    IndexAccessNode qtIndex = (IndexAccessNode) qtIndexExpr;

    ExprNode qtBase = unwrapParen(qtIndex.base);
    if(!(qtBase instanceof NameNode) || !"qt".equals(((NameNode) qtBase).name)) {
      return null;
    }

    if(!(unwrapParen(qtIndex.indexExpr) instanceof NumberNode)) {
      return null;
    }
    int questId = parseIntSafe(((NumberNode) unwrapParen(qtIndex.indexExpr)).text);
    int index = parseIntSafe(((NumberNode) indexNode.indexExpr).text);
    if(questId <= 0 || index <= 0) {
      return null;
    }

    AccessMatch match = new AccessMatch();
    match.questId = questId;
    match.index = index;
    match.accessType = accessType;
    return match;
  }

  private void collectIndexNodes(ExprNode node, List<IndexAccessNode> out) {
    if(node == null) {
      return;
    }
    if(node instanceof IndexAccessNode) {
      out.add((IndexAccessNode) node);
      IndexAccessNode idx = (IndexAccessNode) node;
      collectIndexNodes(idx.base, out);
      collectIndexNodes(idx.indexExpr, out);
      return;
    }
    if(node instanceof FieldAccessNode) {
      collectIndexNodes(((FieldAccessNode) node).base, out);
      return;
    }
    if(node instanceof CallNode) {
      CallNode call = (CallNode) node;
      collectIndexNodes(call.callee, out);
      for(ExprNode arg : call.arguments) {
        collectIndexNodes(arg, out);
      }
      return;
    }
    if(node instanceof BinaryNode) {
      collectIndexNodes(((BinaryNode) node).left, out);
      collectIndexNodes(((BinaryNode) node).right, out);
      return;
    }
    if(node instanceof UnaryNode) {
      collectIndexNodes(((UnaryNode) node).expr, out);
      return;
    }
    if(node instanceof ParenNode) {
      collectIndexNodes(((ParenNode) node).inner, out);
    }
  }

  private ExprNode unwrapParen(ExprNode node) {
    ExprNode current = node;
    while(current instanceof ParenNode) {
      current = ((ParenNode) current).inner;
    }
    return current;
  }

  private ParseResult parsePostfixChain(List<Token> tokens, int startIndex) {
    if(startIndex < 0 || startIndex >= tokens.size()) {
      return null;
    }
    Token first = tokens.get(startIndex);
    if(first.kind != TokenKind.IDENT && first.kind != TokenKind.KEYWORD) {
      return null;
    }

    ExprNode current = new NameNode(first.text, first.startOffset, first.endOffset, first.line, first.column);
    int index = startIndex + 1;
    while(index < tokens.size()) {
      Token token = tokens.get(index);
      if(token.isSymbol(".")) {
        if(index + 1 >= tokens.size()) {
          break;
        }
        Token name = tokens.get(index + 1);
        if(name.kind != TokenKind.IDENT && name.kind != TokenKind.KEYWORD) {
          break;
        }
        current = new FieldAccessNode(current, name.text, current.startOffset, name.endOffset, current.line, current.column);
        index += 2;
        continue;
      }

      if(token.isSymbol("[")) {
        int close = findMatching(tokens, index, "[", "]");
        if(close < 0) {
          break;
        }
        ExprNode indexExpr = parseExpressionSlice(tokens, index + 1, close);
        Token closeToken = tokens.get(close);
        current = new IndexAccessNode(current, indexExpr, current.startOffset, closeToken.endOffset, current.line, current.column);
        index = close + 1;
        continue;
      }

      if(token.isSymbol("(")) {
        int close = findMatching(tokens, index, "(", ")");
        if(close < 0) {
          break;
        }
        List<ExprNode> args = parseArgs(tokens, index + 1, close);
        Token closeToken = tokens.get(close);
        current = new CallNode(current, args, current.startOffset, closeToken.endOffset, current.line, current.column);
        index = close + 1;
        continue;
      }

      break;
    }

    ParseResult out = new ParseResult();
    out.node = current;
    out.nextIndex = index;
    return out;
  }

  private List<ExprNode> parseArgs(List<Token> tokens, int start, int endExclusive) {
    List<ExprNode> args = new ArrayList<ExprNode>();
    int cursor = start;
    int depthParen = 0;
    int depthBracket = 0;
    int depthBrace = 0;
    int argStart = start;
    while(cursor < endExclusive) {
      Token t = tokens.get(cursor);
      if(t.isSymbol("(")) depthParen++;
      else if(t.isSymbol(")")) depthParen--;
      else if(t.isSymbol("[")) depthBracket++;
      else if(t.isSymbol("]")) depthBracket--;
      else if(t.isSymbol("{")) depthBrace++;
      else if(t.isSymbol("}")) depthBrace--;

      if(depthParen == 0 && depthBracket == 0 && depthBrace == 0 && t.isSymbol(",")) {
        args.add(parseExpressionSlice(tokens, argStart, cursor));
        argStart = cursor + 1;
      }
      cursor++;
    }
    if(argStart < endExclusive) {
      args.add(parseExpressionSlice(tokens, argStart, endExclusive));
    }
    return args;
  }

  private ExprNode parseExpressionSlice(List<Token> tokens, int start, int endExclusive) {
    if(start >= endExclusive) {
      return new RawNode("", 0, 0, 1, 1);
    }
    ExpressionParser parser = new ExpressionParser(tokens, start, endExclusive);
    ExprNode parsed = parser.parseExpression();
    if(parsed == null || !parser.isAtEnd()) {
      Token s = tokens.get(start);
      Token e = tokens.get(endExclusive - 1);
      return new RawNode(joinTokenText(tokens, start, endExclusive), s.startOffset, e.endOffset, s.line, s.column);
    }
    return parsed;
  }

  private int findMatching(List<Token> tokens, int openIndex, String open, String close) {
    int depth = 0;
    for(int i = openIndex; i < tokens.size(); i++) {
      Token t = tokens.get(i);
      if(t.isSymbol(open)) {
        depth++;
      } else if(t.isSymbol(close)) {
        depth--;
        if(depth == 0) {
          return i;
        }
      }
    }
    return -1;
  }

  private String joinTokenText(List<Token> tokens, int start, int endExclusive) {
    StringBuilder sb = new StringBuilder();
    for(int i = start; i < endExclusive; i++) {
      if(i > start) {
        sb.append(' ');
      }
      sb.append(tokens.get(i).text);
    }
    return sb.toString();
  }

  private String safeSlice(String text, int startOffset, int endOffset) {
    if(text == null || text.isEmpty()) {
      return "";
    }
    int start = Math.max(0, Math.min(startOffset, text.length()));
    int end = Math.max(start, Math.min(endOffset, text.length()));
    return text.substring(start, end);
  }

  private void writeReport(Path output, ScanReport report) throws Exception {
    if(output.getParent() != null && !Files.exists(output.getParent())) {
      Files.createDirectories(output.getParent());
    }

    List<Map.Entry<String, CountTriple>> quests = new ArrayList<Map.Entry<String, CountTriple>>(report.byQuestId.entrySet());
    Collections.sort(quests, Comparator.comparingInt(entry -> parseIntSafe(entry.getKey())));

    List<Map.Entry<String, CountTriple>> files = new ArrayList<Map.Entry<String, CountTriple>>(report.byNpcFile.entrySet());
    Collections.sort(files, Comparator.comparing(Map.Entry::getKey, String.CASE_INSENSITIVE_ORDER));

    StringBuilder sb = new StringBuilder();
    sb.append("{\n");
    sb.append("  \"generatedAt\": ").append(QuestSemanticJson.jsonString(report.generatedAt)).append(",\n");
    sb.append("  \"sourceDir\": ").append(QuestSemanticJson.jsonString(report.sourceDir)).append(",\n");
    sb.append("  \"scannedFiles\": ").append(report.scannedFiles).append(",\n");
    sb.append("  \"totalIndexedAccess\": ").append(report.totalIndexedAccess).append(",\n");
    sb.append("  \"getItemIndexedCount\": ").append(report.getItemIndexedCount).append(",\n");
    sb.append("  \"killMonsterIndexedCount\": ").append(report.killMonsterIndexedCount).append(",\n");
    sb.append("  \"meetNpcIndexedCount\": ").append(report.meetNpcIndexedCount).append(",\n");

    sb.append("  \"byQuestId\": {");
    if(!quests.isEmpty()) {
      sb.append("\n");
      for(int i = 0; i < quests.size(); i++) {
        if(i > 0) sb.append(",\n");
        Map.Entry<String, CountTriple> e = quests.get(i);
        sb.append("    ").append(QuestSemanticJson.jsonString(e.getKey())).append(": ").append(e.getValue().toJson());
      }
      sb.append("\n  ");
    }
    sb.append("},\n");

    sb.append("  \"byNpcFile\": {");
    if(!files.isEmpty()) {
      sb.append("\n");
      for(int i = 0; i < files.size(); i++) {
        if(i > 0) sb.append(",\n");
        Map.Entry<String, CountTriple> e = files.get(i);
        sb.append("    ").append(QuestSemanticJson.jsonString(e.getKey())).append(": ").append(e.getValue().toJson());
      }
      sb.append("\n  ");
    }
    sb.append("},\n");

    sb.append("  \"nodeLocation\": [");
    if(!report.nodeLocation.isEmpty()) {
      sb.append("\n");
      for(int i = 0; i < report.nodeLocation.size(); i++) {
        NodeLocation n = report.nodeLocation.get(i);
        if(i > 0) sb.append(",\n");
        sb.append("    {")
            .append("\"npcFile\": ").append(QuestSemanticJson.jsonString(n.npcFile)).append(", ")
            .append("\"questId\": ").append(n.questId).append(", ")
            .append("\"accessType\": ").append(QuestSemanticJson.jsonString(n.accessType)).append(", ")
            .append("\"index\": ").append(n.index).append(", ")
            .append("\"line\": ").append(n.line).append(", ")
            .append("\"column\": ").append(n.column).append(", ")
            .append("\"fullExpressionText\": ").append(QuestSemanticJson.jsonString(n.fullExpressionText))
            .append("}");
      }
      sb.append("\n  ");
    }
    sb.append("]\n");
    sb.append("}\n");

    Files.write(output, sb.toString().getBytes(UTF8));
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

  private String normalizePath(String path) {
    if(path == null) {
      return "";
    }
    return path.replace('\\', '/').trim();
  }

  private int parseIntSafe(String text) {
    if(text == null) {
      return -1;
    }
    String value = text.trim();
    if(value.isEmpty()) {
      return -1;
    }
    try {
      return Integer.parseInt(value);
    } catch(Exception ex) {
      return -1;
    }
  }

  private List<Token> tokenize(String text) {
    List<Token> tokens = new ArrayList<Token>();
    int index = 0;
    int line = 1;
    int column = 1;

    while(index < text.length()) {
      char ch = text.charAt(index);
      if(ch == ' ' || ch == '\t' || ch == '\f') {
        index++;
        column++;
        continue;
      }
      if(ch == '\r' || ch == '\n') {
        int[] moved = moveLine(text, index, line, column);
        index = moved[0];
        line = moved[1];
        column = moved[2];
        continue;
      }

      if(ch == '-' && index + 1 < text.length() && text.charAt(index + 1) == '-') {
        int longEq = longBracketEquals(text, index + 2);
        if(longEq >= 0) {
          int[] moved = skipLongBracket(text, index + 2, line, column, longEq);
          index = moved[0];
          line = moved[1];
          column = moved[2];
        } else {
          while(index < text.length() && text.charAt(index) != '\r' && text.charAt(index) != '\n') {
            index++;
            column++;
          }
        }
        continue;
      }

      int tokenLine = line;
      int tokenColumn = column;
      int startOffset = index;

      if(ch == '\'' || ch == '"') {
        int[] moved = consumeQuotedString(text, index, line, column, ch);
        index = moved[0];
        line = moved[1];
        column = moved[2];
        tokens.add(new Token(TokenKind.STRING, text.substring(startOffset, index), startOffset, index, tokenLine, tokenColumn));
        continue;
      }

      int longEq = longBracketEquals(text, index);
      if(longEq >= 0) {
        int[] moved = skipLongBracket(text, index, line, column, longEq);
        index = moved[0];
        line = moved[1];
        column = moved[2];
        tokens.add(new Token(TokenKind.STRING, text.substring(startOffset, index), startOffset, index, tokenLine, tokenColumn));
        continue;
      }

      if(isIdentifierStart(ch)) {
        index++;
        column++;
        while(index < text.length() && isIdentifierPart(text.charAt(index))) {
          index++;
          column++;
        }
        String ident = text.substring(startOffset, index);
        TokenKind kind = isKeyword(ident) ? TokenKind.KEYWORD : TokenKind.IDENT;
        tokens.add(new Token(kind, ident, startOffset, index, tokenLine, tokenColumn));
        continue;
      }

      if(Character.isDigit(ch)) {
        while(index < text.length() && Character.isDigit(text.charAt(index))) {
          index++;
          column++;
        }
        if(index + 1 < text.length() && text.charAt(index) == '.' && Character.isDigit(text.charAt(index + 1))) {
          index += 2;
          column += 2;
          while(index < text.length() && Character.isDigit(text.charAt(index))) {
            index++;
            column++;
          }
        }
        tokens.add(new Token(TokenKind.NUMBER, text.substring(startOffset, index), startOffset, index, tokenLine, tokenColumn));
        continue;
      }

      String two = index + 1 < text.length() ? text.substring(index, index + 2) : "";
      if(">=".equals(two) || "<=".equals(two) || "==".equals(two) || "~=".equals(two) || "..".equals(two)) {
        tokens.add(new Token(TokenKind.SYMBOL, two, startOffset, startOffset + 2, tokenLine, tokenColumn));
        index += 2;
        column += 2;
        continue;
      }

      tokens.add(new Token(TokenKind.SYMBOL, String.valueOf(ch), startOffset, startOffset + 1, tokenLine, tokenColumn));
      index++;
      column++;
    }

    return tokens;
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
        || "else".equals(ident)
        || "end".equals(ident)
        || "and".equals(ident)
        || "or".equals(ident)
        || "not".equals(ident)
        || "true".equals(ident)
        || "false".equals(ident)
        || "nil".equals(ident)
        || "function".equals(ident)
        || "local".equals(ident)
        || "return".equals(ident);
  }

  private int[] moveLine(String text, int index, int line, int column) {
    if(text.charAt(index) == '\r') {
      if(index + 1 < text.length() && text.charAt(index + 1) == '\n') {
        return new int[] {index + 2, line + 1, 1};
      }
      return new int[] {index + 1, line + 1, 1};
    }
    return new int[] {index + 1, line + 1, 1};
  }

  private int[] consumeQuotedString(String text, int index, int line, int column, char quote) {
    index++;
    column++;
    while(index < text.length()) {
      char ch = text.charAt(index);
      if(ch == '\\') {
        if(index + 1 < text.length()) {
          if(text.charAt(index + 1) == '\r' || text.charAt(index + 1) == '\n') {
            int[] moved = moveLine(text, index + 1, line, column + 1);
            index = moved[0];
            line = moved[1];
            column = moved[2];
          } else {
            index += 2;
            column += 2;
          }
          continue;
        }
        index++;
        column++;
        continue;
      }
      if(ch == quote) {
        index++;
        column++;
        break;
      }
      if(ch == '\r' || ch == '\n') {
        int[] moved = moveLine(text, index, line, column);
        index = moved[0];
        line = moved[1];
        column = moved[2];
      } else {
        index++;
        column++;
      }
    }
    return new int[] {index, line, column};
  }

  private int longBracketEquals(String text, int start) {
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

  private int[] skipLongBracket(String text, int start, int line, int column, int equals) {
    int index = start + 2 + equals;
    column += 2 + equals;
    while(index < text.length()) {
      char ch = text.charAt(index);
      if(ch == ']') {
        int cursor = index + 1;
        int matched = 0;
        while(matched < equals && cursor < text.length() && text.charAt(cursor) == '=') {
          matched++;
          cursor++;
        }
        if(matched == equals && cursor < text.length() && text.charAt(cursor) == ']') {
          int consumed = (cursor + 1) - index;
          index = cursor + 1;
          column += consumed;
          return new int[] {index, line, column};
        }
      }

      if(ch == '\r' || ch == '\n') {
        int[] moved = moveLine(text, index, line, column);
        index = moved[0];
        line = moved[1];
        column = moved[2];
      } else {
        index++;
        column++;
      }
    }
    return new int[] {index, line, column};
  }

  private final class ExpressionParser {

    private final List<Token> tokens;
    private final int endExclusive;
    private int index;

    ExpressionParser(List<Token> tokens, int start, int endExclusive) {
      this.tokens = tokens;
      this.index = start;
      this.endExclusive = endExclusive;
    }

    ExprNode parseExpression() {
      if(isAtEnd()) {
        return null;
      }
      return parseOr();
    }

    boolean isAtEnd() {
      return index >= endExclusive;
    }

    private ExprNode parseOr() {
      ExprNode left = parseAnd();
      while(matchKeyword("or")) {
        Token op = previous();
        ExprNode right = parseAnd();
        left = new BinaryNode("or", left, right, left.startOffset, right.endOffset, op.line, op.column);
      }
      return left;
    }

    private ExprNode parseAnd() {
      ExprNode left = parseCompare();
      while(matchKeyword("and")) {
        Token op = previous();
        ExprNode right = parseCompare();
        left = new BinaryNode("and", left, right, left.startOffset, right.endOffset, op.line, op.column);
      }
      return left;
    }

    private ExprNode parseCompare() {
      ExprNode left = parseUnary();
      while(matchSymbol("==") || matchSymbol("~=") || matchSymbol(">=")
          || matchSymbol("<=") || matchSymbol(">") || matchSymbol("<")) {
        String op = previous().text;
        Token opToken = previous();
        ExprNode right = parseUnary();
        left = new BinaryNode(op, left, right, left.startOffset, right.endOffset, opToken.line, opToken.column);
      }
      return left;
    }

    private ExprNode parseUnary() {
      if(matchKeyword("not")) {
        Token op = previous();
        ExprNode child = parseUnary();
        return new UnaryNode("not", child, op.startOffset, child.endOffset, op.line, op.column);
      }
      if(matchSymbol("-")) {
        Token op = previous();
        ExprNode child = parseUnary();
        return new UnaryNode("-", child, op.startOffset, child.endOffset, op.line, op.column);
      }
      return parsePrimary();
    }

    private ExprNode parsePrimary() {
      if(matchSymbol("(")) {
        Token left = previous();
        ExprNode inner = parseExpression();
        Token right = matchSymbol(")") ? previous() : left;
        ParenNode paren = new ParenNode(inner, left.startOffset, right.endOffset, left.line, left.column);
        return parsePostfix(paren);
      }

      if(matchKind(TokenKind.IDENT) || matchKind(TokenKind.KEYWORD)) {
        Token token = previous();
        NameNode node = new NameNode(token.text, token.startOffset, token.endOffset, token.line, token.column);
        return parsePostfix(node);
      }

      if(matchKind(TokenKind.NUMBER)) {
        Token token = previous();
        NumberNode node = new NumberNode(token.text, token.startOffset, token.endOffset, token.line, token.column);
        return parsePostfix(node);
      }

      if(matchKind(TokenKind.STRING)) {
        Token token = previous();
        RawNode node = new RawNode(token.text, token.startOffset, token.endOffset, token.line, token.column);
        return parsePostfix(node);
      }

      if(!isAtEnd()) {
        Token token = advance();
        return new RawNode(token.text, token.startOffset, token.endOffset, token.line, token.column);
      }
      return null;
    }

    private ExprNode parsePostfix(ExprNode base) {
      ExprNode current = base;
      while(!isAtEnd()) {
        if(matchSymbol(".")) {
          if(isAtEnd()) {
            break;
          }
          Token name = peek();
          if(name.kind != TokenKind.IDENT && name.kind != TokenKind.KEYWORD) {
            break;
          }
          advance();
          current = new FieldAccessNode(current, name.text, current.startOffset, name.endOffset, current.line, current.column);
          continue;
        }

        if(matchSymbol("[")) {
          int exprStart = index;
          int close = findMatchingWithin(exprStart - 1, "[", "]");
          if(close < 0) {
            break;
          }
          ExprNode idx = new ExpressionParser(tokens, exprStart, close).parseExpression();
          Token closeToken = tokens.get(close);
          current = new IndexAccessNode(current, idx, current.startOffset, closeToken.endOffset, current.line, current.column);
          index = close + 1;
          continue;
        }

        if(matchSymbol("(")) {
          int argStart = index;
          int close = findMatchingWithin(argStart - 1, "(", ")");
          if(close < 0) {
            break;
          }
          List<ExprNode> args = parseArgs(tokens, argStart, close);
          Token closeToken = tokens.get(close);
          current = new CallNode(current, args, current.startOffset, closeToken.endOffset, current.line, current.column);
          index = close + 1;
          continue;
        }
        break;
      }
      return current;
    }

    private int findMatchingWithin(int openIndex, String open, String close) {
      int depth = 0;
      for(int i = openIndex; i < endExclusive; i++) {
        Token t = tokens.get(i);
        if(t.isSymbol(open)) depth++;
        else if(t.isSymbol(close)) {
          depth--;
          if(depth == 0) return i;
        }
      }
      return -1;
    }

    private boolean matchKind(TokenKind kind) {
      if(isAtEnd()) return false;
      if(peek().kind != kind) return false;
      advance();
      return true;
    }

    private boolean matchKeyword(String keyword) {
      if(isAtEnd()) return false;
      Token t = peek();
      if(t.kind == TokenKind.KEYWORD && keyword.equals(t.text)) {
        advance();
        return true;
      }
      return false;
    }

    private boolean matchSymbol(String symbol) {
      if(isAtEnd()) return false;
      Token t = peek();
      if(t.kind == TokenKind.SYMBOL && symbol.equals(t.text)) {
        advance();
        return true;
      }
      return false;
    }

    private Token previous() {
      return tokens.get(index - 1);
    }

    private Token peek() {
      return tokens.get(index);
    }

    private Token advance() {
      return tokens.get(index++);
    }
  }

  private static abstract class ExprNode {
    final int startOffset;
    final int endOffset;
    final int line;
    final int column;

    ExprNode(int startOffset, int endOffset, int line, int column) {
      this.startOffset = startOffset;
      this.endOffset = endOffset;
      this.line = line;
      this.column = column;
    }
  }

  private static final class NameNode extends ExprNode {
    final String name;
    NameNode(String name, int startOffset, int endOffset, int line, int column) {
      super(startOffset, endOffset, line, column);
      this.name = name;
    }
  }

  private static final class NumberNode extends ExprNode {
    final String text;
    NumberNode(String text, int startOffset, int endOffset, int line, int column) {
      super(startOffset, endOffset, line, column);
      this.text = text;
    }
  }

  private static final class RawNode extends ExprNode {
    final String text;
    RawNode(String text, int startOffset, int endOffset, int line, int column) {
      super(startOffset, endOffset, line, column);
      this.text = text;
    }
  }

  private static final class ParenNode extends ExprNode {
    final ExprNode inner;
    ParenNode(ExprNode inner, int startOffset, int endOffset, int line, int column) {
      super(startOffset, endOffset, line, column);
      this.inner = inner;
    }
  }

  private static final class UnaryNode extends ExprNode {
    final String op;
    final ExprNode expr;
    UnaryNode(String op, ExprNode expr, int startOffset, int endOffset, int line, int column) {
      super(startOffset, endOffset, line, column);
      this.op = op;
      this.expr = expr;
    }
  }

  private static final class BinaryNode extends ExprNode {
    final String op;
    final ExprNode left;
    final ExprNode right;
    BinaryNode(String op, ExprNode left, ExprNode right, int startOffset, int endOffset, int line, int column) {
      super(startOffset, endOffset, line, column);
      this.op = op;
      this.left = left;
      this.right = right;
    }
  }

  private static final class FieldAccessNode extends ExprNode {
    final ExprNode base;
    final String field;
    FieldAccessNode(ExprNode base, String field, int startOffset, int endOffset, int line, int column) {
      super(startOffset, endOffset, line, column);
      this.base = base;
      this.field = field;
    }
  }

  private static final class IndexAccessNode extends ExprNode {
    final ExprNode base;
    final ExprNode indexExpr;
    IndexAccessNode(ExprNode base, ExprNode indexExpr, int startOffset, int endOffset, int line, int column) {
      super(startOffset, endOffset, line, column);
      this.base = base;
      this.indexExpr = indexExpr;
    }
  }

  private static final class CallNode extends ExprNode {
    final ExprNode callee;
    final List<ExprNode> arguments;
    CallNode(ExprNode callee, List<ExprNode> arguments, int startOffset, int endOffset, int line, int column) {
      super(startOffset, endOffset, line, column);
      this.callee = callee;
      this.arguments = arguments == null ? Collections.<ExprNode>emptyList() : arguments;
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
    final int line;
    final int column;

    Token(TokenKind kind, String text, int startOffset, int endOffset, int line, int column) {
      this.kind = kind;
      this.text = text;
      this.startOffset = startOffset;
      this.endOffset = endOffset;
      this.line = line;
      this.column = column;
    }

    boolean isSymbol(String symbol) {
      return kind == TokenKind.SYMBOL && symbol.equals(text);
    }
  }

  private static final class ParseResult {
    ExprNode node;
    int nextIndex;
  }

  private static final class AccessMatch {
    int questId;
    int index;
    String accessType;
  }

  private static final class NodeLocation {
    String npcFile;
    int questId;
    String accessType;
    int index;
    int line;
    int column;
    String fullExpressionText;
  }

  private static final class CountTriple {
    int getItem;
    int killMonster;
    int meetNpc;

    void add(String type) {
      if("getItem".equals(type)) {
        getItem++;
      } else if("killMonster".equals(type)) {
        killMonster++;
      } else if("meetNpc".equals(type)) {
        meetNpc++;
      }
    }

    String toJson() {
      return "{\"getItem\":" + getItem + ",\"killMonster\":" + killMonster + ",\"meetNpc\":" + meetNpc + "}";
    }
  }

  public static final class ScanReport {
    String generatedAt = "";
    String sourceDir = "";
    int scannedFiles;
    int totalIndexedAccess;
    int getItemIndexedCount;
    int killMonsterIndexedCount;
    int meetNpcIndexedCount;
    final Map<String, CountTriple> byQuestId = new LinkedHashMap<String, CountTriple>();
    final Map<String, CountTriple> byNpcFile = new LinkedHashMap<String, CountTriple>();
    final List<NodeLocation> nodeLocation = new ArrayList<NodeLocation>();
  }

  private static final class DecodedText {
    Charset charset;
    byte[] bom;
    String text;
  }
}
