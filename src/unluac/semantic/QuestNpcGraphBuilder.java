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
import java.util.Comparator;
import java.util.LinkedHashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import unluac.chunk.Lua50ChunkParser;
import unluac.chunk.LuaChunk;

public class QuestNpcGraphBuilder {

  private static final Charset UTF8 = Charset.forName("UTF-8");

  private static final Pattern NPC_FILE_PATTERN = Pattern.compile("(?i)^npc_(\\d+)\\.(lua|luc)$");
  private static final Pattern QDATA_STATE_PATTERN = Pattern.compile("qData\\s*\\[\\s*(\\d+)\\s*\\]\\s*\\.\\s*state\\b", Pattern.CASE_INSENSITIVE);
  private static final Pattern QT_GOAL_PATTERN = Pattern.compile("qt\\s*\\[\\s*(\\d+)\\s*\\]\\s*\\.\\s*goal\\b", Pattern.CASE_INSENSITIVE);
  private static final Pattern SET_QUEST_STATE_PATTERN = Pattern.compile("SET_QUEST_STATE\\s*\\(\\s*(\\d+)\\s*,\\s*(\\d+)\\s*\\)", Pattern.CASE_INSENSITIVE);
  private static final Pattern GET_REWARD_CALL_PATTERN = Pattern.compile("\\b(?:get_?reward\\w*)\\s*\\(", Pattern.CASE_INSENSITIVE);
  private static final Pattern CHECK_ITEM_WITH_QUEST_PATTERN = Pattern.compile(
      "CHECK_ITEM_CNT\\s*\\(\\s*qt\\s*\\[\\s*(\\d+)\\s*\\]\\s*\\.\\s*goal", Pattern.CASE_INSENSITIVE);
  private static final Pattern CHECK_ITEM_CALL_PATTERN = Pattern.compile("\\bCHECK_ITEM_CNT\\s*\\(", Pattern.CASE_INSENSITIVE);
  private static final Pattern QUEST_REF_PATTERN = Pattern.compile("(?:qt|qData)\\s*\\[\\s*(\\d+)\\s*\\]", Pattern.CASE_INSENSITIVE);

  private static final Pattern EXACT_STATE_PATTERN_TEMPLATE = Pattern.compile("qData\\s*\\[\\s*%d\\s*\\]\\s*\\.\\s*state\\s*==\\s*(\\d+)", Pattern.CASE_INSENSITIVE);

  public static void main(String[] args) throws Exception {
    if(args.length < 3) {
      printUsage();
      return;
    }

    Path npcPath = Paths.get(args[0]);
    Path questLuc = Paths.get(args[1]);
    Path outputJson = Paths.get(args[2]);

    QuestNpcGraphBuilder builder = new QuestNpcGraphBuilder();
    BuildResult result = builder.build(npcPath, questLuc, outputJson);

    System.out.println("scanned_files=" + result.scannedFiles);
    System.out.println("linked_quest_count=" + result.linkedQuestCount);
    System.out.println("orphan_npc_count=" + result.orphanNpcCount);
    System.out.println("multi_npc_quest_count=" + result.multiNpcQuestCount);
    System.out.println("output=" + outputJson.toAbsolutePath());
  }

