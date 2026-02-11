package unluac.semantic;

import java.net.URL;
import java.net.URLClassLoader;
import java.nio.ByteBuffer;
import java.nio.CharBuffer;
import java.nio.charset.CharacterCodingException;
import java.nio.charset.Charset;
import java.nio.charset.CharsetDecoder;
import java.nio.charset.CodingErrorAction;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.Driver;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.OffsetDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Set;

/**
 * Phase7D 影响校验器：验证文本导出仅影响预期文本节点，不破坏 NPC 逻辑结构。
 *
 * <p>所属链路：链路 B（DB 修改 -> 导出 -> 客户端读取）的最终文本变更守门阶段。</p>
 * <p>输入：原始 NPC 目录、Phase7C 导出目录、数据库中的 modifiedText 记录。</p>
 * <p>输出：`phase7D_text_mutation_validation.json`。</p>
 * <p>数据库副作用：无（只读查询）。</p>
 * <p>文件副作用：写校验报告；不改写任何 NPC 文件。</p>
 */
public class Phase7DTextImpactValidator {

  private static final Charset UTF8 = Charset.forName("UTF-8");
  private static final int EXPECTED_NPC_FILE_COUNT = 468;

  private static final String DEFAULT_JDBC = "jdbc:mysql://127.0.0.1:3306/ghost_game"
      + "?useUnicode=true&characterEncoding=utf8&serverTimezone=UTC&useSSL=false&allowPublicKeyRetrieval=true";
  private static final String DEFAULT_USER = "root";
  private static final String DEFAULT_PASSWORD = "root";

  /**
   * CLI 入口。
   *
   * @param args 参数顺序：sourceNpcDir、exportedNpcDir、reportOutput、jdbcUrl、user、password
   * @throws Exception 校验失败或 finalStatus 非 SAFE 时抛出
   */
  public static void main(String[] args) throws Exception {
    Path sourceNpcDir = args.length >= 1
        ? Paths.get(args[0])
        : Paths.get("D:/TitanGames/GhostOnline/zChina/Script/npc-lua-generated");
    Path exportedNpcDir = args.length >= 2
        ? Paths.get(args[1])
        : Paths.get("reports", "phase7C_exported_npc");
    Path reportOutput = args.length >= 3
        ? Paths.get(args[2])
        : Paths.get("reports", "phase7D_text_mutation_validation.json");
    String jdbcUrl = args.length >= 4 ? args[3] : DEFAULT_JDBC;
    String user = args.length >= 5 ? args[4] : DEFAULT_USER;
    String password = args.length >= 6 ? args[5] : DEFAULT_PASSWORD;

    long start = System.nanoTime();
    Phase7DTextImpactValidator validator = new Phase7DTextImpactValidator();
    ValidationReport report = validator.validate(sourceNpcDir, exportedNpcDir, reportOutput, jdbcUrl, user, password);
    long elapsed = (System.nanoTime() - start) / 1_000_000L;

    System.out.println("mutatedTextIds=" + report.mutatedTextIds.size());
    System.out.println("expectedNpcFiles=" + report.expectedNpcFiles.size());
    System.out.println("actualChangedNpcFiles=" + report.actualChangedNpcFiles.size());
    System.out.println("unexpectedChangedFiles=" + report.unexpectedChangedFiles.size());
    System.out.println("unchangedExpectedFiles=" + report.unchangedExpectedFiles.size());
    System.out.println("finalStatus=" + report.finalStatus);
    System.out.println("report=" + reportOutput.toAbsolutePath());
    System.out.println("phase7DMillis=" + elapsed);

    if(!"SAFE".equals(report.finalStatus)) {
      throw new IllegalStateException("Phase7D validation failed: finalStatus=" + report.finalStatus);
    }
  }

