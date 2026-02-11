package unluac.semantic;

import java.net.URL;
import java.net.URLClassLoader;
import java.nio.ByteBuffer;
import java.nio.CharBuffer;
import java.nio.charset.CharacterCodingException;
import java.nio.charset.Charset;
import java.nio.charset.CharsetDecoder;
import java.nio.charset.CharsetEncoder;
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
import java.util.Comparator;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Set;

public class Phase7CNpcTextExporter {

  private static final Charset UTF8 = Charset.forName("UTF-8");
  private static final int EXPECTED_NPC_FILE_COUNT = 468;

  private static final String DEFAULT_JDBC = "jdbc:mysql://127.0.0.1:3306/ghost_game"
      + "?useUnicode=true&characterEncoding=utf8&serverTimezone=UTC&useSSL=false&allowPublicKeyRetrieval=true";
  private static final String DEFAULT_USER = "root";
  private static final String DEFAULT_PASSWORD = "root";

  public static void main(String[] args) throws Exception {
    Path sourceNpcDir = args.length >= 1
        ? Paths.get(args[0])
        : Paths.get("D:/TitanGames/GhostOnline/zChina/Script/npc-lua-generated");
    Path outputDir = args.length >= 2
        ? Paths.get(args[1])
        : Paths.get("reports", "phase7C_exported_npc");
    Path reportOutput = args.length >= 3
        ? Paths.get(args[2])
        : Paths.get("reports", "phase7C_export_validation.json");
    String jdbcUrl = args.length >= 4 ? args[3] : DEFAULT_JDBC;
    String user = args.length >= 5 ? args[4] : DEFAULT_USER;
    String password = args.length >= 6 ? args[5] : DEFAULT_PASSWORD;

    long start = System.nanoTime();
    Phase7CNpcTextExporter exporter = new Phase7CNpcTextExporter();
    ExportValidationReport report = exporter.export(sourceNpcDir, outputDir, reportOutput, jdbcUrl, user, password);
    long elapsed = (System.nanoTime() - start) / 1_000_000L;

    System.out.println("sourceNpcDir=" + sourceNpcDir.toAbsolutePath());
    System.out.println("outputDir=" + outputDir.toAbsolutePath());
    System.out.println("reportOutput=" + reportOutput.toAbsolutePath());
    System.out.println("totalNpcFilesCompared=" + report.totalNpcFilesCompared);
    System.out.println("updatedNpcFilesCount=" + report.updatedNpcFilesCount);
    System.out.println("unchangedNpcFilesCount=" + report.unchangedNpcFilesCount);
    System.out.println("validationErrors=" + report.validationErrors.size());
    System.out.println("finalStatus=" + report.finalStatus);
    System.out.println("phase7CMillis=" + elapsed);

    if(!"SAFE".equals(report.finalStatus)) {
      throw new IllegalStateException("Phase7C export failed: " + report.validationErrors.size() + " validation errors");
    }
  }

