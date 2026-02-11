package unluac.semantic;

import java.nio.charset.Charset;
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

public class Phase25QuestNpcDependencyMapper {

  private static final Charset UTF8 = Charset.forName("UTF-8");

  public static void main(String[] args) throws Exception {
    Path questInput = args.length >= 1
        ? Paths.get(args[0])
        : Paths.get("reports", "phase2_quest_data.json");
    Path npcInput = args.length >= 2
        ? Paths.get(args[1])
        : Paths.get("reports", "phase2_npc_reference_index.json");
    Path graphOutput = args.length >= 3
        ? Paths.get(args[2])
        : Paths.get("reports", "phase2_5_quest_npc_dependency_graph.json");
    Path summaryOutput = args.length >= 4
        ? Paths.get(args[3])
        : Paths.get("reports", "phase2_5_dependency_summary.json");

    long start = System.nanoTime();
    Phase25QuestNpcDependencyMapper mapper = new Phase25QuestNpcDependencyMapper();
    BuildResult result = mapper.build(questInput, npcInput, graphOutput, summaryOutput);
    long elapsedMillis = (System.nanoTime() - start) / 1_000_000L;

    System.out.println("buildMillis=" + elapsedMillis);
    System.out.println("totalQuestNodes=" + result.totalQuestNodes);
    System.out.println("totalNpcNodes=" + result.totalNpcNodes);
    System.out.println("edgeCount=" + result.edgeCount);
    System.out.println("unreferencedQuestIds=" + QuestSemanticJson.toJsonArrayInt(result.questsWithNoNpcReference));
    System.out.println("graphOutput=" + graphOutput.toAbsolutePath());
    System.out.println("summaryOutput=" + summaryOutput.toAbsolutePath());
  }