  /**
   * 对 Phase7C 的文本导出进行影响范围校验。
   *
   * @param sourceNpcDir 原始 NPC 目录
   * @param exportedNpcDir 导出 NPC 目录
   * @param reportOutput 报告输出路径
   * @param jdbcUrl 数据库连接
   * @param user 数据库用户名
   * @param password 数据库密码
   * @return 校验报告
   * @throws Exception 目录错误、数据库读取失败或比对过程异常时抛出
   */
  public ValidationReport validate(Path sourceNpcDir,
                                   Path exportedNpcDir,
                                   Path reportOutput,
                                   String jdbcUrl,
                                   String user,
                                   String password) throws Exception {
    if(sourceNpcDir == null || !Files.exists(sourceNpcDir) || !Files.isDirectory(sourceNpcDir)) {
      throw new IllegalStateException("source npc dir not found: " + sourceNpcDir);
    }
    if(exportedNpcDir == null || !Files.exists(exportedNpcDir) || !Files.isDirectory(exportedNpcDir)) {
      throw new IllegalStateException("exported npc dir not found: " + exportedNpcDir);
    }

    List<Path> sourceFiles = collectNpcFiles(sourceNpcDir);
    if(sourceFiles.size() != EXPECTED_NPC_FILE_COUNT) {
      throw new IllegalStateException("source npc file scan incomplete: expected=" + EXPECTED_NPC_FILE_COUNT + " actual=" + sourceFiles.size());
    }

    ensureMysqlDriverAvailable(jdbcUrl);
    Map<String, List<MutatedTextRow>> mutatedByFile = loadMutatedRows(jdbcUrl, user, password);

    ValidationReport report = new ValidationReport();
    report.generatedAt = OffsetDateTime.now().format(DateTimeFormatter.ISO_OFFSET_DATE_TIME);
    report.sourceNpcDir = sourceNpcDir.toAbsolutePath().toString();
    report.exportedNpcDir = exportedNpcDir.toAbsolutePath().toString();

    Set<Long> textIds = new LinkedHashSet<Long>();
    for(List<MutatedTextRow> rows : mutatedByFile.values()) {
      for(MutatedTextRow row : rows) {
        textIds.add(Long.valueOf(row.textId));
      }
    }
    report.mutatedTextIds.addAll(textIds);

    List<String> expectedFiles = new ArrayList<String>(mutatedByFile.keySet());
    Collections.sort(expectedFiles, String.CASE_INSENSITIVE_ORDER);
    report.expectedNpcFiles.addAll(expectedFiles);

    Set<String> expectedSet = new LinkedHashSet<String>(expectedFiles);
    Set<String> actualChangedSet = new LinkedHashSet<String>();

    for(Path sourceFile : sourceFiles) {
      String relative = normalizePath(sourceNpcDir.relativize(sourceFile).toString());
      report.totalFilesCompared++;

      Path exportedFile = exportedNpcDir.resolve(relative);
      if(!Files.exists(exportedFile) || !Files.isRegularFile(exportedFile)) {
        report.validationErrors.add(relative + ":0:0 - exported file missing");
        continue;
      }

      byte[] sourceBytes = Files.readAllBytes(sourceFile);
      byte[] exportedBytes = Files.readAllBytes(exportedFile);
      boolean changed = !Arrays.equals(sourceBytes, exportedBytes);
      if(changed) {
        actualChangedSet.add(relative);
      }

      boolean shouldInspect = changed || expectedSet.contains(relative);
      if(!shouldInspect) {
        continue;
      }

      String sourceText = decode(sourceBytes).text;
      String exportedText = decode(exportedBytes).text;
      FileCheckResult check = analyzeFile(relative, sourceText, exportedText, mutatedByFile.get(relative));

      report.structuralChangedFileCount += check.structuralChanged ? 1 : 0;
      report.changedDialogNodeCount += check.changedDialogNodeCount;
      report.validationErrors.addAll(check.validationErrors);

      if(changed && (!check.validationErrors.isEmpty() || check.structuralChanged || report.diffEntries.isEmpty())) {
        DiffEntry diff = new DiffEntry();
        diff.file = relative;
        diff.diff = buildUnifiedDiff(relative, sourceText, exportedText);
        report.diffEntries.add(diff);
      }
    }

    report.actualChangedNpcFiles.addAll(sortSet(actualChangedSet));

    Set<String> unexpected = new LinkedHashSet<String>(actualChangedSet);
    unexpected.removeAll(expectedSet);
    report.unexpectedChangedFiles.addAll(sortSet(unexpected));

    Set<String> unchangedExpected = new LinkedHashSet<String>(expectedSet);
    unchangedExpected.removeAll(actualChangedSet);
    report.unchangedExpectedFiles.addAll(sortSet(unchangedExpected));

    if(!report.unexpectedChangedFiles.isEmpty()) {
      for(String file : report.unexpectedChangedFiles) {
        report.validationErrors.add(file + ":0:0 - changed file is not in expectedNpcFiles");
      }
    }
    if(!report.unchangedExpectedFiles.isEmpty()) {
      for(String file : report.unchangedExpectedFiles) {
        report.validationErrors.add(file + ":0:0 - expected changed file remained unchanged");
      }
    }

    report.diffSummary.put("totalFilesCompared", Integer.valueOf(report.totalFilesCompared));
    report.diffSummary.put("changedFileCount", Integer.valueOf(report.actualChangedNpcFiles.size()));
    report.diffSummary.put("expectedAffectedCount", Integer.valueOf(report.expectedNpcFiles.size()));
    report.diffSummary.put("unexpectedChangedCount", Integer.valueOf(report.unexpectedChangedFiles.size()));
    report.diffSummary.put("unchangedExpectedCount", Integer.valueOf(report.unchangedExpectedFiles.size()));
    report.diffSummary.put("structurallyChangedFileCount", Integer.valueOf(report.structuralChangedFileCount));
    report.diffSummary.put("changedDialogNodeCount", Integer.valueOf(report.changedDialogNodeCount));

    report.finalStatus = report.validationErrors.isEmpty() ? "SAFE" : "UNSAFE";

    if("UNSAFE".equals(report.finalStatus) && report.diffEntries.isEmpty()) {
      for(String file : report.actualChangedNpcFiles) {
        Path src = sourceNpcDir.resolve(file);
        Path dst = exportedNpcDir.resolve(file);
        if(Files.exists(src) && Files.exists(dst)) {
          String a = decode(Files.readAllBytes(src)).text;
          String b = decode(Files.readAllBytes(dst)).text;
          DiffEntry diff = new DiffEntry();
          diff.file = file;
          diff.diff = buildUnifiedDiff(file, a, b);
          report.diffEntries.add(diff);
        }
      }
    }

    ensureParent(reportOutput);
    Files.write(reportOutput, report.toJson().getBytes(UTF8));
    return report;
  }

