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
import java.sql.Driver;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.Statement;
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

/**
 * Phase7A 文本抽取系统：从原始 NPC Lua 文件提取 NPC_SAY/NPC_ASK 文本并写入数据库。
 *
 * <p>所属链路：链路 B（DB 修改 -> 导出 -> 客户端读取）中的文本抽取阶段。</p>
 * <p>输入：`npc-lua-generated` 目录下全部 NPC 文件。</p>
 * <p>输出：`phase7A_npc_text_extraction.json`、DDL 文件、`npc_dialogue_text` 表记录。</p>
 * <p>数据库副作用：清空并重建抽取表，然后批量写入文本节点。</p>
 * <p>文件副作用：写报告和 DDL，不修改任何 NPC 源文件。</p>
 */
public class Phase7ANpcTextExtractionSystem {

  private static final Charset UTF8 = Charset.forName("UTF-8");
  private static final int EXPECTED_NPC_FILE_COUNT = 468;

  private static final String DEFAULT_JDBC = "jdbc:mysql://127.0.0.1:3306/ghost_game"
      + "?useUnicode=true&characterEncoding=utf8&serverTimezone=UTC&useSSL=false&allowPublicKeyRetrieval=true";
  private static final String DEFAULT_USER = "root";
  private static final String DEFAULT_PASSWORD = "root";

  /**
   * CLI 入口。
   *
   * @param args 参数顺序：npcDir、reportOutput、ddlOutput、jdbcUrl、user、password
   * @throws Exception 扫描、解析或入库失败时抛出
   */
  public static void main(String[] args) throws Exception {
    Path npcDir = args.length >= 1
        ? Paths.get(args[0])
        : Paths.get("D:/TitanGames/GhostOnline/zChina/Script/npc-lua-generated");
    Path reportOutput = args.length >= 2
        ? Paths.get(args[1])
        : Paths.get("reports", "phase7A_npc_text_extraction.json");
    Path ddlOutput = args.length >= 3
        ? Paths.get(args[2])
        : Paths.get("reports", "phase7A_npc_dialogue_text_ddl.sql");
    String jdbcUrl = args.length >= 4 ? args[3] : DEFAULT_JDBC;
    String user = args.length >= 5 ? args[4] : DEFAULT_USER;
    String password = args.length >= 6 ? args[5] : DEFAULT_PASSWORD;

    long start = System.nanoTime();
    Phase7ANpcTextExtractionSystem extractor = new Phase7ANpcTextExtractionSystem();
    ExtractionReport report = extractor.scanAndStore(npcDir, reportOutput, ddlOutput, jdbcUrl, user, password);
    long elapsed = (System.nanoTime() - start) / 1_000_000L;

    System.out.println("npcDir=" + npcDir.toAbsolutePath());
    System.out.println("totalNpcFilesScanned=" + report.totalNpcFilesScanned);
    System.out.println("totalNpcTextNodesFound=" + report.totalNpcTextNodesFound);
    System.out.println("dbInsertedRows=" + report.dbInsertedRows);
    System.out.println("extractionErrors=" + report.extractionErrors.size());
    System.out.println("report=" + reportOutput.toAbsolutePath());
    System.out.println("ddl=" + ddlOutput.toAbsolutePath());
    System.out.println("phase7AMillis=" + elapsed);
  }

