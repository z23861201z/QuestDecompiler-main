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
import java.util.LinkedHashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.Set;

public class Phase6DbMutationAndImpactValidator {

  private static final Charset UTF8 = Charset.forName("UTF-8");
  private static final String DEFAULT_JDBC = "jdbc:mysql://127.0.0.1:3306/ghost_game"
      + "?useUnicode=true&characterEncoding=utf8&serverTimezone=UTC&useSSL=false&allowPublicKeyRetrieval=true";
  private static final String DEFAULT_USER = "root";
  private static final String DEFAULT_PASSWORD = "root";
  private static final String MODIFIED_TOKEN = "[MODIFIED_TEST]";

  public static void main(String[] args) throws Exception {
    Path graphPath = args.length >= 1
        ? Paths.get(args[0])
        : Paths.get("reports", "phase2_5_quest_npc_dependency_graph.json");
    Path baselineDir = args.length >= 2
        ? Paths.get(args[1])
        : Paths.get("reports", "phase5_exported_npc");
    Path afterDir = args.length >= 3
        ? Paths.get(args[2])
        : Paths.get("reports", "phase6_export_after_mutation");
    Path reportPath = args.length >= 4
        ? Paths.get(args[3])
        : Paths.get("reports", "phase6_mutation_validation.json");

    long start = System.nanoTime();
    Phase6DbMutationAndImpactValidator runner = new Phase6DbMutationAndImpactValidator();
    ValidationReport report = runner.run(graphPath, baselineDir, afterDir, reportPath);
    long elapsed = (System.nanoTime() - start) / 1_000_000L;

    System.out.println("mutatedQuestIds=" + QuestSemanticJson.toJsonArrayInt(report.mutatedQuestIds));
    System.out.println("expectedAffectedNpcFiles count=" + report.expectedAffectedNpcFiles.size());
    System.out.println("actualChangedNpcFiles count=" + report.actualChangedNpcFiles.size());
    System.out.println("finalStatus=" + report.finalStatus);
    System.out.println("phase6Millis=" + elapsed);

    if(!"SAFE".equals(report.finalStatus)) {
      System.out.println("=== Phase6 Diff Details ===");
      for(DiffDetail detail : report.diffDetails) {
        System.out.println("file=" + detail.file);
        System.out.println(detail.snippet);
      }
      throw new IllegalStateException("Phase6 finalStatus is UNSAFE");
    }
  }

  public ValidationReport run(Path graphPath,
                              Path baselineDir,
                              Path afterDir,
                              Path reportPath) throws Exception {
    if(graphPath == null || !Files.exists(graphPath) || !Files.isRegularFile(graphPath)) {
      throw new IllegalStateException("graph file not found: " + graphPath);
    }
    if(baselineDir == null || !Files.exists(baselineDir) || !Files.isDirectory(baselineDir)) {
      throw new IllegalStateException("baseline npc dir not found: " + baselineDir);
    }

    ensureMysqlDriverAvailable();
    Map<Integer, Set<String>> graphEdges = loadQuestToNpcEdges(graphPath);

    MutationResult mutation = mutateDatabase(graphEdges);

    Phase5NpcLucExporter exporter = new Phase5NpcLucExporter();
    Path phase2NpcIndex = Paths.get("reports", "phase2_npc_reference_index.json");
    Path phase6ExportSummary = Paths.get("reports", "phase6_export_summary.json");
    exporter.export(phase2NpcIndex, afterDir, phase6ExportSummary, DEFAULT_JDBC, DEFAULT_USER, DEFAULT_PASSWORD);

    DirectoryDiff diff = compareDirectories(baselineDir, afterDir);

    ValidationReport report = buildValidationReport(mutation, diff, graphEdges);
    ensureParent(reportPath);
    Files.write(reportPath, report.toJson().getBytes(UTF8));
    return report;
  }

