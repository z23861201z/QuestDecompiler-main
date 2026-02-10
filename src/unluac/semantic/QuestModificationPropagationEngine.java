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
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Set;

public class QuestModificationPropagationEngine {

  private static final Charset UTF8 = Charset.forName("UTF-8");

  public static void main(String[] args) throws Exception {
    if(args.length < 3) {
      printUsage();
      return;
    }

    Path dependencyIndexPath = Paths.get(args[0]);
    Path propagationPath = Paths.get(args[1]);
    Path outputPath = Paths.get(args[2]);

    QuestModificationPropagationEngine engine = new QuestModificationPropagationEngine();
    PropagationResult result = engine.analyze(dependencyIndexPath, propagationPath, outputPath);

    System.out.println("quest_count=" + result.quests.size());
    System.out.println("totalPropagationNodes=" + result.totalPropagationNodes);
    System.out.println("output=" + outputPath.toAbsolutePath());
  }

  public PropagationResult analyze(Path dependencyIndexPath,
                                   Path propagationPath,
                                   Path outputPath) throws Exception {
    QuestNpcGraphBuilder graphBuilder = new QuestNpcGraphBuilder();
    QuestNpcDependencyGraph graph = graphBuilder.buildGraph(dependencyIndexPath, propagationPath, false);

    String propagationJson = new String(Files.readAllBytes(propagationPath), UTF8);
    Map<String, Object> root = QuestSemanticJson.parseObject(propagationJson, "quest_modification_propagation", 0);

    PropagationResult result = new PropagationResult();
    result.generatedAt = OffsetDateTime.now().format(DateTimeFormatter.ISO_OFFSET_DATE_TIME);

    List<Map<String, Object>> questItems = parseQuestItems(root);
    Set<String> nodeVisited = new LinkedHashSet<String>();

    for(Map<String, Object> questItem : questItems) {
      int questId = intOf(questItem.get("questId"));
      if(questId <= 0) {
        continue;
      }

      QuestNode questNode = graph.questNodes.get(Integer.valueOf(questId));
      if(questNode == null) {
        continue;
      }

      List<String> modificationTypes = parseStringList(questItem.get("modificationType"));
      if(modificationTypes.isEmpty()) {
        continue;
      }

      PropagationResult.QuestPropagationItem item = new PropagationResult.QuestPropagationItem();
      item.questId = questId;
      item.modificationTypes.addAll(modificationTypes);

      bfsPropagate(questNode, modificationTypes, item, nodeVisited);
      item.highestRiskLevel = evaluateHighestRisk(item.propagationChains);
      item.rewriteRequired = hasRewriteRequired(item.propagationChains);

      Collections.sort(item.affectedNpcFiles, String.CASE_INSENSITIVE_ORDER);
      Collections.sort(item.propagationChains, new Comparator<PropagationEdge>() {
        @Override
        public int compare(PropagationEdge a, PropagationEdge b) {
          int c = a.toNode.compareToIgnoreCase(b.toNode);
          if(c != 0) {
            return c;
          }
          return a.rule.compareToIgnoreCase(b.rule);
        }
      });

      result.quests.add(item);
    }

    Collections.sort(result.quests, new Comparator<PropagationResult.QuestPropagationItem>() {
      @Override
      public int compare(PropagationResult.QuestPropagationItem a, PropagationResult.QuestPropagationItem b) {
        return Integer.compare(a.questId, b.questId);
      }
    });

    result.totalPropagationNodes = nodeVisited.size();

    if(outputPath.getParent() != null && !Files.exists(outputPath.getParent())) {
      Files.createDirectories(outputPath.getParent());
    }
    Files.write(outputPath, result.toJson().getBytes(UTF8));
    return result;
  }

  private void bfsPropagate(QuestNode rootQuest,
                            List<String> modificationTypes,
                            PropagationResult.QuestPropagationItem out,
                            Set<String> globalVisited) {
    Set<String> seenNpcFile = new LinkedHashSet<String>();

    String qVertex = QuestNpcDependencyGraph.questVertexKey(rootQuest.questId);
    globalVisited.add(qVertex);

    List<NpcNode> npcQueue = new ArrayList<NpcNode>(rootQuest.referencedNpcs);
    for(int i = 0; i < npcQueue.size(); i++) {
      NpcNode npc = npcQueue.get(i);
      if(npc == null || npc.filePath == null || npc.filePath.isEmpty()) {
        continue;
      }

      String nVertex = QuestNpcDependencyGraph.npcVertexKey(npc.filePath);
      globalVisited.add(nVertex);

      String risk = evaluateRisk(modificationTypes, npc);
      String rule = ruleName(modificationTypes);
      PropagationEdge edge = new PropagationEdge();
      edge.questId = rootQuest.questId;
      edge.fromNode = qVertex;
      edge.toNode = nVertex;
      edge.rule = rule;
      edge.riskLevel = risk;
      out.propagationChains.add(edge);

      if(seenNpcFile.add(npc.filePath)) {
        out.affectedNpcFiles.add(npc.filePath);
      }
    }
  }