  private FileCheckResult analyzeFile(String file,
                                      String sourceText,
                                      String exportedText,
                                      List<MutatedTextRow> expectedRows) {
    FileCheckResult out = new FileCheckResult();

    List<Token> sourceTokens = tokenize(sourceText);
    List<Token> exportedTokens = tokenize(exportedText);

    Map<Integer, DialogNode> dialogByTokenIndex = new HashMap<Integer, DialogNode>();
    Map<String, DialogNode> dialogByMarker = new HashMap<String, DialogNode>();
    Map<String, DialogNode> dialogByCallLineColumn = new HashMap<String, DialogNode>();

    List<DialogNode> dialogNodes = extractDialogNodes(sourceTokens);
    for(DialogNode node : dialogNodes) {
      dialogByTokenIndex.put(Integer.valueOf(node.tokenIndex), node);
      dialogByMarker.put(node.astMarker, node);
      dialogByCallLineColumn.put(node.callType + "@" + node.line + ":" + node.column, node);
    }

    Set<String> expectedChangedNodes = new LinkedHashSet<String>();
    if(expectedRows != null) {
      for(MutatedTextRow row : expectedRows) {
        DialogNode found = locateExpectedNode(row, dialogByMarker, dialogByCallLineColumn);
        if(found != null) {
          expectedChangedNodes.add(found.callType + "@" + found.line + ":" + found.column);
        } else {
          String callType = row.callType == null || row.callType.isEmpty() ? "NPC_SAY" : row.callType;
          out.validationErrors.add(file + ":" + row.line + ":" + row.column + " - expected modified text node not found");
          expectedChangedNodes.add(callType + "@" + row.line + ":" + row.column);
        }
      }
    }

    int limit = Math.min(sourceTokens.size(), exportedTokens.size());
    for(int i = 0; i < limit; i++) {
      Token a = sourceTokens.get(i);
      Token b = exportedTokens.get(i);

      if(a.kind == TokenKind.STRING && b.kind == TokenKind.STRING) {
        if(!safe(a.text).equals(safe(b.text))) {
          DialogNode node = dialogByTokenIndex.get(Integer.valueOf(i));
          if(node == null) {
            out.validationErrors.add(file + ":" + a.line + ":" + a.column + " - string changed outside NPC_SAY/NPC_ASK");
          } else {
            String key = node.callType + "@" + node.line + ":" + node.column;
            out.actualChangedNodes.add(key);
            out.changedDialogNodeCount++;
          }
        }
        continue;
      }

      if(a.kind != b.kind || !safe(a.text).equals(safe(b.text))) {
        out.structuralChanged = true;
        out.validationErrors.add(file + ":" + a.line + ":" + a.column + " - non-text token changed: " + a.text + " -> " + b.text);
      }
    }

    if(sourceTokens.size() != exportedTokens.size()) {
      out.structuralChanged = true;
      out.validationErrors.add(file + ":0:0 - token count changed: " + sourceTokens.size() + " -> " + exportedTokens.size());
    }

    Set<String> unexpectedNodes = new LinkedHashSet<String>(out.actualChangedNodes);
    unexpectedNodes.removeAll(expectedChangedNodes);
    for(String key : unexpectedNodes) {
      out.validationErrors.add(file + ":0:0 - unexpected changed text node: " + key);
    }

    return out;
  }