  private MutationResult mutateDatabase(Map<Integer, Set<String>> graphEdges) throws Exception {
    MutationResult out = new MutationResult();

    List<Integer> candidates = new ArrayList<Integer>();
    List<Integer> noEdgeCandidates = new ArrayList<Integer>();

    try(Connection connection = DriverManager.getConnection(DEFAULT_JDBC, DEFAULT_USER, DEFAULT_PASSWORD)) {
      connection.setAutoCommit(false);
      try {
        String query = "SELECT qm.quest_id "
            + "FROM quest_main qm "
            + "WHERE EXISTS (SELECT 1 FROM quest_contents qc WHERE qc.quest_id = qm.quest_id AND qc.seq_index = 0) "
            + "AND EXISTS (SELECT 1 FROM quest_reward_item qri WHERE qri.quest_id = qm.quest_id) "
            + "ORDER BY qm.quest_id ASC";

        try(PreparedStatement ps = connection.prepareStatement(query);
            ResultSet rs = ps.executeQuery()) {
          while(rs.next()) {
            int questId = rs.getInt(1);
            candidates.add(Integer.valueOf(questId));
            Set<String> edges = graphEdges.get(Integer.valueOf(questId));
            if(edges == null || edges.isEmpty()) {
              noEdgeCandidates.add(Integer.valueOf(questId));
            }
          }
        }

        if(candidates.isEmpty()) {
          throw new IllegalStateException("No quest candidates available for mutation");
        }

        List<Integer> pickPool = noEdgeCandidates.isEmpty() ? candidates : noEdgeCandidates;
        int mutateCount = 1 + new Random(System.nanoTime()).nextInt(3);
        List<Integer> picked = randomPick(pickPool, mutateCount);

        String updateName = "UPDATE quest_main SET name = CONCAT(COALESCE(name,''), ?) WHERE quest_id = ?";
        String updateReward = "UPDATE quest_reward_item SET item_count = item_count + 1 WHERE quest_id = ? ORDER BY seq_index ASC LIMIT 1";
        String updateContent = "UPDATE quest_contents SET text = CONCAT(COALESCE(text,''), ?) WHERE quest_id = ? AND seq_index = 0";

        try(PreparedStatement psName = connection.prepareStatement(updateName);
            PreparedStatement psReward = connection.prepareStatement(updateReward);
            PreparedStatement psContent = connection.prepareStatement(updateContent)) {

          for(Integer questId : picked) {
            psName.setString(1, MODIFIED_TOKEN);
            psName.setInt(2, questId.intValue());
            int nameRows = psName.executeUpdate();

            psReward.setInt(1, questId.intValue());
            int rewardRows = psReward.executeUpdate();

            psContent.setString(1, MODIFIED_TOKEN);
            psContent.setInt(2, questId.intValue());
            int contentRows = psContent.executeUpdate();

            if(nameRows <= 0 || rewardRows <= 0 || contentRows <= 0) {
              throw new IllegalStateException("Mutation failed for questId=" + questId
                  + " nameRows=" + nameRows
                  + " rewardRows=" + rewardRows
                  + " contentRows=" + contentRows);
            }

            out.mutatedQuestIds.add(Integer.valueOf(questId.intValue()));
          }
        }

        connection.commit();
      } catch(Exception ex) {
        connection.rollback();
        throw ex;
      }
    }

    Collections.sort(out.mutatedQuestIds);
    return out;
  }

  private List<Integer> randomPick(List<Integer> input, int desiredCount) {
    List<Integer> pool = new ArrayList<Integer>(input);
    Collections.shuffle(pool, new Random(System.nanoTime()));
    int count = Math.min(desiredCount, pool.size());
    List<Integer> out = new ArrayList<Integer>();
    for(int i = 0; i < count; i++) {
      out.add(pool.get(i));
    }
    return out;
  }

  private Map<Integer, Set<String>> loadQuestToNpcEdges(Path graphPath) throws Exception {
    Map<Integer, Set<String>> out = new LinkedHashMap<Integer, Set<String>>();
    Map<String, Object> root = readJsonObject(graphPath, "phase2_5_quest_npc_dependency_graph");
    Object edgesObj = root.get("edges");
    if(!(edgesObj instanceof List<?>)) {
      return out;
    }

    @SuppressWarnings("unchecked")
    List<Object> edges = (List<Object>) edgesObj;
    for(Object edgeObj : edges) {
      if(!(edgeObj instanceof Map<?, ?>)) {
        continue;
      }

      @SuppressWarnings("unchecked")
      Map<String, Object> edge = (Map<String, Object>) edgeObj;
      String from = normalizePath(safe(edge.get("from")));
      int questId = parseQuestId(edge.get("to"));
      if(questId <= 0 || from.isEmpty()) {
        continue;
      }
      Set<String> files = out.get(Integer.valueOf(questId));
      if(files == null) {
        files = new LinkedHashSet<String>();
        out.put(Integer.valueOf(questId), files);
      }
      files.add(from);
    }
    return out;
  }

  private int parseQuestId(Object value) {
    String text = safe(value).trim();
    if(text.startsWith("quest_")) {
      text = text.substring("quest_".length());
    }
    try {
      return Integer.parseInt(text);
    } catch(Exception ex) {
      return 0;
    }
  }