  public BuildResult build(Path questInput,
                           Path npcInput,
                           Path graphOutput,
                           Path summaryOutput) throws Exception {
    if(questInput == null || !Files.exists(questInput) || !Files.isRegularFile(questInput)) {
      throw new IllegalStateException("phase2 quest report not found: " + questInput);
    }
    if(npcInput == null || !Files.exists(npcInput) || !Files.isRegularFile(npcInput)) {
      throw new IllegalStateException("phase2 npc report not found: " + npcInput);
    }

    Map<String, Object> questRoot = readJsonObject(questInput, "phase2_quest_data");
    Map<String, Object> npcRoot = readJsonObject(npcInput, "phase2_npc_reference_index");

    LinkedHashMap<Integer, QuestAggregate> quests = new LinkedHashMap<Integer, QuestAggregate>();
    LinkedHashMap<String, NpcAggregate> npcs = new LinkedHashMap<String, NpcAggregate>();
    List<Edge> edges = new ArrayList<Edge>();
    LinkedHashSet<Integer> unresolvedQuestIds = new LinkedHashSet<Integer>();

    int phase2QuestCount = loadQuestAggregates(questRoot, quests);
    int phase2NpcCount = loadNpcAggregates(npcRoot, npcs, quests);
    int totalQuestReferencesDetected = intOf(npcRoot.get("totalQuestReferences"));

    @SuppressWarnings("unchecked")
    List<Object> nodeLocations = npcRoot.get("nodeLocations") instanceof List<?>
        ? (List<Object>) npcRoot.get("nodeLocations")
        : Collections.<Object>emptyList();

    for(Object item : nodeLocations) {
      if(!(item instanceof Map<?, ?>)) {
        continue;
      }
      @SuppressWarnings("unchecked")
      Map<String, Object> row = (Map<String, Object>) item;

      int questId = intOf(row.get("questId"));
      String npcFile = safe(row.get("npcFile"));
      String accessType = safe(row.get("accessType"));
      int index = intOf(row.get("index"));

      if(questId <= 0 || npcFile.isEmpty()) {
        continue;
      }

      QuestAggregate quest = quests.get(Integer.valueOf(questId));
      NpcAggregate npc = ensureNpcAggregate(npcs, npcFile);

      if(quest != null) {
        quest.referencedNpcFiles.add(npcFile);
        quest.totalReferenceCount++;
        quest.accessTypeCount.put(accessType, Integer.valueOf(quest.accessTypeCount.getOrDefault(accessType, Integer.valueOf(0)).intValue() + 1));
      } else {
        unresolvedQuestIds.add(Integer.valueOf(questId));
      }

      npc.referencedQuestIds.add(Integer.valueOf(questId));
      npc.totalReferenceCount++;
      npc.touchQuestAccessType(questId, accessType);
      if(index > 0) {
        npc.touchQuestAccessIndex(questId, accessType, index);
      }

      if("goal.getItem".equals(accessType)) {
        if(quest != null) {
          quest.goalGetItemAccessCount++;
        }
        npc.goalGetItemAccessCount++;
      } else if("goal.killMonster".equals(accessType)) {
        if(quest != null) {
          quest.goalKillMonsterAccessCount++;
        }
        npc.goalKillMonsterAccessCount++;
      } else if("goal.meetNpc".equals(accessType)) {
        if(quest != null) {
          quest.goalMeetNpcAccessCount++;
        }
        npc.goalMeetNpcAccessCount++;
      }

      Edge edge = new Edge();
      edge.from = npcFile;
      edge.to = "quest_" + questId;
      edge.accessType = normalizeAccessType(accessType);
      if(index > 0) {
        edge.indexUsed.add(Integer.valueOf(index));
      }
      edges.add(edge);
    }

    GraphReport graphReport = new GraphReport();
    graphReport.generatedAt = OffsetDateTime.now().format(DateTimeFormatter.ISO_OFFSET_DATE_TIME);
    graphReport.sourceQuestData = questInput.toAbsolutePath().toString();
    graphReport.sourceNpcReferenceIndex = npcInput.toAbsolutePath().toString();
    graphReport.totalQuestNodes = quests.size();
    graphReport.totalNpcNodes = npcs.size();
    graphReport.edgeCount = edges.size();
    graphReport.totalQuestReferencesDetected = totalQuestReferencesDetected;
    graphReport.unresolvedQuestIds.addAll(unresolvedQuestIds);

    appendQuestMappings(graphReport, quests);
    appendNpcMappings(graphReport, npcs);
    appendNodes(graphReport, quests, npcs);
    graphReport.edges.addAll(edges);

    SummaryReport summary = buildSummary(quests, npcs, graphReport);

    runSelfCheck(phase2QuestCount, phase2NpcCount, totalQuestReferencesDetected, graphReport);

    ensureParent(graphOutput);
    ensureParent(summaryOutput);
    Files.write(graphOutput, graphReport.toJson().getBytes(UTF8));
    Files.write(summaryOutput, summary.toJson().getBytes(UTF8));

    BuildResult result = new BuildResult();
    result.totalQuestNodes = graphReport.totalQuestNodes;
    result.totalNpcNodes = graphReport.totalNpcNodes;
    result.edgeCount = graphReport.edgeCount;
    result.questsWithNoNpcReference.addAll(summary.questsWithNoNpcReference);
    return result;
  }

  @SuppressWarnings("unchecked")
  private int loadQuestAggregates(Map<String, Object> questRoot,
                                  LinkedHashMap<Integer, QuestAggregate> quests) {
    Object questsObj = questRoot.get("quests");
    if(questsObj instanceof List<?>) {
      for(Object item : (List<Object>) questsObj) {
        if(!(item instanceof Map<?, ?>)) {
          continue;
        }
        Map<String, Object> row = (Map<String, Object>) item;
        int questId = intOf(row.get("questId"));
        if(questId <= 0) {
          continue;
        }
        QuestAggregate aggregate = ensureQuestAggregate(quests, questId);
        aggregate.name = safe(row.get("name"));
      }
    }

    int totalQuestCount = intOf(questRoot.get("totalQuestCount"));
    if(totalQuestCount <= 0) {
      totalQuestCount = quests.size();
    }
    return totalQuestCount;
  }

