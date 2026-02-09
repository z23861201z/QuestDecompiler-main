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

public class NpcHardcodeRewriter {

  private static final Charset UTF8 = Charset.forName("UTF-8");

  private static final Pattern SIMPLE_GETITEM_REF = Pattern.compile(
      "qt\\s*\\[\\s*(\\d+)\\s*\\]\\s*\\.\\s*goal\\s*\\.\\s*getItem\\s*\\[\\s*(\\d+)\\s*\\]\\s*\\.\\s*(id|count)");

  private static final Pattern CHECK_ITEM_PAIR = Pattern.compile(
      "CHECK_ITEM_CNT\\s*\\(\\s*qt\\s*\\[\\s*(\\d+)\\s*\\]\\s*\\.\\s*goal\\s*\\.\\s*getItem\\s*\\[\\s*(\\d+)\\s*\\]\\s*\\.\\s*id\\s*\\)\\s*([<>]=?)\\s*qt\\s*\\[\\s*\\1\\s*\\]\\s*\\.\\s*goal\\s*\\.\\s*getItem\\s*\\[\\s*\\2\\s*\\]\\s*\\.\\s*count");

  private static final Pattern DUPLICATED_HAS_ALL_ITEMS_AND = Pattern.compile(
      "(__QUEST_HAS_ALL_ITEMS\\(qt\\[[0-9]+\\]\\.goal\\.getItem\\))\\s+and\\s+\\1");

  private static final Pattern IF_OR_ELSEIF_LINE = Pattern.compile("^\\s*(if|elseif)\\b.*\\bthen\\s*(--.*)?$");

  public static void main(String[] args) throws Exception {
    Path npcLuaDir = args.length >= 1
        ? Paths.get(args[0])
        : Paths.get("D:\\TitanGames\\GhostOnline\\zChina\\Script\\npc-lua");
    Path rewrittenOutDir = args.length >= 2
        ? Paths.get(args[1])
        : Paths.get("npc-lua-rewritten");
    Path planOut = args.length >= 3
        ? Paths.get(args[2])
        : Paths.get("reports", "npc_hardcode_rewrite_plan.json");
    Path diffOut = args.length >= 4
        ? Paths.get(args[3])
        : Paths.get("reports", "npc_rewrite_diff.txt");

    RewriteOutput output = rewriteAll(npcLuaDir, rewrittenOutDir, planOut, diffOut);

    Path rewrittenScanOut = Paths.get("reports", "npc_lua_rewritten_dependency_index.json");
    QuestNpcDependencyScanner.DependencyIndex scan = QuestNpcDependencyScanner.scanDirectory(rewrittenOutDir);
    QuestNpcDependencyScanner.writeIndex(scan, rewrittenScanOut);

    int hardcodedGetItemCount = countHardcodedGoalGetItem(scan);

    System.out.println("input_dir=" + npcLuaDir.toAbsolutePath());
    System.out.println("rewritten_dir=" + rewrittenOutDir.toAbsolutePath());
    System.out.println("plan_json=" + planOut.toAbsolutePath());
    System.out.println("diff_txt=" + diffOut.toAbsolutePath());
    System.out.println("rewritten_scan_json=" + rewrittenScanOut.toAbsolutePath());
    System.out.println("scanned_files=" + output.scannedFiles);
    System.out.println("rewritten_files=" + output.rewrittenFiles);
    System.out.println("rewritten_lines=" + output.rewrittenLineCount);
    System.out.println("hardcoded_goal_getItem_count=" + hardcodedGetItemCount);

    if(hardcodedGetItemCount > 0) {
      throw new IllegalStateException("rewrite incomplete: goal.getItem hardcodedIndex still exists, count=" + hardcodedGetItemCount);
    }
  }

  public static RewriteOutput rewriteAll(Path npcLuaDir,
                                         Path rewrittenOutDir,
                                         Path planOut,
                                         Path diffOut) throws Exception {
    if(npcLuaDir == null || !Files.exists(npcLuaDir) || !Files.isDirectory(npcLuaDir)) {
      throw new IllegalStateException("npc lua dir not found: " + npcLuaDir);
    }

    if(!Files.exists(rewrittenOutDir)) {
      Files.createDirectories(rewrittenOutDir);
    }

    List<Path> files = new ArrayList<Path>();
    Files.walk(npcLuaDir)
        .filter(Files::isRegularFile)
        .filter(path -> {
          String name = path.getFileName().toString().toLowerCase(Locale.ROOT);
          return name.startsWith("npc_") && name.endsWith(".lua");
        })
        .forEach(files::add);
    Collections.sort(files);

    RewriteOutput output = new RewriteOutput();
    output.scannedFiles = files.size();

    Map<String, List<PlanItem>> plan = new LinkedHashMap<String, List<PlanItem>>();
    List<FileDiff> fileDiffs = new ArrayList<FileDiff>();

    for(Path source : files) {
      Path rel = npcLuaDir.relativize(source);
      Path target = rewrittenOutDir.resolve(rel);
      if(target.getParent() != null && !Files.exists(target.getParent())) {
        Files.createDirectories(target.getParent());
      }

      RewriteFileResult fileResult = rewriteOneFile(source, rel.toString().replace('\\', '/'));
      if(fileResult.changed) {
        output.rewrittenFiles++;
        output.rewrittenLineCount += fileResult.planItems.size();
        plan.put(fileResult.relativePath, fileResult.planItems);
        fileDiffs.add(fileResult.diff);
        Files.write(target, fileResult.newBytes);
      } else {
        Files.copy(source, target, StandardCopyOption.REPLACE_EXISTING);
      }
    }

    writePlan(planOut, plan, npcLuaDir, rewrittenOutDir);
    writeDiff(diffOut, fileDiffs);
    return output;
  }