  private DialogNode locateExpectedNode(MutatedTextRow row,
                                        Map<String, DialogNode> byMarker,
                                        Map<String, DialogNode> byCallLineColumn) {
    if(row.astMarker != null && !row.astMarker.isEmpty()) {
      DialogNode marker = byMarker.get(row.astMarker);
      if(marker != null) {
        return marker;
      }
    }

    if(row.callType != null && !row.callType.isEmpty()) {
      DialogNode exact = byCallLineColumn.get(row.callType + "@" + row.line + ":" + row.column);
      if(exact != null) {
        return exact;
      }
    }

    DialogNode say = byCallLineColumn.get("NPC_SAY@" + row.line + ":" + row.column);
    if(say != null) {
      return say;
    }
    return byCallLineColumn.get("NPC_ASK@" + row.line + ":" + row.column);
  }

  private List<DialogNode> extractDialogNodes(List<Token> tokens) {
    List<DialogNode> out = new ArrayList<DialogNode>();
    int ordinal = 0;
    for(int i = 0; i < tokens.size(); i++) {
      Token token = tokens.get(i);
      if(token.kind != TokenKind.IDENT && token.kind != TokenKind.KEYWORD) {
        continue;
      }
      if(!"NPC_SAY".equals(token.text) && !"NPC_ASK".equals(token.text)) {
        continue;
      }
      if(i + 1 >= tokens.size() || !tokens.get(i + 1).isSymbol("(")) {
        continue;
      }

      int close = findMatching(tokens, i + 1, "(", ")");
      if(close < 0) {
        continue;
      }

      for(int j = i + 2; j < close; j++) {
        Token t = tokens.get(j);
        if(t.kind != TokenKind.STRING) {
          continue;
        }

        DialogNode node = new DialogNode();
        node.callType = token.text;
        node.line = t.line;
        node.column = t.column;
        node.tokenIndex = j;
        node.astMarker = token.text + "@" + t.line + ":" + t.column + "#" + (++ordinal);
        out.add(node);
      }

      i = Math.max(i, close);
    }
    return out;
  }

  private int findMatching(List<Token> tokens, int openIndex, String open, String close) {
    int depth = 0;
    for(int i = openIndex; i < tokens.size(); i++) {
      Token token = tokens.get(i);
      if(token.isSymbol(open)) {
        depth++;
      } else if(token.isSymbol(close)) {
        depth--;
        if(depth == 0) {
          return i;
        }
      }
    }
    return -1;
  }

  private List<Path> collectNpcFiles(Path root) throws Exception {
    List<Path> out = new ArrayList<Path>();
    Files.walk(root)
        .filter(Files::isRegularFile)
        .filter(path -> {
          String lower = path.getFileName().toString().toLowerCase(Locale.ROOT);
          return lower.startsWith("npc_") && lower.endsWith(".lua");
        })
        .forEach(out::add);
    Collections.sort(out);
    return out;
  }