  @SuppressWarnings("unchecked")
  private int loadNpcAggregates(Map<String, Object> npcRoot,
                                LinkedHashMap<String, NpcAggregate> npcs,
                                LinkedHashMap<Integer, QuestAggregate> quests) {
    Object byNpcObj = npcRoot.get("byNpcFile");
    if(byNpcObj instanceof Map<?, ?>) {
      Map<String, Object> byNpc = (Map<String, Object>) byNpcObj;
      for(Map.Entry<String, Object> entry : byNpc.entrySet()) {
        String npcFile = safe(entry.getKey());
        if(npcFile.isEmpty()) {
          continue;
        }

        NpcAggregate npc = ensureNpcAggregate(npcs, npcFile);

        if(!(entry.getValue() instanceof Map<?, ?>)) {
          continue;
        }
        Map<String, Object> detail = (Map<String, Object>) entry.getValue();
        Object questIdsObj = detail.get("referencedQuestIds");
        if(questIdsObj instanceof List<?>) {
          for(Object questIdItem : (List<Object>) questIdsObj) {
            int questId = intOf(questIdItem);
            if(questId <= 0) {
              continue;
            }
            npc.referencedQuestIds.add(Integer.valueOf(questId));
          }
        }
      }
    }

    int totalNpcCount = intOf(npcRoot.get("totalNpcFiles"));
    if(totalNpcCount <= 0) {
      totalNpcCount = npcs.size();
    }
    return totalNpcCount;
  }

  private SummaryReport buildSummary(LinkedHashMap<Integer, QuestAggregate> quests,
                                     LinkedHashMap<String, NpcAggregate> npcs,
                                     GraphReport graphReport) {
    SummaryReport summary = new SummaryReport();
    summary.generatedAt = OffsetDateTime.now().format(DateTimeFormatter.ISO_OFFSET_DATE_TIME);
    summary.totalQuests = quests.size();
    summary.totalNpcFiles = npcs.size();
    summary.totalQuestNodes = graphReport.totalQuestNodes;
    summary.totalNpcNodes = graphReport.totalNpcNodes;
    summary.edgeCount = graphReport.edgeCount;
    summary.totalQuestReferencesDetected = graphReport.totalQuestReferencesDetected;

    List<Integer> questIds = new ArrayList<Integer>(quests.keySet());
    Collections.sort(questIds);
    for(Integer questId : questIds) {
      QuestAggregate quest = quests.get(questId);
      if(quest == null || !quest.referencedNpcFiles.isEmpty()) {
        continue;
      }
      summary.questsWithNoNpcReference.add(Integer.valueOf(quest.questId));
    }

    List<String> npcFiles = new ArrayList<String>(npcs.keySet());
    Collections.sort(npcFiles, String.CASE_INSENSITIVE_ORDER);
    for(String npcFile : npcFiles) {
      NpcAggregate npc = npcs.get(npcFile);
      if(npc == null || !npc.referencedQuestIds.isEmpty()) {
        continue;
      }
      summary.npcFilesWithNoQuestReference.add(npcFile);
    }

    List<QuestAggregate> questRanking = new ArrayList<QuestAggregate>(quests.values());
    questRanking.sort((left, right) -> {
      int cmp = Integer.compare(right.referencedNpcFiles.size(), left.referencedNpcFiles.size());
      if(cmp != 0) {
        return cmp;
      }
      cmp = Integer.compare(right.totalReferenceCount, left.totalReferenceCount);
      if(cmp != 0) {
        return cmp;
      }
      return Integer.compare(left.questId, right.questId);
    });
    int questTop = Math.min(20, questRanking.size());
    for(int i = 0; i < questTop; i++) {
      summary.topReferencedQuests.add(TopQuest.from(questRanking.get(i)));
    }

    List<NpcAggregate> npcRanking = new ArrayList<NpcAggregate>(npcs.values());
    npcRanking.sort((left, right) -> {
      int cmp = Integer.compare(right.totalReferenceCount, left.totalReferenceCount);
      if(cmp != 0) {
        return cmp;
      }
      cmp = Integer.compare(right.referencedQuestIds.size(), left.referencedQuestIds.size());
      if(cmp != 0) {
        return cmp;
      }
      return String.CASE_INSENSITIVE_ORDER.compare(left.npcFile, right.npcFile);
    });
    int npcTop = Math.min(20, npcRanking.size());
    for(int i = 0; i < npcTop; i++) {
      summary.topHeavyNpcFiles.add(TopNpc.from(npcRanking.get(i)));
    }

    return summary;
  }