  public ExportValidationReport export(Path sourceNpcDir,
                                       Path outputDir,
                                       Path reportOutput,
                                       String jdbcUrl,
                                       String user,
                                       String password) throws Exception {
    if(sourceNpcDir == null || !Files.exists(sourceNpcDir) || !Files.isDirectory(sourceNpcDir)) {
      throw new IllegalStateException("source npc dir not found: " + sourceNpcDir);
    }
    if(outputDir == null) {
      throw new IllegalStateException("output dir is null");
    }
    if(sourceNpcDir.toAbsolutePath().normalize().equals(outputDir.toAbsolutePath().normalize())) {
      throw new IllegalStateException("output dir must not equal source dir");
    }

    List<Path> npcFiles = collectNpcFiles(sourceNpcDir);
    if(npcFiles.size() != EXPECTED_NPC_FILE_COUNT) {
      throw new IllegalStateException("npc file scan incomplete: expected=" + EXPECTED_NPC_FILE_COUNT + " actual=" + npcFiles.size());
    }

    ensureMysqlDriverAvailable(jdbcUrl);
    Map<String, List<ModifiedTextRow>> rowMap = loadModifiedRows(jdbcUrl, user, password);

    ExportValidationReport report = new ExportValidationReport();
    report.generatedAt = OffsetDateTime.now().format(DateTimeFormatter.ISO_OFFSET_DATE_TIME);
    report.sourceNpcDir = sourceNpcDir.toAbsolutePath().toString();
    report.outputDir = outputDir.toAbsolutePath().toString();
    report.totalNpcFilesCompared = npcFiles.size();
    report.modifiedRowsLoaded = countRows(rowMap);

    if(!Files.exists(outputDir)) {
      Files.createDirectories(outputDir);
    }

    Set<String> scannedRelativeFiles = new LinkedHashSet<String>();

    for(Path sourceFile : npcFiles) {
      String relative = normalizePath(sourceNpcDir.relativize(sourceFile).toString());
      scannedRelativeFiles.add(relative);
      byte[] sourceRaw = Files.readAllBytes(sourceFile);
      Path outputFile = outputDir.resolve(relative);
      ensureParent(outputFile);

      List<ModifiedTextRow> rows = rowMap.get(relative);
      if(rows == null || rows.isEmpty()) {
        Files.write(outputFile, sourceRaw);
        report.unchangedNpcFilesCount++;
        continue;
      }

      FileProcessResult result = processFile(relative, sourceRaw, rows);
      Files.write(outputFile, result.outputBytes);

      if(result.changed) {
        report.updatedNpcFilesCount++;
        report.updatedNpcFiles.add(relative);
      } else {
        report.unchangedNpcFilesCount++;
      }

      report.validationErrors.addAll(result.errors);
      if(result.changed && result.diffText != null && !result.diffText.isEmpty()) {
        DiffEntry diff = new DiffEntry();
        diff.file = relative;
        diff.diff = result.diffText;
        report.diffEntries.add(diff);
      }
    }

    for(String dbFile : rowMap.keySet()) {
      if(!scannedRelativeFiles.contains(dbFile)) {
        report.validationErrors.add(dbFile + ":0:0 - modified row target file not found in source directory");
      }
    }

    verifyUnchangedBytes(sourceNpcDir, outputDir, report.updatedNpcFiles, report.validationErrors);

    if(report.validationErrors.isEmpty()) {
      report.finalStatus = "SAFE";
    } else {
      report.finalStatus = "UNSAFE";
      if(report.diffEntries.isEmpty()) {
        DiffEntry emptyDiff = new DiffEntry();
        emptyDiff.file = "__NO_CHANGED_FILE__";
        emptyDiff.diff = "No changed files available for diff output while finalStatus=UNSAFE.";
        report.diffEntries.add(emptyDiff);
      }
    }

    ensureParent(reportOutput);
    Files.write(reportOutput, report.toJson().getBytes(UTF8));
    return report;
  }

  private List<Path> collectNpcFiles(Path sourceNpcDir) throws Exception {
    List<Path> files = new ArrayList<Path>();
    Files.walk(sourceNpcDir)
        .filter(Files::isRegularFile)
        .filter(path -> {
          String lower = path.getFileName().toString().toLowerCase(Locale.ROOT);
          return lower.startsWith("npc_") && lower.endsWith(".lua");
        })
        .forEach(files::add);
    Collections.sort(files);
    return files;
  }

  private int countRows(Map<String, List<ModifiedTextRow>> rows) {
    int count = 0;
    for(List<ModifiedTextRow> list : rows.values()) {
      count += list.size();
    }
    return count;
  }

  private void verifyUnchangedBytes(Path sourceNpcDir,
                                    Path outputDir,
                                    List<String> changedFiles,
                                    List<String> validationErrors) throws Exception {
    Set<String> changedSet = new LinkedHashSet<String>(changedFiles);
    List<Path> src = collectNpcFiles(sourceNpcDir);
    for(Path srcFile : src) {
      String rel = normalizePath(sourceNpcDir.relativize(srcFile).toString());
      if(changedSet.contains(rel)) {
        continue;
      }
      Path out = outputDir.resolve(rel);
      if(!Files.exists(out) || !Files.isRegularFile(out)) {
        validationErrors.add(rel + ":0:0 - exported file missing");
        continue;
      }
      byte[] a = Files.readAllBytes(srcFile);
      byte[] b = Files.readAllBytes(out);
      if(!Arrays.equals(a, b)) {
        validationErrors.add(rel + ":0:0 - unchanged file is not byte-for-byte identical");
      }
    }
  }