  /**
   * 扫描全量 NPC 文件并完成文本抽取入库。
   *
   * @param npcDir NPC 脚本目录
   * @param reportOutput 抽取报告路径
   * @param ddlOutput DDL 输出路径
   * @param jdbcUrl 数据库连接
   * @param user 数据库用户名
   * @param password 数据库密码
   * @return 抽取报告对象
   * @throws Exception 输入目录不合法、抽取失败或数据库写入失败时抛出
   */
  public ExtractionReport scanAndStore(Path npcDir,
                                       Path reportOutput,
                                       Path ddlOutput,
                                       String jdbcUrl,
                                       String user,
                                       String password) throws Exception {
    if(npcDir == null || !Files.exists(npcDir) || !Files.isDirectory(npcDir)) {
      throw new IllegalStateException("npc directory not found: " + npcDir);
    }

    List<Path> files = new ArrayList<Path>();
    Files.walk(npcDir)
        .filter(Files::isRegularFile)
        .filter(path -> {
          String lower = path.getFileName().toString().toLowerCase(Locale.ROOT);
          return lower.startsWith("npc_") && lower.endsWith(".lua");
        })
        .forEach(files::add);
    Collections.sort(files);

    ExtractionReport report = new ExtractionReport();
    report.generatedAt = OffsetDateTime.now().format(DateTimeFormatter.ISO_OFFSET_DATE_TIME);
    report.sourceNpcDir = npcDir.toAbsolutePath().toString();
    report.totalNpcFilesScanned = files.size();

    if(report.totalNpcFilesScanned != EXPECTED_NPC_FILE_COUNT) {
      throw new IllegalStateException("npc file scan incomplete: expected=" + EXPECTED_NPC_FILE_COUNT + " actual=" + report.totalNpcFilesScanned);
    }

    for(Path file : files) {
      String rel = normalizePath(npcDir.relativize(file).toString());
      try {
        scanOneFile(file, rel, report);
      } catch(Exception ex) {
        report.extractionErrors.add(rel + " => " + ex.getMessage());
      }
    }

    String ddl = ddlSql();
    writeDdl(ddlOutput, ddl);

    if(!report.extractionErrors.isEmpty()) {
      ensureParent(reportOutput);
      Files.write(reportOutput, report.toJson(ddl).getBytes(UTF8));
      throw new IllegalStateException("Phase7A extraction errors found: " + report.extractionErrors.size());
    }

    ensureMysqlDriverAvailable(jdbcUrl);
    report.dbInsertedRows = upsertIntoDatabase(report.textNodes, ddl, jdbcUrl, user, password);

    ensureParent(reportOutput);
    Files.write(reportOutput, report.toJson(ddl).getBytes(UTF8));
    return report;
  }

  /**
   * 对单个 NPC 文件进行 token 解析并收集文本节点。
   *
   * @param file 文件绝对路径
   * @param relativeFile 相对文件名（用于入库与报告定位）
   * @param report 报告累加器
   * @throws Exception 读取或解析失败时抛出
   */
  private void scanOneFile(Path file,
                           String relativeFile,
                           ExtractionReport report) throws Exception {
    byte[] raw = Files.readAllBytes(file);
    DecodedText decoded = decode(raw);
    String text = decoded.text;

    List<Token> tokens = tokenize(text);
    List<NpcTextNode> nodes = extractNodes(tokens, text, relativeFile);
    report.textNodesByFile.put(relativeFile, Integer.valueOf(nodes.size()));
    report.totalNpcTextNodesFound += nodes.size();
    report.textNodes.addAll(nodes);
  }

  /**
   * 抽取 NPC_SAY/NPC_ASK 文本节点及其定位与上下文信息。
   */
  private List<NpcTextNode> extractNodes(List<Token> tokens,
                                         String sourceText,
                                         String relativeFile) {
    List<NpcTextNode> out = new ArrayList<NpcTextNode>();
    List<BlockContext> contextStack = new ArrayList<BlockContext>();
    int ordinal = 0;

    for(int i = 0; i < tokens.size(); i++) {
      Token token = tokens.get(i);
      if(token.kind == TokenKind.KEYWORD) {
        updateContext(tokens, i, contextStack);
      }

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
      if(stringTokens.isEmpty()) {
        i = Math.max(i, parsed.nextIndex - 1);
        continue;
      }

      Set<Integer> qids = inferQuestIds(tokens, i, parsed.nextIndex, contextStack, call);
      List<Integer> questIds = new ArrayList<Integer>(qids);
      Collections.sort(questIds);

      String functionName = findCurrentFunction(contextStack);
      String astContext = buildAstContext(contextStack);

      for(Token str : stringTokens) {
        NpcTextNode row = new NpcTextNode();
        row.npcFile = relativeFile;
        row.callType = callName;
        row.lineNumber = str.line;
        row.column = str.column;
        row.stringLiteral = str.text;
        row.rawText = stripQuotes(str.text);
        row.surroundingAstContext = astContext;
        row.functionName = functionName;
        row.associatedQuestIds.addAll(questIds);
        row.associatedQuestId = questIds.isEmpty() ? 0 : questIds.get(0).intValue();
        row.astMarker = callName + "@" + row.lineNumber + ":" + row.column + "#" + (++ordinal);
        out.add(row);
      }

      i = Math.max(i, parsed.nextIndex - 1);
    }

    return out;
  }

  /**
   * 收集数据，供后续处理使用。
   * @param call 方法参数
   * @return 计算结果
   */
  private List<Token> collectStringTokens(CallNode call) {
    List<Token> out = new ArrayList<Token>();
    if(call == null || call.arguments == null) {
      return out;
    }
    for(ArgNode arg : call.arguments) {
      if(arg == null || arg.tokens == null) {
        continue;
      }
      for(Token t : arg.tokens) {
        if(t.kind == TokenKind.STRING) {
          out.add(t);
        }
      }
    }
    return out;
  }

