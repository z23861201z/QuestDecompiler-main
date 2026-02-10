package unluac.semantic;

import java.nio.charset.Charset;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.OffsetDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

public class RuntimeAutoFixDispatcher {

  private static final Charset UTF8 = Charset.forName("UTF-8");

  public static void main(String[] args) throws Exception {
    if(args.length < 4) {
      printUsage();
      return;
    }

    Path classificationJsonPath = Paths.get(args[0]);
    Path npcSourceDir = Paths.get(args[1]);
    Path npcOutputDir = Paths.get(args[2]);
    Path fixReportOutput = Paths.get(args[3]);

    RuntimeAutoFixDispatcher dispatcher = new RuntimeAutoFixDispatcher();
    DispatchReport report = dispatcher.dispatch(classificationJsonPath, npcSourceDir, npcOutputDir, fixReportOutput);

    System.out.println("classification_json=" + classificationJsonPath.toAbsolutePath());
    System.out.println("npc_source_dir=" + npcSourceDir.toAbsolutePath());
    System.out.println("npc_output_dir=" + npcOutputDir.toAbsolutePath());
    System.out.println("fix_report_output=" + fixReportOutput.toAbsolutePath());
    System.out.println("fixedCount=" + report.fixedCount);
    System.out.println("skippedCount=" + report.skippedCount);
    System.out.println("rewrittenLineCount=" + report.rewrittenLineCount);
    System.out.println("errors=" + report.errors.size());
  }

  public DispatchReport dispatch(Path classificationJsonPath,
                                 Path npcSourceDir,
                                 Path npcOutputDir,
                                 Path fixReportOutput) throws Exception {
    if(classificationJsonPath == null || !Files.exists(classificationJsonPath)) {
      throw new IllegalStateException("classification json not found: " + classificationJsonPath);
    }
    if(npcSourceDir == null || !Files.exists(npcSourceDir) || !Files.isDirectory(npcSourceDir)) {
      throw new IllegalStateException("npc source dir not found: " + npcSourceDir);
    }

    if(!Files.exists(npcOutputDir)) {
      Files.createDirectories(npcOutputDir);
    }

    Map<String, Object> root = QuestSemanticJson.parseObject(
        new String(Files.readAllBytes(classificationJsonPath), UTF8), "runtime_failure_pattern_classification", 0);

    List<RuntimeFailurePatternClassifier.ClassifiedFailureInput> failures = parseClassifiedFailures(root);
    Map<String, List<RuntimeFailurePatternClassifier.ClassifiedFailureInput>> byPattern = groupByPattern(failures);

    DispatchReport report = new DispatchReport();
    report.generatedAt = OffsetDateTime.now().format(DateTimeFormatter.ISO_OFFSET_DATE_TIME);
    report.classificationJsonPath = classificationJsonPath.toAbsolutePath().toString();
    report.npcSourceDir = npcSourceDir.toAbsolutePath().toString();
    report.npcOutputDir = npcOutputDir.toAbsolutePath().toString();
    report.totalClassifiedFailures = failures.size();

    copyNpcDirectory(npcSourceDir, npcOutputDir);

    PatternBFixer bFixer = new PatternBFixer();
    PatternFFixer fFixer = new PatternFFixer();

    List<RuntimeFailurePatternClassifier.ClassifiedFailureInput> bTargets = byPattern.get("B");
    if(bTargets == null) {
      bTargets = Collections.emptyList();
    }
    List<RuntimeFailurePatternClassifier.ClassifiedFailureInput> fTargets = byPattern.get("F");
    if(fTargets == null) {
      fTargets = Collections.emptyList();
    }

    FixerResult bResult = bFixer.fix(npcOutputDir, npcOutputDir, bTargets);
    FixerResult fResult = fFixer.fix(npcOutputDir, npcOutputDir, fTargets);

    report.fixerResults.add(bResult);
    report.fixerResults.add(fResult);

    for(Map.Entry<String, List<RuntimeFailurePatternClassifier.ClassifiedFailureInput>> entry : byPattern.entrySet()) {
      String pattern = entry.getKey();
      if("B".equals(pattern) || "F".equals(pattern)) {
        continue;
      }
      FixerResult skipped = new FixerResult();
      skipped.patternType = pattern;
      skipped.targetedCount = entry.getValue().size();
      skipped.fixedCount = 0;
      skipped.skippedCount = entry.getValue().size();
      for(RuntimeFailurePatternClassifier.ClassifiedFailureInput input : entry.getValue()) {
        skipped.skippedFiles.add(input.npcFile);
      }
      skipped.errors.add("no fixer registered for patternType=" + pattern);
      report.fixerResults.add(skipped);
    }

    aggregateStats(report);

    if(fixReportOutput.getParent() != null && !Files.exists(fixReportOutput.getParent())) {
      Files.createDirectories(fixReportOutput.getParent());
    }
    Files.write(fixReportOutput, report.toJson().getBytes(UTF8));
    return report;
  }

