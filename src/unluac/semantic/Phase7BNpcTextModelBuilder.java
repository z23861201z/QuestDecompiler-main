package unluac.semantic;

import java.net.URL;
import java.net.URLClassLoader;
import java.nio.charset.Charset;
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
import java.util.List;
import java.util.Map;

public class Phase7BNpcTextModelBuilder {

  private static final Charset UTF8 = Charset.forName("UTF-8");
  private static final String TABLE_NAME = "npc_text_edit_map";

  private static final String DEFAULT_JDBC = "jdbc:mysql://127.0.0.1:3306/ghost_game"
      + "?useUnicode=true&characterEncoding=utf8&serverTimezone=UTC&useSSL=false&allowPublicKeyRetrieval=true";
  private static final String DEFAULT_USER = "root";
  private static final String DEFAULT_PASSWORD = "root";

  public static void main(String[] args) throws Exception {
    Path phase7AReport = args.length >= 1
        ? Paths.get(args[0])
        : Paths.get("reports", "phase7A_npc_text_extraction.json");
    Path ddlOutput = args.length >= 2
        ? Paths.get(args[1])
        : Paths.get("reports", "phase7B_npc_text_model_ddl.sql");
    Path docOutput = args.length >= 3
        ? Paths.get(args[2])
        : Paths.get("docs", "phase7B_npc_text_model_summary.md");
    String jdbcUrl = args.length >= 4 ? args[3] : DEFAULT_JDBC;
    String user = args.length >= 5 ? args[4] : DEFAULT_USER;
    String password = args.length >= 6 ? args[5] : DEFAULT_PASSWORD;

    long start = System.nanoTime();
    Phase7BNpcTextModelBuilder builder = new Phase7BNpcTextModelBuilder();
    Result result = builder.build(phase7AReport, ddlOutput, docOutput, jdbcUrl, user, password);
    long elapsed = (System.nanoTime() - start) / 1_000_000L;

    System.out.println("phase7AReport=" + phase7AReport.toAbsolutePath());
    System.out.println("tableName=" + TABLE_NAME);
    System.out.println("sourceTextNodeCount=" + result.sourceTextNodeCount);
    System.out.println("insertedRowCount=" + result.insertedRowCount);
    System.out.println("ddlOutput=" + ddlOutput.toAbsolutePath());
    System.out.println("docOutput=" + docOutput.toAbsolutePath());
    System.out.println("phase7BMillis=" + elapsed);
  }

  public Result build(Path phase7AReport,
                      Path ddlOutput,
                      Path docOutput,
                      String jdbcUrl,
                      String user,
                      String password) throws Exception {
    if(phase7AReport == null || !Files.exists(phase7AReport) || !Files.isRegularFile(phase7AReport)) {
      throw new IllegalStateException("phase7A report not found: " + phase7AReport);
    }

    String json = new String(Files.readAllBytes(phase7AReport), UTF8);
    Map<String, Object> root = QuestSemanticJson.parseObject(json, "phase7A_npc_text_extraction", 0);

    List<NpcTextRow> rows = parseRows(root);
    String ddl = ddlSql();

    ensureParent(ddlOutput);
    Files.write(ddlOutput, (ddl + System.lineSeparator()).getBytes(UTF8));

    ensureMysqlDriverAvailable(jdbcUrl);
    int inserted = createAndLoadTable(rows, ddl, jdbcUrl, user, password);

    ensureParent(docOutput);
    Files.write(docOutput, buildSummaryMarkdown(phase7AReport, rows.size(), inserted).getBytes(UTF8));

    Result result = new Result();
    result.sourceTextNodeCount = rows.size();
    result.insertedRowCount = inserted;
    return result;
  }

  private List<NpcTextRow> parseRows(Map<String, Object> root) {
    Object nodesObj = root.get("textNodes");
    if(!(nodesObj instanceof List<?>)) {
      throw new IllegalStateException("phase7A report missing textNodes array");
    }

    @SuppressWarnings("unchecked")
    List<Object> nodes = (List<Object>) nodesObj;
    List<NpcTextRow> out = new ArrayList<NpcTextRow>(nodes.size());
    for(Object nodeObj : nodes) {
      if(!(nodeObj instanceof Map<?, ?>)) {
        continue;
      }

      @SuppressWarnings("unchecked")
      Map<String, Object> node = (Map<String, Object>) nodeObj;

      NpcTextRow row = new NpcTextRow();
      row.npcFile = safe(node.get("npcFile"));
      row.line = intOf(node.get("lineNumber"));
      row.columnNumber = intOf(node.get("column"));
      row.callType = safe(node.get("callType"));
      row.rawText = safe(node.get("rawText"));
      row.stringLiteral = safe(node.get("stringLiteral"));
      row.astMarker = safe(node.get("astMarker"));
      row.functionName = safe(node.get("functionName"));
      row.surroundingAstContext = safe(node.get("surroundingAstContext"));
      row.associatedQuestId = intOf(node.get("associatedQuestId"));
      row.associatedQuestIdsJson = toQuestIdsJson(node.get("associatedQuestIds"));

      if(row.npcFile.isEmpty() || row.line <= 0 || row.columnNumber <= 0 || row.callType.isEmpty()) {
        continue;
      }
      out.add(row);
    }
    return out;
  }