  /**
   * 在扫描 token 时维护轻量流程上下文栈。
   */
  private void updateContext(List<Token> tokens,
                             int index,
                             List<BlockContext> stack) {
    Token token = tokens.get(index);
    String kw = token.text;

    if("function".equals(kw)) {
      BlockContext ctx = new BlockContext();
      ctx.kind = "function";
      ctx.name = parseFunctionName(tokens, index + 1);
      stack.add(ctx);
      return;
    }

    if("if".equals(kw) || "elseif".equals(kw)) {
      int thenIndex = findKeyword(tokens, index + 1, "then");
      List<Token> cond = thenIndex > index ? sliceTokens(tokens, index + 1, thenIndex) : Collections.<Token>emptyList();
      if("elseif".equals(kw)) {
        for(int i = stack.size() - 1; i >= 0; i--) {
          if("if".equals(stack.get(i).kind)) {
            stack.get(i).conditionTokens = cond;
            return;
          }
        }
      }
      BlockContext ctx = new BlockContext();
      ctx.kind = "if";
      ctx.conditionTokens = cond;
      stack.add(ctx);
      return;
    }

    if("for".equals(kw) || "while".equals(kw)) {
      int doIndex = findKeyword(tokens, index + 1, "do");
      BlockContext ctx = new BlockContext();
      ctx.kind = kw;
      ctx.conditionTokens = doIndex > index ? sliceTokens(tokens, index + 1, doIndex) : Collections.<Token>emptyList();
      stack.add(ctx);
      return;
    }

    if("repeat".equals(kw) || "do".equals(kw)) {
      BlockContext ctx = new BlockContext();
      ctx.kind = kw;
      stack.add(ctx);
      return;
    }

    if("until".equals(kw)) {
      for(int i = stack.size() - 1; i >= 0; i--) {
        if("repeat".equals(stack.get(i).kind)) {
          stack.remove(i);
          return;
        }
      }
      return;
    }

    if("end".equals(kw) && !stack.isEmpty()) {
      stack.remove(stack.size() - 1);
    }
  }

  /**
   * 计算并返回结果。
   * @param tokens 方法参数
   * @param start 方法参数
   * @param keyword 方法参数
   * @return 计算结果
   */
  private int findKeyword(List<Token> tokens, int start, String keyword) {
    int depthParen = 0;
    int depthBracket = 0;
    int depthBrace = 0;
    for(int i = start; i < tokens.size(); i++) {
      Token token = tokens.get(i);
      if(token.isSymbol("(")) depthParen++;
      else if(token.isSymbol(")")) depthParen = Math.max(0, depthParen - 1);
      else if(token.isSymbol("[")) depthBracket++;
      else if(token.isSymbol("]")) depthBracket = Math.max(0, depthBracket - 1);
      else if(token.isSymbol("{")) depthBrace++;
      else if(token.isSymbol("}")) depthBrace = Math.max(0, depthBrace - 1);

      if(depthParen == 0 && depthBracket == 0 && depthBrace == 0
          && token.kind == TokenKind.KEYWORD
          && keyword.equals(token.text)) {
        return i;
      }
    }
    return -1;
  }

  /**
   * 计算并返回结果。
   * @param tokens 方法参数
   * @param start 方法参数
   * @param endExclusive 方法参数
   * @return 计算结果
   */
  private List<Token> sliceTokens(List<Token> tokens, int start, int endExclusive) {
    if(start < 0) {
      start = 0;
    }
    if(endExclusive > tokens.size()) {
      endExclusive = tokens.size();
    }
    if(start >= endExclusive) {
      return Collections.emptyList();
    }
    return new ArrayList<Token>(tokens.subList(start, endExclusive));
  }

  /**
   * 解析来源数据。
   * @param tokens 方法参数
   * @param start 方法参数
   * @return 计算结果
   */
  private String parseFunctionName(List<Token> tokens, int start) {
    StringBuilder sb = new StringBuilder();
    int index = start;
    while(index < tokens.size()) {
      Token token = tokens.get(index);
      if(token.isSymbol("(")) {
        break;
      }
      if(token.kind == TokenKind.IDENT || token.kind == TokenKind.KEYWORD) {
        if(sb.length() > 0) {
          Token prev = tokens.get(index - 1);
          if(prev.isSymbol(".") || prev.isSymbol(":")) {
            sb.append(prev.text);
          }
        }
        sb.append(token.text);
      } else if(!token.isSymbol(".") && !token.isSymbol(":")) {
        break;
      }
      index++;
    }
    return sb.length() == 0 ? "<anonymous>" : sb.toString();
  }