  private void runSelfCheck(int phase2QuestCount,
                            int phase2NpcCount,
                            int totalQuestReferencesDetected,
                            GraphReport graphReport) {
    if(graphReport.totalQuestNodes != phase2QuestCount) {
      throw new IllegalStateException("self-check failed: totalQuestNodes=" + graphReport.totalQuestNodes
          + " != phase2QuestCount=" + phase2QuestCount);
    }
    if(graphReport.totalNpcNodes != phase2NpcCount) {
      throw new IllegalStateException("self-check failed: totalNpcNodes=" + graphReport.totalNpcNodes
          + " != phase2NpcCount=" + phase2NpcCount);
    }
    if(graphReport.edgeCount < totalQuestReferencesDetected) {
      throw new IllegalStateException("self-check failed: edgeCount=" + graphReport.edgeCount
          + " < totalQuestReferencesDetected=" + totalQuestReferencesDetected);
    }
  }

  private void appendQuestMappings(GraphReport graphReport,
                                   LinkedHashMap<Integer, QuestAggregate> quests) {
    List<Integer> questIds = new ArrayList<Integer>(quests.keySet());
    Collections.sort(questIds);
    for(Integer questId : questIds) {
      QuestAggregate quest = quests.get(questId);
      if(quest == null) {
        continue;
      }
      graphReport.questMappings.put(Integer.toString(quest.questId), quest);
    }
  }

  private void appendNpcMappings(GraphReport graphReport,
                                 LinkedHashMap<String, NpcAggregate> npcs) {
    List<String> files = new ArrayList<String>(npcs.keySet());
    Collections.sort(files, String.CASE_INSENSITIVE_ORDER);
    for(String file : files) {
      NpcAggregate npc = npcs.get(file);
      if(npc == null) {
        continue;
      }
      graphReport.npcMappings.put(file, npc);
    }
  }

  private void appendNodes(GraphReport graphReport,
                           LinkedHashMap<Integer, QuestAggregate> quests,
                           LinkedHashMap<String, NpcAggregate> npcs) {
    List<Integer> questIds = new ArrayList<Integer>(quests.keySet());
    Collections.sort(questIds);
    for(Integer questId : questIds) {
      Node node = new Node();
      node.id = "quest_" + questId.intValue();
      node.type = "quest";
      graphReport.nodes.add(node);
    }

    List<String> files = new ArrayList<String>(npcs.keySet());
    Collections.sort(files, String.CASE_INSENSITIVE_ORDER);
    for(String file : files) {
      Node node = new Node();
      node.id = file;
      node.type = "npc";
      graphReport.nodes.add(node);
    }
  }

  private String normalizeAccessType(String accessType) {
    if(accessType == null) {
      return "";
    }
    if(accessType.startsWith("goal.")) {
      return accessType.substring("goal.".length());
    }
    return accessType;
  }

  private QuestAggregate ensureQuestAggregate(LinkedHashMap<Integer, QuestAggregate> quests,
                                              int questId) {
    QuestAggregate quest = quests.get(Integer.valueOf(questId));
    if(quest == null) {
      quest = new QuestAggregate();
      quest.questId = questId;
      quests.put(Integer.valueOf(questId), quest);
    }
    return quest;
  }

  private NpcAggregate ensureNpcAggregate(LinkedHashMap<String, NpcAggregate> npcs,
                                          String npcFile) {
    NpcAggregate npc = npcs.get(npcFile);
    if(npc == null) {
      npc = new NpcAggregate();
      npc.npcFile = npcFile;
      npcs.put(npcFile, npc);
    }
    return npc;
  }

  private Map<String, Object> readJsonObject(Path path, String field) throws Exception {
    String json = new String(Files.readAllBytes(path), UTF8);
    return QuestSemanticJson.parseObject(json, field, 0);
  }

  private void ensureParent(Path file) throws Exception {
    if(file.getParent() != null && !Files.exists(file.getParent())) {
      Files.createDirectories(file.getParent());
    }
  }