  public BuildResult build(Path npcPath, Path questLuc, Path outputJson) throws Exception {
    if(npcPath == null || !Files.exists(npcPath) || !Files.isDirectory(npcPath)) {
      throw new IllegalStateException("npc path not found: " + npcPath);
    }
    if(questLuc == null || !Files.exists(questLuc) || !Files.isRegularFile(questLuc)) {
      throw new IllegalStateException("quest luc not found: " + questLuc);
    }

    Map<Integer, String> questNameById = loadQuestNames(questLuc);
    List<Path> npcLuaFiles = listNpcLuaFiles(npcPath);

    GraphOutput graph = new GraphOutput();
    graph.generatedAt = OffsetDateTime.now().format(DateTimeFormatter.ISO_OFFSET_DATE_TIME);
    graph.totalNpcFiles = npcLuaFiles.size();

    NpcSemanticExtractor npcSemanticExtractor = new NpcSemanticExtractor();
    int orphanCount = 0;

    for(Path npcLuaFile : npcLuaFiles) {
      FileGraphResult fileResult = scanSingleNpcFile(npcPath, npcLuaFile, npcSemanticExtractor);
      if(fileResult.questIds.isEmpty()) {
        orphanCount++;
        continue;
      }

      for(Integer questId : fileResult.questIds) {
        if(questId == null || questId.intValue() <= 0) {
          continue;
        }
        int qid = questId.intValue();
        QuestNode node = graph.ensureQuest(qid);
        if(node.questName == null || node.questName.isEmpty()) {
          String questName = questNameById.get(Integer.valueOf(qid));
          node.questName = questName == null ? "" : questName;
        }

        MutableNpcRelation relation = fileResult.relationByQuest.get(Integer.valueOf(qid));
        if(relation == null) {
          relation = new MutableNpcRelation(fileResult.npcId, npcLuaFile.getFileName().toString());
        }
        node.addOrMerge(relation.toFinal());
      }
    }

    graph.sort();

    int multiNpcQuestCount = 0;
    for(QuestNode quest : graph.quests.values()) {
      if(quest.npcRelations.size() > 1) {
        multiNpcQuestCount++;
      }
    }

    graph.totalQuestCount = graph.quests.size();

    if(outputJson.getParent() != null && !Files.exists(outputJson.getParent())) {
      Files.createDirectories(outputJson.getParent());
    }
    Files.write(outputJson, graph.toJson().getBytes(UTF8));

    BuildResult result = new BuildResult();
    result.scannedFiles = npcLuaFiles.size();
    result.linkedQuestCount = graph.quests.size();
    result.orphanNpcCount = orphanCount;
    result.multiNpcQuestCount = multiNpcQuestCount;
    return result;
  }