  /**
   * 根据局部表达式与父级上下文推断关联 questId。
   */
  private Set<Integer> inferQuestIds(List<Token> allTokens,
                                     int fromIndex,
                                     int toIndex,
                                     List<BlockContext> stack,
                                     CallNode call) {
    Set<Integer> ids = new LinkedHashSet<Integer>();
    for(BlockContext ctx : stack) {
      collectQuestIdsFromTokens(ctx.conditionTokens, ids);
    }
    if(call != null && call.arguments != null) {
      for(ArgNode arg : call.arguments) {
        if(arg != null && arg.tokens != null) {
          collectQuestIdsFromTokens(arg.tokens, ids);
        }
      }
    }
    int left = Math.max(0, fromIndex - 120);
    int right = Math.min(allTokens.size(), Math.max(fromIndex + 1, toIndex + 120));
    collectQuestIdsFromTokens(sliceTokens(allTokens, left, right), ids);
    return ids;
  }

  /**
   * 收集数据，供后续处理使用。
   * @param tokens 方法参数
   * @param out 方法参数
   */
  private void collectQuestIdsFromTokens(List<Token> tokens, Set<Integer> out) {
    if(tokens == null || tokens.size() < 4) {
      return;
    }
    for(int i = 0; i + 3 < tokens.size(); i++) {
      Token t0 = tokens.get(i);
      if((t0.kind != TokenKind.IDENT && t0.kind != TokenKind.KEYWORD)
          || (!"qData".equals(t0.text) && !"qt".equals(t0.text))) {
        continue;
      }
      Token t1 = tokens.get(i + 1);
      Token t2 = tokens.get(i + 2);
      Token t3 = tokens.get(i + 3);
      if(!t1.isSymbol("[") || !t3.isSymbol("]") || t2.kind != TokenKind.NUMBER) {
        continue;
      }
      Integer val = parseIntegerToken(t2.text);
      if(val != null && val.intValue() > 0) {
        out.add(val);
      }
    }
  }

  /**
   * 解析来源数据。
   * @param text 方法参数
   * @return 计算结果
   */
  private Integer parseIntegerToken(String text) {
    if(text == null || text.trim().isEmpty()) {
      return null;
    }
    try {
      int value = Integer.parseInt(text.trim());
      return Integer.valueOf(value);
    } catch(Exception ex) {
      return null;
    }
  }

  /**
   * 计算并返回结果。
   * @param stack 方法参数
   * @return 计算结果
   */
  private String findCurrentFunction(List<BlockContext> stack) {
    for(int i = stack.size() - 1; i >= 0; i--) {
      BlockContext ctx = stack.get(i);
      if("function".equals(ctx.kind)) {
        return ctx.name == null ? "" : ctx.name;
      }
    }
    return "";
  }

  /**
   * 计算并返回结果。
   * @param stack 方法参数
   * @return 计算结果
   */
  private String buildAstContext(List<BlockContext> stack) {
    if(stack.isEmpty()) {
      return "<global>";
    }
    StringBuilder sb = new StringBuilder();
    for(int i = 0; i < stack.size(); i++) {
      if(i > 0) {
        sb.append(" > ");
      }
      BlockContext ctx = stack.get(i);
      sb.append(ctx.kind);
      if("function".equals(ctx.kind) && ctx.name != null && !ctx.name.isEmpty()) {
        sb.append('(').append(ctx.name).append(')');
      } else if(ctx.conditionTokens != null && !ctx.conditionTokens.isEmpty()) {
        String cond = joinTokenText(ctx.conditionTokens, 0, ctx.conditionTokens.size());
        if(cond.length() > 200) {
          cond = cond.substring(0, 200) + "...";
        }
        sb.append('(').append(cond).append(')');
      }
    }
    return sb.toString();
  }

  /**
   * 计算并返回结果。
   * @param callee 方法参数
   * @return 计算结果
   */
  private String resolveCallName(ExprNode callee) {
    ExprNode node = callee;
    while(node instanceof ParenNode) {
      node = ((ParenNode) node).inner;
    }
    if(node instanceof NameNode) {
      return ((NameNode) node).name;
    }
    if(node instanceof FieldAccessNode) {
      return ((FieldAccessNode) node).field;
    }
    return "";
  }

  /**
   * 计算并返回结果。
   * @param literal 方法参数
   * @return 计算结果
   */
  private String stripQuotes(String literal) {
    if(literal == null) {
      return "";
    }
    if((literal.startsWith("\"") && literal.endsWith("\"") && literal.length() >= 2)
        || (literal.startsWith("'") && literal.endsWith("'") && literal.length() >= 2)) {
      return literal.substring(1, literal.length() - 1);
    }
    return literal;
  }