  private static RewriteFileResult rewriteOneFile(Path sourceFile, String relativePath) throws Exception {
    byte[] raw = Files.readAllBytes(sourceFile);
    DecodedText decoded = decode(raw);

    String lineEnding = detectLineEnding(decoded.text);
    boolean finalNewline = hasFinalNewline(decoded.text);
    List<String> lines = splitLines(decoded.text);

    List<PlanItem> planItems = new ArrayList<PlanItem>();
    List<LineDiff> lineDiffs = new ArrayList<LineDiff>();

    int helperInsertLine = findHelperInsertLine(lines);
    boolean helperAdded = false;

    for(int i = 0; i < lines.size(); i++) {
      String line = lines.get(i);
      String code = stripTrailingComment(line);
      if(code == null || code.trim().isEmpty()) {
        continue;
      }

      Matcher refMatcher = SIMPLE_GETITEM_REF.matcher(code);
      if(!refMatcher.find()) {
        continue;
      }

      String newCode = code;

      Matcher checkMatcher = CHECK_ITEM_PAIR.matcher(newCode);
      StringBuffer replaced = new StringBuffer();
      boolean changedLine = false;
      while(checkMatcher.find()) {
        String questId = checkMatcher.group(1);
        String op = checkMatcher.group(3);
        String rep;
        if(op.startsWith(">")) {
          rep = "__QUEST_HAS_ALL_ITEMS(qt[" + questId + "].goal.getItem)";
        } else {
          rep = "not __QUEST_HAS_ALL_ITEMS(qt[" + questId + "].goal.getItem)";
        }
        checkMatcher.appendReplacement(replaced, Matcher.quoteReplacement(rep));

        PlanItem item = new PlanItem();
        item.line = i + 1;
        item.original = checkMatcher.group();
        item.rewriteType = "loop_conversion";
        planItems.add(item);
        changedLine = true;
      }
      checkMatcher.appendTail(replaced);
      newCode = replaced.toString();

      String residualReplaced = replaceResidualGetItemRefs(newCode, planItems, i + 1);
      if(!residualReplaced.equals(newCode)) {
        newCode = residualReplaced;
        changedLine = true;
      }

      String deduped = dedupeSameQuestHasAllItems(newCode);
      if(!deduped.equals(newCode)) {
        newCode = deduped;
        changedLine = true;
      }

      if(!changedLine) {
        continue;
      }

      if(!helperAdded) {
        List<String> helper = buildHelperBlock();
        for(int h = 0; h < helper.size(); h++) {
          lines.add(helperInsertLine + h, helper.get(h));
          lineDiffs.add(new LineDiff(helperInsertLine + h + 1, "", helper.get(h)));
        }
        if(helperInsertLine <= i) {
          i += helper.size();
        }
        helperAdded = true;
      }

      String comment = line.substring(code.length());
      String rewrittenLine = newCode + comment;
      if(!rewrittenLine.equals(line)) {
        lines.set(i, rewrittenLine);
        lineDiffs.add(new LineDiff(i + 1, line, rewrittenLine));
      }
    }

    if(planItems.isEmpty()) {
      RewriteFileResult result = new RewriteFileResult();
      result.changed = false;
      result.relativePath = relativePath;
      return result;
    }

    String newText = joinLines(lines, lineEnding, finalNewline);
    byte[] newBytes = encode(newText, decoded.charset, decoded.bom);

    RewriteFileResult result = new RewriteFileResult();
    result.changed = true;
    result.relativePath = relativePath;
    result.planItems = planItems;
    result.diff = new FileDiff();
    result.diff.relativePath = relativePath;
    result.diff.lines = lineDiffs;
    result.newBytes = newBytes;
    return result;
  }