  private String safe(Object value) {
    return value == null ? "" : String.valueOf(value).trim();
  }

  private int intOf(Object value) {
    if(value == null) {
      return 0;
    }
    if(value instanceof Number) {
      return ((Number) value).intValue();
    }
    String text = safe(value);
    if(text.isEmpty()) {
      return 0;
    }
    try {
      return Integer.parseInt(text);
    } catch(Exception ex) {
      return 0;
    }
  }

  private static final class QuestAggregate {
    int questId;
    String name = "";
    int totalReferenceCount;
    int goalGetItemAccessCount;
    int goalKillMonsterAccessCount;
    int goalMeetNpcAccessCount;
    final Set<String> referencedNpcFiles = new LinkedHashSet<String>();
    final Map<String, Integer> accessTypeCount = new LinkedHashMap<String, Integer>();

    String toJson() {
      List<String> npcFiles = new ArrayList<String>(referencedNpcFiles);
      Collections.sort(npcFiles, String.CASE_INSENSITIVE_ORDER);
      return "{"
          + "\"questId\":" + questId
          + ",\"name\":" + QuestSemanticJson.jsonString(name)
          + ",\"npcFileCount\":" + npcFiles.size()
          + ",\"referencedNpcFiles\":" + QuestSemanticJson.toJsonArrayString(npcFiles)
          + ",\"goalGetItemAccessCount\":" + goalGetItemAccessCount
          + ",\"goalKillMonsterAccessCount\":" + goalKillMonsterAccessCount
          + ",\"goalMeetNpcAccessCount\":" + goalMeetNpcAccessCount
          + ",\"totalReferenceCount\":" + totalReferenceCount
          + ",\"accessTypeCount\":" + toJsonMap(accessTypeCount)
          + "}";
    }
  }

  private static final class NpcAggregate {
    String npcFile = "";
    int totalReferenceCount;
    int goalGetItemAccessCount;
    int goalKillMonsterAccessCount;
    int goalMeetNpcAccessCount;
    final Set<Integer> referencedQuestIds = new LinkedHashSet<Integer>();
    final Map<Integer, Set<String>> accessTypesByQuest = new LinkedHashMap<Integer, Set<String>>();
    final Map<Integer, Map<String, Set<Integer>>> indexUsageByQuest = new LinkedHashMap<Integer, Map<String, Set<Integer>>>();

    void touchQuestAccessType(int questId, String accessType) {
      Set<String> set = accessTypesByQuest.get(Integer.valueOf(questId));
      if(set == null) {
        set = new LinkedHashSet<String>();
        accessTypesByQuest.put(Integer.valueOf(questId), set);
      }
      set.add(accessType);
    }

    void touchQuestAccessIndex(int questId, String accessType, int index) {
      Map<String, Set<Integer>> byType = indexUsageByQuest.get(Integer.valueOf(questId));
      if(byType == null) {
        byType = new LinkedHashMap<String, Set<Integer>>();
        indexUsageByQuest.put(Integer.valueOf(questId), byType);
      }
      Set<Integer> indexes = byType.get(accessType);
      if(indexes == null) {
        indexes = new LinkedHashSet<Integer>();
        byType.put(accessType, indexes);
      }
      indexes.add(Integer.valueOf(index));
    }

    String toJson() {
      List<Integer> questIds = new ArrayList<Integer>(referencedQuestIds);
      Collections.sort(questIds);
      return "{"
          + "\"npcFile\":" + QuestSemanticJson.jsonString(npcFile)
          + ",\"referencedQuestIds\":" + QuestSemanticJson.toJsonArrayInt(questIds)
          + ",\"totalReferenceCount\":" + totalReferenceCount
          + ",\"goalGetItemAccessCount\":" + goalGetItemAccessCount
          + ",\"goalKillMonsterAccessCount\":" + goalKillMonsterAccessCount
          + ",\"goalMeetNpcAccessCount\":" + goalMeetNpcAccessCount
          + ",\"accessTypesByQuest\":" + toJsonAccessTypesByQuest(accessTypesByQuest)
          + ",\"indexUsageByQuest\":" + toJsonIndexUsageByQuest(indexUsageByQuest)
          + "}";
    }
  }

