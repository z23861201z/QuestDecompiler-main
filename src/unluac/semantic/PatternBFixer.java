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
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class PatternBFixer {

  private static final Charset UTF8 = Charset.forName("UTF-8");

  private static final Pattern CHECK_ITEM_PAIR = Pattern.compile(
      "CHECK_ITEM_CNT\\s*\\(\\s*qt\\s*\\[\\s*(\\d+)\\s*\\]\\s*\\.\\s*goal\\s*\\.\\s*getItem\\s*\\[\\s*(\\d+)\\s*\\]\\s*\\.\\s*id\\s*\\)\\s*([<>]=?)\\s*qt\\s*\\[\\s*\\1\\s*\\]\\s*\\.\\s*goal\\s*\\.\\s*getItem\\s*\\[\\s*\\2\\s*\\]\\s*\\.\\s*count",
      Pattern.CASE_INSENSITIVE);
  private static final Pattern GETITEM_ID = Pattern.compile(
      "qt\\s*\\[\\s*(\\d+)\\s*\\]\\s*\\.\\s*goal\\s*\\.\\s*getItem\\s*\\[\\s*\\d+\\s*\\]\\s*\\.\\s*id",
      Pattern.CASE_INSENSITIVE);
  private static final Pattern GETITEM_COUNT = Pattern.compile(
      "qt\\s*\\[\\s*(\\d+)\\s*\\]\\s*\\.\\s*goal\\s*\\.\\s*getItem\\s*\\[\\s*\\d+\\s*\\]\\s*\\.\\s*count",
      Pattern.CASE_INSENSITIVE);
  private static final Pattern DUP_HELPER_AND = Pattern.compile(
      "(__QUEST_HAS_ALL_ITEMS\\(qt\\[[0-9]+\\]\\.goal\\.getItem\\))\\s+and\\s+\\1",
      Pattern.CASE_INSENSITIVE);

  public static void main(String[] args) throws Exception {
    if(args.length < 1) {
      printUsage();
      return;
    }

    Path targetJsonPath = Paths.get(args[0]);
    Path npcSourceDir = args.length >= 2
        ? Paths.get(args[1])
        : Paths.get("npc-lua-auto-rewritten");
    Path npcOutputDir = args.length >= 3
        ? Paths.get(args[2])
        : Paths.get("npc-lua-autofixed");
    Path diffOut = args.length >= 4
        ? Paths.get(args[3])
        : Paths.get("reports", "pattern_b_fix_diff.txt");

    PatternBFixer fixer = new PatternBFixer();
    FixRunResult run = fixer.fixFromTargetJson(targetJsonPath, npcSourceDir, npcOutputDir, diffOut);

    System.out.println("target_json=" + targetJsonPath.toAbsolutePath());
    System.out.println("npc_source_dir=" + npcSourceDir.toAbsolutePath());
    System.out.println("npc_output_dir=" + npcOutputDir.toAbsolutePath());
    System.out.println("diff_out=" + diffOut.toAbsolutePath());
    System.out.println("targetedLines=" + run.targetedLineCount);
    System.out.println("fixedLines=" + run.fixedLineCount);
    System.out.println("fixedFiles=" + run.fixedFileCount);
    System.out.println("skippedFiles=" + run.skippedFileCount);
  }

  public FixRunResult fixFromTargetJson(Path targetJsonPath,
                                        Path npcSourceDir,
                                        Path npcOutputDir,
                                        Path diffOut) throws Exception {
    if(targetJsonPath == null || !Files.exists(targetJsonPath)) {
      throw new IllegalStateException("target json not found: " + targetJsonPath);
    }

    String text = new String(Files.readAllBytes(targetJsonPath), UTF8);
    Map<String, Object> parsed = QuestSemanticJson.parseObject(text, "pattern_b_targets", 0);

    List<FixTarget> targets = parseTargets(parsed);
    return fixTargetsByLine(npcSourceDir, npcOutputDir, diffOut, targets);
  }

  public FixRunResult fixTargetsByLine(Path npcSourceDir,
                                       Path npcOutputDir,
                                       Path diffOut,
                                       List<FixTarget> targets) throws Exception {
    if(npcSourceDir == null || !Files.exists(npcSourceDir) || !Files.isDirectory(npcSourceDir)) {
      throw new IllegalStateException("npc source dir not found: " + npcSourceDir);
    }
    if(!Files.exists(npcOutputDir)) {
      Files.createDirectories(npcOutputDir);
    }

    List<Path> sourceFiles = new ArrayList<Path>();
    Files.walk(npcSourceDir)
        .filter(Files::isRegularFile)
        .filter(path -> path.getFileName().toString().toLowerCase(Locale.ROOT).startsWith("npc_"))
        .filter(path -> path.getFileName().toString().toLowerCase(Locale.ROOT).endsWith(".lua"))
        .forEach(sourceFiles::add);
    Collections.sort(sourceFiles);

    Map<String, List<FixTarget>> targetsByFile = groupByFile(targets);
    FixRunResult result = new FixRunResult();
    result.generatedAt = OffsetDateTime.now().format(DateTimeFormatter.ISO_OFFSET_DATE_TIME);

    List<String> diffBlocks = new ArrayList<String>();
    for(Path source : sourceFiles) {
      String rel = normalizePath(npcSourceDir.relativize(source).toString());
      Path output = npcOutputDir.resolve(rel.replace('/', File.separatorChar));
      ensureParent(output);

      List<FixTarget> fileTargets = targetsByFile.get(rel);
      if(fileTargets == null || fileTargets.isEmpty()) {
        Files.copy(source, output, StandardCopyOption.REPLACE_EXISTING);
        continue;
      }

      RewriteResult rewrite = rewriteOneFile(source, rel, fileTargets);
      result.targetedLineCount += rewrite.targetedLines;
      result.fixedLineCount += rewrite.fixedLines;
      result.fileResults.add(rewrite.fileResult);

      if(rewrite.changed) {
        Files.write(output, rewrite.bytes);
        result.fixedFileCount++;
        if(!rewrite.diffLines.isEmpty()) {
          diffBlocks.add(toDiffBlock(rel, rewrite.diffLines));
        }
      } else {
        Files.copy(source, output, StandardCopyOption.REPLACE_EXISTING);
        result.skippedFileCount++;
      }
    }

    writeDiff(diffOut, diffBlocks);
    return result;
  }

  public FixerResult fix(Path npcSourceDir,
                         Path npcOutputDir,
                         List<RuntimeFailurePatternClassifier.ClassifiedFailureInput> targets) {
    FixerResult result = new FixerResult();
    result.patternType = "B";
    result.targetedCount = targets == null ? 0 : targets.size();

    try {
      List<FixTarget> preciseTargets = resolveTargetsFromClassification(npcSourceDir, targets);
      Path diffOut = Paths.get("reports", "pattern_b_fix_diff.txt");
      FixRunResult run = fixTargetsByLine(npcSourceDir, npcOutputDir, diffOut, preciseTargets);

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

  private List<FixTarget> resolveTargetsFromClassification(Path npcSourceDir,
                                                           List<RuntimeFailurePatternClassifier.ClassifiedFailureInput> rows) throws Exception {
    if(rows == null || rows.isEmpty()) {
      return Collections.emptyList();
    }

    List<FixTarget> out = new ArrayList<FixTarget>();
    for(RuntimeFailurePatternClassifier.ClassifiedFailureInput row : rows) {
      if(row == null) {
        continue;
      }
      String file = normalizePath(row.npcFile);
      if(file.isEmpty()) {
        continue;
      }
      int questId = row.questIds.isEmpty() ? 0 : row.questIds.get(0).intValue();

      List<String> lines = loadLines(npcSourceDir.resolve(file.replace('/', File.separatorChar)));
      if(lines.isEmpty()) {
        continue;
      }

      Set<Integer> lineNumbers = new LinkedHashSet<Integer>();
      for(String snippet : row.failureCodeSnippets) {
        String normalizedSnippet = snippet == null ? "" : snippet.trim();
        if(normalizedSnippet.isEmpty()) {
          continue;
        }
        for(int i = 0; i < lines.size(); i++) {
          if(lines.get(i).trim().equals(normalizedSnippet)) {
            lineNumbers.add(Integer.valueOf(i + 1));
          }
        }
      }

      if(lineNumbers.isEmpty() && questId > 0) {
        Pattern qPattern = Pattern.compile("qt\\s*\\[\\s*" + questId + "\\s*\\]\\s*\\.\\s*goal\\s*\\.\\s*getItem\\s*\\[",
            Pattern.CASE_INSENSITIVE);
        for(int i = 0; i < lines.size(); i++) {
          String code = stripTrailingComment(lines.get(i));
          if(code == null || code.trim().isEmpty()) {
            continue;
          }
          if(qPattern.matcher(code).find() && (GETITEM_ID.matcher(code).find() || GETITEM_COUNT.matcher(code).find())) {
            lineNumbers.add(Integer.valueOf(i + 1));
          }
        }
      }

      for(Integer ln : lineNumbers) {
        FixTarget target = new FixTarget();
        target.npcFile = file;
        target.questId = questId;
        target.lineNumber = ln.intValue();
        out.add(target);
      }
    }

    return dedupTargets(out);
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
        result.diffLines.add(new LineDiff(line, before, after));
      }
    }

    if(result.fixedLines > 0 && helperNeeded && !hasHelperFunction(lines)) {
      List<String> helper = buildHelperBlock();
      for(int i = 0; i < helper.size(); i++) {
        lines.add(helperInsertLine + i, helper.get(i));
        result.diffLines.add(new LineDiff(helperInsertLine + i + 1, "", helper.get(i)));
      }
    }

    result.fileResult.fixedLines = result.fixedLines;
    result.fileResult.status = result.fixedLines > 0 ? "FIXED" : "SKIPPED";
    result.changed = result.fixedLines > 0;

    if(result.changed) {
      String text = joinLines(lines, lineEnding, finalNewline);
      result.bytes = encode(text, decoded.charset, decoded.bom);
    } else {
      result.bytes = raw;
    }

    return result;
  }

  private String transformLine(String code, int scopedQuestId) {
    String transformed = code;

    Matcher pairMatcher = CHECK_ITEM_PAIR.matcher(transformed);
    StringBuffer sb = new StringBuffer();
    while(pairMatcher.find()) {
      int questId = parseIntSafe(pairMatcher.group(1));
      if(!matchesQuest(questId, scopedQuestId)) {
        continue;
      }
      String op = pairMatcher.group(3);
      String replace = op.startsWith(">")
          ? "__QUEST_HAS_ALL_ITEMS(qt[" + questId + "].goal.getItem)"
          : "not __QUEST_HAS_ALL_ITEMS(qt[" + questId + "].goal.getItem)";
      pairMatcher.appendReplacement(sb, Matcher.quoteReplacement(replace));
    }
    pairMatcher.appendTail(sb);
    transformed = sb.toString();

    transformed = replaceDirectAccessor(transformed, GETITEM_ID, scopedQuestId);
    transformed = replaceDirectAccessor(transformed, GETITEM_COUNT, scopedQuestId);
    transformed = DUP_HELPER_AND.matcher(transformed).replaceAll("$1");
    return transformed;
  }

  private String replaceDirectAccessor(String code, Pattern pattern, int scopedQuestId) {
    Matcher matcher = pattern.matcher(code);
    StringBuffer sb = new StringBuffer();
    while(matcher.find()) {
      int questId = parseIntSafe(matcher.group(1));
      if(!matchesQuest(questId, scopedQuestId)) {
        continue;
      }
      String replace = "__QUEST_HAS_ALL_ITEMS(qt[" + questId + "].goal.getItem)";
      matcher.appendReplacement(sb, Matcher.quoteReplacement(replace));
    }
    matcher.appendTail(sb);
    return sb.toString();
  }

  private boolean matchesQuest(int questId, int scopedQuestId) {
    if(scopedQuestId <= 0) {
      return questId > 0;
    }
    return questId == scopedQuestId;
  }

  private List<FixTarget> parseTargets(Map<String, Object> root) {
    List<FixTarget> targets = new ArrayList<FixTarget>();
    if(root == null || root.isEmpty()) {
      return Collections.emptyList();
    }

    Object directTargets = root.get("targets");
    if(directTargets instanceof List<?>) {
      @SuppressWarnings("unchecked")
      List<Object> arr = (List<Object>) directTargets;
      for(Object item : arr) {
        FixTarget target = parseDirectTarget(item);
        if(target != null) {
          targets.add(target);
        }
      }
      return dedupTargets(targets);
    }

    for(Map.Entry<String, Object> entry : root.entrySet()) {
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

      @SuppressWarnings("unchecked")
      Map<String, Object> questObj = (Map<String, Object>) entry.getValue();
      Object npcFilesObj = questObj.get("npcFiles");
      if(!(npcFilesObj instanceof List<?>)) {
        continue;
      }

      @SuppressWarnings("unchecked")
      List<Object> npcFiles = (List<Object>) npcFilesObj;
      for(Object npcObj : npcFiles) {
        if(!(npcObj instanceof Map<?, ?>)) {
          continue;
        }
        @SuppressWarnings("unchecked")
        Map<String, Object> npcMap = (Map<String, Object>) npcObj;
        String file = normalizePath(stringOf(npcMap.get("file")));
        if(file.isEmpty()) {
          continue;
        }

        Object accessObj = npcMap.get("access");
        if(!(accessObj instanceof List<?>)) {
          continue;
        }
        @SuppressWarnings("unchecked")
        List<Object> accessList = (List<Object>) accessObj;
        for(Object accessItem : accessList) {
          if(!(accessItem instanceof Map<?, ?>)) {
            continue;
          }
          @SuppressWarnings("unchecked")
          Map<String, Object> access = (Map<String, Object>) accessItem;
          if(!boolOf(access.get("hardcodedIndex"))) {
            continue;
          }
          if(!"goal.getItem".equals(stringOf(access.get("type")))) {
            continue;
          }
          int line = intOf(access.get("line"));
          if(line <= 0) {
            continue;
          }

          FixTarget target = new FixTarget();
          target.npcFile = file;
          target.questId = questId;
          target.lineNumber = line;
          targets.add(target);
        }
      }
    }

    return dedupTargets(targets);
  }

  private FixTarget parseDirectTarget(Object item) {
    if(!(item instanceof Map<?, ?>)) {
      return null;
    }
    @SuppressWarnings("unchecked")
    Map<String, Object> map = (Map<String, Object>) item;
    FixTarget target = new FixTarget();
    target.npcFile = normalizePath(stringOf(map.get("npcFile")));
    target.questId = intOf(map.get("questId"));
    target.lineNumber = intOf(map.get("lineNumber"));
    if(target.npcFile.isEmpty() || target.lineNumber <= 0) {
      return null;
    }
    return target;
  }

  private List<FixTarget> dedupTargets(List<FixTarget> targets) {
    Map<String, FixTarget> dedup = new LinkedHashMap<String, FixTarget>();
    for(FixTarget target : targets) {
      if(target == null || target.npcFile == null || target.npcFile.isEmpty() || target.lineNumber <= 0) {
        continue;
      }
      String key = target.npcFile + "#" + target.lineNumber;
      if(!dedup.containsKey(key)) {
        dedup.put(key, target);
      }
    }

    List<FixTarget> out = new ArrayList<FixTarget>(dedup.values());
    Collections.sort(out, (a, b) -> {
      int c = a.npcFile.compareToIgnoreCase(b.npcFile);
      if(c != 0) {
        return c;
      }
      return Integer.compare(a.lineNumber, b.lineNumber);
    });
    return out;
  }

  private Map<String, List<FixTarget>> groupByFile(List<FixTarget> targets) {
    Map<String, List<FixTarget>> grouped = new LinkedHashMap<String, List<FixTarget>>();
    for(FixTarget target : targets) {
      List<FixTarget> bucket = grouped.get(target.npcFile);
      if(bucket == null) {
        bucket = new ArrayList<FixTarget>();
        grouped.put(target.npcFile, bucket);
      }
      bucket.add(target);
    }
    return grouped;
  }

  private List<String> loadLines(Path path) throws Exception {
    if(!Files.exists(path) || !Files.isRegularFile(path)) {
      return Collections.emptyList();
    }
    byte[] raw = Files.readAllBytes(path);
    DecodedText decoded = decode(raw);
    return splitLines(decoded.text);
  }

  private void writeDiff(Path diffOut, List<String> blocks) throws Exception {
    if(diffOut.getParent() != null && !Files.exists(diffOut.getParent())) {
      Files.createDirectories(diffOut.getParent());
    }
    StringBuilder sb = new StringBuilder();
    for(int i = 0; i < blocks.size(); i++) {
      if(i > 0) {
        sb.append("\n");
      }
      sb.append(blocks.get(i));
      if(!blocks.get(i).endsWith("\n")) {
        sb.append("\n");
      }
    }
    Files.write(diffOut, sb.toString().getBytes(UTF8));
  }

  private String toDiffBlock(String relativeFile, List<LineDiff> lines) {
    String outName = relativeFile.endsWith(".lua")
        ? relativeFile.substring(0, relativeFile.length() - 4) + "_autofixed.lua"
        : relativeFile + "_autofixed";
    StringBuilder sb = new StringBuilder();
    sb.append("--- ").append(relativeFile).append("\n");
    sb.append("+++ ").append(outName).append("\n");
    for(LineDiff line : lines) {
      if(!line.before.isEmpty()) {
        sb.append("- ").append(line.before).append("\n");
      }
      if(!line.after.isEmpty()) {
        sb.append("+ ").append(line.after).append("\n");
      }
    }
    return sb.toString();
  }

  private List<String> buildHelperBlock() {
    List<String> helper = new ArrayList<String>();
    helper.add("local function __QUEST_HAS_ALL_ITEMS(goalItems)");
    helper.add("  for i, v in ipairs(goalItems) do");
    helper.add("    if CHECK_ITEM_CNT(v.id) < v.count then");
    helper.add("      return false");
    helper.add("    end");
    helper.add("  end");
    helper.add("  return true");
    helper.add("end");
    helper.add("");
    return helper;
  }

  private boolean hasHelperFunction(List<String> lines) {
    for(String line : lines) {
      if(line != null && line.contains("__QUEST_HAS_ALL_ITEMS")) {
        return true;
      }
    }
    return false;
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

  private String normalizePath(String path) {
    if(path == null) {
      return "";
    }
    return path.replace('\\', '/').trim();
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

  private int intOf(Object value) {
    if(value instanceof Number) {
      return ((Number) value).intValue();
    }
    return parseIntSafe(stringOf(value));
  }

  private int parseIntSafe(String text) {
    if(text == null) {
      return -1;
    }
    try {
      return Integer.parseInt(text.trim());
    } catch(Exception ex) {
      return -1;
    }
  }

  private String stringOf(Object value) {
    return value == null ? "" : String.valueOf(value);
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
    List<String> lines = new ArrayList<String>(arr.length);
    Collections.addAll(lines, arr);
    if(!lines.isEmpty() && lines.get(lines.size() - 1).isEmpty()) {
      lines.remove(lines.size() - 1);
    }
    return lines;
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
    System.out.println("  java -cp build unluac.semantic.PatternBFixer <target_json_path> [npc_source_dir] [npc_output_dir] [diff_out]");
  }

  public static final class FixTarget {
    public String npcFile = "";
    public int questId;
    public int lineNumber;
  }

  public static final class FixRunResult {
    public String generatedAt = "";
    public int targetedLineCount;
    public int fixedLineCount;
    public int fixedFileCount;
    public int skippedFileCount;
    public final List<FileFixResult> fileResults = new ArrayList<FileFixResult>();
  }

  public static final class FileFixResult {
    public String file = "";
    public String status = "SKIPPED";
    public int targetedLines;
    public int fixedLines;
  }

  private static final class RewriteResult {
    boolean changed;
    int targetedLines;
    int fixedLines;
    byte[] bytes;
    final List<LineDiff> diffLines = new ArrayList<LineDiff>();
    final FileFixResult fileResult = new FileFixResult();
  }

  private static final class LineDiff {
    final int line;
    final String before;
    final String after;

    LineDiff(int line, String before, String after) {
      this.line = line;
      this.before = before == null ? "" : before;
      this.after = after == null ? "" : after;
    }
  }

  private static final class DecodedText {
    Charset charset;
    byte[] bom;
    String text;
  }
}
