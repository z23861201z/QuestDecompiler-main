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
import java.nio.file.StandardCopyOption;
import java.time.OffsetDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class PatternFFixer {

  private static final Charset UTF8 = Charset.forName("UTF-8");

  private static final Pattern KILL_MONSTER_PAIR = Pattern.compile(
      "qData\\s*\\[\\s*(\\d+)\\s*\\]\\s*\\.\\s*killMonster\\s*\\[\\s*qt\\s*\\[\\s*\\1\\s*\\]\\s*\\.\\s*goal\\s*\\.\\s*killMonster\\s*\\[\\s*(\\d+)\\s*\\]\\s*\\.\\s*id\\s*\\]\\s*>=\\s*qt\\s*\\[\\s*\\1\\s*\\]\\s*\\.\\s*goal\\s*\\.\\s*killMonster\\s*\\[\\s*\\2\\s*\\]\\s*\\.\\s*count",
      Pattern.CASE_INSENSITIVE);
  private static final Pattern KILL_MONSTER_INDEX_ACCESS = Pattern.compile(
      "qt\\s*\\[\\s*(\\d+)\\s*\\]\\s*\\.\\s*goal\\s*\\.\\s*killMonster\\s*\\[\\s*\\d+\\s*\\]\\s*\\.(id|count)",
      Pattern.CASE_INSENSITIVE);

  public static void main(String[] args) throws Exception {
    if(args.length < 1) {
      printUsage();
      return;
    }

    Path classificationJsonPath = Paths.get(args[0]);
    Path npcSourceDir = args.length >= 2
        ? Paths.get(args[1])
        : Paths.get("npc-lua-autofixed");
    Path npcOutputDir = args.length >= 3
        ? Paths.get(args[2])
        : Paths.get("npc-lua-autofixed-f");
    Path planOut = args.length >= 4
        ? Paths.get(args[3])
        : Paths.get("reports", "pattern_f_rewrite_plan.json");

    PatternFFixer fixer = new PatternFFixer();
    FixRunResult result = fixer.fixFromClassification(classificationJsonPath, npcSourceDir, npcOutputDir, planOut);

    System.out.println("classification_json=" + classificationJsonPath.toAbsolutePath());
    System.out.println("npc_source_dir=" + npcSourceDir.toAbsolutePath());
    System.out.println("npc_output_dir=" + npcOutputDir.toAbsolutePath());
    System.out.println("plan_out=" + planOut.toAbsolutePath());
    System.out.println("targetedLines=" + result.targetedLineCount);
    System.out.println("fixedLines=" + result.fixedLineCount);
    System.out.println("fixedFiles=" + result.fixedFileCount);
    System.out.println("skippedFiles=" + result.skippedFileCount);
  }

  public FixRunResult fixFromClassification(Path classificationJsonPath,
                                            Path npcSourceDir,
                                            Path npcOutputDir,
                                            Path planOut) throws Exception {
    if(classificationJsonPath == null || !Files.exists(classificationJsonPath)) {
      throw new IllegalStateException("classification json not found: " + classificationJsonPath);
    }
    if(npcSourceDir == null || !Files.exists(npcSourceDir) || !Files.isDirectory(npcSourceDir)) {
      throw new IllegalStateException("npc source dir not found: " + npcSourceDir);
    }

    String text = new String(Files.readAllBytes(classificationJsonPath), UTF8);
    Map<String, Object> root = QuestSemanticJson.parseObject(text, "runtime_failure_pattern_classification", 0);

    List<FixTarget> targets = resolvePatternFTargets(root, npcSourceDir);
    FixRunResult run = fixTargetsByLine(npcSourceDir, npcOutputDir, targets);
    writeRewritePlan(planOut, run);
    return run;
  }

  public FixerResult fix(Path npcSourceDir,
                         Path npcOutputDir,
                         List<RuntimeFailurePatternClassifier.ClassifiedFailureInput> targets) {
    FixerResult result = new FixerResult();
    result.patternType = "F";
    result.targetedCount = targets == null ? 0 : targets.size();

    try {
      List<FixTarget> precise = resolveTargetsFromRows(targets, npcSourceDir);
      FixRunResult run = fixTargetsByLine(npcSourceDir, npcOutputDir, precise);

      result.fixedCount = run.fixedFileCount;
      result.skippedCount = run.skippedFileCount;
      result.rewrittenLineCount = run.fixedLineCount;
      for(FileFixResult file : run.fileResults) {
        if("FIXED".equals(file.status)) {
          result.fixedFiles.add(file.file);
        } else {
          result.skippedFiles.add(file.file);
        }
      }
    } catch(Exception ex) {
      result.errors.add(ex.getMessage() == null ? ex.getClass().getSimpleName() : ex.getMessage());
      result.skippedCount = result.targetedCount;
    }

    Collections.sort(result.fixedFiles, String.CASE_INSENSITIVE_ORDER);
    Collections.sort(result.skippedFiles, String.CASE_INSENSITIVE_ORDER);
    return result;
  }

  private FixRunResult fixTargetsByLine(Path npcSourceDir,
                                        Path npcOutputDir,
                                        List<FixTarget> targets) throws Exception {
    if(!Files.exists(npcOutputDir)) {
      Files.createDirectories(npcOutputDir);
    }

    List<Path> files = new ArrayList<Path>();
    Files.walk(npcSourceDir)
        .filter(Files::isRegularFile)
        .filter(path -> path.getFileName().toString().toLowerCase(Locale.ROOT).startsWith("npc_"))
        .filter(path -> path.getFileName().toString().toLowerCase(Locale.ROOT).endsWith(".lua"))
        .forEach(files::add);
    Collections.sort(files);

    Map<String, List<FixTarget>> byFile = new LinkedHashMap<String, List<FixTarget>>();
    for(FixTarget target : targets) {
      List<FixTarget> bucket = byFile.get(target.npcFile);
      if(bucket == null) {
        bucket = new ArrayList<FixTarget>();
        byFile.put(target.npcFile, bucket);
      }
      bucket.add(target);
    }

    FixRunResult run = new FixRunResult();
    run.generatedAt = OffsetDateTime.now().format(DateTimeFormatter.ISO_OFFSET_DATE_TIME);

    for(Path source : files) {
      String rel = normalizePath(npcSourceDir.relativize(source).toString());
      Path output = npcOutputDir.resolve(rel.replace('/', File.separatorChar));
      ensureParent(output);

      List<FixTarget> fileTargets = byFile.get(rel);
      if(fileTargets == null || fileTargets.isEmpty()) {
        Files.copy(source, output, StandardCopyOption.REPLACE_EXISTING);
        continue;
      }

      RewriteResult rewritten = rewriteOneFile(source, rel, fileTargets);
      run.targetedLineCount += rewritten.targetedLines;
      run.fixedLineCount += rewritten.fixedLines;
      run.planItems.addAll(rewritten.planItems);
      run.fileResults.add(rewritten.fileResult);
      if(rewritten.changed) {
        Files.write(output, rewritten.bytes);
        run.fixedFileCount++;
      } else {
        Files.copy(source, output, StandardCopyOption.REPLACE_EXISTING);
        run.skippedFileCount++;
      }
    }

    return run;
  }

  private RewriteResult rewriteOneFile(Path source,
                                       String relativeFile,
                                       List<FixTarget> targets) throws Exception {
    byte[] raw = Files.readAllBytes(source);
    DecodedText decoded = decode(raw);

    String lineEnding = detectLineEnding(decoded.text);
    boolean finalNewline = hasFinalNewline(decoded.text);
    List<String> lines = splitLines(decoded.text);

    int helperInsertLine = findHelperInsertLine(lines);
    boolean helperNeeded = false;

    RewriteResult result = new RewriteResult();
    result.fileResult.file = relativeFile;
    result.targetedLines = targets.size();
    result.fileResult.targetedLines = targets.size();

    for(FixTarget target : targets) {
      int line = target.lineNumber;
      if(line <= 0 || line > lines.size()) {
        continue;
      }

      String before = lines.get(line - 1);
      String code = stripTrailingComment(before);
      if(code == null || code.trim().isEmpty()) {
        continue;
      }

      String afterCode = transformLine(code, target.questId);
      if(afterCode.equals(code)) {
        continue;
      }

      helperNeeded = true;
      String comment = before.substring(code.length());
      String after = afterCode + comment;
      if(!after.equals(before)) {
        lines.set(line - 1, after);
        result.fixedLines++;
        result.planItems.add(new RewritePlanItem(relativeFile, line, before.trim(), after.trim(), target.questId));
      }
    }

    if(result.fixedLines > 0 && helperNeeded && !hasHelper(lines)) {
      List<String> helper = buildHelperBlock();
      for(int i = 0; i < helper.size(); i++) {
        lines.add(helperInsertLine + i, helper.get(i));
      }
    }

    result.changed = result.fixedLines > 0;
    result.fileResult.fixedLines = result.fixedLines;
    result.fileResult.status = result.fixedLines > 0 ? "FIXED" : "SKIPPED";
    if(result.changed) {
      String text = joinLines(lines, lineEnding, finalNewline);
      result.bytes = encode(text, decoded.charset, decoded.bom);
    } else {
      result.bytes = raw;
    }
    return result;
  }

  private String transformLine(String code, int scopedQuestId) {
    Matcher matcher = KILL_MONSTER_PAIR.matcher(code);
    StringBuffer sb = new StringBuffer();
    while(matcher.find()) {
      int questId = intOf(matcher.group(1));
      if(scopedQuestId > 0 && questId != scopedQuestId) {
        continue;
      }
      String replacement = "__QUEST_HAS_ALL_KILL_TARGETS(qt[" + questId + "].goal.killMonster)";
      matcher.appendReplacement(sb, Matcher.quoteReplacement(replacement));
    }
    matcher.appendTail(sb);
    return sb.toString();
  }

  @SuppressWarnings("unchecked")
  private List<FixTarget> resolvePatternFTargets(Map<String, Object> root,
                                                 Path npcSourceDir) throws Exception {
    Object failuresObj = root.get("classifiedFailures");
    if(!(failuresObj instanceof List<?>)) {
      return Collections.emptyList();
    }

    List<FixTarget> targets = new ArrayList<FixTarget>();
    for(Object item : (List<Object>) failuresObj) {
      if(!(item instanceof Map<?, ?>)) {
        continue;
      }
      Map<String, Object> row = (Map<String, Object>) item;
      String pattern = normalizePattern(stringOf(row.get("patternType")));
      if(!"F".equals(pattern)) {
        continue;
      }

      RuntimeFailurePatternClassifier.ClassifiedFailureInput input = new RuntimeFailurePatternClassifier.ClassifiedFailureInput();
      input.npcFile = normalizePath(stringOf(row.get("npcFile")));
      input.patternType = pattern;
      input.sourceRule = stringOf(row.get("sourceRule"));
      input.questIds.addAll(parseIntList(row.get("questIds")));
      input.failureCodeSnippets.addAll(parseStringList(row.get("failureCodeSnippets")));

      targets.addAll(resolveTargetsFromRows(Collections.singletonList(input), npcSourceDir));
    }
    return dedupTargets(targets);
  }

  private List<FixTarget> resolveTargetsFromRows(List<RuntimeFailurePatternClassifier.ClassifiedFailureInput> rows,
                                                 Path npcSourceDir) throws Exception {
    if(rows == null || rows.isEmpty()) {
      return Collections.emptyList();
    }

    List<FixTarget> targets = new ArrayList<FixTarget>();
    for(RuntimeFailurePatternClassifier.ClassifiedFailureInput row : rows) {
      if(row == null || row.npcFile == null || row.npcFile.trim().isEmpty()) {
        continue;
      }

      String file = normalizePath(row.npcFile);
      int questId = row.questIds.isEmpty() ? 0 : row.questIds.get(0).intValue();
      List<String> lines = loadLines(npcSourceDir.resolve(file.replace('/', File.separatorChar)));
      if(lines.isEmpty()) {
        continue;
      }

      List<Integer> hitLines = new ArrayList<Integer>();
      for(int i = 0; i < lines.size(); i++) {
        String code = stripTrailingComment(lines.get(i));
        if(code == null || code.trim().isEmpty()) {
          continue;
        }

        Matcher matcher = KILL_MONSTER_PAIR.matcher(code);
        boolean matched = false;
        while(matcher.find()) {
          int q = intOf(matcher.group(1));
          if(questId <= 0 || q == questId) {
            matched = true;
            break;
          }
        }
        if(matched) {
          hitLines.add(Integer.valueOf(i + 1));
        }
      }

      if(hitLines.isEmpty()) {
        continue;
      }

      for(Integer line : hitLines) {
        FixTarget t = new FixTarget();
        t.npcFile = file;
        t.questId = questId;
        t.lineNumber = line.intValue();
        targets.add(t);
      }
    }

    return dedupTargets(targets);
  }

  private void writeRewritePlan(Path planOut, FixRunResult run) throws Exception {
    if(planOut.getParent() != null && !Files.exists(planOut.getParent())) {
      Files.createDirectories(planOut.getParent());
    }
    StringBuilder sb = new StringBuilder();
    sb.append("{\n");
    sb.append("  \"generatedAt\": \"").append(escape(run.generatedAt)).append("\",\n");
    sb.append("  \"targetedLineCount\": ").append(run.targetedLineCount).append(",\n");
    sb.append("  \"fixedLineCount\": ").append(run.fixedLineCount).append(",\n");
    sb.append("  \"fixedFileCount\": ").append(run.fixedFileCount).append(",\n");
    sb.append("  \"skippedFileCount\": ").append(run.skippedFileCount).append(",\n");
    sb.append("  \"items\": [");
    if(!run.planItems.isEmpty()) {
      sb.append("\n");
    }
    for(int i = 0; i < run.planItems.size(); i++) {
      if(i > 0) {
        sb.append(",\n");
      }
      RewritePlanItem item = run.planItems.get(i);
      sb.append("    {");
      sb.append("\"file\": \"").append(escape(item.file)).append("\", ");
      sb.append("\"line\": ").append(item.line).append(", ");
      sb.append("\"questId\": ").append(item.questId).append(", ");
      sb.append("\"before\": \"").append(escape(item.before)).append("\", ");
      sb.append("\"after\": \"").append(escape(item.after)).append("\"");
      sb.append("}");
    }
    if(!run.planItems.isEmpty()) {
      sb.append("\n");
    }
    sb.append("  ]\n");
    sb.append("}\n");
    Files.write(planOut, sb.toString().getBytes(UTF8));
  }

  private List<FixTarget> dedupTargets(List<FixTarget> targets) {
    Map<String, FixTarget> dedup = new LinkedHashMap<String, FixTarget>();
    for(FixTarget t : targets) {
      if(t == null || t.npcFile == null || t.npcFile.isEmpty() || t.lineNumber <= 0) {
        continue;
      }
      String key = t.npcFile + "#" + t.lineNumber;
      if(!dedup.containsKey(key)) {
        dedup.put(key, t);
      }
    }
    return new ArrayList<FixTarget>(dedup.values());
  }

  private boolean hasHelper(List<String> lines) {
    for(String line : lines) {
      if(line != null && line.contains("__QUEST_HAS_ALL_KILL_TARGETS")) {
        return true;
      }
    }
    return false;
  }

  private List<String> buildHelperBlock() {
    List<String> helper = new ArrayList<String>();
    helper.add("local function __QUEST_HAS_ALL_KILL_TARGETS(killGoals)");
    helper.add("  for i, v in ipairs(killGoals) do");
    helper.add("    if qData == nil then");
    helper.add("      return false");
    helper.add("    end");
    helper.add("    local questData = qData[v.id] or qData");
    helper.add("    local current = 0");
    helper.add("    if type(questData) == 'table' and questData.killMonster ~= nil then");
    helper.add("      current = questData.killMonster[v.id] or 0");
    helper.add("    elseif type(qData.killMonster) == 'table' then");
    helper.add("      current = qData.killMonster[v.id] or 0");
    helper.add("    end");
    helper.add("    if current < v.count then");
    helper.add("      return false");
    helper.add("    end");
    helper.add("  end");
    helper.add("  return true");
    helper.add("end");
    helper.add("");
    return helper;
  }

  private int findHelperInsertLine(List<String> lines) {
    int idx = 0;
    while(idx < lines.size()) {
      String trim = lines.get(idx).trim();
      if(trim.isEmpty() || trim.startsWith("--")) {
        idx++;
      } else {
        break;
      }
    }
    return idx;
  }

  private void ensureParent(Path path) throws Exception {
    if(path.getParent() != null && !Files.exists(path.getParent())) {
      Files.createDirectories(path.getParent());
    }
  }

  private String normalizePattern(String patternType) {
    if(patternType == null || patternType.isEmpty()) {
      return "G";
    }
    String t = patternType.trim().toUpperCase(Locale.ROOT);
    if(t.length() == 1 && t.charAt(0) >= 'A' && t.charAt(0) <= 'G') {
      return t;
    }
    char c = t.charAt(0);
    if(c >= 'A' && c <= 'G') {
      return String.valueOf(c);
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
  private List<Integer> parseIntList(Object value) {
    if(!(value instanceof List<?>)) {
      return Collections.emptyList();
    }
    List<Integer> out = new ArrayList<Integer>();
    for(Object item : (List<Object>) value) {
      if(item instanceof Number) {
        out.add(Integer.valueOf(((Number) item).intValue()));
      } else {
        int parsed = intOf(item);
        if(parsed > 0) {
          out.add(Integer.valueOf(parsed));
        }
      }
    }
    return out;
  }

  @SuppressWarnings("unchecked")
  private List<String> parseStringList(Object value) {
    if(!(value instanceof List<?>)) {
      return Collections.emptyList();
    }
    List<String> out = new ArrayList<String>();
    for(Object item : (List<Object>) value) {
      String text = stringOf(item);
      if(!text.isEmpty()) {
        out.add(text);
      }
    }
    return out;
  }

  private int intOf(Object value) {
    if(value instanceof Number) {
      return ((Number) value).intValue();
    }
    try {
      return Integer.parseInt(stringOf(value).trim());
    } catch(Exception ex) {
      return -1;
    }
  }

  private String stringOf(Object value) {
    return value == null ? "" : String.valueOf(value);
  }

  private List<String> loadLines(Path path) throws Exception {
    if(!Files.exists(path) || !Files.isRegularFile(path)) {
      return Collections.emptyList();
    }
    byte[] raw = Files.readAllBytes(path);
    DecodedText decoded = decode(raw);
    return splitLines(decoded.text);
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

  private byte[] encode(String text, Charset charset, byte[] bom) {
    byte[] body = text.getBytes(charset);
    if(bom == null || bom.length == 0) {
      return body;
    }
    byte[] out = new byte[bom.length + body.length];
    System.arraycopy(bom, 0, out, 0, bom.length);
    System.arraycopy(body, 0, out, bom.length, body.length);
    return out;
  }

  private String detectLineEnding(String text) {
    if(text.contains("\r\n")) {
      return "\r\n";
    }
    if(text.contains("\n")) {
      return "\n";
    }
    if(text.contains("\r")) {
      return "\r";
    }
    return "\r\n";
  }

  private boolean hasFinalNewline(String text) {
    if(text == null || text.isEmpty()) {
      return false;
    }
    return text.endsWith("\r\n") || text.endsWith("\n") || text.endsWith("\r");
  }

  private List<String> splitLines(String text) {
    String normalized = text.replace("\r\n", "\n").replace('\r', '\n');
    String[] arr = normalized.split("\n", -1);
    List<String> out = new ArrayList<String>(arr.length);
    Collections.addAll(out, arr);
    if(!out.isEmpty() && out.get(out.size() - 1).isEmpty()) {
      out.remove(out.size() - 1);
    }
    return out;
  }

  private String joinLines(List<String> lines, String lineEnding, boolean finalNewline) {
    StringBuilder sb = new StringBuilder();
    for(int i = 0; i < lines.size(); i++) {
      if(i > 0) {
        sb.append(lineEnding);
      }
      sb.append(lines.get(i));
    }
    if(finalNewline && !lines.isEmpty()) {
      sb.append(lineEnding);
    }
    return sb.toString();
  }

  private String stripTrailingComment(String line) {
    if(line == null) {
      return null;
    }
    int idx = commentStart(line);
    if(idx < 0) {
      return line;
    }
    return line.substring(0, idx);
  }

  private int commentStart(String line) {
    boolean inSingle = false;
    boolean inDouble = false;
    for(int i = 0; i < line.length() - 1; i++) {
      char c = line.charAt(i);
      char n = line.charAt(i + 1);
      if(c == '\\') {
        i++;
        continue;
      }
      if(c == '\'' && !inDouble) {
        inSingle = !inSingle;
        continue;
      }
      if(c == '"' && !inSingle) {
        inDouble = !inDouble;
        continue;
      }
      if(!inSingle && !inDouble && c == '-' && n == '-') {
        return i;
      }
    }
    return -1;
  }

  private static void printUsage() {
    System.out.println("Usage:");
    System.out.println("  java -cp build unluac.semantic.PatternFFixer <classification_json> [npc_source_dir] [npc_output_dir] [plan_out_json]");
  }

  public static final class FixTarget {
    public String npcFile = "";
    public int questId;
    public int lineNumber;
  }

  public static final class FileFixResult {
    public String file = "";
    public String status = "SKIPPED";
    public int targetedLines;
    public int fixedLines;
  }

  public static final class FixRunResult {
    public String generatedAt = "";
    public int targetedLineCount;
    public int fixedLineCount;
    public int fixedFileCount;
    public int skippedFileCount;
    public final List<FileFixResult> fileResults = new ArrayList<FileFixResult>();
    public final List<RewritePlanItem> planItems = new ArrayList<RewritePlanItem>();
  }

  public static final class RewritePlanItem {
    public final String file;
    public final int line;
    public final String before;
    public final String after;
    public final int questId;

    RewritePlanItem(String file, int line, String before, String after, int questId) {
      this.file = file;
      this.line = line;
      this.before = before;
      this.after = after;
      this.questId = questId;
    }
  }

  private static final class RewriteResult {
    boolean changed;
    int targetedLines;
    int fixedLines;
    byte[] bytes;
    final FileFixResult fileResult = new FileFixResult();
    final List<RewritePlanItem> planItems = new ArrayList<RewritePlanItem>();
  }

  private static final class DecodedText {
    Charset charset;
    byte[] bom;
    String text;
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
}
