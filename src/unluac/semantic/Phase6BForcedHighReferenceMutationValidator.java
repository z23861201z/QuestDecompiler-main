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
import java.util.LinkedHashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.HashSet;
import java.util.Set;

public class Phase6BForcedHighReferenceMutationValidator {

  private static final Charset UTF8 = Charset.forName("UTF-8");
  private static final String DEFAULT_JDBC = "jdbc:mysql://127.0.0.1:3306/ghost_game"
      + "?useUnicode=true&characterEncoding=utf8&serverTimezone=UTC&useSSL=false&allowPublicKeyRetrieval=true";
  private static final String DEFAULT_USER = "root";
  private static final String DEFAULT_PASSWORD = "root";
  private static final String FORCE_TOKEN = "[FORCE_TEST]";

  public static void main(String[] args) throws Exception {
    Path graphPath = args.length >= 1
        ? Paths.get(args[0])
        : Paths.get("reports", "phase2_5_quest_npc_dependency_graph.json");
    Path baselineDir = args.length >= 2
        ? Paths.get(args[1])
        : Paths.get("reports", "phase5_exported_npc");
    Path afterDir = args.length >= 3
        ? Paths.get(args[2])
        : Paths.get("reports", "phase6B_export_after_mutation");
    Path reportPath = args.length >= 4
        ? Paths.get(args[3])
        : Paths.get("reports", "phase6B_mutation_validation.json");

    long start = System.nanoTime();
    Phase6BForcedHighReferenceMutationValidator runner = new Phase6BForcedHighReferenceMutationValidator();
    ValidationReport report = runner.run(graphPath, baselineDir, afterDir, reportPath);
    long elapsed = (System.nanoTime() - start) / 1_000_000L;

    for(Integer questId : report.mutatedQuestIds) {
      Integer ref = report.questReferenceCount.get(Integer.toString(questId.intValue()));
      System.out.println("questId=" + questId + " referenceCount=" + (ref == null ? 0 : ref.intValue()));
    }
    System.out.println("expectedAffectedNpcFiles=" + QuestSemanticJson.toJsonArrayString(report.expectedAffectedNpcFiles));
    System.out.println("actualChangedNpcFiles=" + QuestSemanticJson.toJsonArrayString(report.actualChangedNpcFiles));
    System.out.println("finalStatus=" + report.finalStatus);
    System.out.println("phase6BMillis=" + elapsed);

    if(!"SAFE".equals(report.finalStatus)) {
      System.out.println("=== Phase6B Diff Details ===");
      for(DiffSnippet s : report.diffSnippets) {
        System.out.println("file=" + s.file);
        System.out.println(s.snippet);
      }
      throw new IllegalStateException("Phase6-B finalStatus is UNSAFE");
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

    GraphIndex graph = loadGraph(graphPath);
    List<Integer> chosen = chooseMutatedQuestIds(graph);
    if(chosen.isEmpty()) {
      throw new IllegalStateException("No high-reference quests selected for mutation");
    }

    for(Integer questId : chosen) {
      int count = graph.questReferenceCount.getOrDefault(Integer.valueOf(questId.intValue()), Integer.valueOf(0)).intValue();
      if(count <= 0) {
        throw new IllegalStateException("Selected quest has zero referenceCount: questId=" + questId);
      }
    }

    mutateDatabase(chosen);

    Phase5NpcLucExporter exporter = new Phase5NpcLucExporter();
    exporter.export(
        Paths.get("reports", "phase2_npc_reference_index.json"),
        afterDir,
        Paths.get("reports", "phase6B_export_summary.json"),
        DEFAULT_JDBC,
        DEFAULT_USER,
        DEFAULT_PASSWORD);

    DirectoryDiff diff = compareDirectories(baselineDir, afterDir);
    ValidationReport report = buildReport(chosen, graph, diff);

    ensureParent(reportPath);
    Files.write(reportPath, report.toJson().getBytes(UTF8));
    return report;
  }

  private GraphIndex loadGraph(Path graphPath) throws Exception {
    GraphIndex out = new GraphIndex();
    Map<String, Object> root = readJsonObject(graphPath, "phase2_5_quest_npc_dependency_graph");
    Object edgesObj = root.get("edges");
    if(!(edgesObj instanceof List<?>)) {
      throw new IllegalStateException("graph.edges missing or invalid");
    }

    @SuppressWarnings("unchecked")
    List<Object> edges = (List<Object>) edgesObj;
    for(Object edgeObj : edges) {
      if(!(edgeObj instanceof Map<?, ?>)) {
        continue;
      }
      @SuppressWarnings("unchecked")
      Map<String, Object> edge = (Map<String, Object>) edgeObj;

      int questId = parseQuestId(edge.get("to"));
      String npcFile = normalizePath(safe(edge.get("from")));
      if(questId <= 0 || npcFile.isEmpty()) {
        continue;
      }

      out.questReferenceCount.put(
          Integer.valueOf(questId),
          Integer.valueOf(out.questReferenceCount.getOrDefault(Integer.valueOf(questId), Integer.valueOf(0)).intValue() + 1));

      Set<String> files = out.questToNpcFiles.get(Integer.valueOf(questId));
      if(files == null) {
        files = new LinkedHashSet<String>();
        out.questToNpcFiles.put(Integer.valueOf(questId), files);
      }
      files.add(npcFile);
    }

    return out;
  }

  private List<Integer> chooseMutatedQuestIds(GraphIndex graph) {
    List<Integer> quests = new ArrayList<Integer>(graph.questReferenceCount.keySet());
    quests.sort((left, right) -> {
      int lc = graph.questReferenceCount.get(left).intValue();
      int rc = graph.questReferenceCount.get(right).intValue();
      int cmp = Integer.compare(rc, lc);
      if(cmp != 0) {
        return cmp;
      }
      return Integer.compare(left.intValue(), right.intValue());
    });

    List<Integer> top3 = new ArrayList<Integer>();
    for(Integer questId : quests) {
      int c = graph.questReferenceCount.get(questId).intValue();
      if(c <= 0) {
        continue;
      }
      top3.add(Integer.valueOf(questId.intValue()));
      if(top3.size() >= 3) {
        break;
      }
    }

    int mutateCount = Math.min(top3.size(), 2);
    List<Integer> selected = new ArrayList<Integer>();
    for(int i = 0; i < mutateCount; i++) {
      selected.add(top3.get(i));
    }
    return selected;
  }

  private void mutateDatabase(List<Integer> questIds) throws Exception {
    try(Connection connection = DriverManager.getConnection(DEFAULT_JDBC, DEFAULT_USER, DEFAULT_PASSWORD)) {
      connection.setAutoCommit(false);
      try {
        String updateName = "UPDATE quest_main SET name = CONCAT(COALESCE(name,''), ?) WHERE quest_id = ?";
        String updateReward = "UPDATE quest_reward_item SET item_count = item_count + 2 WHERE quest_id = ? ORDER BY seq_index ASC LIMIT 1";
        String insertReward = "INSERT INTO quest_reward_item(quest_id, seq_index, item_id, item_count) VALUES(?,?,?,?)";
        String updateContent = "UPDATE quest_contents SET text = CONCAT(COALESCE(text,''), ?) WHERE quest_id = ? AND seq_index = 0";

        try(PreparedStatement psName = connection.prepareStatement(updateName);
            PreparedStatement psReward = connection.prepareStatement(updateReward);
            PreparedStatement psInsertReward = connection.prepareStatement(insertReward);
            PreparedStatement psContent = connection.prepareStatement(updateContent)) {

          for(Integer questId : questIds) {
            psName.setString(1, FORCE_TOKEN);
            psName.setInt(2, questId.intValue());
            int nameRows = psName.executeUpdate();

            psReward.setInt(1, questId.intValue());
            int rewardRows = psReward.executeUpdate();
            if(rewardRows <= 0) {
              int nextIndex = queryNextRewardSeqIndex(connection, questId.intValue());
              psInsertReward.setInt(1, questId.intValue());
              psInsertReward.setInt(2, nextIndex);
              psInsertReward.setInt(3, 0);
              psInsertReward.setInt(4, 2);
              rewardRows = psInsertReward.executeUpdate();
            }

            psContent.setString(1, FORCE_TOKEN);
            psContent.setInt(2, questId.intValue());
            int contentRows = psContent.executeUpdate();

            if(nameRows <= 0 || rewardRows <= 0 || contentRows <= 0) {
              throw new IllegalStateException("Mutation failed for questId=" + questId
                  + " nameRows=" + nameRows
                  + " rewardRows=" + rewardRows
                  + " contentRows=" + contentRows);
            }
          }
        }

        connection.commit();
      } catch(Exception ex) {
        connection.rollback();
        throw ex;
      }
    }
  }

  private DirectoryDiff compareDirectories(Path baselineDir,
                                           Path afterDir) throws Exception {
    DirectoryDiff out = new DirectoryDiff();
    List<String> baselineFiles = collectNpcFiles(baselineDir);
    List<String> afterFiles = collectNpcFiles(afterDir);
    out.totalFilesCompared = baselineFiles.size();

    Set<String> afterSet = new HashSet<String>(afterFiles);
    for(String rel : baselineFiles) {
      Path before = baselineDir.resolve(rel);
      Path after = afterDir.resolve(rel);
      if(!Files.exists(after)) {
        out.changedFiles.add(rel);
        out.snippets.add(missingSnippet(rel, true));
        continue;
      }

      byte[] left = Files.readAllBytes(before);
      byte[] right = Files.readAllBytes(after);
      if(!sameBytes(left, right)) {
        out.changedFiles.add(rel);
        out.snippets.add(buildSnippet(rel, new String(left, UTF8), new String(right, UTF8)));
      }
      afterSet.remove(rel);
    }

    if(!afterSet.isEmpty()) {
      List<String> extra = new ArrayList<String>(afterSet);
      Collections.sort(extra, String.CASE_INSENSITIVE_ORDER);
      for(String rel : extra) {
        out.changedFiles.add(rel);
        out.snippets.add(missingSnippet(rel, false));
      }
    }

    Collections.sort(out.changedFiles, String.CASE_INSENSITIVE_ORDER);
    return out;
  }

  private int queryNextRewardSeqIndex(Connection connection, int questId) throws Exception {
    String sql = "SELECT COALESCE(MAX(seq_index), -1) + 1 FROM quest_reward_item WHERE quest_id = ?";
    try(PreparedStatement ps = connection.prepareStatement(sql)) {
      ps.setInt(1, questId);
      try(ResultSet rs = ps.executeQuery()) {
        if(rs.next()) {
          return rs.getInt(1);
        }
      }
    }
    return 0;
  }

  private DiffSnippet missingSnippet(String file, boolean missingAfter) {
    DiffSnippet s = new DiffSnippet();
    s.file = file;
    s.snippet = missingAfter
        ? "--- " + file + " (baseline)\n+++ " + file + " (after)\n<missing in after directory>"
        : "--- " + file + " (baseline)\n+++ " + file + " (after)\n<extra in after directory>";
    return s;
  }

  private DiffSnippet buildSnippet(String file, String before, String after) {
    String[] left = before.split("\\r?\\n", -1);
    String[] right = after.split("\\r?\\n", -1);

    int min = Math.min(left.length, right.length);
    int firstDiff = -1;
    for(int i = 0; i < min; i++) {
      if(!left[i].equals(right[i])) {
        firstDiff = i;
        break;
      }
    }
    if(firstDiff < 0 && left.length != right.length) {
      firstDiff = min;
    }
    if(firstDiff < 0) {
      firstDiff = 0;
    }

    int start = Math.max(0, firstDiff - 20);
    int endL = Math.min(left.length - 1, firstDiff + 20);
    int endR = Math.min(right.length - 1, firstDiff + 20);

    StringBuilder sb = new StringBuilder();
    sb.append("--- ").append(file).append(" (baseline)\n");
    sb.append("+++ ").append(file).append(" (after)\n");
    sb.append("@@ around line ").append(firstDiff + 1).append(" @@\n");
    for(int i = start; i <= endL; i++) {
      sb.append("-").append(i + 1).append(": ").append(left[i]).append("\n");
    }
    for(int i = start; i <= endR; i++) {
      sb.append("+").append(i + 1).append(": ").append(right[i]).append("\n");
    }

    DiffSnippet snippet = new DiffSnippet();
    snippet.file = file;
    snippet.snippet = sb.toString();
    return snippet;
  }

  private boolean sameBytes(byte[] left, byte[] right) {
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

  private ValidationReport buildReport(List<Integer> mutatedQuestIds,
                                       GraphIndex graph,
                                       DirectoryDiff diff) {
    ValidationReport report = new ValidationReport();
    report.generatedAt = OffsetDateTime.now().format(DateTimeFormatter.ISO_OFFSET_DATE_TIME);
    report.mutatedQuestIds.addAll(mutatedQuestIds);

    Set<String> expected = new LinkedHashSet<String>();
    for(Integer q : mutatedQuestIds) {
      int c = graph.questReferenceCount.getOrDefault(Integer.valueOf(q.intValue()), Integer.valueOf(0)).intValue();
      report.questReferenceCount.put(Integer.toString(q.intValue()), Integer.valueOf(c));
      Set<String> files = graph.questToNpcFiles.get(Integer.valueOf(q.intValue()));
      if(files != null) {
        expected.addAll(files);
      }
    }

    report.expectedAffectedNpcFiles.addAll(sort(expected));

    Set<String> actual = new LinkedHashSet<String>(diff.changedFiles);
    report.actualChangedNpcFiles.addAll(sort(actual));

    Set<String> unexpected = new LinkedHashSet<String>(actual);
    unexpected.removeAll(expected);
    report.unexpectedChangedFiles.addAll(sort(unexpected));

    Set<String> unchangedExpected = new LinkedHashSet<String>(expected);
    unchangedExpected.removeAll(actual);
    report.unchangedExpectedFiles.addAll(sort(unchangedExpected));

    report.diffSummary.totalFilesCompared = diff.totalFilesCompared;
    report.diffSummary.changedFileCount = actual.size();
    report.diffSnippets.addAll(diff.snippets);

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

  private List<String> sort(Set<String> in) {
    List<String> out = new ArrayList<String>(in);
    Collections.sort(out, String.CASE_INSENSITIVE_ORDER);
    return out;
  }

  private Map<String, Object> readJsonObject(Path path, String field) throws Exception {
    String json = new String(Files.readAllBytes(path), UTF8);
    return QuestSemanticJson.parseObject(json, field, 0);
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

  private String normalizePath(String path) {
    if(path == null) {
      return "";
    }
    return path.replace('\\', '/').trim();
  }

  private String safe(Object value) {
    return value == null ? "" : String.valueOf(value);
  }

  private void ensureParent(Path file) throws Exception {
    if(file.getParent() != null && !Files.exists(file.getParent())) {
      Files.createDirectories(file.getParent());
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
    URLClassLoader loader = new URLClassLoader(new URL[] {url}, Phase6BForcedHighReferenceMutationValidator.class.getClassLoader());
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

  private static final class GraphIndex {
    final Map<Integer, Integer> questReferenceCount = new LinkedHashMap<Integer, Integer>();
    final Map<Integer, Set<String>> questToNpcFiles = new LinkedHashMap<Integer, Set<String>>();
  }

  private static final class DirectoryDiff {
    int totalFilesCompared;
    final List<String> changedFiles = new ArrayList<String>();
    final List<DiffSnippet> snippets = new ArrayList<DiffSnippet>();
  }

  private static final class DiffSnippet {
    String file = "";
    String snippet = "";

    String toJson() {
      return "{"
          + "\"file\":" + QuestSemanticJson.jsonString(file)
          + ",\"snippet\":" + QuestSemanticJson.jsonString(snippet)
          + "}";
    }
  }

  private static final class DiffSummary {
    int totalFilesCompared;
    int changedFileCount;

    String toJson() {
      return "{"
          + "\"totalFilesCompared\":" + totalFilesCompared
          + ",\"changedFileCount\":" + changedFileCount
          + "}";
    }
  }

  public static final class ValidationReport {
    String generatedAt = "";
    final List<Integer> mutatedQuestIds = new ArrayList<Integer>();
    final Map<String, Integer> questReferenceCount = new LinkedHashMap<String, Integer>();
    final List<String> expectedAffectedNpcFiles = new ArrayList<String>();
    final List<String> actualChangedNpcFiles = new ArrayList<String>();
    final List<String> unexpectedChangedFiles = new ArrayList<String>();
    final List<String> unchangedExpectedFiles = new ArrayList<String>();
    final DiffSummary diffSummary = new DiffSummary();
    final List<DiffSnippet> diffSnippets = new ArrayList<DiffSnippet>();
    String finalStatus = "UNSAFE";

    String toJson() {
      StringBuilder sb = new StringBuilder();
      sb.append("{\n");
      sb.append("  \"generatedAt\": ").append(QuestSemanticJson.jsonString(generatedAt)).append(",\n");
      sb.append("  \"mutatedQuestIds\": ").append(QuestSemanticJson.toJsonArrayInt(mutatedQuestIds)).append(",\n");
      sb.append("  \"questReferenceCount\": ").append(toJsonObjectIntMap(questReferenceCount)).append(",\n");
      sb.append("  \"expectedAffectedNpcFiles\": ").append(QuestSemanticJson.toJsonArrayString(expectedAffectedNpcFiles)).append(",\n");
      sb.append("  \"actualChangedNpcFiles\": ").append(QuestSemanticJson.toJsonArrayString(actualChangedNpcFiles)).append(",\n");
      sb.append("  \"unexpectedChangedFiles\": ").append(QuestSemanticJson.toJsonArrayString(unexpectedChangedFiles)).append(",\n");
      sb.append("  \"unchangedExpectedFiles\": ").append(QuestSemanticJson.toJsonArrayString(unchangedExpectedFiles)).append(",\n");
      sb.append("  \"diffSummary\": ").append(diffSummary.toJson()).append(",\n");

      sb.append("  \"diffSnippets\": [");
      if(!diffSnippets.isEmpty()) {
        sb.append("\n");
        for(int i = 0; i < diffSnippets.size(); i++) {
          if(i > 0) {
            sb.append(",\n");
          }
          sb.append("    ").append(diffSnippets.get(i).toJson());
        }
        sb.append("\n  ");
      }
      sb.append("],\n");

      sb.append("  \"finalStatus\": ").append(QuestSemanticJson.jsonString(finalStatus)).append("\n");
      sb.append("}\n");
      return sb.toString();
    }

    private String toJsonObjectIntMap(Map<String, Integer> map) {
      if(map.isEmpty()) {
        return "{}";
      }
      List<String> keys = new ArrayList<String>(map.keySet());
      Collections.sort(keys, String.CASE_INSENSITIVE_ORDER);
      StringBuilder sb = new StringBuilder();
      sb.append('{');
      for(int i = 0; i < keys.size(); i++) {
        if(i > 0) {
          sb.append(',');
        }
        String key = keys.get(i);
        sb.append(QuestSemanticJson.jsonString(key)).append(':').append(map.get(key).intValue());
      }
      sb.append('}');
      return sb.toString();
    }
  }
}