  private FileGraphResult scanSingleNpcFile(Path npcRoot,
                                            Path npcLuaFile,
                                            NpcSemanticExtractor npcSemanticExtractor) throws Exception {
    FileGraphResult result = new FileGraphResult();
    result.npcId = parseNpcId(npcLuaFile.getFileName().toString());
    result.file = npcLuaFile.getFileName().toString();

    List<String> lines = readAllLines(npcLuaFile);
    Set<Integer> fileQuestIds = new LinkedHashSet<Integer>();
    int lastContextQuestId = 0;

    for(int i = 0; i < lines.size(); i++) {
      String rawLine = lines.get(i);
      String code = stripComment(rawLine);
      if(code == null || code.trim().isEmpty()) {
        continue;
      }

      Set<Integer> lineQuestIds = extractQuestIds(code);
      if(!lineQuestIds.isEmpty()) {
        lastContextQuestId = lineQuestIds.iterator().next().intValue();
      }
      fileQuestIds.addAll(lineQuestIds);

      Matcher stateMatcher = QDATA_STATE_PATTERN.matcher(code);
      while(stateMatcher.find()) {
        int questId = parsePositiveInt(stateMatcher.group(1));
        if(questId <= 0) {
          continue;
        }
        fileQuestIds.add(Integer.valueOf(questId));
        MutableNpcRelation rel = result.ensureRelation(questId, result.npcId, result.file);
        rel.addRole("STATE_CHECK");
      }

      Matcher goalMatcher = QT_GOAL_PATTERN.matcher(code);
      while(goalMatcher.find()) {
        int questId = parsePositiveInt(goalMatcher.group(1));
        if(questId <= 0) {
          continue;
        }
        fileQuestIds.add(Integer.valueOf(questId));
        MutableNpcRelation rel = result.ensureRelation(questId, result.npcId, result.file);
        rel.addRole("GOAL_VERIFY");
        rel.readsGoal = true;
      }

      Matcher checkItemMatcher = CHECK_ITEM_WITH_QUEST_PATTERN.matcher(code);
      while(checkItemMatcher.find()) {
        int questId = parsePositiveInt(checkItemMatcher.group(1));
        if(questId <= 0) {
          continue;
        }
        fileQuestIds.add(Integer.valueOf(questId));
        MutableNpcRelation rel = result.ensureRelation(questId, result.npcId, result.file);
        rel.addRole("GOAL_VERIFY");
        rel.readsGoal = true;
      }

      Matcher checkItemCall = CHECK_ITEM_CALL_PATTERN.matcher(code);
      if(checkItemCall.find()) {
        Set<Integer> checkQuests = new LinkedHashSet<Integer>();
        checkQuests.addAll(lineQuestIds);
        if(checkQuests.isEmpty() && lastContextQuestId > 0) {
          checkQuests.add(Integer.valueOf(lastContextQuestId));
        }
        if(checkQuests.isEmpty() && fileQuestIds.size() == 1) {
          checkQuests.add(fileQuestIds.iterator().next());
        }
        for(Integer qidObj : checkQuests) {
          if(qidObj == null || qidObj.intValue() <= 0) {
            continue;
          }
          int questId = qidObj.intValue();
          fileQuestIds.add(Integer.valueOf(questId));
          MutableNpcRelation rel = result.ensureRelation(questId, result.npcId, result.file);
          rel.addRole("GOAL_VERIFY");
          rel.readsGoal = true;
        }
      }

      Matcher setStateMatcher = SET_QUEST_STATE_PATTERN.matcher(code);
      while(setStateMatcher.find()) {
        int questId = parsePositiveInt(setStateMatcher.group(1));
        int toState = parseIntSafe(setStateMatcher.group(2));
        if(questId <= 0) {
          continue;
        }
        fileQuestIds.add(Integer.valueOf(questId));
        MutableNpcRelation rel = result.ensureRelation(questId, result.npcId, result.file);
        rel.addRole("STATE_ADVANCE");
        rel.writesState = true;

        int fromState = inferFromState(lines, i, questId);
        if(fromState >= 0 && toState >= 0) {
          rel.addTransition(fromState, toState);
        }
      }

      Matcher rewardMatcher = GET_REWARD_CALL_PATTERN.matcher(code);
      if(rewardMatcher.find()) {
        Set<Integer> rewardQuestIds = new LinkedHashSet<Integer>();
        rewardQuestIds.addAll(lineQuestIds);
        if(rewardQuestIds.isEmpty() && lastContextQuestId > 0) {
          rewardQuestIds.add(Integer.valueOf(lastContextQuestId));
        }
        if(rewardQuestIds.isEmpty() && fileQuestIds.size() == 1) {
          rewardQuestIds.add(fileQuestIds.iterator().next());
        }

        for(Integer qidObj : rewardQuestIds) {
          if(qidObj == null || qidObj.intValue() <= 0) {
            continue;
          }
          int questId = qidObj.intValue();
          fileQuestIds.add(Integer.valueOf(questId));
          MutableNpcRelation rel = result.ensureRelation(questId, result.npcId, result.file);
          rel.addRole("REWARD_TRIGGER");
          rel.callsReward = true;
        }
      }
    }

    NpcScriptModel npcModel = tryExtractNpcModelFromLuc(npcRoot, npcLuaFile, npcSemanticExtractor);
    if(npcModel != null) {
      if(result.npcId <= 0 && npcModel.npcId > 0) {
        result.npcId = npcModel.npcId;
      }
      for(Integer questId : npcModel.relatedQuestIds) {
        if(questId == null || questId.intValue() <= 0) {
          continue;
        }
        int qid = questId.intValue();
        fileQuestIds.add(Integer.valueOf(qid));
        result.ensureRelation(qid, result.npcId, result.file);
      }

      for(NpcScriptModel.DialogBranch branch : npcModel.branches) {
        if(branch == null || branch.questId <= 0) {
          continue;
        }
        int qid = branch.questId;
        fileQuestIds.add(Integer.valueOf(qid));
        MutableNpcRelation rel = result.ensureRelation(qid, result.npcId, result.file);
        if("SET_QUEST_STATE".equals(branch.action)) {
          rel.addRole("STATE_ADVANCE");
          rel.writesState = true;
          if(branch.stateValue >= 0) {
            int from = inferFromState(lines, 0, qid);
            if(from >= 0) {
              rel.addTransition(from, branch.stateValue);
            }
          }
        } else if("CHECK_ITEM_CNT".equals(branch.action)) {
          rel.addRole("GOAL_VERIFY");
          rel.readsGoal = true;
        }
      }
    }

    result.questIds.addAll(fileQuestIds);
    return result;
  }