  /**
   * 重建 `npc_dialogue_text` 并批量写入抽取节点。
   */
  private int upsertIntoDatabase(List<NpcTextNode> nodes,
                                 String ddl,
                                 String jdbcUrl,
                                 String user,
                                 String password) throws Exception {
    try(Connection connection = DriverManager.getConnection(jdbcUrl, user, password)) {
      connection.setAutoCommit(false);
      try {
        try(Statement statement = connection.createStatement()) {
          statement.execute(ddl);
          statement.execute("DELETE FROM npc_dialogue_text");
        }

        String sql = "INSERT INTO npc_dialogue_text(" 
            + "npc_file, call_type, line_number, column_number, raw_text, string_literal, "
            + "ast_context, function_name, associated_quest_id, associated_quest_ids_json, ast_marker" 
            + ") VALUES (?,?,?,?,?,?,?,?,?,?,?)";

        int inserted = 0;
        try(PreparedStatement ps = connection.prepareStatement(sql)) {
          for(NpcTextNode row : nodes) {
            ps.setString(1, row.npcFile);
            ps.setString(2, row.callType);
            ps.setInt(3, row.lineNumber);
            ps.setInt(4, row.column);
            ps.setString(5, row.rawText);
            ps.setString(6, row.stringLiteral);
            ps.setString(7, row.surroundingAstContext);
            ps.setString(8, row.functionName);
            if(row.associatedQuestId > 0) {
              ps.setInt(9, row.associatedQuestId);
            } else {
              ps.setNull(9, java.sql.Types.INTEGER);
            }
            ps.setString(10, QuestSemanticJson.toJsonArrayInt(row.associatedQuestIds));
            ps.setString(11, row.astMarker);
            ps.addBatch();
            inserted++;
          }
          ps.executeBatch();
        }

        connection.commit();
        return inserted;
      } catch(Exception ex) {
        connection.rollback();
        throw ex;
      }
    }
  }

  /**
   * 处理write Ddl辅助逻辑。
   * @param ddlOutput 方法参数
   * @param ddl 方法参数
   * @throws Exception 处理失败时抛出
   */
  private void writeDdl(Path ddlOutput, String ddl) throws Exception {
    ensureParent(ddlOutput);
    Files.write(ddlOutput, (ddl + System.lineSeparator()).getBytes(UTF8));
  }

  /**
   * 计算并返回结果。
   * @return 计算结果
   */
  private String ddlSql() {
    return "CREATE TABLE IF NOT EXISTS npc_dialogue_text ("
        + "id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,"
        + "npc_file VARCHAR(255) NOT NULL,"
        + "call_type VARCHAR(32) NOT NULL,"
        + "line_number INT NOT NULL,"
        + "column_number INT NOT NULL,"
        + "raw_text LONGTEXT NOT NULL,"
        + "string_literal LONGTEXT NOT NULL,"
        + "ast_context LONGTEXT,"
        + "function_name VARCHAR(128),"
        + "associated_quest_id INT NULL,"
        + "associated_quest_ids_json JSON NULL,"
        + "ast_marker VARCHAR(255) NOT NULL,"
        + "created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,"
        + "updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,"
        + "UNIQUE KEY uk_npc_dialogue_text_marker (npc_file, ast_marker),"
        + "KEY idx_npc_dialogue_file (npc_file),"
        + "KEY idx_npc_dialogue_quest (associated_quest_id),"
        + "KEY idx_npc_dialogue_call (call_type)"
        + ") ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci";
  }

  /**
   * 解析来源数据。
   * @param tokens 方法参数
   * @param startIndex 方法参数
   * @return 计算结果
   */
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

  /**
   * 解析来源数据。
   * @param tokens 方法参数
   * @param start 方法参数
   * @param endExclusive 方法参数
   * @return 计算结果
   */
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

  /**
   * 计算并返回结果。
   * @param tokens 方法参数
   * @param start 方法参数
   * @param endExclusive 方法参数
   * @return 计算结果
   */
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

  /**
   * 解析来源数据。
   * @param tokens 方法参数
   * @param start 方法参数
   * @param endExclusive 方法参数
   * @return 计算结果
   */
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

  /**
   * 计算并返回结果。
   * @param tokens 方法参数
   * @param openIndex 方法参数
   * @param open 方法参数
   * @param close 方法参数
   * @return 计算结果
   */
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