  private FileProcessResult processFile(String relative,
                                        byte[] sourceRaw,
                                        List<ModifiedTextRow> rows) throws Exception {
    FileProcessResult result = new FileProcessResult();
    result.outputBytes = sourceRaw;

    DecodedText decoded = decode(sourceRaw);
    List<Token> tokens = tokenize(decoded.text);
    List<LuaTextNode> nodes = extractTextNodes(tokens);

    Map<String, LuaTextNode> byMarker = new LinkedHashMap<String, LuaTextNode>();
    Map<String, LuaTextNode> byLineColumn = new LinkedHashMap<String, LuaTextNode>();
    for(LuaTextNode node : nodes) {
      if(node.astMarker != null && !node.astMarker.isEmpty()) {
        byMarker.put(node.astMarker, node);
      }
      byLineColumn.put(node.callType + "@" + node.line + ":" + node.column, node);
    }

    List<ReplacementSpan> spans = new ArrayList<ReplacementSpan>();
    for(ModifiedTextRow row : rows) {
      LuaTextNode node = locateNode(row, byMarker, byLineColumn);
      if(node == null) {
        result.errors.add(relative + ":" + row.line + ":" + row.column + " - target AST text node not found");
        continue;
      }

      if(row.callType != null && !row.callType.isEmpty() && !row.callType.equals(node.callType)) {
        result.errors.add(relative + ":" + row.line + ":" + row.column + " - call type mismatch, db=" + row.callType + " ast=" + node.callType);
        continue;
      }

      String replacementLiteral;
      try {
        replacementLiteral = buildReplacementLiteral(row.modifiedText, node.stringLiteral);
      } catch(Exception ex) {
        result.errors.add(relative + ":" + row.line + ":" + row.column + " - literal build failed: " + ex.getMessage());
        continue;
      }

      if(replacementLiteral.equals(node.stringLiteral)) {
        continue;
      }

      ReplacementSpan span = new ReplacementSpan();
      span.startOffset = node.startOffset;
      span.endOffset = node.endOffset;
      span.replacement = replacementLiteral;
      span.line = node.line;
      span.column = node.column;
      spans.add(span);
    }

    if(spans.isEmpty()) {
      return result;
    }

    Collections.sort(spans, Comparator.comparingInt(s -> s.startOffset));
    for(int i = 1; i < spans.size(); i++) {
      if(spans.get(i - 1).endOffset > spans.get(i).startOffset) {
        ReplacementSpan left = spans.get(i - 1);
        ReplacementSpan right = spans.get(i);
        result.errors.add(relative + ":" + right.line + ":" + right.column + " - overlapping text replacement spans");
        result.outputBytes = sourceRaw;
        return result;
      }
    }

    String rewritten = applySpans(decoded.text, spans);
    byte[] rewrittenBytes;
    try {
      rewrittenBytes = encode(decoded, rewritten);
    } catch(Exception ex) {
      result.errors.add(relative + ":0:0 - charset encoding failed: " + ex.getMessage());
      result.outputBytes = sourceRaw;
      return result;
    }

    result.outputBytes = rewrittenBytes;
    result.changed = !Arrays.equals(sourceRaw, rewrittenBytes);
    if(result.changed) {
      result.diffText = buildUnifiedDiff(relative, decoded.text, rewritten);
    }
    return result;
  }

  private LuaTextNode locateNode(ModifiedTextRow row,
                                 Map<String, LuaTextNode> byMarker,
                                 Map<String, LuaTextNode> byLineColumn) {
    if(row.astMarker != null && !row.astMarker.isEmpty()) {
      LuaTextNode markerNode = byMarker.get(row.astMarker);
      if(markerNode != null) {
        return markerNode;
      }
    }

    String key = (row.callType == null || row.callType.isEmpty() ? "NPC_SAY" : row.callType)
        + "@" + row.line + ":" + row.column;
    LuaTextNode exact = byLineColumn.get(key);
    if(exact != null) {
      return exact;
    }

    if(row.callType == null || row.callType.isEmpty()) {
      LuaTextNode say = byLineColumn.get("NPC_SAY@" + row.line + ":" + row.column);
      if(say != null) {
        return say;
      }
      return byLineColumn.get("NPC_ASK@" + row.line + ":" + row.column);
    }
    return null;
  }