  private Map<String, List<MutatedTextRow>> loadMutatedRows(String jdbcUrl,
                                                            String user,
                                                            String password) throws Exception {
    Map<String, List<MutatedTextRow>> out = new LinkedHashMap<String, List<MutatedTextRow>>();
    try(Connection connection = DriverManager.getConnection(jdbcUrl, user, password)) {
      TableMapping table = detectSourceTable(connection);
      if(table == null) {
        return out;
      }

      String sql = "SELECT "
          + quoteIdentifier(table.idColumn) + " AS text_id, "
          + quoteIdentifier(table.npcFileColumn) + " AS npc_file, "
          + quoteIdentifier(table.lineColumn) + " AS line_number, "
          + quoteIdentifier(table.columnColumn) + " AS column_number, "
          + nullableColumnExpr(table.callTypeColumn, "call_type") + ", "
          + nullableColumnExpr(table.rawTextColumn, "raw_text") + ", "
          + quoteIdentifier(table.modifiedTextColumn) + " AS modified_text, "
          + nullableColumnExpr(table.astMarkerColumn, "ast_marker")
          + " FROM " + quoteIdentifier(table.tableName)
          + " WHERE " + quoteIdentifier(table.modifiedTextColumn) + " IS NOT NULL";

      try(PreparedStatement ps = connection.prepareStatement(sql);
          ResultSet rs = ps.executeQuery()) {
        while(rs.next()) {
          MutatedTextRow row = new MutatedTextRow();
          row.textId = rs.getLong("text_id");
          row.npcFile = normalizePath(rs.getString("npc_file"));
          row.line = rs.getInt("line_number");
          row.column = rs.getInt("column_number");
          row.callType = safe(rs.getString("call_type"));
          row.rawText = safe(rs.getString("raw_text"));
          row.modifiedText = rs.getString("modified_text");
          row.astMarker = safe(rs.getString("ast_marker"));

          if(row.npcFile.isEmpty() || row.modifiedText == null) {
            continue;
          }
          if(row.modifiedText.equals(row.rawText)) {
            continue;
          }

          List<MutatedTextRow> rows = out.get(row.npcFile);
          if(rows == null) {
            rows = new ArrayList<MutatedTextRow>();
            out.put(row.npcFile, rows);
          }
          rows.add(row);
        }
      }
    }

    for(List<MutatedTextRow> rows : out.values()) {
      Collections.sort(rows, (a, b) -> {
        if(a.line != b.line) {
          return Integer.compare(a.line, b.line);
        }
        if(a.column != b.column) {
          return Integer.compare(a.column, b.column);
        }
        return Long.compare(a.textId, b.textId);
      });
    }

    return out;
  }

  private TableMapping detectSourceTable(Connection connection) throws Exception {
    String schema = connection.getCatalog();
    if(schema == null || schema.trim().isEmpty()) {
      try(PreparedStatement ps = connection.prepareStatement("SELECT DATABASE()")) {
        try(ResultSet rs = ps.executeQuery()) {
          if(rs.next()) {
            schema = rs.getString(1);
          }
        }
      }
    }

    if(schema == null || schema.trim().isEmpty()) {
      throw new IllegalStateException("Unable to resolve database schema for Phase7D");
    }

    List<String> candidates = Arrays.asList("npc_text_edit_map", "npc_dialogue_text");
    DatabaseMetaData meta = connection.getMetaData();
    for(String tableName : candidates) {
      if(!tableExists(meta, schema, tableName)) {
        continue;
      }

      Map<String, String> columns = readColumnMap(meta, schema, tableName);
      String modified = pick(columns, "modifiedText", "modified_text");
      if(modified == null) {
        continue;
      }

      String id = pick(columns, "textId", "text_id", "id");
      String npcFile = pick(columns, "npcFile", "npc_file");
      String line = pick(columns, "line", "line_number");
      String column = pick(columns, "columnNumber", "column_number", "column");
      if(id == null || npcFile == null || line == null || column == null) {
        continue;
      }

      TableMapping mapping = new TableMapping();
      mapping.tableName = tableName;
      mapping.idColumn = id;
      mapping.npcFileColumn = npcFile;
      mapping.lineColumn = line;
      mapping.columnColumn = column;
      mapping.callTypeColumn = pick(columns, "callType", "call_type");
      mapping.rawTextColumn = pick(columns, "rawText", "raw_text");
      mapping.modifiedTextColumn = modified;
      mapping.astMarkerColumn = pick(columns, "astMarker", "ast_marker");
      return mapping;
    }

    return null;
  }