  private static final class Node {
    String id = "";
    String type = "";

    String toJson() {
      return "{\"id\":" + QuestSemanticJson.jsonString(id)
          + ",\"type\":" + QuestSemanticJson.jsonString(type) + "}";
    }
  }

  private static final class Edge {
    String from = "";
    String to = "";
    String accessType = "";
    final List<Integer> indexUsed = new ArrayList<Integer>();

    String toJson() {
      return "{\"from\":" + QuestSemanticJson.jsonString(from)
          + ",\"to\":" + QuestSemanticJson.jsonString(to)
          + ",\"accessType\":" + QuestSemanticJson.jsonString(accessType)
          + ",\"indexUsed\":" + QuestSemanticJson.toJsonArrayInt(indexUsed)
          + "}";
    }
  }

  private static final class GraphReport {
    String generatedAt = "";
    String sourceQuestData = "";
    String sourceNpcReferenceIndex = "";
    int totalQuestNodes;
    int totalNpcNodes;
    int edgeCount;
    int totalQuestReferencesDetected;
    final List<Integer> unresolvedQuestIds = new ArrayList<Integer>();
    final Map<String, QuestAggregate> questMappings = new LinkedHashMap<String, QuestAggregate>();
    final Map<String, NpcAggregate> npcMappings = new LinkedHashMap<String, NpcAggregate>();
    final List<Node> nodes = new ArrayList<Node>();
    final List<Edge> edges = new ArrayList<Edge>();

    String toJson() {
      StringBuilder sb = new StringBuilder();
      sb.append("{\n");
      sb.append("  \"generatedAt\": ").append(QuestSemanticJson.jsonString(generatedAt)).append(",\n");
      sb.append("  \"sourceQuestData\": ").append(QuestSemanticJson.jsonString(sourceQuestData)).append(",\n");
      sb.append("  \"sourceNpcReferenceIndex\": ").append(QuestSemanticJson.jsonString(sourceNpcReferenceIndex)).append(",\n");
      sb.append("  \"totalQuestNodes\": ").append(totalQuestNodes).append(",\n");
      sb.append("  \"totalNpcNodes\": ").append(totalNpcNodes).append(",\n");
      sb.append("  \"edgeCount\": ").append(edgeCount).append(",\n");
      sb.append("  \"totalQuestReferencesDetected\": ").append(totalQuestReferencesDetected).append(",\n");
      sb.append("  \"unresolvedQuestIds\": ").append(QuestSemanticJson.toJsonArrayInt(unresolvedQuestIds)).append(",\n");

      sb.append("  \"questMappings\": {");
      if(!questMappings.isEmpty()) {
        sb.append("\n");
        int i = 0;
        for(Map.Entry<String, QuestAggregate> entry : questMappings.entrySet()) {
          if(i++ > 0) {
            sb.append(",\n");
          }
          sb.append("    ").append(QuestSemanticJson.jsonString(entry.getKey())).append(": ")
              .append(entry.getValue().toJson());
        }
        sb.append("\n  ");
      }
      sb.append("},\n");

      sb.append("  \"npcMappings\": {");
      if(!npcMappings.isEmpty()) {
        sb.append("\n");
        int i = 0;
        for(Map.Entry<String, NpcAggregate> entry : npcMappings.entrySet()) {
          if(i++ > 0) {
            sb.append(",\n");
          }
          sb.append("    ").append(QuestSemanticJson.jsonString(entry.getKey())).append(": ")
              .append(entry.getValue().toJson());
        }
        sb.append("\n  ");
      }
      sb.append("},\n");

      sb.append("  \"nodes\": [");
      if(!nodes.isEmpty()) {
        sb.append("\n");
        for(int i = 0; i < nodes.size(); i++) {
          if(i > 0) {
            sb.append(",\n");
          }
          sb.append("    ").append(nodes.get(i).toJson());
        }
        sb.append("\n  ");
      }
      sb.append("],\n");

      sb.append("  \"edges\": [");
      if(!edges.isEmpty()) {
        sb.append("\n");
        for(int i = 0; i < edges.size(); i++) {
          if(i > 0) {
            sb.append(",\n");
          }
          sb.append("    ").append(edges.get(i).toJson());
        }
        sb.append("\n  ");
      }
      sb.append("]\n");
      sb.append("}\n");
      return sb.toString();
    }
  }