  /**
   * 计算并返回结果。
   * @param tokens 方法参数
   * @param start 方法参数
   * @param endExclusive 方法参数
   * @return 计算结果
   */
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

  /**
   * 将源码文本切分为词法单元。
   * @param text 方法参数
   * @return 计算结果
   */
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

  /**
   * 计算并返回结果。
   * @param ch 方法参数
   * @return 计算结果
   */
  private boolean isIdentifierStart(char ch) {
    return ch == '_' || Character.isLetter(ch);
  }

  /**
   * 计算并返回结果。
   * @param ch 方法参数
   * @return 计算结果
   */
  private boolean isIdentifierPart(char ch) {
    return ch == '_' || Character.isLetterOrDigit(ch);
  }

  /**
   * 计算并返回结果。
   * @param ident 方法参数
   * @return 计算结果
   */
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
        || "return".equals(ident)
        || "for".equals(ident)
        || "while".equals(ident)
        || "repeat".equals(ident)
        || "until".equals(ident)
        || "do".equals(ident);
  }

  /**
   * 计算并返回结果。
   * @param text 方法参数
   * @param index 方法参数
   * @param line 方法参数
   * @param column 方法参数
   * @return 计算结果
   */
  private int[] moveLine(String text, int index, int line, int column) {
    if(text.charAt(index) == '\r') {
      if(index + 1 < text.length() && text.charAt(index + 1) == '\n') {
        return new int[] {index + 2, line + 1, 1};
      }
      return new int[] {index + 1, line + 1, 1};
    }
    return new int[] {index + 1, line + 1, 1};
  }

  /**
   * 计算并返回结果。
   * @param text 方法参数
   * @param index 方法参数
   * @param line 方法参数
   * @param column 方法参数
   * @param quote 方法参数
   * @return 计算结果
   */
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

  /**
   * 计算并返回结果。
   * @param text 方法参数
   * @param start 方法参数
   * @return 计算结果
   */
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

  /**
   * 计算并返回结果。
   * @param text 方法参数
   * @param start 方法参数
   * @param line 方法参数
   * @param column 方法参数
   * @param equals 方法参数
   * @return 计算结果
   */
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

  /**
   * 计算并返回结果。
   * @param raw 方法参数
   * @return 计算结果
   * @throws Exception 处理失败时抛出
   */
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

  /**
   * Normalize normalize Path into stable representation.
   * @param path 方法参数
   * @return 计算结果
   */
  private String normalizePath(String path) {
    if(path == null) {
      return "";
    }
    return path.replace('\\', '/').trim();
  }

  /**
   * 确保前置条件满足。
   * @param file 方法参数
   * @throws Exception 处理失败时抛出
   */
  private void ensureParent(Path file) throws Exception {
    if(file.getParent() != null && !Files.exists(file.getParent())) {
      Files.createDirectories(file.getParent());
    }
  }

  /**
   * 确保前置条件满足。
   * @param jdbcUrl 方法参数
   * @throws Exception 处理失败时抛出
   */
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
    URLClassLoader loader = new URLClassLoader(new URL[] {url}, Phase7ANpcTextExtractionSystem.class.getClassLoader());
    Class<?> cls = Class.forName("com.mysql.cj.jdbc.Driver", true, loader);
    Object obj = cls.getDeclaredConstructor().newInstance();
    if(!(obj instanceof Driver)) {
      throw new IllegalStateException("Loaded class is not java.sql.Driver: " + cls.getName());
    }
    DriverManager.registerDriver(new DriverShim((Driver) obj));
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

    /**
     * 解析来源数据。
     * @return 计算结果
     */
    private ExprNode parseOr() {
      ExprNode left = parseAnd();
      while(matchKeyword("or")) {
        Token op = previous();
        ExprNode right = parseAnd();
        left = new BinaryNode(op.text, left, right, left.startOffset, right.endOffset, op.line, op.column);
      }
      return left;
    }

    /**
     * 解析来源数据。
     * @return 计算结果
     */
    private ExprNode parseAnd() {
      ExprNode left = parseEquality();
      while(matchKeyword("and")) {
        Token op = previous();
        ExprNode right = parseEquality();
        left = new BinaryNode(op.text, left, right, left.startOffset, right.endOffset, op.line, op.column);
      }
      return left;
    }

    /**
     * 解析来源数据。
     * @return 计算结果
     */
    private ExprNode parseEquality() {
      ExprNode left = parseComparison();
      while(matchSymbol("==") || matchSymbol("~=")) {
        Token op = previous();
        ExprNode right = parseComparison();
        left = new BinaryNode(op.text, left, right, left.startOffset, right.endOffset, op.line, op.column);
      }
      return left;
    }

    /**
     * 解析来源数据。
     * @return 计算结果
     */
    private ExprNode parseComparison() {
      ExprNode left = parseConcat();
      while(matchSymbol(">") || matchSymbol(">=") || matchSymbol("<") || matchSymbol("<=")) {
        Token opToken = previous();
        ExprNode right = parseConcat();
        left = new BinaryNode(opToken.text, left, right, left.startOffset, right.endOffset, opToken.line, opToken.column);
      }
      return left;
    }

    /**
     * 解析来源数据。
     * @return 计算结果
     */
    private ExprNode parseConcat() {
      ExprNode left = parseUnary();
      while(matchSymbol("..")) {
        Token op = previous();
        ExprNode right = parseUnary();
        left = new BinaryNode(op.text, left, right, left.startOffset, right.endOffset, op.line, op.column);
      }
      return left;
    }

    /**
     * 解析来源数据。
     * @return 计算结果
     */
    private ExprNode parseUnary() {
      if(matchKeyword("not")) {
        Token op = previous();
        ExprNode child = parseUnary();
        return new UnaryNode(op.text, child, op.startOffset, child.endOffset, op.line, op.column);
      }
      if(matchSymbol("-")) {
        Token op = previous();
        ExprNode child = parseUnary();
        return new UnaryNode("-", child, op.startOffset, child.endOffset, op.line, op.column);
      }
      return parsePrimary();
    }

    /**
     * 解析来源数据。
     * @return 计算结果
     */
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

    /**
     * 解析来源数据。
     * @param base 方法参数
     * @return 计算结果
     */
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
          List<ArgNode> args = parseArgs(tokens, argStart, close);
          Token closeToken = tokens.get(close);
          current = new CallNode(current, args, current.startOffset, closeToken.endOffset, current.line, current.column);
          index = close + 1;
          continue;
        }
        break;
      }
      return current;
    }

    /**
     * 计算并返回结果。
     * @param openIndex 方法参数
     * @param open 方法参数
     * @param close 方法参数
     * @return 计算结果
     */
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

    /**
     * 将数据与预期结构进行匹配。
     * @param kind 方法参数
     * @return 计算结果
     */
    private boolean matchKind(TokenKind kind) {
      if(isAtEnd()) return false;
      if(peek().kind != kind) return false;
      advance();
      return true;
    }

    /**
     * 将数据与预期结构进行匹配。
     * @param keyword 方法参数
     * @return 计算结果
     */
    private boolean matchKeyword(String keyword) {
      if(isAtEnd()) return false;
      Token t = peek();
      if(t.kind == TokenKind.KEYWORD && keyword.equals(t.text)) {
        advance();
        return true;
      }
      return false;
    }

    /**
     * 将数据与预期结构进行匹配。
     * @param symbol 方法参数
     * @return 计算结果
     */
    private boolean matchSymbol(String symbol) {
      if(isAtEnd()) return false;
      Token t = peek();
      if(t.kind == TokenKind.SYMBOL && symbol.equals(t.text)) {
        advance();
        return true;
      }
      return false;
    }

    /**
     * 计算并返回结果。
     * @return 计算结果
     */
    private Token previous() {
      return tokens.get(index - 1);
    }

    /**
     * 计算并返回结果。
     * @return 计算结果
     */
    private Token peek() {
      return tokens.get(index);
    }

    /**
     * 计算并返回结果。
     * @return 计算结果
     */
    private Token advance() {
      return tokens.get(index++);
    }
  }

  private static final class DriverShim implements Driver {
    private final Driver driver;

    DriverShim(Driver driver) {
      this.driver = driver;
    }

    @Override
    /**
     * 计算并返回结果。
     * @param url 方法参数
     * @param info 方法参数
     * @return 计算结果
     * @throws Exception 处理失败时抛出
     */
    public Connection connect(String url, java.util.Properties info) throws java.sql.SQLException {
      return driver.connect(url, info);
    }

    @Override
    /**
     * 计算并返回结果。
     * @param url 方法参数
     * @return 计算结果
     * @throws Exception 处理失败时抛出
     */
    public boolean acceptsURL(String url) throws java.sql.SQLException {
      return driver.acceptsURL(url);
    }

    @Override
    public java.sql.DriverPropertyInfo[] getPropertyInfo(String url, java.util.Properties info) throws java.sql.SQLException {
      return driver.getPropertyInfo(url, info);
    }

    @Override
    /**
     * 计算并返回结果。
     * @return 计算结果
     */
    public int getMajorVersion() {
      return driver.getMajorVersion();
    }

    @Override
    /**
     * 计算并返回结果。
     * @return 计算结果
     */
    public int getMinorVersion() {
      return driver.getMinorVersion();
    }

    @Override
    /**
     * 计算并返回结果。
     * @return 计算结果
     */
    public boolean jdbcCompliant() {
      return driver.jdbcCompliant();
    }

    @Override
    public java.util.logging.Logger getParentLogger() throws java.sql.SQLFeatureNotSupportedException {
      return driver.getParentLogger();
    }
  }

  private static final class BlockContext {
    String kind = "";
    String name = "";
    List<Token> conditionTokens = Collections.emptyList();
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

  private static final class NpcTextNode {
    String npcFile = "";
    String callType = "";
    int lineNumber;
    int column;
    String rawText = "";
    String stringLiteral = "";
    String surroundingAstContext = "";
    String functionName = "";
    int associatedQuestId;
    final List<Integer> associatedQuestIds = new ArrayList<Integer>();
    String astMarker = "";

    String toJson() {
      return "{"
          + "\"npcFile\": " + QuestSemanticJson.jsonString(npcFile) + ", "
          + "\"lineNumber\": " + lineNumber + ", "
          + "\"column\": " + column + ", "
          + "\"callType\": " + QuestSemanticJson.jsonString(callType) + ", "
          + "\"rawText\": " + QuestSemanticJson.jsonString(rawText) + ", "
          + "\"stringLiteral\": " + QuestSemanticJson.jsonString(stringLiteral) + ", "
          + "\"surroundingAstContext\": " + QuestSemanticJson.jsonString(surroundingAstContext) + ", "
          + "\"functionName\": " + QuestSemanticJson.jsonString(functionName) + ", "
          + "\"associatedQuestId\": " + associatedQuestId + ", "
          + "\"associatedQuestIds\": " + QuestSemanticJson.toJsonArrayInt(associatedQuestIds) + ", "
          + "\"astMarker\": " + QuestSemanticJson.jsonString(astMarker)
          + "}";
    }
  }

  public static final class ExtractionReport {
    String generatedAt = "";
    String sourceNpcDir = "";
    int totalNpcFilesScanned;
    int totalNpcTextNodesFound;
    int dbInsertedRows;
    final Map<String, Integer> textNodesByFile = new LinkedHashMap<String, Integer>();
    final List<String> extractionErrors = new ArrayList<String>();
    final List<NpcTextNode> textNodes = new ArrayList<NpcTextNode>();

    String toJson(String ddl) {
      List<Map.Entry<String, Integer>> files = new ArrayList<Map.Entry<String, Integer>>(textNodesByFile.entrySet());
      Collections.sort(files, Comparator.comparing(Map.Entry::getKey, String.CASE_INSENSITIVE_ORDER));

      StringBuilder sb = new StringBuilder();
      sb.append("{\n");
      sb.append("  \"generatedAt\": ").append(QuestSemanticJson.jsonString(generatedAt)).append(",\n");
      sb.append("  \"sourceNpcDir\": ").append(QuestSemanticJson.jsonString(sourceNpcDir)).append(",\n");
      sb.append("  \"totalNpcFilesScanned\": ").append(totalNpcFilesScanned).append(",\n");
      sb.append("  \"totalNpcTextNodesFound\": ").append(totalNpcTextNodesFound).append(",\n");
      sb.append("  \"dbInsertedRows\": ").append(dbInsertedRows).append(",\n");

      sb.append("  \"textNodesByFile\": {");
      if(!files.isEmpty()) {
        sb.append("\n");
        for(int i = 0; i < files.size(); i++) {
          if(i > 0) sb.append(",\n");
          Map.Entry<String, Integer> e = files.get(i);
          sb.append("    ").append(QuestSemanticJson.jsonString(e.getKey())).append(": ").append(e.getValue().intValue());
        }
        sb.append("\n  ");
      }
      sb.append("},\n");

      sb.append("  \"extractionErrors\": ").append(QuestSemanticJson.toJsonArrayString(extractionErrors)).append(",\n");
      sb.append("  \"tableDDL\": ").append(QuestSemanticJson.jsonString(ddl)).append(",\n");

      sb.append("  \"textNodes\": [");
      if(!textNodes.isEmpty()) {
        sb.append("\n");
        for(int i = 0; i < textNodes.size(); i++) {
          if(i > 0) sb.append(",\n");
          sb.append("    ").append(textNodes.get(i).toJson());
        }
        sb.append("\n  ");
      }
      sb.append("]\n");
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