  private boolean tableExists(DatabaseMetaData meta, String schema, String table) throws Exception {
    try(ResultSet rs = meta.getTables(schema, null, table, new String[] {"TABLE"})) {
      if(rs.next()) {
        return true;
      }
    }
    try(ResultSet rs = meta.getTables(null, schema, table, new String[] {"TABLE"})) {
      return rs.next();
    }
  }

  private Map<String, String> readColumnMap(DatabaseMetaData meta, String schema, String table) throws Exception {
    Map<String, String> out = new HashMap<String, String>();
    try(ResultSet rs = meta.getColumns(schema, null, table, "%")) {
      while(rs.next()) {
        String name = rs.getString("COLUMN_NAME");
        if(name != null) {
          out.put(name.toLowerCase(Locale.ROOT), name);
        }
      }
    }
    if(out.isEmpty()) {
      try(ResultSet rs = meta.getColumns(null, schema, table, "%")) {
        while(rs.next()) {
          String name = rs.getString("COLUMN_NAME");
          if(name != null) {
            out.put(name.toLowerCase(Locale.ROOT), name);
          }
        }
      }
    }
    return out;
  }

  private String pick(Map<String, String> columns, String... candidates) {
    for(String candidate : candidates) {
      if(candidate == null) {
        continue;
      }
      String key = candidate.toLowerCase(Locale.ROOT);
      if(columns.containsKey(key)) {
        return columns.get(key);
      }
    }
    return null;
  }

  private String nullableColumnExpr(String column, String alias) {
    if(column == null || column.trim().isEmpty()) {
      return "NULL AS " + alias;
    }
    return quoteIdentifier(column) + " AS " + alias;
  }

  private String quoteIdentifier(String id) {
    return "`" + id.replace("`", "``") + "`";
  }

  private List<String> sortSet(Set<String> values) {
    List<String> out = new ArrayList<String>(values);
    Collections.sort(out, String.CASE_INSENSITIVE_ORDER);
    return out;
  }

  private String safe(String value) {
    return value == null ? "" : value;
  }

  private String normalizePath(String path) {
    if(path == null) {
      return "";
    }
    return path.replace('\\', '/').trim();
  }

  private void ensureParent(Path file) throws Exception {
    if(file.getParent() != null && !Files.exists(file.getParent())) {
      Files.createDirectories(file.getParent());
    }
  }

  private String buildUnifiedDiff(String relativeFile, String original, String rewritten) {
    StringBuilder sb = new StringBuilder();
    sb.append("--- ").append(relativeFile).append("\n");
    sb.append("+++ ").append(relativeFile).append("\n");
    sb.append("@@ FULL @@\n");
    String[] a = original.split("\\r?\\n", -1);
    String[] b = rewritten.split("\\r?\\n", -1);
    for(String line : a) {
      sb.append("-").append(line).append("\n");
    }
    for(String line : b) {
      sb.append("+").append(line).append("\n");
    }
    return sb.toString();
  }

  private List<Token> tokenize(String text) {
    List<Token> tokens = new ArrayList<Token>();
    int index = 0;
    int line = 1;
    int column = 1;
    int tokenIndex = 0;

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
        tokens.add(new Token(tokenIndex++, TokenKind.STRING, text.substring(startOffset, index), startOffset, index, tokenLine, tokenColumn));
        continue;
      }

      int longEq = longBracketEquals(text, index);
      if(longEq >= 0) {
        int[] moved = skipLongBracket(text, index, line, column, longEq);
        index = moved[0];
        line = moved[1];
        column = moved[2];
        tokens.add(new Token(tokenIndex++, TokenKind.STRING, text.substring(startOffset, index), startOffset, index, tokenLine, tokenColumn));
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
        tokens.add(new Token(tokenIndex++, kind, ident, startOffset, index, tokenLine, tokenColumn));
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
        tokens.add(new Token(tokenIndex++, TokenKind.NUMBER, text.substring(startOffset, index), startOffset, index, tokenLine, tokenColumn));
        continue;
      }