  private static final class TopQuest {
    int questId;
    String name = "";
    int npcFileCount;
    int totalReferenceCount;
    int goalGetItemAccessCount;
    int goalKillMonsterAccessCount;
    int goalMeetNpcAccessCount;

    static TopQuest from(QuestAggregate quest) {
      TopQuest top = new TopQuest();
      top.questId = quest.questId;
      top.name = quest.name;
      top.npcFileCount = quest.referencedNpcFiles.size();
      top.totalReferenceCount = quest.totalReferenceCount;
      top.goalGetItemAccessCount = quest.goalGetItemAccessCount;
      top.goalKillMonsterAccessCount = quest.goalKillMonsterAccessCount;
      top.goalMeetNpcAccessCount = quest.goalMeetNpcAccessCount;
      return top;
    }

    String toJson() {
      return "{"
          + "\"questId\":" + questId
          + ",\"name\":" + QuestSemanticJson.jsonString(name)
          + ",\"npcFileCount\":" + npcFileCount
          + ",\"totalReferenceCount\":" + totalReferenceCount
          + ",\"goalGetItemAccessCount\":" + goalGetItemAccessCount
          + ",\"goalKillMonsterAccessCount\":" + goalKillMonsterAccessCount
          + ",\"goalMeetNpcAccessCount\":" + goalMeetNpcAccessCount
          + "}";
    }
  }

  private static final class TopNpc {
    String npcFile = "";
    int referencedQuestCount;
    int totalReferenceCount;
    int goalGetItemAccessCount;
    int goalKillMonsterAccessCount;
    int goalMeetNpcAccessCount;

    static TopNpc from(NpcAggregate npc) {
      TopNpc top = new TopNpc();
      top.npcFile = npc.npcFile;
      top.referencedQuestCount = npc.referencedQuestIds.size();
      top.totalReferenceCount = npc.totalReferenceCount;
      top.goalGetItemAccessCount = npc.goalGetItemAccessCount;
      top.goalKillMonsterAccessCount = npc.goalKillMonsterAccessCount;
      top.goalMeetNpcAccessCount = npc.goalMeetNpcAccessCount;
      return top;
    }

    String toJson() {
      return "{"
          + "\"npcFile\":" + QuestSemanticJson.jsonString(npcFile)
          + ",\"referencedQuestCount\":" + referencedQuestCount
          + ",\"totalReferenceCount\":" + totalReferenceCount
          + ",\"goalGetItemAccessCount\":" + goalGetItemAccessCount
          + ",\"goalKillMonsterAccessCount\":" + goalKillMonsterAccessCount
          + ",\"goalMeetNpcAccessCount\":" + goalMeetNpcAccessCount
          + "}";
    }
  }

  private static final class SummaryReport {
    String generatedAt = "";
    int totalQuests;
    int totalNpcFiles;
    int totalQuestNodes;
    int totalNpcNodes;
    int edgeCount;
    int totalQuestReferencesDetected;
    final List<Integer> questsWithNoNpcReference = new ArrayList<Integer>();
    final List<String> npcFilesWithNoQuestReference = new ArrayList<String>();
    final List<TopQuest> topReferencedQuests = new ArrayList<TopQuest>();
    final List<TopNpc> topHeavyNpcFiles = new ArrayList<TopNpc>();