  private NpcScriptModel tryExtractNpcModelFromLuc(Path npcRoot,
                                                   Path npcLuaFile,
                                                   NpcSemanticExtractor npcSemanticExtractor) {
    List<Path> candidates = resolveLucCandidates(npcRoot, npcLuaFile);
    for(Path candidate : candidates) {
      if(candidate == null || !Files.exists(candidate) || !Files.isRegularFile(candidate)) {
        continue;
      }
      try {
        return npcSemanticExtractor.extract(candidate);
      } catch(Exception ignored) {
      }
    }
    return null;
  }

  private List<Path> resolveLucCandidates(Path npcRoot, Path npcLuaFile) {
    List<Path> out = new ArrayList<Path>();
    String fileName = npcLuaFile.getFileName().toString();
    String lucName = fileName.replaceAll("(?i)\\.lua$", ".luc");

    out.add(npcLuaFile.getParent().resolve(lucName));

    if(npcLuaFile.getParent() != null && npcLuaFile.getParent().getParent() != null) {
      Path parent = npcLuaFile.getParent();
      if("npc-lua".equalsIgnoreCase(parent.getFileName().toString())) {
        out.add(parent.getParent().resolve(lucName));
      }
    }

    if(npcRoot != null) {
      out.add(npcRoot.resolve(lucName));
      if(npcRoot.getParent() != null) {
        out.add(npcRoot.getParent().resolve(lucName));
      }
    }

    List<Path> unique = new ArrayList<Path>();
    Set<String> seen = new LinkedHashSet<String>();
    for(Path p : out) {
      if(p == null) {
        continue;
      }
      String key = p.toAbsolutePath().normalize().toString();
      if(seen.add(key)) {
        unique.add(p);
      }
    }
    return unique;
  }

  private int inferFromState(List<String> lines, int lineIndex, int questId) {
    int start = Math.max(0, lineIndex - 8);
    Pattern exactPattern = Pattern.compile(
        String.format(Locale.ROOT, EXACT_STATE_PATTERN_TEMPLATE.pattern(), Integer.valueOf(questId)),
        Pattern.CASE_INSENSITIVE);

    for(int i = lineIndex; i >= start; i--) {
      String code = stripComment(lines.get(i));
      if(code == null) {
        continue;
      }
      Matcher matcher = exactPattern.matcher(code);
      if(matcher.find()) {
        return parseIntSafe(matcher.group(1));
      }
    }
    return -1;
  }

  private Map<Integer, String> loadQuestNames(Path questLuc) throws Exception {
    byte[] data = Files.readAllBytes(questLuc);
    LuaChunk chunk = new Lua50ChunkParser().parse(data);
    QuestSemanticExtractor extractor = new QuestSemanticExtractor();
    QuestSemanticExtractor.ExtractionResult extraction = extractor.extract(chunk);

    Map<Integer, String> out = new LinkedHashMap<Integer, String>();
    for(QuestSemanticModel model : extraction.quests) {
      if(model == null || model.questId <= 0) {
        continue;
      }
      out.put(Integer.valueOf(model.questId), model.title == null ? "" : model.title);
    }
    return out;
  }

  private List<Path> listNpcLuaFiles(Path npcPath) throws Exception {
    List<Path> out = new ArrayList<Path>();
    Files.walk(npcPath)
        .filter(Files::isRegularFile)
        .forEach(path -> {
          String name = path.getFileName().toString();
          Matcher matcher = NPC_FILE_PATTERN.matcher(name);
          if(!matcher.find()) {
            return;
          }
          String ext = matcher.group(2);
          if("lua".equalsIgnoreCase(ext)) {
            out.add(path);
          }
        });
    Collections.sort(out);
    return out;
  }

  private Set<Integer> extractQuestIds(String code) {
    Set<Integer> ids = new LinkedHashSet<Integer>();
    Matcher matcher = QUEST_REF_PATTERN.matcher(code);
    while(matcher.find()) {
      int id = parsePositiveInt(matcher.group(1));
      if(id > 0) {
        ids.add(Integer.valueOf(id));
      }
    }
    Matcher setState = SET_QUEST_STATE_PATTERN.matcher(code);
    while(setState.find()) {
      int id = parsePositiveInt(setState.group(1));
      if(id > 0) {
        ids.add(Integer.valueOf(id));
      }
    }
    return ids;
  }