      String two = index + 1 < text.length() ? text.substring(index, index + 2) : "";
      if(">=".equals(two) || "<=".equals(two) || "==".equals(two) || "~=".equals(two) || "..".equals(two)) {
        tokens.add(new Token(tokenIndex++, TokenKind.SYMBOL, two, startOffset, startOffset + 2, tokenLine, tokenColumn));
        index += 2;
        column += 2;
        continue;
      }

      tokens.add(new Token(tokenIndex++, TokenKind.SYMBOL, String.valueOf(ch), startOffset, startOffset + 1, tokenLine, tokenColumn));
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
        || "function".equals(ident)
        || "local".equals(ident)
        || "return".equals(ident)
        || "nil".equals(ident)
        || "true".equals(ident)
        || "false".equals(ident)
        || "for".equals(ident)
        || "while".equals(ident)
        || "repeat".equals(ident)
        || "until".equals(ident)
        || "do".equals(ident);
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

  private void ensureMysqlDriverAvailable(String jdbcUrl) throws Exception {
    try {
      DriverManager.getDriver(jdbcUrl);
      return;
    } catch(Exception ignored) {
    }

    try {
      Class<?> cls = Class.forName("com.mysql.cj.jdbc.Driver");
      Object obj = cls.getDeclaredConstructor().newInstance();
      if(obj instanceof Driver) {
        DriverManager.registerDriver((Driver) obj);
        return;
      }
    } catch(Throwable ignored) {
    }

    Path jar = Paths.get("lib", "mysql-connector-j-8.4.0.jar");
    if(!Files.exists(jar)) {
      throw new IllegalStateException("MySQL JDBC driver not found on classpath and missing jar: " + jar.toAbsolutePath());
    }

    URL url = jar.toUri().toURL();
    URLClassLoader loader = new URLClassLoader(new URL[] {url}, Phase7DTextImpactValidator.class.getClassLoader());
    Class<?> cls = Class.forName("com.mysql.cj.jdbc.Driver", true, loader);
    Object obj = cls.getDeclaredConstructor().newInstance();
    if(!(obj instanceof Driver)) {
      throw new IllegalStateException("Loaded class is not java.sql.Driver: " + cls.getName());
    }
    DriverManager.registerDriver(new DriverShim((Driver) obj));
  }

  private static final class DriverShim implements Driver {
    private final Driver driver;

    DriverShim(Driver driver) {
      this.driver = driver;
    }

    @Override
    public Connection connect(String url, java.util.Properties info) throws java.sql.SQLException {
      return driver.connect(url, info);
    }

    @Override
    public boolean acceptsURL(String url) throws java.sql.SQLException {
      return driver.acceptsURL(url);
    }

    @Override
    public java.sql.DriverPropertyInfo[] getPropertyInfo(String url, java.util.Properties info) throws java.sql.SQLException {
      return driver.getPropertyInfo(url, info);
    }

    @Override
    public int getMajorVersion() {
      return driver.getMajorVersion();
    }

    @Override
    public int getMinorVersion() {
      return driver.getMinorVersion();
    }

    @Override
    public boolean jdbcCompliant() {
      return driver.jdbcCompliant();
    }

    @Override
    public java.util.logging.Logger getParentLogger() throws java.sql.SQLFeatureNotSupportedException {
      return driver.getParentLogger();
    }
  }

  private static final class MutatedTextRow {
    long textId;
    String npcFile = "";
    int line;
    int column;
    String callType = "";
    String rawText = "";
    String modifiedText;
    String astMarker = "";
  }

  private static final class TableMapping {
    String tableName;
    String idColumn;
    String npcFileColumn;
    String lineColumn;
    String columnColumn;
    String callTypeColumn;
    String rawTextColumn;
    String modifiedTextColumn;
    String astMarkerColumn;
  }

  private static final class FileCheckResult {
    boolean structuralChanged;
    int changedDialogNodeCount;
    final Set<String> actualChangedNodes = new LinkedHashSet<String>();
    final List<String> validationErrors = new ArrayList<String>();
  }