    String toJson() {
      StringBuilder sb = new StringBuilder();
      sb.append("{\n");
      sb.append("  \"generatedAt\": ").append(QuestSemanticJson.jsonString(generatedAt)).append(",\n");
      sb.append("  \"totalQuests\": ").append(totalQuests).append(",\n");
      sb.append("  \"totalNpcFiles\": ").append(totalNpcFiles).append(",\n");
      sb.append("  \"totalQuestNodes\": ").append(totalQuestNodes).append(",\n");
      sb.append("  \"totalNpcNodes\": ").append(totalNpcNodes).append(",\n");
      sb.append("  \"edgeCount\": ").append(edgeCount).append(",\n");
      sb.append("  \"totalQuestReferencesDetected\": ").append(totalQuestReferencesDetected).append(",\n");
      sb.append("  \"questsWithNoNpcReference\": ").append(QuestSemanticJson.toJsonArrayInt(questsWithNoNpcReference)).append(",\n");
      sb.append("  \"npcFilesWithNoQuestReference\": ").append(QuestSemanticJson.toJsonArrayString(npcFilesWithNoQuestReference)).append(",\n");

      sb.append("  \"topReferencedQuests\": [");
      if(!topReferencedQuests.isEmpty()) {
        sb.append("\n");
        for(int i = 0; i < topReferencedQuests.size(); i++) {
          if(i > 0) {
            sb.append(",\n");
          }
          sb.append("    ").append(topReferencedQuests.get(i).toJson());
        }
        sb.append("\n  ");
      }
      sb.append("],\n");

      sb.append("  \"topHeavyNpcFiles\": [");
      if(!topHeavyNpcFiles.isEmpty()) {
        sb.append("\n");
        for(int i = 0; i < topHeavyNpcFiles.size(); i++) {
          if(i > 0) {
            sb.append(",\n");
          }
          sb.append("    ").append(topHeavyNpcFiles.get(i).toJson());
        }
        sb.append("\n  ");
      }
      sb.append("]\n");
      sb.append("}\n");
      return sb.toString();
    }
  }

  public static final class BuildResult {
    int totalQuestNodes;
    int totalNpcNodes;
    int edgeCount;
    final List<Integer> questsWithNoNpcReference = new ArrayList<Integer>();
  }

  private static String toJsonMap(Map<String, Integer> map) {
    if(map == null || map.isEmpty()) {
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

  private static String toJsonAccessTypesByQuest(Map<Integer, Set<String>> map) {
    if(map == null || map.isEmpty()) {
      return "{}";
    }
    List<Integer> questIds = new ArrayList<Integer>(map.keySet());
    Collections.sort(questIds);
    StringBuilder sb = new StringBuilder();
    sb.append('{');
    int i = 0;
    for(Integer questId : questIds) {
      if(i++ > 0) {
        sb.append(',');
      }
      List<String> types = new ArrayList<String>(map.get(questId));
      Collections.sort(types, String.CASE_INSENSITIVE_ORDER);
      sb.append(QuestSemanticJson.jsonString(Integer.toString(questId.intValue())))
          .append(':')
          .append(QuestSemanticJson.toJsonArrayString(types));
    }
    sb.append('}');
    return sb.toString();
  }

  private static String toJsonIndexUsageByQuest(Map<Integer, Map<String, Set<Integer>>> map) {
    if(map == null || map.isEmpty()) {
      return "{}";
    }
    List<Integer> questIds = new ArrayList<Integer>(map.keySet());
    Collections.sort(questIds);

    StringBuilder sb = new StringBuilder();
    sb.append('{');
    int i = 0;
    for(Integer questId : questIds) {
      if(i++ > 0) {
        sb.append(',');
      }
      sb.append(QuestSemanticJson.jsonString(Integer.toString(questId.intValue()))).append(':');

      Map<String, Set<Integer>> byType = map.get(questId);
      if(byType == null || byType.isEmpty()) {
        sb.append("{}");
        continue;
      }

      List<String> types = new ArrayList<String>(byType.keySet());
      Collections.sort(types, String.CASE_INSENSITIVE_ORDER);
      sb.append('{');
      int j = 0;
      for(String type : types) {
        if(j++ > 0) {
          sb.append(',');
        }
        List<Integer> indexes = new ArrayList<Integer>(byType.get(type));
        Collections.sort(indexes);
        sb.append(QuestSemanticJson.jsonString(type)).append(':')
            .append(QuestSemanticJson.toJsonArrayInt(indexes));
      }
      sb.append('}');
    }
    sb.append('}');
    return sb.toString();
  }
}
