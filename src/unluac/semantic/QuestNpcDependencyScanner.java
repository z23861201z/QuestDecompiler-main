package unluac.semantic;

import java.nio.charset.Charset;
import java.nio.charset.CharacterCodingException;
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
import java.util.TreeSet;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class QuestNpcDependencyScanner {

  private static final Pattern QT_PATTERN = Pattern.compile("\\bqt\\s*\\[\\s*(\\d+)\\s*\\]");
  private static final Pattern QDATA_PATTERN = Pattern.compile("\\bqData\\s*\\[\\s*(\\d+)\\s*\\]");
  private static final Pattern SET_QUEST_STATE_PATTERN = Pattern.compile("\\bSET_QUEST_STATE\\s*\\(\\s*(\\d+)\\s*,");
  private static final Pattern GOAL_GET_ITEM_PATTERN = Pattern.compile("^\\s*\\.\\s*goal\\s*\\.\\s*getItem\\s*\\[\\s*(\\d+)\\s*\\]");
  private static final Pattern GOAL_KILL_MONSTER_PATTERN = Pattern.compile("^\\s*\\.\\s*goal\\s*\\.\\s*killMonster\\s*\\[\\s*(\\d+)\\s*\\]");
  private static final Pattern NEED_LEVEL_PATTERN = Pattern.compile("^\\s*\\.\\s*needLevel\\b");
  private static final Pattern REWARD_PATTERN = Pattern.compile("^\\s*\\.\\s*reward\\b");

  private static final Charset UTF8 = Charset.forName("UTF-8");
  private static final List<Charset> READ_CHARSETS = buildReadCharsets();

  public static void main(String[] args) throws Exception {
    if(args.length < 1) {
      printUsage();
      return;
    }

    Path npcLuaDirectory = Paths.get(args[0]);
    Path outputJson = args.length >= 2
        ? Paths.get(args[1])
        : Paths.get("reports", "quest_npc_dependency_index.json");

    DependencyIndex index = scanDirectory(npcLuaDirectory);
    writeIndex(index, outputJson);

    System.out.println("input_dir=" + npcLuaDirectory.toAbsolutePath());
    System.out.println("output_json=" + outputJson.toAbsolutePath());
    System.out.println("scanned_files=" + index.scannedFileCount);
    System.out.println("quest_count=" + index.quests.size());
  }

  public static DependencyIndex scanDirectory(Path npcLuaDirectory) throws Exception {
    DependencyIndex index = new DependencyIndex();
    index.sourceDirectory = npcLuaDirectory == null ? "" : npcLuaDirectory.toAbsolutePath().toString();
    index.generatedAt = OffsetDateTime.now().format(DateTimeFormatter.ISO_OFFSET_DATE_TIME);

    if(npcLuaDirectory == null || !Files.exists(npcLuaDirectory) || !Files.isDirectory(npcLuaDirectory)) {
      return index;
    }

    List<Path> files = new ArrayList<Path>();
    Files.walk(npcLuaDirectory)
        .filter(Files::isRegularFile)
        .filter(path -> {
          String name = path.getFileName().toString().toLowerCase(Locale.ROOT);
          return name.startsWith("npc_") && name.endsWith(".lua");
        })
        .forEach(files::add);
    Collections.sort(files);
    index.scannedFileCount = files.size();

    Map<Integer, QuestDependencyRecord> byQuest = new LinkedHashMap<Integer, QuestDependencyRecord>();
    for(Path file : files) {
      scanSingleFile(file, byQuest);
    }

    List<Integer> questIds = new ArrayList<Integer>(byQuest.keySet());
    Collections.sort(questIds);
    for(Integer questId : questIds) {
      QuestDependencyRecord record = byQuest.get(questId);
      if(record == null) {
        continue;
      }
      for(NpcReference ref : record.npcFiles) {
        finalizeReferenceRisk(ref);
      }
      Collections.sort(record.npcFiles, (a, b) -> a.file.compareToIgnoreCase(b.file));
      index.quests.put(Integer.toString(questId.intValue()), record);
    }

    return index;
  }

  public static void writeIndex(DependencyIndex index, Path outputJson) throws Exception {
    Path parent = outputJson.getParent();
    if(parent != null && !Files.exists(parent)) {
      Files.createDirectories(parent);
    }
    Files.write(outputJson, index.toJson().getBytes(UTF8));
  }

  private static void scanSingleFile(Path file, Map<Integer, QuestDependencyRecord> byQuest) throws Exception {
    List<String> lines = readAllLines(file);
    String fileName = file.getFileName().toString();

    Map<Integer, NpcReferenceBuilder> builders = new LinkedHashMap<Integer, NpcReferenceBuilder>();
    for(int i = 0; i < lines.size(); i++) {
      int lineNumber = i + 1;
      String line = stripComment(lines.get(i));
      if(line == null || line.trim().isEmpty()) {
        continue;
      }

      boolean isBranch = isBranchLine(line);
      scanQt(line, lineNumber, isBranch, fileName, builders);
      scanQData(line, lineNumber, isBranch, fileName, builders);
      scanSetQuestState(line, lineNumber, isBranch, fileName, builders);
    }

    for(NpcReferenceBuilder builder : builders.values()) {
      QuestDependencyRecord record = byQuest.get(Integer.valueOf(builder.questId));
      if(record == null) {
        record = new QuestDependencyRecord();
        byQuest.put(Integer.valueOf(builder.questId), record);
      }
      record.npcFiles.add(builder.build());
    }
  }

  private static void scanQt(String line,
                             int lineNumber,
                             boolean isBranch,
                             String fileName,
                             Map<Integer, NpcReferenceBuilder> builders) {
    Matcher matcher = QT_PATTERN.matcher(line);
    while(matcher.find()) {
      int questId = parseIntSafe(matcher.group(1));
      if(questId < 0) {
        continue;
      }

      NpcReferenceBuilder builder = getBuilder(builders, questId, fileName);
      builder.lines.add(Integer.valueOf(lineNumber));
      builder.qtReferenced = true;
      builder.directIndex = true;
      if(isBranch) {
        builder.branchLines.add(Integer.valueOf(lineNumber));
      }

      String suffix = line.substring(matcher.end());

      Matcher getItemMatcher = GOAL_GET_ITEM_PATTERN.matcher(suffix);
      if(getItemMatcher.find()) {
        int index = parseIntSafe(getItemMatcher.group(1));
        AccessEntry access = new AccessEntry();
        access.type = "goal.getItem";
        access.index = index;
        access.hardcodedIndex = index > 0;
        access.line = lineNumber;
        builder.accesses.add(access);
      }

      Matcher killMatcher = GOAL_KILL_MONSTER_PATTERN.matcher(suffix);
      if(killMatcher.find()) {
        int index = parseIntSafe(killMatcher.group(1));
        AccessEntry access = new AccessEntry();
        access.type = "goal.killMonster";
        access.index = index;
        access.hardcodedIndex = index > 0;
        access.line = lineNumber;
        builder.accesses.add(access);
      }

      if(REWARD_PATTERN.matcher(suffix).find()) {
        AccessEntry access = new AccessEntry();
        access.type = "reward";
        access.index = -1;
        access.hardcodedIndex = false;
        access.line = lineNumber;
        builder.accesses.add(access);
      }

      if(NEED_LEVEL_PATTERN.matcher(suffix).find()) {
        AccessEntry access = new AccessEntry();
        access.type = "needLevel";
        access.index = -1;
        access.hardcodedIndex = false;
        access.line = lineNumber;
        builder.accesses.add(access);
      }

      if(builder.accesses.isEmpty() || !hasLineAccess(builder.accesses, lineNumber)) {
        AccessEntry access = new AccessEntry();
        access.type = "directIndex";
        access.index = -1;
        access.hardcodedIndex = false;
        access.line = lineNumber;
        builder.accesses.add(access);
      }
    }
  }

  private static void scanQData(String line,
                                int lineNumber,
                                boolean isBranch,
                                String fileName,
                                Map<Integer, NpcReferenceBuilder> builders) {
    Matcher matcher = QDATA_PATTERN.matcher(line);
    while(matcher.find()) {
      int questId = parseIntSafe(matcher.group(1));
      if(questId < 0) {
        continue;
      }
      NpcReferenceBuilder builder = getBuilder(builders, questId, fileName);
      builder.lines.add(Integer.valueOf(lineNumber));
      builder.qDataReferenced = true;
      builder.directIndex = true;
      if(isBranch) {
        builder.branchLines.add(Integer.valueOf(lineNumber));
      }
      AccessEntry access = new AccessEntry();
      access.type = "qData";
      access.index = -1;
      access.hardcodedIndex = false;
      access.line = lineNumber;
      builder.accesses.add(access);
    }
  }

  private static void scanSetQuestState(String line,
                                        int lineNumber,
                                        boolean isBranch,
                                        String fileName,
                                        Map<Integer, NpcReferenceBuilder> builders) {
    Matcher matcher = SET_QUEST_STATE_PATTERN.matcher(line);
    while(matcher.find()) {
      int questId = parseIntSafe(matcher.group(1));
      if(questId < 0) {
        continue;
      }
      NpcReferenceBuilder builder = getBuilder(builders, questId, fileName);
      builder.lines.add(Integer.valueOf(lineNumber));
      builder.setQuestStateReferenced = true;
      if(isBranch) {
        builder.branchLines.add(Integer.valueOf(lineNumber));
      }
      AccessEntry access = new AccessEntry();
      access.type = "SET_QUEST_STATE";
      access.index = -1;
      access.hardcodedIndex = false;
      access.line = lineNumber;
      builder.accesses.add(access);
    }
  }

  private static NpcReferenceBuilder getBuilder(Map<Integer, NpcReferenceBuilder> builders, int questId, String fileName) {
    NpcReferenceBuilder builder = builders.get(Integer.valueOf(questId));
    if(builder == null) {
      builder = new NpcReferenceBuilder();
      builder.questId = questId;
      builder.file = fileName;
      builders.put(Integer.valueOf(questId), builder);
    }
    return builder;
  }

  private static boolean hasLineAccess(List<AccessEntry> accesses, int line) {
    for(AccessEntry access : accesses) {
      if(access != null && access.line == line) {
        return true;
      }
    }
    return false;
  }

  private static void finalizeReferenceRisk(NpcReference ref) {
    boolean hasHardcodedIndex = false;
    for(AccessEntry access : ref.access) {
      if(access != null && access.hardcodedIndex) {
        hasHardcodedIndex = true;
        break;
      }
    }

    boolean multiBranch = ref.branchLines.size() >= 2;
    boolean onlySetQuestState = ref.access.size() > 0;
    for(AccessEntry access : ref.access) {
      if(access == null) {
        continue;
      }
      if(!"SET_QUEST_STATE".equals(access.type)) {
        onlySetQuestState = false;
        break;
      }
    }

    if(hasHardcodedIndex || multiBranch) {
      ref.riskLevel = "HIGH";
      return;
    }
    if(onlySetQuestState) {
      ref.riskLevel = "LOW";
      return;
    }
    ref.riskLevel = "MEDIUM";
  }

  private static int parseIntSafe(String text) {
    if(text == null) {
      return -1;
    }
    try {
      return Integer.parseInt(text.trim());
    } catch(Exception ex) {
      return -1;
    }
  }

  private static boolean isBranchLine(String line) {
    String t = line == null ? "" : line.trim().toLowerCase(Locale.ROOT);
    return t.startsWith("if ") || t.startsWith("elseif ") || t.startsWith("for ") || t.startsWith("while ");
  }

  private static String stripComment(String line) {
    if(line == null || line.isEmpty()) {
      return line;
    }
    boolean inSingle = false;
    boolean inDouble = false;
    boolean escape = false;
    for(int i = 0; i < line.length() - 1; i++) {
      char c = line.charAt(i);
      char n = line.charAt(i + 1);
      if(escape) {
        escape = false;
        continue;
      }
      if((inSingle || inDouble) && c == '\\') {
        escape = true;
        continue;
      }
      if(!inDouble && c == '\'') {
        inSingle = !inSingle;
        continue;
      }
      if(!inSingle && c == '"') {
        inDouble = !inDouble;
        continue;
      }
      if(!inSingle && !inDouble && c == '-' && n == '-') {
        return line.substring(0, i);
      }
    }
    return line;
  }

  private static List<String> readAllLines(Path file) throws Exception {
    Exception last = null;
    for(Charset cs : READ_CHARSETS) {
      try {
        return Files.readAllLines(file, cs);
      } catch(CharacterCodingException ex) {
        last = ex;
      }
    }
    if(last != null) {
      throw last;
    }
    return Files.readAllLines(file, UTF8);
  }

  private static List<Charset> buildReadCharsets() {
    List<Charset> out = new ArrayList<Charset>();
    out.add(Charset.forName("UTF-8"));
    out.add(Charset.forName("GBK"));
    out.add(Charset.forName("UTF-16LE"));
    out.add(Charset.forName("UTF-16"));
    return Collections.unmodifiableList(out);
  }

  private static String escapeJson(String text) {
    if(text == null) {
      return "";
    }
    return text
        .replace("\\", "\\\\")
        .replace("\"", "\\\"")
        .replace("\r", "\\r")
        .replace("\n", "\\n");
  }

  private static String toJsonIntArray(List<Integer> values) {
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

  private static void printUsage() {
    System.out.println("Usage:");
    System.out.println("  java -cp build unluac.semantic.QuestNpcDependencyScanner <npc-lua-dir> [output-json]");
  }

  public static final class DependencyIndex {
    public String sourceDirectory = "";
    public String generatedAt = "";
    public int scannedFileCount;
    public final Map<String, QuestDependencyRecord> quests = new LinkedHashMap<String, QuestDependencyRecord>();

    public String toJson() {
      StringBuilder sb = new StringBuilder();
      sb.append("{\n");
      sb.append("  \"_meta\": {\n");
      sb.append("    \"sourceDirectory\": \"").append(escapeJson(sourceDirectory)).append("\",\n");
      sb.append("    \"generatedAt\": \"").append(escapeJson(generatedAt)).append("\",\n");
      sb.append("    \"scannedFileCount\": ").append(scannedFileCount).append("\n");
      sb.append("  }");

      for(Map.Entry<String, QuestDependencyRecord> entry : quests.entrySet()) {
        sb.append(",\n");
        sb.append("  \"").append(escapeJson(entry.getKey())).append("\": ");
        sb.append(entry.getValue().toJson("  "));
      }

      sb.append("\n}\n");
      return sb.toString();
    }
  }

  public static final class QuestDependencyRecord {
    public final List<NpcReference> npcFiles = new ArrayList<NpcReference>();

    public String toJson(String indent) {
      String next = indent + "  ";
      StringBuilder sb = new StringBuilder();
      sb.append("{\n");
      sb.append(next).append("\"npcFiles\": [\n");
      for(int i = 0; i < npcFiles.size(); i++) {
        if(i > 0) {
          sb.append(",\n");
        }
        sb.append(npcFiles.get(i).toJson(next + "  "));
      }
      sb.append("\n").append(next).append("]\n");
      sb.append(indent).append("}");
      return sb.toString();
    }
  }

  public static final class NpcReference {
    public String file = "";
    public final List<Integer> lines = new ArrayList<Integer>();
    public final List<Integer> branchLines = new ArrayList<Integer>();
    public final List<AccessEntry> access = new ArrayList<AccessEntry>();
    public String riskLevel = "MEDIUM";

    public String toJson(String indent) {
      String next = indent + "  ";
      StringBuilder sb = new StringBuilder();
      sb.append(indent).append("{\n");
      sb.append(next).append("\"file\": \"").append(escapeJson(file)).append("\",\n");
      sb.append(next).append("\"lines\": ").append(toJsonIntArray(lines)).append(",\n");
      sb.append(next).append("\"access\": [\n");
      for(int i = 0; i < access.size(); i++) {
        if(i > 0) {
          sb.append(",\n");
        }
        sb.append(access.get(i).toJson(next + "  "));
      }
      sb.append("\n").append(next).append("],\n");
      sb.append(next).append("\"riskLevel\": \"").append(escapeJson(riskLevel)).append("\"\n");
      sb.append(indent).append("}");
      return sb.toString();
    }
  }

  public static final class AccessEntry {
    public String type = "";
    public int index = -1;
    public boolean hardcodedIndex;
    public int line;

    public String toJson(String indent) {
      String next = indent + "  ";
      StringBuilder sb = new StringBuilder();
      sb.append(indent).append("{\n");
      sb.append(next).append("\"type\": \"").append(escapeJson(type)).append("\",\n");
      sb.append(next).append("\"index\": ").append(index).append(",\n");
      sb.append(next).append("\"hardcodedIndex\": ").append(hardcodedIndex).append(",\n");
      sb.append(next).append("\"line\": ").append(line).append("\n");
      sb.append(indent).append("}");
      return sb.toString();
    }
  }

  private static final class NpcReferenceBuilder {
    int questId;
    String file;
    final Set<Integer> lines = new TreeSet<Integer>();
    final Set<Integer> branchLines = new TreeSet<Integer>();
    final List<AccessEntry> accesses = new ArrayList<AccessEntry>();

    boolean qtReferenced;
    boolean qDataReferenced;
    boolean setQuestStateReferenced;
    boolean directIndex;

    NpcReference build() {
      NpcReference ref = new NpcReference();
      ref.file = file == null ? "" : file;
      ref.lines.addAll(lines);
      ref.branchLines.addAll(branchLines);
      ref.access.addAll(accesses);
      return ref;
    }
  }
}