  private DirectoryDiff compareDirectories(Path baselineDir,
                                           Path afterDir) throws Exception {
    DirectoryDiff diff = new DirectoryDiff();

    List<String> baselineFiles = collectNpcFiles(baselineDir);
    List<String> afterFiles = collectNpcFiles(afterDir);
    diff.totalFilesCompared = baselineFiles.size();

    Set<String> afterSet = new HashSet<String>(afterFiles);

    for(String rel : baselineFiles) {
      Path before = baselineDir.resolve(rel);
      Path after = afterDir.resolve(rel);
      if(!Files.exists(after)) {
        diff.changedFiles.add(rel);
        DiffDetail detail = new DiffDetail();
        detail.file = rel;
        detail.snippet = "--- " + rel + " (baseline)\n+++ " + rel + " (after)\n<missing in after directory>";
        diff.details.add(detail);
        continue;
      }

      byte[] left = Files.readAllBytes(before);
      byte[] right = Files.readAllBytes(after);
      if(!equalsBytes(left, right)) {
        diff.changedFiles.add(rel);
        DiffDetail detail = new DiffDetail();
        detail.file = rel;
        detail.snippet = buildDiffSnippet(rel,
            new String(left, UTF8),
            new String(right, UTF8));
        diff.details.add(detail);
      }

      afterSet.remove(rel);
    }

    if(!afterSet.isEmpty()) {
      List<String> extra = new ArrayList<String>(afterSet);
      Collections.sort(extra, String.CASE_INSENSITIVE_ORDER);
      for(String rel : extra) {
        diff.changedFiles.add(rel);
        DiffDetail detail = new DiffDetail();
        detail.file = rel;
        detail.snippet = "--- " + rel + " (baseline)\n+++ " + rel + " (after)\n<extra file in after directory>";
        diff.details.add(detail);
      }
    }

    Collections.sort(diff.changedFiles, String.CASE_INSENSITIVE_ORDER);
    return diff;
  }

  private boolean equalsBytes(byte[] left, byte[] right) {
    if(left == null || right == null) {
      return left == right;
    }
    if(left.length != right.length) {
      return false;
    }
    for(int i = 0; i < left.length; i++) {
      if(left[i] != right[i]) {
        return false;
      }
    }
    return true;
  }

  private String buildDiffSnippet(String file,
                                  String beforeText,
                                  String afterText) {
    String[] beforeLines = beforeText == null ? new String[0] : beforeText.split("\\r?\\n", -1);
    String[] afterLines = afterText == null ? new String[0] : afterText.split("\\r?\\n", -1);

    int min = Math.min(beforeLines.length, afterLines.length);
    int diffIndex = -1;
    for(int i = 0; i < min; i++) {
      if(!beforeLines[i].equals(afterLines[i])) {
        diffIndex = i;
        break;
      }
    }
    if(diffIndex < 0 && beforeLines.length != afterLines.length) {
      diffIndex = min;
    }
    if(diffIndex < 0) {
      diffIndex = 0;
    }

    int start = Math.max(0, diffIndex - 20);
    int endBefore = Math.min(beforeLines.length - 1, diffIndex + 20);
    int endAfter = Math.min(afterLines.length - 1, diffIndex + 20);

    StringBuilder sb = new StringBuilder();
    sb.append("--- ").append(file).append(" (baseline)\n");
    sb.append("+++ ").append(file).append(" (after)\n");
    sb.append("@@ around line ").append(diffIndex + 1).append(" @@\n");

    for(int i = start; i <= endBefore; i++) {
      sb.append("-").append(i + 1).append(": ").append(beforeLines[i]).append("\n");
    }
    for(int i = start; i <= endAfter; i++) {
      sb.append("+").append(i + 1).append(": ").append(afterLines[i]).append("\n");
    }
    return sb.toString();
  }