  private static final class DialogNode {
    String callType = "";
    int line;
    int column;
    int tokenIndex;
    String astMarker = "";
  }

  private enum TokenKind {
    IDENT,
    NUMBER,
    STRING,
    SYMBOL,
    KEYWORD
  }

  private static final class Token {
    final int index;
    final TokenKind kind;
    final String text;
    final int startOffset;
    final int endOffset;
    final int line;
    final int column;

    Token(int index, TokenKind kind, String text, int startOffset, int endOffset, int line, int column) {
      this.index = index;
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

  private static final class DiffEntry {
    String file = "";
    String diff = "";

    String toJson() {
      return "{"
          + "\"file\": " + QuestSemanticJson.jsonString(file) + ","
          + "\"diff\": " + QuestSemanticJson.jsonString(diff)
          + "}";
    }
  }

  public static final class ValidationReport {
    String generatedAt = "";
    String sourceNpcDir = "";
    String exportedNpcDir = "";
    final List<Long> mutatedTextIds = new ArrayList<Long>();
    final List<String> expectedNpcFiles = new ArrayList<String>();
    final List<String> actualChangedNpcFiles = new ArrayList<String>();
    final List<String> unexpectedChangedFiles = new ArrayList<String>();
    final List<String> unchangedExpectedFiles = new ArrayList<String>();
    final Map<String, Object> diffSummary = new LinkedHashMap<String, Object>();
    final List<String> validationErrors = new ArrayList<String>();
    final List<DiffEntry> diffEntries = new ArrayList<DiffEntry>();
    int totalFilesCompared;
    int structuralChangedFileCount;
    int changedDialogNodeCount;
    String finalStatus = "UNSAFE";

    String toJson() {
      StringBuilder sb = new StringBuilder();
      sb.append("{\n");
      sb.append("  \"generatedAt\": ").append(QuestSemanticJson.jsonString(generatedAt)).append(",\n");
      sb.append("  \"sourceNpcDir\": ").append(QuestSemanticJson.jsonString(sourceNpcDir)).append(",\n");
      sb.append("  \"exportedNpcDir\": ").append(QuestSemanticJson.jsonString(exportedNpcDir)).append(",\n");
      sb.append("  \"mutatedTextIds\": ").append(toJsonArrayLong(mutatedTextIds)).append(",\n");
      sb.append("  \"expectedNpcFiles\": ").append(QuestSemanticJson.toJsonArrayString(expectedNpcFiles)).append(",\n");
      sb.append("  \"actualChangedNpcFiles\": ").append(QuestSemanticJson.toJsonArrayString(actualChangedNpcFiles)).append(",\n");
      sb.append("  \"unexpectedChangedFiles\": ").append(QuestSemanticJson.toJsonArrayString(unexpectedChangedFiles)).append(",\n");
      sb.append("  \"unchangedExpectedFiles\": ").append(QuestSemanticJson.toJsonArrayString(unchangedExpectedFiles)).append(",\n");
      sb.append("  \"diffSummary\": ").append(QuestSemanticJson.toJsonObject(diffSummary)).append(",\n");
      sb.append("  \"validationErrors\": ").append(QuestSemanticJson.toJsonArrayString(validationErrors)).append(",\n");
      sb.append("  \"diffEntries\": [");
      if(!diffEntries.isEmpty()) {
        sb.append("\n");
        for(int i = 0; i < diffEntries.size(); i++) {
          if(i > 0) {
            sb.append(",\n");
          }
          sb.append("    ").append(diffEntries.get(i).toJson());
        }
        sb.append("\n  ");
      }
      sb.append("],\n");
      sb.append("  \"finalStatus\": ").append(QuestSemanticJson.jsonString(finalStatus)).append("\n");
      sb.append("}\n");
      return sb.toString();
    }

    private String toJsonArrayLong(List<Long> values) {
      StringBuilder sb = new StringBuilder();
      sb.append('[');
      for(int i = 0; i < values.size(); i++) {
        if(i > 0) {
          sb.append(',');
        }
        sb.append(values.get(i).longValue());
      }
      sb.append(']');
      return sb.toString();
    }
  }

  private static final class DecodedText {
    Charset charset;
    byte[] bom;
    String text;
  }
}