  private static String replaceResidualGetItemRefs(String code, List<PlanItem> planItems, int line) {
    String out = code;

    String replaced = out.replaceAll(
        "qt\\s*\\[\\s*(\\d+)\\s*\\]\\s*\\.\\s*goal\\s*\\.\\s*getItem\\s*\\[\\s*\\d+\\s*\\]\\s*\\.\\s*id",
        "__QUEST_FIRST_ITEM_ID(qt[$1].goal.getItem)");
    if(!replaced.equals(out)) {
      PlanItem item = new PlanItem();
      item.line = line;
      item.original = "qt[...].goal.getItem[n].id";
      item.rewriteType = "single_item_ref";
      planItems.add(item);
      out = replaced;
    }

    replaced = out.replaceAll(
        "qt\\s*\\[\\s*(\\d+)\\s*\\]\\s*\\.\\s*goal\\s*\\.\\s*getItem\\s*\\[\\s*\\d+\\s*\\]\\s*\\.\\s*count",
        "__QUEST_FIRST_ITEM_COUNT(qt[$1].goal.getItem)");
    if(!replaced.equals(out)) {
      PlanItem item = new PlanItem();
      item.line = line;
      item.original = "qt[...].goal.getItem[n].count";
      item.rewriteType = "single_item_ref";
      planItems.add(item);
      out = replaced;
    }

    return out;
  }

  private static String dedupeSameQuestHasAllItems(String code) {
    String out = code;
    while(true) {
      Matcher m = DUPLICATED_HAS_ALL_ITEMS_AND.matcher(out);
      if(!m.find()) {
        break;
      }
      out = m.replaceAll("$1");
    }
    return out;
  }

  private static List<String> buildHelperBlock() {
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
    helper.add("local function __QUEST_FIRST_ITEM_ID(goalItems)");
    helper.add("  if goalItems == nil or goalItems[1] == nil then");
    helper.add("    return 0");
    helper.add("  end");
    helper.add("  return goalItems[1].id");
    helper.add("end");
    helper.add("");
    helper.add("local function __QUEST_FIRST_ITEM_COUNT(goalItems)");
    helper.add("  if goalItems == nil or goalItems[1] == nil then");
    helper.add("    return 0");
    helper.add("  end");
    helper.add("  return goalItems[1].count");
    helper.add("end");
    helper.add("");
    return helper;
  }

  private static int countHardcodedGoalGetItem(QuestNpcDependencyScanner.DependencyIndex index) {
    int count = 0;
    if(index == null || index.quests == null) {
      return 0;
    }
    for(QuestNpcDependencyScanner.QuestDependencyRecord record : index.quests.values()) {
      if(record == null || record.npcFiles == null) {
        continue;
      }
      for(QuestNpcDependencyScanner.NpcReference ref : record.npcFiles) {
        if(ref == null || ref.access == null) {
          continue;
        }
        for(QuestNpcDependencyScanner.AccessEntry access : ref.access) {
          if(access == null) {
            continue;
          }
          if(access.hardcodedIndex && "goal.getItem".equals(access.type)) {
            count++;
          }
        }
      }
    }
    return count;
  }

  private static void writePlan(Path planOut,
                                Map<String, List<PlanItem>> plan,
                                Path sourceDir,
                                Path targetDir) throws Exception {
    if(planOut.getParent() != null && !Files.exists(planOut.getParent())) {
      Files.createDirectories(planOut.getParent());
    }

    StringBuilder sb = new StringBuilder();
    sb.append("{\n");
    sb.append("  \"_meta\": {\n");
    sb.append("    \"generatedAt\": \"").append(escape(OffsetDateTime.now().format(DateTimeFormatter.ISO_OFFSET_DATE_TIME))).append("\",\n");
    sb.append("    \"sourceDir\": \"").append(escape(sourceDir.toAbsolutePath().toString())).append("\",\n");
    sb.append("    \"targetDir\": \"").append(escape(targetDir.toAbsolutePath().toString())).append("\"\n");
    sb.append("  }");

    for(Map.Entry<String, List<PlanItem>> entry : plan.entrySet()) {
      sb.append(",\n");
      sb.append("  \"").append(escape(entry.getKey())).append("\": [\n");
      for(int i = 0; i < entry.getValue().size(); i++) {
        PlanItem item = entry.getValue().get(i);
        if(i > 0) {
          sb.append(",\n");
        }
        sb.append("    {\n");
        sb.append("      \"line\": ").append(item.line).append(",\n");
        sb.append("      \"original\": \"").append(escape(item.original)).append("\",\n");
        sb.append("      \"rewriteType\": \"").append(escape(item.rewriteType)).append("\"\n");
        sb.append("    }");
      }
      sb.append("\n  ]");
    }

    sb.append("\n}\n");
    Files.write(planOut, sb.toString().getBytes(UTF8));
  }