  private ValidationReport buildValidationReport(MutationResult mutation,
                                                 DirectoryDiff diff,
                                                 Map<Integer, Set<String>> graphEdges) {
    ValidationReport report = new ValidationReport();
    report.generatedAt = OffsetDateTime.now().format(DateTimeFormatter.ISO_OFFSET_DATE_TIME);
    report.mutatedQuestIds.addAll(mutation.mutatedQuestIds);

    Set<String> expected = new LinkedHashSet<String>();
    for(Integer questId : mutation.mutatedQuestIds) {
      Set<String> files = graphEdges.get(questId);
      if(files != null) {
        expected.addAll(files);
      }
    }

    report.expectedAffectedNpcFiles.addAll(sorted(expected));
    report.actualChangedNpcFiles.addAll(sorted(new LinkedHashSet<String>(diff.changedFiles)));

    Set<String> actual = new LinkedHashSet<String>(report.actualChangedNpcFiles);

    Set<String> unexpected = new LinkedHashSet<String>(actual);
    unexpected.removeAll(expected);
    report.unexpectedChangedFiles.addAll(sorted(unexpected));

    Set<String> unchangedExpected = new LinkedHashSet<String>(expected);
    unchangedExpected.removeAll(actual);
    report.unchangedExpectedFiles.addAll(sorted(unchangedExpected));

    report.diffSummary.totalFilesCompared = diff.totalFilesCompared;
    report.diffSummary.changedFileCount = report.actualChangedNpcFiles.size();
    report.diffDetails.addAll(diff.details);

    report.finalStatus = (report.unexpectedChangedFiles.isEmpty() && report.unchangedExpectedFiles.isEmpty())
        ? "SAFE"
        : "UNSAFE";
    return report;
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

  private List<String> sorted(Set<String> values) {
    List<String> out = new ArrayList<String>(values);
    Collections.sort(out, String.CASE_INSENSITIVE_ORDER);
    return out;
  }

  private Map<String, Object> readJsonObject(Path path, String field) throws Exception {
    String json = new String(Files.readAllBytes(path), UTF8);
    return QuestSemanticJson.parseObject(json, field, 0);
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

  private void ensureParent(Path output) throws Exception {
    if(output.getParent() != null && !Files.exists(output.getParent())) {
      Files.createDirectories(output.getParent());
    }
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
    URLClassLoader loader = new URLClassLoader(new URL[] {url}, Phase6DbMutationAndImpactValidator.class.getClassLoader());
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

  private static final class MutationResult {
    final List<Integer> mutatedQuestIds = new ArrayList<Integer>();
  }

  private static final class DirectoryDiff {
    int totalFilesCompared;
    final List<String> changedFiles = new ArrayList<String>();
    final List<DiffDetail> details = new ArrayList<DiffDetail>();
  }

  private static final class DiffDetail {
    String file = "";
    String snippet = "";

    String toJson() {
      StringBuilder sb = new StringBuilder();
      sb.append("{")
          .append("\"file\":").append(QuestSemanticJson.jsonString(file)).append(',')
          .append("\"snippet\":").append(QuestSemanticJson.jsonString(snippet))
          .append("}");
      return sb.toString();
    }
  }

  private static final class DiffSummary {
    int totalFilesCompared;
    int changedFileCount;

    String toJson() {
      StringBuilder sb = new StringBuilder();
      sb.append("{")
          .append("\"totalFilesCompared\":").append(totalFilesCompared).append(',')
          .append("\"changedFileCount\":").append(changedFileCount)
          .append("}");
      return sb.toString();
    }
  }

  public static final class ValidationReport {
    String generatedAt = "";
    final List<Integer> mutatedQuestIds = new ArrayList<Integer>();
    final List<String> expectedAffectedNpcFiles = new ArrayList<String>();
    final List<String> actualChangedNpcFiles = new ArrayList<String>();
    final List<String> unexpectedChangedFiles = new ArrayList<String>();
    final List<String> unchangedExpectedFiles = new ArrayList<String>();
    final DiffSummary diffSummary = new DiffSummary();
    final List<DiffDetail> diffDetails = new ArrayList<DiffDetail>();
    String finalStatus = "UNSAFE";

    String toJson() {
      StringBuilder sb = new StringBuilder();
      sb.append("{\n");
      sb.append("  \"generatedAt\": ").append(QuestSemanticJson.jsonString(generatedAt)).append(",\n");
      sb.append("  \"mutatedQuestIds\": ").append(QuestSemanticJson.toJsonArrayInt(mutatedQuestIds)).append(",\n");
      sb.append("  \"expectedAffectedNpcFiles\": ").append(QuestSemanticJson.toJsonArrayString(expectedAffectedNpcFiles)).append(",\n");
      sb.append("  \"actualChangedNpcFiles\": ").append(QuestSemanticJson.toJsonArrayString(actualChangedNpcFiles)).append(",\n");
      sb.append("  \"unexpectedChangedFiles\": ").append(QuestSemanticJson.toJsonArrayString(unexpectedChangedFiles)).append(",\n");
      sb.append("  \"unchangedExpectedFiles\": ").append(QuestSemanticJson.toJsonArrayString(unchangedExpectedFiles)).append(",\n");
      sb.append("  \"diffSummary\": ").append(diffSummary.toJson()).append(",\n");

      sb.append("  \"diffDetails\": [");
      if(!diffDetails.isEmpty()) {
        sb.append("\n");
        for(int i = 0; i < diffDetails.size(); i++) {
          if(i > 0) {
            sb.append(",\n");
          }
          sb.append("    ").append(diffDetails.get(i).toJson());
        }
        sb.append("\n  ");
      }
      sb.append("],\n");

      sb.append("  \"finalStatus\": ").append(QuestSemanticJson.jsonString(finalStatus)).append("\n");
      sb.append("}\n");
      return sb.toString();
    }
  }
}