  private String toQuestIdsJson(Object value) {
    if(!(value instanceof List<?>)) {
      return "[]";
    }
    @SuppressWarnings("unchecked")
    List<Object> list = (List<Object>) value;
    List<Integer> ids = new ArrayList<Integer>();
    for(Object item : list) {
      int parsed = intOf(item);
      if(parsed > 0) {
        ids.add(Integer.valueOf(parsed));
      }
    }
    Collections.sort(ids);
    return QuestSemanticJson.toJsonArrayInt(ids);
  }

  private int createAndLoadTable(List<NpcTextRow> rows,
                                 String ddl,
                                 String jdbcUrl,
                                 String user,
                                 String password) throws Exception {
    try(Connection connection = DriverManager.getConnection(jdbcUrl, user, password)) {
      connection.setAutoCommit(false);
      try {
        try(Statement statement = connection.createStatement()) {
          statement.execute(ddl);
          statement.execute("DELETE FROM " + TABLE_NAME);
        }

        String insertSql = "INSERT INTO " + TABLE_NAME + "(" 
            + "npcFile, line, columnNumber, callType, rawText, modifiedText, stringLiteral, "
            + "astMarker, functionName, surroundingAstContext, associatedQuestId, associatedQuestIdsJson" 
            + ") VALUES (?,?,?,?,?,?,?,?,?,?,?,?)";

        int inserted = 0;
        try(PreparedStatement ps = connection.prepareStatement(insertSql)) {
          for(NpcTextRow row : rows) {
            ps.setString(1, row.npcFile);
            ps.setInt(2, row.line);
            ps.setInt(3, row.columnNumber);
            ps.setString(4, row.callType);
            ps.setString(5, row.rawText);
            ps.setNull(6, java.sql.Types.LONGVARCHAR);
            ps.setString(7, row.stringLiteral);
            ps.setString(8, row.astMarker);
            ps.setString(9, row.functionName);
            ps.setString(10, row.surroundingAstContext);
            if(row.associatedQuestId > 0) {
              ps.setInt(11, row.associatedQuestId);
            } else {
              ps.setNull(11, java.sql.Types.INTEGER);
            }
            ps.setString(12, row.associatedQuestIdsJson);
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

  private String buildSummaryMarkdown(Path source,
                                      int sourceTextNodeCount,
                                      int insertedRowCount) {
    StringBuilder sb = new StringBuilder();
    sb.append("# Phase7B NPC Text Model Summary\n\n");
    sb.append("- GeneratedAt: ").append(OffsetDateTime.now().format(DateTimeFormatter.ISO_OFFSET_DATE_TIME)).append("\n");
    sb.append("- SourceReport: `").append(source.toString().replace('\\', '/')).append("`\n");
    sb.append("- TableName: `").append(TABLE_NAME).append("`\n");
    sb.append("- SourceTextNodeCount: ").append(sourceTextNodeCount).append("\n");
    sb.append("- InsertedRowCount: ").append(insertedRowCount).append("\n\n");

    sb.append("## Table DDL\n\n");
    sb.append("```sql\n").append(ddlSql()).append("\n```\n\n");

    sb.append("## Field Definition\n\n");
    sb.append("| Field | Type | Description |\n");
    sb.append("|---|---|---|\n");
    sb.append("| `textId` | BIGINT PK | Unique text id for Web editing row |\n");
    sb.append("| `npcFile` | VARCHAR(255) | Source NPC file name, e.g. `npc_218008.lua` |\n");
    sb.append("| `line` | INT | Original line number (1-based) |\n");
    sb.append("| `columnNumber` | INT | Original column number (1-based) |\n");
    sb.append("| `callType` | VARCHAR(32) | Editable call type scope: `NPC_SAY` / `NPC_ASK` |\n");
    sb.append("| `rawText` | LONGTEXT | Original extracted text |\n");
    sb.append("| `modifiedText` | LONGTEXT | User edited text, nullable |\n");
    sb.append("| `stringLiteral` | LONGTEXT | Original Lua string literal with quote/escape |\n");
    sb.append("| `astMarker` | VARCHAR(255) | AST location marker for exact locate |\n");
    sb.append("| `functionName` | VARCHAR(128) | Function containing the text node |\n");
    sb.append("| `surroundingAstContext` | LONGTEXT | AST context for safe localization |\n");
    sb.append("| `associatedQuestId` | INT | Primary related quest id, nullable |\n");
    sb.append("| `associatedQuestIdsJson` | JSON | Related quest id array |\n");
    sb.append("| `created_at` / `updated_at` | TIMESTAMP | Audit fields |\n\n");

    sb.append("## textId Locate to Source\n\n");
    sb.append("1. Query one row by textId:\n");
    sb.append("   `SELECT npcFile, line, columnNumber, astMarker, callType, rawText, modifiedText FROM ")
        .append(TABLE_NAME)
        .append(" WHERE textId=?;`\n");
    sb.append("2. Open `npcFile` and locate by `line + columnNumber + astMarker`.\n");
    sb.append("3. Replace only text literal: `effectiveText = COALESCE(modifiedText, rawText)`.\n");
    sb.append("4. Do not modify AST structure, function structure, call name, or argument count.\n\n");

    sb.append("## Locate + Replace Rule\n\n");
    sb.append("- Reversible: `rawText` and `stringLiteral` are always preserved.\n");
    sb.append("- Editable only: `modifiedText`.\n");
    sb.append("- No refactor logic: only text replacement, no AST rewrite.\n");
    sb.append("- Unique locator: `UNIQUE(npcFile, line, columnNumber, astMarker)`.\n\n");

    sb.append("## Quest Association\n\n");
    sb.append("- Use `associatedQuestId` and `associatedQuestIdsJson` for quest linkage if present.\n");
    sb.append("- Quest side change can query impacted NPC text rows by quest id.\n");

    return sb.toString();
  }

  private String ddlSql() {
    return "CREATE TABLE IF NOT EXISTS " + TABLE_NAME + " ("
        + "textId BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,"
        + "npcFile VARCHAR(255) NOT NULL,"
        + "line INT NOT NULL,"
        + "columnNumber INT NOT NULL,"
        + "callType VARCHAR(32) NOT NULL,"
        + "rawText LONGTEXT NOT NULL,"
        + "modifiedText LONGTEXT NULL,"
        + "stringLiteral LONGTEXT NOT NULL,"
        + "astMarker VARCHAR(255) NOT NULL,"
        + "functionName VARCHAR(128) NULL,"
        + "surroundingAstContext LONGTEXT NULL,"
        + "associatedQuestId INT NULL,"
        + "associatedQuestIdsJson JSON NULL,"
        + "created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,"
        + "updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,"
        + "UNIQUE KEY uk_npc_text_locator (npcFile, line, columnNumber, astMarker),"
        + "KEY idx_npc_text_file (npcFile),"
        + "KEY idx_npc_text_quest (associatedQuestId),"
        + "KEY idx_npc_text_call (callType)"
        + ") ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci";
  }

  private String safe(Object value) {
    return value == null ? "" : String.valueOf(value);
  }

  private int intOf(Object value) {
    if(value == null) {
      return 0;
    }
    if(value instanceof Number) {
      return ((Number) value).intValue();
    }
    try {
      return Integer.parseInt(String.valueOf(value).trim());
    } catch(Exception ex) {
      return 0;
    }
  }

  private void ensureParent(Path file) throws Exception {
    if(file.getParent() != null && !Files.exists(file.getParent())) {
      Files.createDirectories(file.getParent());
    }
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
    URLClassLoader loader = new URLClassLoader(new URL[] {url}, Phase7BNpcTextModelBuilder.class.getClassLoader());
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

  private static final class NpcTextRow {
    String npcFile = "";
    int line;
    int columnNumber;
    String callType = "";
    String rawText = "";
    String stringLiteral = "";
    String astMarker = "";
    String functionName = "";
    String surroundingAstContext = "";
    int associatedQuestId;
    String associatedQuestIdsJson = "[]";
  }

  public static final class Result {
    int sourceTextNodeCount;
    int insertedRowCount;
  }
}