  private String evaluateRisk(List<String> modificationTypes, NpcNode npc) {
    if(hasType(modificationTypes, "QUEST_ID_CHANGED")) {
      return "CRITICAL";
    }
    if(hasType(modificationTypes, "GOAL_ITEM_COUNT_CHANGED")) {
      if(npc != null && !npc.hardcodedGoalIndexes.isEmpty()) {
        return "HIGH";
      }
      return "MEDIUM";
    }
    if(hasType(modificationTypes, "REWARD_STRUCTURE_CHANGED")) {
      if(npc != null && npc.dependencyTypes.contains("state_transition")) {
        return "MEDIUM";
      }
      return "LOW";
    }
    return "LOW";
  }

  private String ruleName(List<String> modificationTypes) {
    if(hasType(modificationTypes, "QUEST_ID_CHANGED")) {
      return "QUEST_ID_CRITICAL_PROPAGATION";
    }
    if(hasType(modificationTypes, "GOAL_ITEM_COUNT_CHANGED")) {
      return "GOAL_ITEM_COUNT_PROPAGATION";
    }
    if(hasType(modificationTypes, "REWARD_STRUCTURE_CHANGED")) {
      return "REWARD_STRUCTURE_PROPAGATION";
    }
    return "GENERIC_PROPAGATION";
  }

  private boolean hasType(List<String> types, String target) {
    for(String type : types) {
      if(target.equals(type)) {
        return true;
      }
    }
    return false;
  }

  private String evaluateHighestRisk(List<PropagationEdge> chains) {
    String highest = "LOW";
    for(PropagationEdge edge : chains) {
      highest = higherRisk(highest, edge.riskLevel);
    }
    return highest;
  }

  private boolean hasRewriteRequired(List<PropagationEdge> chains) {
    for(PropagationEdge edge : chains) {
      if("CRITICAL".equals(edge.riskLevel) || "HIGH".equals(edge.riskLevel)) {
        return true;
      }
    }
    return false;
  }

  private String higherRisk(String left, String right) {
    return riskRank(left) >= riskRank(right) ? normalizeRisk(left) : normalizeRisk(right);
  }

  private int riskRank(String risk) {
    String normalized = normalizeRisk(risk);
    if("CRITICAL".equals(normalized)) {
      return 4;
    }
    if("HIGH".equals(normalized)) {
      return 3;
    }
    if("MEDIUM".equals(normalized)) {
      return 2;
    }
    return 1;
  }

  private String normalizeRisk(String risk) {
    if(risk == null) {
      return "LOW";
    }
    String up = risk.trim().toUpperCase(Locale.ROOT);
    if("CRITICAL".equals(up) || "HIGH".equals(up) || "MEDIUM".equals(up)) {
      return up;
    }
    return "LOW";
  }

  @SuppressWarnings("unchecked")
  private List<Map<String, Object>> parseQuestItems(Map<String, Object> root) {
    Object questsObj = root.get("quests");
    if(!(questsObj instanceof List<?>)) {
      return Collections.emptyList();
    }
    List<Map<String, Object>> out = new ArrayList<Map<String, Object>>();
    for(Object item : (List<Object>) questsObj) {
      if(item instanceof Map<?, ?>) {
        out.add((Map<String, Object>) item);
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
      String text = stringOf(item).trim();
      if(!text.isEmpty()) {
        out.add(text.toUpperCase(Locale.ROOT));
      }
    }
    return out;
  }

  private int intOf(Object value) {
    if(value instanceof Number) {
      return ((Number) value).intValue();
    }
    if(value instanceof String) {
      try {
        return Integer.parseInt(((String) value).trim());
      } catch(Exception ignored) {
      }
    }
    return 0;
  }

  private String stringOf(Object value) {
    return value == null ? "" : String.valueOf(value);
  }

  private static void printUsage() {
    System.out.println("Usage:");
    System.out.println("  java -cp build unluac.semantic.QuestModificationPropagationEngine <quest_npc_dependency_index.json> <quest_modification_propagation.json> <output.json>");
  }
}