  private int parseNpcId(String fileName) {
    if(fileName == null) {
      return 0;
    }
    Matcher matcher = NPC_FILE_PATTERN.matcher(fileName);
    if(!matcher.find()) {
      return 0;
    }
    return parsePositiveInt(matcher.group(1));
  }

  private int parsePositiveInt(String text) {
    int value = parseIntSafe(text);
    return value > 0 ? value : 0;
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

  private static void printUsage() {
    System.out.println("Usage:");
    System.out.println("  java -cp build unluac.semantic.QuestNpcGraphBuilder <npc-path> <quest.luc> <output.json>");
  }

  private List<String> readAllLines(Path file) throws Exception {
    byte[] bytes = Files.readAllBytes(file);
    return splitLines(decodeText(bytes));
  }

  private String decodeText(byte[] bytes) throws Exception {
    byte[] content = bytes;
    if(bytes.length >= 3
        && (bytes[0] & 0xFF) == 0xEF
        && (bytes[1] & 0xFF) == 0xBB
        && (bytes[2] & 0xFF) == 0xBF) {
      content = new byte[bytes.length - 3];
      System.arraycopy(bytes, 3, content, 0, content.length);
    }

    Charset[] candidates = new Charset[] {
        Charset.forName("UTF-8"),
        Charset.forName("GB18030"),
        Charset.forName("GBK"),
        Charset.forName("Big5")
    };

    for(Charset candidate : candidates) {
      try {
        CharsetDecoder decoder = candidate.newDecoder();
        decoder.onMalformedInput(CodingErrorAction.REPORT);
        decoder.onUnmappableCharacter(CodingErrorAction.REPORT);
        CharBuffer buffer = decoder.decode(ByteBuffer.wrap(content));
        return buffer.toString();
      } catch(CharacterCodingException ignored) {
      }
    }

    return new String(content, UTF8);
  }

  private List<String> splitLines(String text) {
    String normalized = text.replace("\r\n", "\n").replace('\r', '\n');
    String[] parts = normalized.split("\n", -1);
    List<String> out = new ArrayList<String>(parts.length);
    Collections.addAll(out, parts);
    if(!out.isEmpty() && out.get(out.size() - 1).isEmpty()) {
      out.remove(out.size() - 1);
    }
    return out;
  }

  private String stripComment(String line) {
    if(line == null) {
      return null;
    }
    int commentStart = findCommentStart(line);
    if(commentStart < 0) {
      return line;
    }
    return line.substring(0, commentStart);
  }

  private int findCommentStart(String line) {
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

  public static final class BuildResult {
    public int scannedFiles;
    public int linkedQuestCount;
    public int orphanNpcCount;
    public int multiNpcQuestCount;
  }

  private static final class FileGraphResult {
    int npcId;
    String file;
    final Set<Integer> questIds = new LinkedHashSet<Integer>();
    final Map<Integer, MutableNpcRelation> relationByQuest = new LinkedHashMap<Integer, MutableNpcRelation>();

    MutableNpcRelation ensureRelation(int questId, int npcId, String file) {
      MutableNpcRelation relation = relationByQuest.get(Integer.valueOf(questId));
      if(relation == null) {
        relation = new MutableNpcRelation(npcId, file);
        relationByQuest.put(Integer.valueOf(questId), relation);
      } else {
        if(relation.npcId <= 0 && npcId > 0) {
          relation.npcId = npcId;
        }
        if((relation.file == null || relation.file.isEmpty()) && file != null) {
          relation.file = file;
        }
      }
      return relation;
    }
  }

  private static final class GraphOutput {
    String generatedAt;
    int totalNpcFiles;
    int totalQuestCount;
    final Map<Integer, QuestNode> quests = new LinkedHashMap<Integer, QuestNode>();

    QuestNode ensureQuest(int questId) {
      QuestNode node = quests.get(Integer.valueOf(questId));
      if(node == null) {
        node = new QuestNode();
        node.questId = questId;
        quests.put(Integer.valueOf(questId), node);
      }
      return node;
    }

    void sort() {
      for(QuestNode node : quests.values()) {
        node.sort();
      }
    }

    String toJson() {
      StringBuilder sb = new StringBuilder();
      sb.append("{\n");
      sb.append("  \"generatedAt\": \"").append(escapeJson(generatedAt)).append("\",\n");
      sb.append("  \"totalNpcFiles\": ").append(totalNpcFiles).append(",\n");
      sb.append("  \"totalQuestCount\": ").append(totalQuestCount).append(",\n");
      sb.append("  \"quests\": {");

      List<Integer> questIds = new ArrayList<Integer>(quests.keySet());
      Collections.sort(questIds);
      if(!questIds.isEmpty()) {
        sb.append("\n");
      }

      for(int i = 0; i < questIds.size(); i++) {
        int questId = questIds.get(i).intValue();
        QuestNode node = quests.get(Integer.valueOf(questId));
        if(i > 0) {
          sb.append(",\n");
        }
        sb.append("    \"").append(questId).append("\": ");
        sb.append(node.toJson("    "));
      }

      if(!questIds.isEmpty()) {
        sb.append("\n");
      }
      sb.append("  }\n");
      sb.append("}\n");
      return sb.toString();
    }
  }

  private static final class QuestNode {
    int questId;
    String questName = "";
    final List<NpcRelation> npcRelations = new ArrayList<NpcRelation>();

    void addOrMerge(NpcRelation candidate) {
      for(NpcRelation existing : npcRelations) {
        if(existing.sameNpc(candidate)) {
          existing.merge(candidate);
          return;
        }
      }
      npcRelations.add(candidate);
    }

    void sort() {
      for(NpcRelation relation : npcRelations) {
        relation.sort();
      }
      Collections.sort(npcRelations, new Comparator<NpcRelation>() {
        @Override
        public int compare(NpcRelation a, NpcRelation b) {
          int c = Integer.compare(a.npcId, b.npcId);
          if(c != 0) {
            return c;
          }
          String af = a.file == null ? "" : a.file;
          String bf = b.file == null ? "" : b.file;
          return af.compareToIgnoreCase(bf);
        }
      });
    }

    String toJson(String indent) {
      String next = indent + "  ";
      StringBuilder sb = new StringBuilder();
      sb.append("{\n");
      sb.append(next).append("\"questId\": ").append(questId).append(",\n");
      sb.append(next).append("\"questName\": \"").append(escapeJson(questName)).append("\",\n");
      sb.append(next).append("\"npcRelations\": [");
      if(!npcRelations.isEmpty()) {
        sb.append("\n");
      }

      for(int i = 0; i < npcRelations.size(); i++) {
        if(i > 0) {
          sb.append(",\n");
        }
        sb.append(npcRelations.get(i).toJson(next + "  "));
      }

      if(!npcRelations.isEmpty()) {
        sb.append("\n");
      }
      sb.append(next).append("]\n");
      sb.append(indent).append("}");
      return sb.toString();
    }
  }

  private static final class MutableNpcRelation {
    int npcId;
    String file;
    final Set<String> roles = new LinkedHashSet<String>();
    final Set<String> transitionKeys = new LinkedHashSet<String>();
    final List<StateTransition> transitions = new ArrayList<StateTransition>();
    boolean readsGoal;
    boolean writesState;
    boolean callsReward;

    MutableNpcRelation(int npcId, String file) {
      this.npcId = npcId;
      this.file = file;
    }

    void addRole(String role) {
      if(role != null && !role.isEmpty()) {
        roles.add(role);
      }
    }

    void addTransition(int from, int to) {
      if(from < 0 || to < 0) {
        return;
      }
      String key = from + "->" + to;
      if(!transitionKeys.add(key)) {
        return;
      }
      StateTransition transition = new StateTransition();
      transition.from = from;
      transition.to = to;
      transitions.add(transition);
    }

    NpcRelation toFinal() {
      NpcRelation relation = new NpcRelation();
      relation.npcId = npcId;
      relation.file = file == null ? "" : file;

      List<String> orderedRoles = new ArrayList<String>();
      if(roles.contains("STATE_CHECK")) {
        orderedRoles.add("STATE_CHECK");
      }
      if(roles.contains("GOAL_VERIFY")) {
        orderedRoles.add("GOAL_VERIFY");
      }
      if(roles.contains("STATE_ADVANCE")) {
        orderedRoles.add("STATE_ADVANCE");
      }
      if(roles.contains("REWARD_TRIGGER")) {
        orderedRoles.add("REWARD_TRIGGER");
      }
      relation.roles.addAll(orderedRoles);

      relation.stateTransitions.addAll(transitions);
      relation.readsGoal = readsGoal;
      relation.writesState = writesState;
      relation.callsReward = callsReward;
      relation.sort();
      return relation;
    }
  }

  private static final class NpcRelation {
    int npcId;
    String file;
    final List<String> roles = new ArrayList<String>();
    final List<StateTransition> stateTransitions = new ArrayList<StateTransition>();
    boolean readsGoal;
    boolean writesState;
    boolean callsReward;

    boolean sameNpc(NpcRelation other) {
      if(other == null) {
        return false;
      }
      if(this.npcId > 0 && other.npcId > 0) {
        return this.npcId == other.npcId;
      }
      return safe(this.file).equalsIgnoreCase(safe(other.file));
    }

    void merge(NpcRelation other) {
      if(other == null) {
        return;
      }
      if(this.npcId <= 0 && other.npcId > 0) {
        this.npcId = other.npcId;
      }
      if((this.file == null || this.file.isEmpty()) && other.file != null) {
        this.file = other.file;
      }
      for(String role : other.roles) {
        if(!this.roles.contains(role)) {
          this.roles.add(role);
        }
      }
      for(StateTransition transition : other.stateTransitions) {
        boolean exists = false;
        for(StateTransition current : this.stateTransitions) {
          if(current.from == transition.from && current.to == transition.to) {
            exists = true;
            break;
          }
        }
        if(!exists) {
          StateTransition copy = new StateTransition();
          copy.from = transition.from;
          copy.to = transition.to;
          this.stateTransitions.add(copy);
        }
      }
      this.readsGoal = this.readsGoal || other.readsGoal;
      this.writesState = this.writesState || other.writesState;
      this.callsReward = this.callsReward || other.callsReward;
      sort();
    }

    void sort() {
      Collections.sort(stateTransitions, new Comparator<StateTransition>() {
        @Override
        public int compare(StateTransition a, StateTransition b) {
          int c = Integer.compare(a.from, b.from);
          if(c != 0) {
            return c;
          }
          return Integer.compare(a.to, b.to);
        }
      });
    }

    String toJson(String indent) {
      String next = indent + "  ";
      StringBuilder sb = new StringBuilder();
      sb.append(indent).append("{\n");
      sb.append(next).append("\"npcId\": ").append(npcId).append(",\n");
      sb.append(next).append("\"file\": \"").append(escapeJson(file)).append("\",\n");
      sb.append(next).append("\"roles\": [");
      for(int i = 0; i < roles.size(); i++) {
        if(i > 0) {
          sb.append(", ");
        }
        sb.append("\"").append(escapeJson(roles.get(i))).append("\"");
      }
      sb.append("],\n");

      sb.append(next).append("\"stateTransitions\": [");
      if(!stateTransitions.isEmpty()) {
        sb.append("\n");
      }
      for(int i = 0; i < stateTransitions.size(); i++) {
        if(i > 0) {
          sb.append(",\n");
        }
        StateTransition t = stateTransitions.get(i);
        sb.append(next).append("  { \"from\": ").append(t.from)
            .append(", \"to\": ").append(t.to).append(" }");
      }
      if(!stateTransitions.isEmpty()) {
        sb.append("\n").append(next);
      }
      sb.append("],\n");

      sb.append(next).append("\"readsGoal\": ").append(readsGoal).append(",\n");
      sb.append(next).append("\"writesState\": ").append(writesState).append(",\n");
      sb.append(next).append("\"callsReward\": ").append(callsReward).append("\n");
      sb.append(indent).append("}");
      return sb.toString();
    }
  }

  private static final class StateTransition {
    int from;
    int to;
  }

  private static String safe(String text) {
    return text == null ? "" : text;
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
}