  private String applySpans(String text, List<ReplacementSpan> spans) {
    StringBuilder sb = new StringBuilder(text.length() + spans.size() * 16);
    int cursor = 0;
    for(ReplacementSpan span : spans) {
      if(cursor < span.startOffset) {
        sb.append(text, cursor, span.startOffset);
      }
      sb.append(span.replacement);
      cursor = span.endOffset;
    }
    if(cursor < text.length()) {
      sb.append(text.substring(cursor));
    }
    return sb.toString();
  }

  private String buildUnifiedDiff(String relativeFile, String original, String rewritten) {
    StringBuilder sb = new StringBuilder();
    sb.append("--- ").append(relativeFile).append("\n");
    sb.append("+++ ").append(relativeFile).append("\n");
    sb.append("@@ FULL @@\n");
    String[] a = splitLines(original);
    String[] b = splitLines(rewritten);
    for(String line : a) {
      sb.append("-").append(line).append("\n");
    }
    for(String line : b) {
      sb.append("+").append(line).append("\n");
    }
    return sb.toString();
  }

  private String[] splitLines(String text) {
    return text.split("\\r?\\n", -1);
  }

  private Map<String, List<ModifiedTextRow>> loadModifiedRows(String jdbcUrl,
                                                              String user,
                                                              String password) throws Exception {
    Map<String, List<ModifiedTextRow>> out = new LinkedHashMap<String, List<ModifiedTextRow>>();

    try(Connection connection = DriverManager.getConnection(jdbcUrl, user, password)) {
      TableMapping table = detectSourceTable(connection);
      if(table == null) {
        return out;
      }

      String sql = "SELECT "
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
          ModifiedTextRow row = new ModifiedTextRow();
          row.npcFile = normalizePath(rs.getString("npc_file"));
          row.line = rs.getInt("line_number");
          row.column = rs.getInt("column_number");
          row.callType = safe(rs.getString("call_type"));
          row.rawText = safe(rs.getString("raw_text"));
          row.modifiedText = rs.getString("modified_text");
          row.astMarker = safe(rs.getString("ast_marker"));

          if(row.npcFile.isEmpty()) {
            continue;
          }
          if(row.modifiedText == null) {
            continue;
          }
          if(row.modifiedText.equals(row.rawText)) {
            continue;
          }

          List<ModifiedTextRow> list = out.get(row.npcFile);
          if(list == null) {
            list = new ArrayList<ModifiedTextRow>();
            out.put(row.npcFile, list);
          }
          list.add(row);
        }
      }
    }

    for(List<ModifiedTextRow> rows : out.values()) {
      Collections.sort(rows, (a, b) -> {
        if(a.line != b.line) {
          return Integer.compare(a.line, b.line);
        }
        if(a.column != b.column) {
          return Integer.compare(a.column, b.column);
        }
        return safe(a.astMarker).compareTo(safe(b.astMarker));
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
      throw new IllegalStateException("Unable to resolve database schema for Phase7C");
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
      String npcFile = pick(columns, "npcFile", "npc_file");
      String line = pick(columns, "line", "line_number");
      String column = pick(columns, "columnNumber", "column_number", "column");
      if(npcFile == null || line == null || column == null) {
        continue;
      }

      TableMapping mapping = new TableMapping();
      mapping.tableName = tableName;
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

  private byte[] encode(DecodedText decoded, String text) throws Exception {
    byte[] body;
    Charset charset = decoded != null && decoded.charset != null ? decoded.charset : UTF8;
    try {
      CharsetEncoder encoder = charset.newEncoder();
      encoder.onMalformedInput(CodingErrorAction.REPORT);
      encoder.onUnmappableCharacter(CodingErrorAction.REPORT);
      ByteBuffer buffer = encoder.encode(CharBuffer.wrap(text));
      body = new byte[buffer.remaining()];
      buffer.get(body);
    } catch(Exception ex) {
      body = text.getBytes(UTF8);
    }

    byte[] bom = decoded == null || decoded.bom == null ? new byte[0] : decoded.bom;
    if(bom.length == 0) {
      return body;
    }

    byte[] out = new byte[bom.length + body.length];
    System.arraycopy(bom, 0, out, 0, bom.length);
    System.arraycopy(body, 0, out, bom.length, body.length);
    return out;
  }

  private String buildReplacementLiteral(String rawText, String originalLiteral) {
    if(rawText == null) {
      rawText = "";
    }
    if(originalLiteral == null || originalLiteral.isEmpty()) {
      return "\"" + escapeLuaString(rawText, '"') + "\"";
    }

    char first = originalLiteral.charAt(0);
    if(first == '\'' || first == '"') {
      return first + escapeLuaString(rawText, first) + first;
    }

    int eq = longBracketEquals(originalLiteral, 0);
    if(eq >= 0) {
      return buildLongBracketLiteral(rawText, eq);
    }

    return "\"" + escapeLuaString(rawText, '"') + "\"";
  }

  private String escapeLuaString(String text, char quote) {
    StringBuilder sb = new StringBuilder(text.length() + 16);
    for(int i = 0; i < text.length(); i++) {
      char ch = text.charAt(i);
      switch(ch) {
        case '\\':
          sb.append("\\\\");
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
        case '\b':
          sb.append("\\b");
          break;
        case '\f':
          sb.append("\\f");
          break;
        default:
          if(ch == quote) {
            sb.append('\\').append(ch);
          } else if(ch < 32) {
            sb.append('\\').append((int) ch);
          } else {
            sb.append(ch);
          }
          break;
      }
    }
    return sb.toString();
  }

  private String buildLongBracketLiteral(String text, int preferredEquals) {
    int eq = Math.max(0, preferredEquals);
    while(true) {
      String end = "]" + repeat('=', eq) + "]";
      if(!text.contains(end)) {
        return "[" + repeat('=', eq) + "[" + text + end;
      }
      eq++;
    }
  }

  private String repeat(char ch, int count) {
    if(count <= 0) {
      return "";
    }
    char[] chars = new char[count];
    Arrays.fill(chars, ch);
    return new String(chars);
  }

  private int longBracketEquals(String text, int start) {
    if(text == null || start < 0 || start >= text.length() || text.charAt(start) != '[') {
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

  private List<LuaTextNode> extractTextNodes(List<Token> tokens) {
    List<LuaTextNode> out = new ArrayList<LuaTextNode>();
    int ordinal = 0;
    for(int i = 0; i < tokens.size(); i++) {
      Token token = tokens.get(i);
      if(token.kind != TokenKind.IDENT && token.kind != TokenKind.KEYWORD) {
        continue;
      }
      if(!"NPC_SAY".equals(token.text) && !"NPC_ASK".equals(token.text)) {
        continue;
      }

      ParseResult parsed = parsePostfixChain(tokens, i);
      if(parsed == null || !(parsed.node instanceof CallNode)) {
        continue;
      }

      CallNode call = (CallNode) parsed.node;
      String callName = resolveCallName(call.callee);
      if(!"NPC_SAY".equals(callName) && !"NPC_ASK".equals(callName)) {
        continue;
      }

      List<Token> stringTokens = collectStringTokens(call);
      for(Token str : stringTokens) {
        LuaTextNode node = new LuaTextNode();
        node.callType = callName;
        node.line = str.line;
        node.column = str.column;
        node.startOffset = str.startOffset;
        node.endOffset = str.endOffset;
        node.stringLiteral = str.text;
        node.astMarker = callName + "@" + node.line + ":" + node.column + "#" + (++ordinal);
        out.add(node);
      }

      i = Math.max(i, parsed.nextIndex - 1);
    }

    return out;
  }

  private String resolveCallName(ExprNode callee) {
    if(callee instanceof NameNode) {
      return ((NameNode) callee).name;
    }
    if(callee instanceof FieldAccessNode) {
      return ((FieldAccessNode) callee).field;
    }
    return "";
  }

  private List<Token> collectStringTokens(CallNode call) {
    List<Token> out = new ArrayList<Token>();
    if(call == null || call.arguments == null) {
      return out;
    }
    for(ArgNode arg : call.arguments) {
      if(arg == null || arg.tokens == null) {
        continue;
      }
      for(Token token : arg.tokens) {
        if(token.kind == TokenKind.STRING) {
          out.add(token);
        }
      }
    }
    return out;
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
        index += (close - index) + 1;
        continue;
      }

      if(token.isSymbol("(")) {
        int close = findMatching(tokens, index, "(", ")");
        if(close < 0) {
          break;
        }
        List<ArgNode> args = parseArgs(tokens, index + 1, close);
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

  private List<ArgNode> parseArgs(List<Token> tokens, int start, int endExclusive) {
    List<ArgNode> args = new ArrayList<ArgNode>();
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
        args.add(buildArg(tokens, argStart, cursor));
        argStart = cursor + 1;
      }
      cursor++;
    }
    if(argStart < endExclusive) {
      args.add(buildArg(tokens, argStart, endExclusive));
    }
    return args;
  }

  private ArgNode buildArg(List<Token> tokens, int start, int endExclusive) {
    ArgNode arg = new ArgNode();
    if(start < 0) {
      start = 0;
    }
    if(endExclusive > tokens.size()) {
      endExclusive = tokens.size();
    }
    if(start >= endExclusive) {
      arg.tokens = Collections.emptyList();
      return arg;
    }
    arg.tokens = new ArrayList<Token>(tokens.subList(start, endExclusive));
    return arg;
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
    URLClassLoader loader = new URLClassLoader(new URL[] {url}, Phase7CNpcTextExporter.class.getClassLoader());
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

  private static final class ExpressionParser {

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
        left = new BinaryNode(op.text, left, right, left.startOffset, right.endOffset, op.line, op.column);
      }
      return left;
    }

    private ExprNode parseAnd() {
      ExprNode left = parseEquality();
      while(matchKeyword("and")) {
        Token op = previous();
        ExprNode right = parseEquality();
        left = new BinaryNode(op.text, left, right, left.startOffset, right.endOffset, op.line, op.column);
      }
      return left;
    }

    private ExprNode parseEquality() {
      ExprNode left = parseComparison();
      while(matchSymbol("==") || matchSymbol("~=")) {
        Token op = previous();
        ExprNode right = parseComparison();
        left = new BinaryNode(op.text, left, right, left.startOffset, right.endOffset, op.line, op.column);
      }
      return left;
    }

    private ExprNode parseComparison() {
      ExprNode left = parseConcat();
      while(matchSymbol(">") || matchSymbol(">=") || matchSymbol("<") || matchSymbol("<=")) {
        Token op = previous();
        ExprNode right = parseConcat();
        left = new BinaryNode(op.text, left, right, left.startOffset, right.endOffset, op.line, op.column);
      }
      return left;
    }

    private ExprNode parseConcat() {
      ExprNode left = parseUnary();
      while(matchSymbol("..")) {
        Token op = previous();
        ExprNode right = parseUnary();
        left = new BinaryNode(op.text, left, right, left.startOffset, right.endOffset, op.line, op.column);
      }
      return left;
    }

    private ExprNode parseUnary() {
      if(matchKeyword("not")) {
        Token op = previous();
        ExprNode child = parseUnary();
        return new UnaryNode(op.text, child, op.startOffset, child.endOffset, op.line, op.column);
      }
      if(matchSymbol("-")) {
        Token op = previous();
        ExprNode child = parseUnary();
        return new UnaryNode(op.text, child, op.startOffset, child.endOffset, op.line, op.column);
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
          int openIndex = index - 1;
          int close = findMatching(openIndex, "[", "]");
          if(close < 0) {
            break;
          }
          ExprNode idx = parseSubExpression(index, close);
          Token closeToken = tokens.get(close);
          current = new IndexAccessNode(current, idx, current.startOffset, closeToken.endOffset, current.line, current.column);
          index = close + 1;
          continue;
        }

        if(matchSymbol("(")) {
          int openIndex = index - 1;
          int close = findMatching(openIndex, "(", ")");
          if(close < 0) {
            break;
          }
          Token closeToken = tokens.get(close);
          current = new CallNode(current, Collections.<ArgNode>emptyList(), current.startOffset, closeToken.endOffset, current.line, current.column);
          index = close + 1;
          continue;
        }

        break;
      }
      return current;
    }

    private ExprNode parseSubExpression(int start, int endExclusive) {
      if(start >= endExclusive) {
        return new RawNode("", tokens.get(start - 1).startOffset, tokens.get(start - 1).endOffset, tokens.get(start - 1).line, tokens.get(start - 1).column);
      }
      ExpressionParser sub = new ExpressionParser(tokens, start, endExclusive);
      ExprNode node = sub.parseExpression();
      if(node == null || !sub.isAtEnd()) {
        Token s = tokens.get(start);
        Token e = tokens.get(endExclusive - 1);
        return new RawNode(joinTokens(start, endExclusive), s.startOffset, e.endOffset, s.line, s.column);
      }
      return node;
    }

    private int findMatching(int openIndex, String open, String close) {
      int depth = 0;
      for(int i = openIndex; i < endExclusive; i++) {
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

    private String joinTokens(int start, int endExclusive) {
      StringBuilder sb = new StringBuilder();
      for(int i = start; i < endExclusive; i++) {
        if(i > start) {
          sb.append(' ');
        }
        sb.append(tokens.get(i).text);
      }
      return sb.toString();
    }

    private boolean matchSymbol(String symbol) {
      if(isAtEnd()) {
        return false;
      }
      Token token = tokens.get(index);
      if(token.kind == TokenKind.SYMBOL && symbol.equals(token.text)) {
        index++;
        return true;
      }
      return false;
    }

    private boolean matchKeyword(String keyword) {
      if(isAtEnd()) {
        return false;
      }
      Token token = tokens.get(index);
      if(token.kind == TokenKind.KEYWORD && keyword.equals(token.text)) {
        index++;
        return true;
      }
      return false;
    }

    private boolean matchKind(TokenKind kind) {
      if(isAtEnd()) {
        return false;
      }
      Token token = tokens.get(index);
      if(token.kind == kind) {
        index++;
        return true;
      }
      return false;
    }

    private Token advance() {
      return tokens.get(index++);
    }

    private Token previous() {
      return tokens.get(index - 1);
    }

    private Token peek() {
      return tokens.get(index);
    }
  }

  private abstract static class ExprNode {
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

  private static final class ArgNode {
    List<Token> tokens = Collections.emptyList();
  }

  private static final class CallNode extends ExprNode {
    final ExprNode callee;
    final List<ArgNode> arguments;
    CallNode(ExprNode callee, List<ArgNode> arguments, int startOffset, int endOffset, int line, int column) {
      super(startOffset, endOffset, line, column);
      this.callee = callee;
      this.arguments = arguments == null ? Collections.<ArgNode>emptyList() : arguments;
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

  private static final class ModifiedTextRow {
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
    String npcFileColumn;
    String lineColumn;
    String columnColumn;
    String callTypeColumn;
    String rawTextColumn;
    String modifiedTextColumn;
    String astMarkerColumn;
  }

  private static final class LuaTextNode {
    String callType = "";
    int line;
    int column;
    int startOffset;
    int endOffset;
    String stringLiteral = "";
    String astMarker = "";
  }

  private static final class ReplacementSpan {
    int startOffset;
    int endOffset;
    String replacement = "";
    int line;
    int column;
  }

  private static final class FileProcessResult {
    byte[] outputBytes;
    boolean changed;
    String diffText = "";
    final List<String> errors = new ArrayList<String>();
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

  public static final class ExportValidationReport {
    String generatedAt = "";
    String sourceNpcDir = "";
    String outputDir = "";
    int totalNpcFilesCompared;
    int modifiedRowsLoaded;
    int updatedNpcFilesCount;
    int unchangedNpcFilesCount;
    String finalStatus = "UNSAFE";
    final List<String> updatedNpcFiles = new ArrayList<String>();
    final List<String> validationErrors = new ArrayList<String>();
    final List<DiffEntry> diffEntries = new ArrayList<DiffEntry>();

    String toJson() {
      StringBuilder sb = new StringBuilder();
      sb.append("{\n");
      sb.append("  \"generatedAt\": ").append(QuestSemanticJson.jsonString(generatedAt)).append(",\n");
      sb.append("  \"sourceNpcDir\": ").append(QuestSemanticJson.jsonString(sourceNpcDir)).append(",\n");
      sb.append("  \"outputDir\": ").append(QuestSemanticJson.jsonString(outputDir)).append(",\n");
      sb.append("  \"totalNpcFilesCompared\": ").append(totalNpcFilesCompared).append(",\n");
      sb.append("  \"modifiedRowsLoaded\": ").append(modifiedRowsLoaded).append(",\n");
      sb.append("  \"updatedNpcFilesCount\": ").append(updatedNpcFilesCount).append(",\n");
      sb.append("  \"unchangedNpcFilesCount\": ").append(unchangedNpcFilesCount).append(",\n");
      sb.append("  \"updatedNpcFiles\": ").append(QuestSemanticJson.toJsonArrayString(updatedNpcFiles)).append(",\n");
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
  }

  private static final class DecodedText {
    Charset charset;
    byte[] bom;
    String text;
  }
}
