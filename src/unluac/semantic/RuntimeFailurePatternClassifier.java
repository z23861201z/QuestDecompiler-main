package unluac.semantic;

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
import java.util.LinkedHashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class RuntimeFailurePatternClassifier {

  private static final Charset UTF8 = Charset.forName("UTF-8");

  private static final Pattern PATTERN_A = Pattern.compile(
      "qt\\s*\\[\\s*\\d+\\s*\\]\\s*\\.\\s*goal\\s*\\.\\s*getItem\\s*\\[\\s*\\d+\\s*\\](?!\\s*\\.)",
      Pattern.CASE_INSENSITIVE);
  private static final Pattern PATTERN_B = Pattern.compile(
      "qt\\s*\\[\\s*\\d+\\s*\\]\\s*\\.\\s*goal\\s*\\.\\s*getItem\\s*\\[\\s*\\d+\\s*\\]\\s*\\.\\s*(id|count)\\b",
      Pattern.CASE_INSENSITIVE);
  private static final Pattern PATTERN_C = Pattern.compile(
      "\\blocal\\s+\\w+\\s*=\\s*qt\\s*\\[\\s*\\d+\\s*\\]\\s*\\.\\s*goal\\s*\\.\\s*getItem\\b",
      Pattern.CASE_INSENSITIVE);
  private static final Pattern PATTERN_D = Pattern.compile(
      "\\bfor\\s+\\w+\\s*=\\s*\\d+\\s*,\\s*\\d+\\s*do\\b",
      Pattern.CASE_INSENSITIVE);
  private static final Pattern PATTERN_E = Pattern.compile(
      "qt\\s*\\[\\s*\\d+\\s*\\]\\s*\\.\\s*reward\\s*\\.\\s*getItem\\s*\\[\\s*\\d+\\s*\\]",
      Pattern.CASE_INSENSITIVE);
  private static final Pattern PATTERN_F = Pattern.compile(
      "qt\\s*\\[\\s*\\d+\\s*\\]\\s*\\.\\s*goal\\s*\\.\\s*killMonster\\s*\\[\\s*\\d+\\s*\\]",
      Pattern.CASE_INSENSITIVE);

  public static void main(String[] args) throws Exception {
    Path runtimeValidationPath = resolveDefaultRuntimeValidationPath(args.length >= 1 ? args[0] : null);
    Path dependencyIndexPath = args.length >= 2
        ? Paths.get(args[1])
        : Paths.get("reports", "auto_rewrite_dependency_index.json");
    Path npcDir = args.length >= 3
        ? Paths.get(args[2])
        : resolveDefaultNpcDir(dependencyIndexPath);
    Path outputPath = args.length >= 4
        ? Paths.get(args[3])
        : Paths.get("reports", "runtime_failure_pattern_classification.json");

    RuntimeFailurePatternClassifier classifier = new RuntimeFailurePatternClassifier();
    ClassificationReport report = classifier.classify(runtimeValidationPath, dependencyIndexPath, npcDir, outputPath);

    System.out.println("runtimeValidationPath=" + runtimeValidationPath.toAbsolutePath());
    System.out.println("dependencyIndexPath=" + dependencyIndexPath.toAbsolutePath());
    System.out.println("npcDir=" + npcDir.toAbsolutePath());
    System.out.println("outputPath=" + outputPath.toAbsolutePath());
    System.out.println("totalFailures=" + report.totalFailures);
    System.out.println("unclassifiedCount=" + report.unclassifiedCount);
  }

  public ClassificationReport classify(Path runtimeValidationPath,
                                       Path dependencyIndexPath,
                                       Path npcDir,
                                       Path outputPath) throws Exception {
    if(runtimeValidationPath == null || !Files.exists(runtimeValidationPath)) {
      throw new IllegalStateException("runtime validation json not found: " + runtimeValidationPath);
    }
    if(dependencyIndexPath == null || !Files.exists(dependencyIndexPath)) {
      throw new IllegalStateException("dependency index json not found: " + dependencyIndexPath);
    }
    if(npcDir == null || !Files.exists(npcDir) || !Files.isDirectory(npcDir)) {
      throw new IllegalStateException("npc directory not found: " + npcDir);
    }

    Map<String, Object> runtimeRoot = QuestSemanticJson.parseObject(
        new String(Files.readAllBytes(runtimeValidationPath), UTF8), "runtime_final_validation", 0);
    Map<String, Object> depRoot = QuestSemanticJson.parseObject(
        new String(Files.readAllBytes(dependencyIndexPath), UTF8), "dependency_index", 0);

    Map<String, List<AccessHit>> hardcodedByNpc = buildHardcodedAccessMap(depRoot);
    Map<String, List<String>> npcLineCache = new LinkedHashMap<String, List<String>>();

    ClassificationReport report = new ClassificationReport();
    report.generatedAt = OffsetDateTime.now().format(DateTimeFormatter.ISO_OFFSET_DATE_TIME);

    List<Map<String, Object>> failures = parseFailureDetails(runtimeRoot);
    for(Map<String, Object> failure : failures) {
      String rule = stringOf(failure.get("rule"));
      if(!"RULE_1_NO_HARDCODED_GOAL_INDEX".equals(rule)) {
        continue;
      }

      report.totalFailures++;
      String npcFile = normalizePath(stringOf(failure.get("entityId")));

      ClassifiedFailure item = new ClassifiedFailure();
      item.npcFile = npcFile;
      item.sourceRule = rule;

      List<AccessHit> hits = hardcodedByNpc.get(npcFile);
      if(hits == null) {
        hits = Collections.emptyList();
      }

      Map<String, Integer> patternCounter = new LinkedHashMap<String, Integer>();
      for(AccessHit hit : hits) {
        if(hit.questId > 0 && !item.questIds.contains(Integer.valueOf(hit.questId))) {
          item.questIds.add(Integer.valueOf(hit.questId));
        }

        String snippet = extractLineSnippet(npcDir, npcFile, hit.line, npcLineCache);
        String context = extractLineContext(npcDir, npcFile, hit.line, npcLineCache, 1);
        if(snippet != null && !snippet.isEmpty() && item.failureCodeSnippets.size() < 3
            && !item.failureCodeSnippets.contains(snippet)) {
          item.failureCodeSnippets.add(snippet);
        }

        String pattern = classifyPattern(context.isEmpty() ? snippet : context);
        increment(patternCounter, pattern);
      }

      if(item.questIds.isEmpty()) {
        item.questIds.add(Integer.valueOf(-1));
      }

      item.patternType = chooseDominantPattern(patternCounter);
      if(item.failureCodeSnippets.isEmpty()) {
        String msgSnippet = stringOf(failure.get("message"));
        if(!msgSnippet.isEmpty()) {
          item.failureCodeSnippets.add(msgSnippet);
        }
      }

      report.classifiedFailures.add(item);
      report.addPatternSample(item.patternType, item.npcFile, item.failureCodeSnippets.isEmpty() ? "" : item.failureCodeSnippets.get(0));
      if("G".equals(item.patternType)) {
        report.unclassifiedCount++;
      }
    }

    report.finalizePatterns();
    if(outputPath.getParent() != null && !Files.exists(outputPath.getParent())) {
      Files.createDirectories(outputPath.getParent());
    }
    Files.write(outputPath, report.toJson().getBytes(UTF8));
    return report;
  }

  @SuppressWarnings("unchecked")
  private List<Map<String, Object>> parseFailureDetails(Map<String, Object> runtimeRoot) {
    Object detailsObj = runtimeRoot.get("failureDetails");
    if(!(detailsObj instanceof List<?>)) {
      return Collections.emptyList();
    }
    List<Map<String, Object>> out = new ArrayList<Map<String, Object>>();
    for(Object item : (List<Object>) detailsObj) {
      if(item instanceof Map<?, ?>) {
        out.add((Map<String, Object>) item);
      }
    }
    return out;
  }

  @SuppressWarnings("unchecked")
  private Map<String, List<AccessHit>> buildHardcodedAccessMap(Map<String, Object> depRoot) {
    Map<String, List<AccessHit>> out = new LinkedHashMap<String, List<AccessHit>>();
    for(Map.Entry<String, Object> entry : depRoot.entrySet()) {
      String key = entry.getKey();
      if(key == null || key.startsWith("_")) {
        continue;
      }
      int questId = parseIntSafe(key);
      if(questId <= 0) {
        continue;
      }
      if(!(entry.getValue() instanceof Map<?, ?>)) {
        continue;
      }

      Map<String, Object> questObj = (Map<String, Object>) entry.getValue();
      Object npcFilesObj = questObj.get("npcFiles");
      if(!(npcFilesObj instanceof List<?>)) {
        continue;
      }

      for(Object npcObj : (List<Object>) npcFilesObj) {
        if(!(npcObj instanceof Map<?, ?>)) {
          continue;
        }
        Map<String, Object> npcMap = (Map<String, Object>) npcObj;
        String file = normalizePath(stringOf(npcMap.get("file")));
        if(file.isEmpty()) {
          continue;
        }

        Object accessObj = npcMap.get("access");
        if(!(accessObj instanceof List<?>)) {
          continue;
        }
        for(Object accessItem : (List<Object>) accessObj) {
          if(!(accessItem instanceof Map<?, ?>)) {
            continue;
          }
          Map<String, Object> access = (Map<String, Object>) accessItem;
          boolean hardcoded = boolOf(access.get("hardcodedIndex"));
          String type = stringOf(access.get("type"));
          if(!hardcoded) {
            continue;
          }
          if(!"goal.getItem".equals(type)) {
            continue;
          }
          AccessHit hit = new AccessHit();
          hit.questId = questId;
          hit.npcFile = file;
          hit.line = intOf(access.get("line"));
          hit.index = intOf(access.get("index"));
          List<AccessHit> bucket = out.get(file);
          if(bucket == null) {
            bucket = new ArrayList<AccessHit>();
            out.put(file, bucket);
          }
          bucket.add(hit);
        }
      }
    }

    for(List<AccessHit> hits : out.values()) {
      Collections.sort(hits, (a, b) -> {
        int c = Integer.compare(a.questId, b.questId);
        if(c != 0) {
          return c;
        }
        c = Integer.compare(a.line, b.line);
        if(c != 0) {
          return c;
        }
        return Integer.compare(a.index, b.index);
      });
    }
    return out;
  }

  private String extractLineSnippet(Path npcDir,
                                    String npcFile,
                                    int lineNumber,
                                    Map<String, List<String>> npcLineCache) {
    if(lineNumber <= 0) {
      return "";
    }
    List<String> lines = loadNpcLines(npcDir, npcFile, npcLineCache);
    if(lines.isEmpty() || lineNumber > lines.size()) {
      return "";
    }
    return lines.get(lineNumber - 1).trim();
  }

  private String extractLineContext(Path npcDir,
                                    String npcFile,
                                    int lineNumber,
                                    Map<String, List<String>> npcLineCache,
                                    int radius) {
    if(lineNumber <= 0) {
      return "";
    }
    List<String> lines = loadNpcLines(npcDir, npcFile, npcLineCache);
    if(lines.isEmpty()) {
      return "";
    }
    int start = Math.max(1, lineNumber - radius);
    int end = Math.min(lines.size(), lineNumber + radius);
    StringBuilder sb = new StringBuilder();
    for(int line = start; line <= end; line++) {
      String code = lines.get(line - 1).trim();
      if(code.isEmpty()) {
        continue;
      }
      if(sb.length() > 0) {
        sb.append(" || ");
      }
      sb.append(code);
    }
    return sb.toString();
  }

  private List<String> loadNpcLines(Path npcDir,
                                    String npcFile,
                                    Map<String, List<String>> npcLineCache) {
    String key = normalizePath(npcFile);
    List<String> cached = npcLineCache.get(key);
    if(cached != null) {
      return cached;
    }

    Path path = npcDir.resolve(key.replace('/', java.io.File.separatorChar));
    if(!Files.exists(path) || !Files.isRegularFile(path)) {
      npcLineCache.put(key, Collections.emptyList());
      return Collections.emptyList();
    }

    try {
      byte[] raw = Files.readAllBytes(path);
      String text = decodeText(raw);
      List<String> lines = splitLines(text);
      npcLineCache.put(key, lines);
      return lines;
    } catch(Exception ex) {
      npcLineCache.put(key, Collections.emptyList());
      return Collections.emptyList();
    }
  }

  private String classifyPattern(String text) {
    String code = text == null ? "" : text;
    if(code.isEmpty()) {
      return "G";
    }

    if(PATTERN_E.matcher(code).find()) {
      return "E";
    }
    if(PATTERN_F.matcher(code).find()) {
      return "F";
    }
    if(PATTERN_D.matcher(code).find() && code.toLowerCase(Locale.ROOT).contains("getitem")) {
      return "D";
    }
    if(PATTERN_C.matcher(code).find()) {
      return "C";
    }
    if(PATTERN_B.matcher(code).find()) {
      return "B";
    }
    if(PATTERN_A.matcher(code).find()) {
      return "A";
    }
    return "G";
  }

  private String chooseDominantPattern(Map<String, Integer> patternCounter) {
    if(patternCounter == null || patternCounter.isEmpty()) {
      return "G";
    }
    String[] priority = new String[] {"B", "A", "C", "D", "E", "F", "G"};
    String best = "G";
    int bestCount = -1;
    for(String p : priority) {
      Integer c = patternCounter.get(p);
      int count = c == null ? 0 : c.intValue();
      if(count > bestCount) {
        bestCount = count;
        best = p;
      }
    }
    return best;
  }

  private static Path resolveDefaultRuntimeValidationPath(String provided) {
    if(provided != null && !provided.trim().isEmpty()) {
      return Paths.get(provided.trim());
    }
    Path mounted = Paths.get("/mnt/data/runtime_final_validation.json");
    if(Files.exists(mounted)) {
      return mounted;
    }
    return Paths.get("reports", "runtime_final_validation.json");
  }

  @SuppressWarnings("unchecked")
  private static Path resolveDefaultNpcDir(Path dependencyIndexPath) {
    try {
      if(dependencyIndexPath != null && Files.exists(dependencyIndexPath)) {
        Map<String, Object> depRoot = QuestSemanticJson.parseObject(
            new String(Files.readAllBytes(dependencyIndexPath), UTF8), "dependency_index", 0);
        Object metaObj = depRoot.get("_meta");
        if(metaObj instanceof Map<?, ?>) {
          Map<String, Object> meta = (Map<String, Object>) metaObj;
          String sourceDir = stringOfStatic(meta.get("sourceDirectory"));
          if(!sourceDir.isEmpty()) {
            Path p = Paths.get(sourceDir);
            if(Files.exists(p) && Files.isDirectory(p)) {
              return p;
            }
          }
        }
      }
    } catch(Exception ignored) {
    }

    Path local = Paths.get("npc-lua-auto-rewritten");
    if(Files.exists(local) && Files.isDirectory(local)) {
      return local;
    }
    return Paths.get("D:\\TitanGames\\GhostOnline\\zChina\\Script\\npc-lua");
  }

  private String decodeText(byte[] raw) throws Exception {
    byte[] content = raw;
    if(raw.length >= 3 && (raw[0] & 0xFF) == 0xEF && (raw[1] & 0xFF) == 0xBB && (raw[2] & 0xFF) == 0xBF) {
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
        return chars.toString();
      } catch(CharacterCodingException ignored) {
      }
    }
    return new String(content, UTF8);
  }

  private List<String> splitLines(String text) {
    String normalized = text.replace("\r\n", "\n").replace('\r', '\n');
    String[] arr = normalized.split("\n", -1);
    List<String> out = new ArrayList<String>(arr.length);
    for(String line : arr) {
      out.add(line);
    }
    if(!out.isEmpty() && out.get(out.size() - 1).isEmpty()) {
      out.remove(out.size() - 1);
    }
    return out;
  }

  private void increment(Map<String, Integer> map, String key) {
    Integer count = map.get(key);
    map.put(key, Integer.valueOf(count == null ? 1 : count.intValue() + 1));
  }

  private int intOf(Object value) {
    if(value instanceof Number) {
      return ((Number) value).intValue();
    }
    if(value instanceof String) {
      return parseIntSafe((String) value);
    }
    return 0;
  }

  private static int parseIntSafe(String value) {
    if(value == null) {
      return -1;
    }
    try {
      return Integer.parseInt(value.trim());
    } catch(Exception ex) {
      return -1;
    }
  }

  private boolean boolOf(Object value) {
    if(value instanceof Boolean) {
      return ((Boolean) value).booleanValue();
    }
    if(value instanceof String) {
      return "true".equalsIgnoreCase(((String) value).trim());
    }
    return false;
  }

  private String stringOf(Object value) {
    return value == null ? "" : String.valueOf(value);
  }

  private static String stringOfStatic(Object value) {
    return value == null ? "" : String.valueOf(value);
  }

  private String normalizePath(String text) {
    if(text == null) {
      return "";
    }
    return text.replace('\\', '/').trim();
  }

  private static String escape(String text) {
    if(text == null) {
      return "";
    }
    return text
        .replace("\\", "\\\\")
        .replace("\"", "\\\"")
        .replace("\r", "\\r")
        .replace("\n", "\\n");
  }

  private static final class AccessHit {
    int questId;
    String npcFile;
    int line;
    int index;
  }

  private static final class ClassifiedFailure {
    String npcFile = "";
    String patternType = "G";
    String sourceRule = "";
    final List<Integer> questIds = new ArrayList<Integer>();
    final List<String> failureCodeSnippets = new ArrayList<String>();
  }

  public static final class ClassifiedFailureInput {
    public String npcFile = "";
    public String patternType = "G";
    public String sourceRule = "";
    public final List<Integer> questIds = new ArrayList<Integer>();
    public final List<String> failureCodeSnippets = new ArrayList<String>();
  }

  public static final class PatternTypeSummary {
    public String patternType = "";
    public int count;
    public final List<String> exampleFiles = new ArrayList<String>();
    public final List<String> exampleCodeSnippets = new ArrayList<String>();

    public String displayName() {
      if("A".equals(patternType)) {
        return "模式A：qt[x].goal.getItem[n] 直接硬编码";
      }
      if("B".equals(patternType)) {
        return "模式B：qt[x].goal.getItem[n].id/.count";
      }
      if("C".equals(patternType)) {
        return "模式C：变量中转(local g = qt[x].goal.getItem)";
      }
      if("D".equals(patternType)) {
        return "模式D：for循环硬编码范围";
      }
      if("E".equals(patternType)) {
        return "模式E：reward.getItem[n]";
      }
      if("F".equals(patternType)) {
        return "模式F：goal.killMonster[n]";
      }
      return "模式G：其它未识别结构";
    }
  }

  public static final class ClassificationReport {
    public String generatedAt = "";
    public int totalFailures;
    public int unclassifiedCount;
    public final List<PatternTypeSummary> patternTypes = new ArrayList<PatternTypeSummary>();
    public final List<ClassifiedFailure> classifiedFailures = new ArrayList<ClassifiedFailure>();

    private final Map<String, PatternTypeSummary> byPattern = new LinkedHashMap<String, PatternTypeSummary>();

    void addPatternSample(String patternType, String file, String snippet) {
      PatternTypeSummary summary = byPattern.get(patternType);
      if(summary == null) {
        summary = new PatternTypeSummary();
        summary.patternType = patternType;
        byPattern.put(patternType, summary);
      }
      summary.count++;
      if(file != null && !file.isEmpty() && summary.exampleFiles.size() < 5 && !summary.exampleFiles.contains(file)) {
        summary.exampleFiles.add(file);
      }
      if(snippet != null && !snippet.isEmpty() && summary.exampleCodeSnippets.size() < 5
          && !summary.exampleCodeSnippets.contains(snippet)) {
        summary.exampleCodeSnippets.add(snippet);
      }
    }

    void finalizePatterns() {
      String[] order = new String[] {"A", "B", "C", "D", "E", "F", "G"};
      for(String key : order) {
        PatternTypeSummary summary = byPattern.get(key);
        if(summary != null) {
          patternTypes.add(summary);
        }
      }
      for(Map.Entry<String, PatternTypeSummary> entry : byPattern.entrySet()) {
        String key = entry.getKey();
        if(!contains(order, key)) {
          patternTypes.add(entry.getValue());
        }
      }
      Collections.sort(classifiedFailures, (a, b) -> a.npcFile.compareToIgnoreCase(b.npcFile));
    }

    private boolean contains(String[] values, String target) {
      for(String value : values) {
        if(value.equals(target)) {
          return true;
        }
      }
      return false;
    }

    public String toJson() {
      StringBuilder sb = new StringBuilder();
      sb.append("{\n");
      sb.append("  \"generatedAt\": \"").append(escape(generatedAt)).append("\",\n");
      sb.append("  \"totalFailures\": ").append(totalFailures).append(",\n");
      sb.append("  \"patternTypes\": [");
      if(!patternTypes.isEmpty()) {
        sb.append("\n");
      }
      for(int i = 0; i < patternTypes.size(); i++) {
        if(i > 0) {
          sb.append(",\n");
        }
        PatternTypeSummary p = patternTypes.get(i);
        sb.append("    {\n");
        sb.append("      \"patternType\": \"").append(escape(p.displayName())).append("\",\n");
        sb.append("      \"count\": ").append(p.count).append(",\n");
        sb.append("      \"exampleFiles\": ").append(toJsonStringArray(p.exampleFiles)).append(",\n");
        sb.append("      \"exampleCodeSnippets\": ").append(toJsonStringArray(p.exampleCodeSnippets)).append("\n");
        sb.append("    }");
      }
      if(!patternTypes.isEmpty()) {
        sb.append("\n");
      }
      sb.append("  ],\n");
      sb.append("  \"unclassifiedCount\": ").append(unclassifiedCount).append(",\n");
      sb.append("  \"classifiedFailures\": [");
      if(!classifiedFailures.isEmpty()) {
        sb.append("\n");
      }
      for(int i = 0; i < classifiedFailures.size(); i++) {
        if(i > 0) {
          sb.append(",\n");
        }
        ClassifiedFailure item = classifiedFailures.get(i);
        sb.append("    {\n");
        sb.append("      \"npcFile\": \"").append(escape(item.npcFile)).append("\",\n");
        sb.append("      \"questIds\": ").append(toJsonIntArray(item.questIds)).append(",\n");
        sb.append("      \"patternType\": \"").append(escape(item.patternType)).append("\",\n");
        sb.append("      \"sourceRule\": \"").append(escape(item.sourceRule)).append("\",\n");
        sb.append("      \"failureCodeSnippets\": ").append(toJsonStringArray(item.failureCodeSnippets)).append("\n");
        sb.append("    }");
      }
      if(!classifiedFailures.isEmpty()) {
        sb.append("\n");
      }
      sb.append("  ]\n");
      sb.append("}\n");
      return sb.toString();
    }

    private String toJsonIntArray(List<Integer> values) {
      StringBuilder sb = new StringBuilder();
      sb.append('[');
      for(int i = 0; i < values.size(); i++) {
        if(i > 0) {
          sb.append(", ");
        }
        sb.append(values.get(i).intValue());
      }
      sb.append(']');
      return sb.toString();
    }

    private String toJsonStringArray(List<String> values) {
      StringBuilder sb = new StringBuilder();
      sb.append('[');
      for(int i = 0; i < values.size(); i++) {
        if(i > 0) {
          sb.append(", ");
        }
        sb.append('"').append(escape(values.get(i))).append('"');
      }
      sb.append(']');
      return sb.toString();
    }
  }
}