  @SuppressWarnings("unchecked")
  private List<RuntimeFailurePatternClassifier.ClassifiedFailureInput> parseClassifiedFailures(Map<String, Object> root) {
    Object arr = root.get("classifiedFailures");
    if(!(arr instanceof List<?>)) {
      return Collections.emptyList();
    }
    List<RuntimeFailurePatternClassifier.ClassifiedFailureInput> out = new ArrayList<RuntimeFailurePatternClassifier.ClassifiedFailureInput>();
    for(Object item : (List<Object>) arr) {
      if(!(item instanceof Map<?, ?>)) {
        continue;
      }
      Map<String, Object> map = (Map<String, Object>) item;
      RuntimeFailurePatternClassifier.ClassifiedFailureInput row = new RuntimeFailurePatternClassifier.ClassifiedFailureInput();
      row.npcFile = normalizePath(stringOf(map.get("npcFile")));
      row.patternType = normalizePattern(stringOf(map.get("patternType")));
      row.sourceRule = stringOf(map.get("sourceRule"));
      row.questIds.addAll(parseIntList(map.get("questIds")));
      row.failureCodeSnippets.addAll(parseStringList(map.get("failureCodeSnippets")));
      if(!row.npcFile.isEmpty()) {
        out.add(row);
      }
    }
    return out;
  }

  private Map<String, List<RuntimeFailurePatternClassifier.ClassifiedFailureInput>> groupByPattern(
      List<RuntimeFailurePatternClassifier.ClassifiedFailureInput> rows) {
    Map<String, List<RuntimeFailurePatternClassifier.ClassifiedFailureInput>> out =
        new LinkedHashMap<String, List<RuntimeFailurePatternClassifier.ClassifiedFailureInput>>();
    for(RuntimeFailurePatternClassifier.ClassifiedFailureInput row : rows) {
      String pattern = normalizePattern(row.patternType);
      List<RuntimeFailurePatternClassifier.ClassifiedFailureInput> bucket = out.get(pattern);
      if(bucket == null) {
        bucket = new ArrayList<RuntimeFailurePatternClassifier.ClassifiedFailureInput>();
        out.put(pattern, bucket);
      }
      bucket.add(row);
    }
    return out;
  }

  private void copyNpcDirectory(Path source, Path target) throws Exception {
    Files.walk(source).forEach(path -> {
      try {
        Path rel = source.relativize(path);
        Path out = target.resolve(rel);
        if(Files.isDirectory(path)) {
          if(!Files.exists(out)) {
            Files.createDirectories(out);
          }
          return;
        }
        if(Files.isRegularFile(path)) {
          if(out.getParent() != null && !Files.exists(out.getParent())) {
            Files.createDirectories(out.getParent());
          }
          Files.copy(path, out, java.nio.file.StandardCopyOption.REPLACE_EXISTING);
        }
      } catch(Exception ex) {
        throw new RuntimeException(ex);
      }
    });
  }

  private void aggregateStats(DispatchReport report) {
    for(FixerResult r : report.fixerResults) {
      report.fixedCount += r.fixedCount;
      report.skippedCount += r.skippedCount;
      report.rewrittenLineCount += r.rewrittenLineCount;
      report.errors.addAll(r.errors);
      report.patternCounts.put(r.patternType, Integer.valueOf(r.targetedCount));
    }
    Collections.sort(report.errors, String.CASE_INSENSITIVE_ORDER);
  }

  private String normalizePattern(String patternType) {
    if(patternType == null) {
      return "G";
    }
    String t = patternType.trim().toUpperCase(Locale.ROOT);
    if(t.length() > 1) {
      char c = t.charAt(0);
      if(c >= 'A' && c <= 'G') {
        return String.valueOf(c);
      }
    }
    if(t.length() == 1 && t.charAt(0) >= 'A' && t.charAt(0) <= 'G') {
      return t;
    }
    return "G";
  }

