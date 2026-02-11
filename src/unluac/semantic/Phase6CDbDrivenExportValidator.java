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
import java.sql.ResultSet;
import java.time.OffsetDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Random;
import java.util.Set;

public class Phase6CDbDrivenExportValidator {

  private static final Charset UTF8 = Charset.forName("UTF-8");
  private static final String DEFAULT_JDBC = "jdbc:mysql://127.0.0.1:3306/ghost_game"
      + "?useUnicode=true&characterEncoding=utf8&serverTimezone=UTC&useSSL=false&allowPublicKeyRetrieval=true";
  private static final String DEFAULT_USER = "root";
  private static final String DEFAULT_PASSWORD = "root";
  private static final String DB_ONLY_MARK = "[DB_ONLY_MARK]";

  public static void main(String[] args) throws Exception {
    Path phase2NpcIndex = args.length >= 1
        ? Paths.get(args[0])
        : Paths.get("reports", "phase2_npc_reference_index.json");
    Path baselineNpcDir = args.length >= 2
        ? Paths.get(args[1])
        : Paths.get("reports", "phase5_exported_npc");
    Path outputNpcDir = args.length >= 3
        ? Paths.get(args[2])
        : Paths.get("reports", "phase6C_db_driven_export");
    Path reportPath = args.length >= 4
        ? Paths.get(args[3])
        : Paths.get("reports", "phase6C_db_driven_validation.json");

    long start = System.nanoTime();
    Phase6CDbDrivenExportValidator runner = new Phase6CDbDrivenExportValidator();
    ValidationReport report = runner.run(phase2NpcIndex, baselineNpcDir, outputNpcDir, reportPath);
    long elapsed = (System.nanoTime() - start) / 1_000_000L;

    System.out.println("mutatedQuestId=" + report.mutatedQuestId);
    System.out.println("dbMutationApplied=" + report.dbMutationApplied);
    System.out.println("npcFilesContainingQuest=" + QuestSemanticJson.toJsonArrayString(report.npcFilesContainingQuest));
    System.out.println("changedNpcFiles=" + QuestSemanticJson.toJsonArrayString(report.changedNpcFiles));
    System.out.println("exportMode=" + report.exportMode);
    System.out.println("finalStatus=" + report.finalStatus);
    System.out.println("phase6CMillis=" + elapsed);

    if("EXPORT_NOT_DB_DRIVEN".equals(report.finalStatus)) {
      throw new IllegalStateException("Phase6-C finalStatus is EXPORT_NOT_DB_DRIVEN");
    }
  }

  public ValidationReport run(Path phase2NpcIndex,
                              Path baselineNpcDir,
                              Path outputNpcDir,
                              Path reportPath) throws Exception {
    if(phase2NpcIndex == null || !Files.exists(phase2NpcIndex) || !Files.isRegularFile(phase2NpcIndex)) {
      throw new IllegalStateException("phase2_npc_reference_index.json not found: " + phase2NpcIndex);
    }
    if(baselineNpcDir == null || !Files.exists(baselineNpcDir) || !Files.isDirectory(baselineNpcDir)) {
      throw new IllegalStateException("baseline npc directory not found: " + baselineNpcDir);
    }

    ensureMysqlDriverAvailable();

    ValidationReport report = new ValidationReport();
    report.generatedAt = OffsetDateTime.now().format(DateTimeFormatter.ISO_OFFSET_DATE_TIME);

    int questId = pickQuestForMutation();
    applyDatabaseMutation(questId);
    report.mutatedQuestId = questId;
    report.dbMutationApplied = true;
    report.npcFilesContainingQuest.addAll(queryNpcFilesByQuestId(questId));

    Phase5NpcLucExporter exporter = new Phase5NpcLucExporter();
    exporter.export(
        phase2NpcIndex,
        outputNpcDir,
        Paths.get("reports", "phase6C_export_summary.json"),
        DEFAULT_JDBC,
        DEFAULT_USER,
        DEFAULT_PASSWORD);

    report.changedNpcFiles.addAll(compareNpcDirectories(baselineNpcDir, outputNpcDir));
    Collections.sort(report.changedNpcFiles, String.CASE_INSENSITIVE_ORDER);

    if(report.changedNpcFiles.isEmpty()) {
      report.exportMode = "NON_DB_DRIVEN";
      report.finalStatus = "EXPORT_NOT_DB_DRIVEN";
    } else {
      report.exportMode = "DB_DRIVEN";
      report.finalStatus = "SAFE";
    }

    ensureParent(reportPath);
    Files.write(reportPath, report.toJson().getBytes(UTF8));
    return report;
  }

  private int pickQuestForMutation() throws Exception {
    List<Integer> questIds = new ArrayList<Integer>();
    String sql = "SELECT DISTINCT qm.quest_id "
        + "FROM quest_main qm "
        + "INNER JOIN quest_reward_item qri ON qri.quest_id = qm.quest_id "
        + "ORDER BY qm.quest_id ASC";
    try(Connection connection = DriverManager.getConnection(DEFAULT_JDBC, DEFAULT_USER, DEFAULT_PASSWORD);
        PreparedStatement ps = connection.prepareStatement(sql);
        ResultSet rs = ps.executeQuery()) {
      while(rs.next()) {
        questIds.add(Integer.valueOf(rs.getInt(1)));
      }
    }
    if(questIds.isEmpty()) {
      throw new IllegalStateException("No eligible quest found in DB for Phase6-C mutation");
    }
    int index = new Random(System.nanoTime()).nextInt(questIds.size());
    return questIds.get(index).intValue();
  }