  private static void writeDiff(Path diffOut, List<FileDiff> diffs) throws Exception {
    if(diffOut.getParent() != null && !Files.exists(diffOut.getParent())) {
      Files.createDirectories(diffOut.getParent());
    }

    StringBuilder sb = new StringBuilder();
    for(FileDiff diff : diffs) {
      String outName = diff.relativePath.endsWith(".lua")
          ? diff.relativePath.substring(0, diff.relativePath.length() - 4) + "_rewritten.lua"
          : diff.relativePath + "_rewritten";

      sb.append("--- ").append(diff.relativePath).append("\n");
      sb.append("+++ ").append(outName).append("\n");
      for(LineDiff line : diff.lines) {
        if(!line.before.isEmpty()) {
          sb.append("- ").append(line.before).append("\n");
        }
        if(!line.after.isEmpty()) {
          sb.append("+ ").append(line.after).append("\n");
        }
      }
      sb.append("\n");
    }

    Files.write(diffOut, sb.toString().getBytes(UTF8));
  }

  private static int findHelperInsertLine(List<String> lines) {
    int idx = 0;
    while(idx < lines.size()) {
      String trim = lines.get(idx).trim();
      if(trim.isEmpty() || trim.startsWith("--")) {
        idx++;
        continue;
      }
      break;
    }
    return idx;
  }

  private static DecodedText decode(byte[] raw) throws Exception {
    byte[] bom = new byte[0];
    byte[] content = raw;
    if(raw.length >= 3 && (raw[0] & 0xFF) == 0xEF && (raw[1] & 0xFF) == 0xBB && (raw[2] & 0xFF) == 0xBF) {
      bom = new byte[] {(byte) 0xEF, (byte) 0xBB, (byte) 0xBF};
      content = new byte[raw.length - 3];
      System.arraycopy(raw, 3, content, 0, content.length);
    }

    Charset[] tryCharsets = new Charset[] {
        Charset.forName("UTF-8"),
        Charset.forName("GB18030"),
        Charset.forName("GBK"),
        Charset.forName("Big5")
    };

    for(Charset c : tryCharsets) {
      try {
        CharsetDecoder decoder = c.newDecoder();
        decoder.onMalformedInput(CodingErrorAction.REPORT);
        decoder.onUnmappableCharacter(CodingErrorAction.REPORT);
        CharBuffer cb = decoder.decode(ByteBuffer.wrap(content));

        DecodedText out = new DecodedText();
        out.charset = c;
        out.bom = bom;
        out.text = cb.toString();
        return out;
      } catch(CharacterCodingException ignored) {
      }
    }

    DecodedText out = new DecodedText();
    out.charset = Charset.forName("UTF-8");
    out.bom = bom;
    out.text = new String(content, out.charset);
    return out;
  }

  private static byte[] encode(String text, Charset charset, byte[] bom) {
    byte[] body = text.getBytes(charset);
    if(bom == null || bom.length == 0) {
      return body;
    }
    byte[] out = new byte[bom.length + body.length];
    System.arraycopy(bom, 0, out, 0, bom.length);
    System.arraycopy(body, 0, out, bom.length, body.length);
    return out;
  }

  private static String detectLineEnding(String text) {
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

  private static boolean hasFinalNewline(String text) {
    if(text == null || text.isEmpty()) {
      return false;
    }
    return text.endsWith("\r\n") || text.endsWith("\n") || text.endsWith("\r");
  }

  private static List<String> splitLines(String text) {
    String normalized = text.replace("\r\n", "\n").replace('\r', '\n');
    String[] parts = normalized.split("\n", -1);
    List<String> out = new ArrayList<String>(parts.length);
    Collections.addAll(out, parts);
    if(!out.isEmpty() && out.get(out.size() - 1).isEmpty()) {
      out.remove(out.size() - 1);
    }
    return out;
  }

  private static String joinLines(List<String> lines, String lineEnding, boolean finalNewline) {
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

  private static String stripTrailingComment(String line) {
    if(line == null) {
      return null;
    }
    int idx = commentStart(line);
    if(idx < 0) {
      return line;
    }
    return line.substring(0, idx);
  }

  private static int commentStart(String line) {
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

  public static final class RewriteOutput {
    public int scannedFiles;
    public int rewrittenFiles;
    public int rewrittenLineCount;
  }

  private static final class RewriteFileResult {
    boolean changed;
    String relativePath;
    List<PlanItem> planItems = new ArrayList<PlanItem>();
    FileDiff diff;
    byte[] newBytes;
  }

  private static final class PlanItem {
    int line;
    String original;
    String rewriteType;
  }

  private static final class FileDiff {
    String relativePath;
    List<LineDiff> lines = new ArrayList<LineDiff>();
  }

  private static final class LineDiff {
    int line;
    String before;
    String after;

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