  private String normalizePath(String path) {
    if(path == null) {
      return "";
    }
    return path.replace('\\', '/').trim();
  }

  @SuppressWarnings("unchecked")
  private List<String> parseStringList(Object value) {
    if(!(value instanceof List<?>)) {
      return Collections.emptyList();
    }
    List<String> out = new ArrayList<String>();
    for(Object item : (List<Object>) value) {
      String s = stringOf(item);
      if(!s.isEmpty()) {
        out.add(s);
      }
    }
    return out;
  }

  @SuppressWarnings("unchecked")
  private List<Integer> parseIntList(Object value) {
    if(!(value instanceof List<?>)) {
      return Collections.emptyList();
    }
    List<Integer> out = new ArrayList<Integer>();
    for(Object item : (List<Object>) value) {
      if(item instanceof Number) {
        out.add(Integer.valueOf(((Number) item).intValue()));
      } else {
        try {
          out.add(Integer.valueOf(Integer.parseInt(stringOf(item).trim())));
        } catch(Exception ignored) {
        }
      }
    }
    return out;
  }

  private String stringOf(Object value) {
    return value == null ? "" : String.valueOf(value);
  }

  private static void printUsage() {
    System.out.println("Usage:");
    System.out.println("  java -cp build unluac.semantic.RuntimeAutoFixDispatcher <classification_json_path> <npc_source_dir> <npc_output_dir> <fix_report_output.json>");
  }

  public static final class DispatchReport {
    public String generatedAt = "";
    public String classificationJsonPath = "";
    public String npcSourceDir = "";
    public String npcOutputDir = "";
    public int totalClassifiedFailures;
    public int fixedCount;
    public int skippedCount;
    public int rewrittenLineCount;
    public final Map<String, Integer> patternCounts = new LinkedHashMap<String, Integer>();
    public final List<String> errors = new ArrayList<String>();
    public final List<FixerResult> fixerResults = new ArrayList<FixerResult>();

    public String toJson() {
      StringBuilder sb = new StringBuilder();
      sb.append("{\n");
      sb.append("  \"generatedAt\": \"").append(escape(generatedAt)).append("\",\n");
      sb.append("  \"classificationJsonPath\": \"").append(escape(classificationJsonPath)).append("\",\n");
      sb.append("  \"npcSourceDir\": \"").append(escape(npcSourceDir)).append("\",\n");
      sb.append("  \"npcOutputDir\": \"").append(escape(npcOutputDir)).append("\",\n");
      sb.append("  \"totalClassifiedFailures\": ").append(totalClassifiedFailures).append(",\n");
      sb.append("  \"fixedCount\": ").append(fixedCount).append(",\n");
      sb.append("  \"skippedCount\": ").append(skippedCount).append(",\n");
      sb.append("  \"rewrittenLineCount\": ").append(rewrittenLineCount).append(",\n");
      sb.append("  \"patternCounts\": ").append(toJsonObject(patternCounts)).append(",\n");
      sb.append("  \"errors\": ").append(toJsonStringArray(errors)).append(",\n");
      sb.append("  \"fixers\": [");
      if(!fixerResults.isEmpty()) {
        sb.append("\n");
      }
      for(int i = 0; i < fixerResults.size(); i++) {
        if(i > 0) {
          sb.append(",\n");
        }
        sb.append(fixerResults.get(i).toJson("    "));
      }
      if(!fixerResults.isEmpty()) {
        sb.append("\n");
      }
      sb.append("  ]\n");
      sb.append("}\n");
      return sb.toString();
    }

    private String toJsonObject(Map<String, Integer> map) {
      StringBuilder sb = new StringBuilder();
      sb.append('{');
      int i = 0;
      for(Map.Entry<String, Integer> e : map.entrySet()) {
        if(i > 0) {
          sb.append(", ");
        }
        sb.append('"').append(escape(e.getKey())).append('"').append(": ").append(e.getValue().intValue());
        i++;
      }
      sb.append('}');
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

    private String escape(String text) {
      if(text == null) {
        return "";
      }
      return text
          .replace("\\", "\\\\")
          .replace("\"", "\\\"")
          .replace("\r", "\\r")
          .replace("\n", "\\n");
    }
  }
}