  private void applyDatabaseMutation(int questId) throws Exception {
    try(Connection connection = DriverManager.getConnection(DEFAULT_JDBC, DEFAULT_USER, DEFAULT_PASSWORD)) {
      connection.setAutoCommit(false);
      try {
        String updateName = "UPDATE quest_main SET name = CONCAT(COALESCE(name,''), ?) WHERE quest_id = ?";
        String updateReward = "UPDATE quest_reward_item SET item_count = item_count + 5 WHERE quest_id = ? ORDER BY seq_index ASC LIMIT 1";

        try(PreparedStatement psName = connection.prepareStatement(updateName);
            PreparedStatement psReward = connection.prepareStatement(updateReward)) {
          psName.setString(1, DB_ONLY_MARK);
          psName.setInt(2, questId);
          int nameRows = psName.executeUpdate();

          psReward.setInt(1, questId);
          int rewardRows = psReward.executeUpdate();

          if(nameRows <= 0 || rewardRows <= 0) {
            throw new IllegalStateException("DB mutation failed for questId=" + questId
                + " nameRows=" + nameRows
                + " rewardRows=" + rewardRows);
          }
        }
        connection.commit();
      } catch(Exception ex) {
        connection.rollback();
        throw ex;
      }
    }
  }

  private List<String> queryNpcFilesByQuestId(int questId) throws Exception {
    List<String> out = new ArrayList<String>();
    String sql = "SELECT DISTINCT npc_file FROM npc_quest_reference WHERE quest_id = ? ORDER BY npc_file ASC";
    try(Connection connection = DriverManager.getConnection(DEFAULT_JDBC, DEFAULT_USER, DEFAULT_PASSWORD);
        PreparedStatement ps = connection.prepareStatement(sql)) {
      ps.setInt(1, questId);
      try(ResultSet rs = ps.executeQuery()) {
        while(rs.next()) {
          String file = normalizePath(safe(rs.getString(1)));
          if(!file.isEmpty()) {
            out.add(file);
          }
        }
      }
    }
    return out;
  }

  private List<String> compareNpcDirectories(Path baselineDir, Path afterDir) throws Exception {
    List<String> baseline = collectNpcFiles(baselineDir);
    List<String> after = collectNpcFiles(afterDir);
    Set<String> afterSet = new HashSet<String>(after);

    List<String> changed = new ArrayList<String>();
    for(String relative : baseline) {
      Path before = baselineDir.resolve(relative);
      Path next = afterDir.resolve(relative);
      if(!Files.exists(next) || !Files.isRegularFile(next)) {
        changed.add(relative);
        continue;
      }
      byte[] left = Files.readAllBytes(before);
      byte[] right = Files.readAllBytes(next);
      if(!sameBytes(left, right)) {
        changed.add(relative);
      }
      afterSet.remove(relative);
    }
    for(String extra : afterSet) {
      changed.add(extra);
    }
    return changed;
  }

  private List<String> collectNpcFiles(Path root) throws Exception {
    List<String> out = new ArrayList<String>();
    Files.walk(root)
        .filter(Files::isRegularFile)
        .forEach(path -> {
          String rel = normalizePath(root.relativize(path).toString());
          if(isNpcLua(rel)) {
            out.add(rel);
          }
        });
    Collections.sort(out, String.CASE_INSENSITIVE_ORDER);
    return out;
  }

  private boolean isNpcLua(String relativePath) {
    if(relativePath == null) {
      return false;
    }
    String lower = relativePath.toLowerCase();
    return lower.startsWith("npc_") && lower.endsWith(".lua");
  }

  private boolean sameBytes(byte[] a, byte[] b) {
    if(a == b) {
      return true;
    }
    if(a == null || b == null || a.length != b.length) {
      return false;
    }
    for(int i = 0; i < a.length; i++) {
      if(a[i] != b[i]) {
        return false;
      }
    }
    return true;
  }

  private void ensureParent(Path file) throws Exception {
    if(file.getParent() != null && !Files.exists(file.getParent())) {
      Files.createDirectories(file.getParent());
    }
  }

  private String normalizePath(String path) {
    if(path == null) {
      return "";
    }
    return path.replace('\\', '/').trim();
  }

  private String safe(Object value) {
    return value == null ? "" : String.valueOf(value);
  }

  private void ensureMysqlDriverAvailable() throws Exception {
    try {
      DriverManager.getDriver(DEFAULT_JDBC);
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
    URLClassLoader loader = new URLClassLoader(new URL[] {url}, Phase6CDbDrivenExportValidator.class.getClassLoader());
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

  public static final class ValidationReport {
    String generatedAt = "";
    int mutatedQuestId;
    boolean dbMutationApplied;
    final List<String> npcFilesContainingQuest = new ArrayList<String>();
    final List<String> changedNpcFiles = new ArrayList<String>();
    String exportMode = "";
    String finalStatus = "";

    String toJson() {
      StringBuilder sb = new StringBuilder();
      sb.append("{\n");
      sb.append("  \"generatedAt\": ").append(QuestSemanticJson.jsonString(generatedAt)).append(",\n");
      sb.append("  \"mutatedQuestId\": ").append(mutatedQuestId).append(",\n");
      sb.append("  \"dbMutationApplied\": ").append(dbMutationApplied).append(",\n");
      sb.append("  \"npcFilesContainingQuest\": ").append(QuestSemanticJson.toJsonArrayString(npcFilesContainingQuest)).append(",\n");
      sb.append("  \"changedNpcFiles\": ").append(QuestSemanticJson.toJsonArrayString(changedNpcFiles)).append(",\n");
      sb.append("  \"exportMode\": ").append(QuestSemanticJson.jsonString(exportMode)).append(",\n");
      sb.append("  \"finalStatus\": ").append(QuestSemanticJson.jsonString(finalStatus)).append("\n");
      sb.append("}\n");
      return sb.toString();
    }
  }
}

