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
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Set;

import unluac.chunk.Lua50ChunkParser;
import unluac.chunk.LuaChunk;

public class QuestNpcGraphBuilder {

  private static final Charset UTF8 = Charset.forName("UTF-8");

  public static void main(String[] args) throws Exception {
    if(args.length < 3) {
      printUsage();
      return;
    }

    Path dependencyIndexPath = Paths.get(args[0]);
    Path propagationPath = Paths.get(args[1]);
    Path snapshotPath = Paths.get(args[2]);

    QuestNpcGraphBuilder builder = new QuestNpcGraphBuilder();
    BuildResult result = builder.build(dependencyIndexPath, propagationPath, snapshotPath);

    System.out.println("totalQuestNodes=" + result.totalQuestNodes);
    System.out.println("totalNpcNodes=" + result.totalNpcNodes);
    System.out.println("totalEdges=" + result.totalEdges);
    System.out.println("highRiskQuestCount=" + result.highRiskQuestIds.size());
    System.out.println("sccCount=" + result.stronglyConnectedComponents.size());
    System.out.println("snapshot=" + snapshotPath.toAbsolutePath());
  }

  public BuildResult build(Path dependencyIndexPath,
                           Path propagationPath,
                           Path snapshotPath) throws Exception {
    QuestNpcDependencyGraph graph = buildGraph(dependencyIndexPath, propagationPath);

    GraphSnapshot snapshot = new GraphSnapshot();
    snapshot.generatedAt = OffsetDateTime.now().format(DateTimeFormatter.ISO_OFFSET_DATE_TIME);
    snapshot.totalQuestNodes = graph.questNodes.size();
    snapshot.totalNpcNodes = graph.npcNodes.size();
    snapshot.totalEdges = graph.totalEdges();
    snapshot.highRiskQuestIds.addAll(graph.highRiskQuestIds());
    snapshot.stronglyConnectedComponents.addAll(graph.stronglyConnectedComponents());

    if(snapshotPath.getParent() != null && !Files.exists(snapshotPath.getParent())) {
      Files.createDirectories(snapshotPath.getParent());
    }
    Files.write(snapshotPath, snapshot.toJson().getBytes(UTF8));

    BuildResult out = new BuildResult();
    out.graph = graph;
    out.totalQuestNodes = snapshot.totalQuestNodes;
    out.totalNpcNodes = snapshot.totalNpcNodes;
    out.totalEdges = snapshot.totalEdges;
    out.highRiskQuestIds.addAll(snapshot.highRiskQuestIds);
    out.stronglyConnectedComponents.addAll(snapshot.stronglyConnectedComponents);
    return out;
  }

  public QuestNpcDependencyGraph buildGraph(Path dependencyIndexPath,
                                            Path propagationPath) throws Exception {
    return buildGraph(dependencyIndexPath, propagationPath, true);
  }

  public QuestNpcDependencyGraph buildGraph(Path dependencyIndexPath,
                                            Path propagationPath,
                                            boolean includeQuestSemanticFields) throws Exception {
    if(dependencyIndexPath == null || !Files.exists(dependencyIndexPath)) {
      throw new IllegalStateException("dependency index not found: " + dependencyIndexPath);
    }
    if(propagationPath == null || !Files.exists(propagationPath)) {
      throw new IllegalStateException("propagation report not found: " + propagationPath);
    }

    QuestNpcDependencyGraph graph = new QuestNpcDependencyGraph();

    Map<Integer, QuestSemanticModel> questSemanticById = includeQuestSemanticFields
        ? loadQuestSemanticsFromDependencySource(dependencyIndexPath)
        : new LinkedHashMap<Integer, QuestSemanticModel>();

    String depJson = new String(Files.readAllBytes(dependencyIndexPath), UTF8);
    Map<String, Object> depRoot = QuestSemanticJson.parseObject(depJson, "quest_npc_dependency_index", 0);
    loadDependencyIndex(depRoot, graph);

    String propagationJson = new String(Files.readAllBytes(propagationPath), UTF8);
    Map<String, Object> propagationRoot = QuestSemanticJson.parseObject(propagationJson, "quest_modification_propagation", 0);
    loadPropagation(propagationRoot, graph);

    if(includeQuestSemanticFields) {
      fillQuestStructures(graph, questSemanticById);
    }
    return graph;
  }

  @SuppressWarnings("unchecked")
  private void loadDependencyIndex(Map<String, Object> root, QuestNpcDependencyGraph graph) {
    if(root == null) {
      return;
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

      Map<String, Object> questObj = (Map<String, Object>) entry.getValue();
      QuestNode questNode = graph.ensureQuestNode(questId);

      Object npcFilesObj = questObj.get("npcFiles");
      if(!(npcFilesObj instanceof List<?>)) {
        continue;
      }

      for(Object npcItemObj : (List<Object>) npcFilesObj) {
        if(!(npcItemObj instanceof Map<?, ?>)) {
          continue;
        }
        Map<String, Object> npcItem = (Map<String, Object>) npcItemObj;
        String file = stringOf(npcItem.get("file"));
        if(file.isEmpty()) {
          continue;
        }

        graph.link(questId, file);
        NpcNode npcNode = graph.ensureNpcNode(file);
        if(npcNode.npcId <= 0) {
          npcNode.npcId = parseNpcIdFromFile(file);
        }

        Object accessObj = npcItem.get("access");
        if(accessObj instanceof List<?>) {
          for(Object accessItemObj : (List<Object>) accessObj) {
            if(!(accessItemObj instanceof Map<?, ?>)) {
              continue;
            }
            Map<String, Object> accessItem = (Map<String, Object>) accessItemObj;
            String type = stringOf(accessItem.get("type"));
            boolean hardcodedIndex = boolOf(accessItem.get("hardcodedIndex"));
            int index = intOf(accessItem.get("index"));

            String mapped = mapDependencyType(type);
            if(!mapped.isEmpty()) {
              questNode.addDependencyType(mapped);
              npcNode.addDependencyType(mapped);
            }

            if(hardcodedIndex && "goal.getItem".equalsIgnoreCase(type)) {
              npcNode.addHardcodedGoalIndex(index);
            }
          }
        }
      }
    }
  }

  @SuppressWarnings("unchecked")
  private void loadPropagation(Map<String, Object> root, QuestNpcDependencyGraph graph) {
    if(root == null) {
      return;
    }

    Object questsObj = root.get("quests");
    if(!(questsObj instanceof List<?>)) {
      return;
    }

    for(Object questItemObj : (List<Object>) questsObj) {
      if(!(questItemObj instanceof Map<?, ?>)) {
        continue;
      }
      Map<String, Object> questItem = (Map<String, Object>) questItemObj;
      int questId = intOf(questItem.get("questId"));
      if(questId <= 0) {
        continue;
      }

      QuestNode questNode = graph.ensureQuestNode(questId);
      questNode.propagationRequired = true;

      Object modsObj = questItem.get("modificationType");
      if(modsObj instanceof List<?>) {
        for(Object modObj : (List<Object>) modsObj) {
          String mod = stringOf(modObj);
          if(!mod.isEmpty()) {
            questNode.addDependencyType(mod.toLowerCase(Locale.ROOT));
          }
        }
      }

      Object affectedObj = questItem.get("affectedNpcs");
      if(!(affectedObj instanceof List<?>)) {
        continue;
      }

      for(Object npcObj : (List<Object>) affectedObj) {
        if(!(npcObj instanceof Map<?, ?>)) {
          continue;
        }

        Map<String, Object> npcItem = (Map<String, Object>) npcObj;
        String file = stringOf(npcItem.get("file"));
        if(file.isEmpty()) {
          continue;
        }

        graph.link(questId, file);

        NpcNode npcNode = graph.ensureNpcNode(file);
        if(npcNode.npcId <= 0) {
          npcNode.npcId = intOf(npcItem.get("npcId"));
          if(npcNode.npcId <= 0) {
            npcNode.npcId = parseNpcIdFromFile(file);
          }
        }

        String questRisk = stringOf(npcItem.get("riskLevel"));
        questNode.mergeRiskLevel(questRisk);
        npcNode.mergeRiskLevel(questRisk);

        boolean rewriteRequired = boolOf(npcItem.get("rewriteRequired"));
        if(rewriteRequired) {
          questNode.propagationRequired = true;
        }

        Object rolesObj = npcItem.get("roles");
        if(rolesObj instanceof List<?>) {
          for(Object roleObj : (List<Object>) rolesObj) {
            String role = stringOf(roleObj);
            String mapped = mapRoleToDependencyType(role);
            if(!mapped.isEmpty()) {
              questNode.addDependencyType(mapped);
              npcNode.addDependencyType(mapped);
            }
          }
        }
      }
    }

    for(QuestNode questNode : graph.questNodes.values()) {
      if(questNode.riskLevel == null || questNode.riskLevel.isEmpty()) {
        questNode.riskLevel = questNode.propagationRequired ? "MEDIUM" : "LOW";
      }
    }
    for(NpcNode npcNode : graph.npcNodes.values()) {
      if(npcNode.riskLevel == null || npcNode.riskLevel.isEmpty()) {
        npcNode.riskLevel = npcNode.hardcodedGoalIndexes.isEmpty() ? "LOW" : "HIGH";
      }
    }
  }

  private void fillQuestStructures(QuestNpcDependencyGraph graph, Map<Integer, QuestSemanticModel> questSemanticById) {
    for(QuestNode questNode : graph.questNodes.values()) {
      QuestSemanticModel model = questSemanticById.get(Integer.valueOf(questNode.questId));
      if(model == null) {
        continue;
      }
      if(model.goal != null) {
        questNode.goal = copyGoal(model.goal);
        questNode.needLevel = model.goal.needLevel;
      }
      questNode.reward.clear();
      for(QuestSemanticModel.Reward reward : model.rewards) {
        questNode.reward.add(copyReward(reward));
      }
      if(questNode.needLevel <= 0) {
        questNode.needLevel = intFromConditions(model.conditions, "needLevel");
      }
    }
  }

  private Map<Integer, QuestSemanticModel> loadQuestSemanticsFromDependencySource(Path dependencyIndexPath) throws Exception {
    String depJson = new String(Files.readAllBytes(dependencyIndexPath), UTF8);
    Map<String, Object> root = QuestSemanticJson.parseObject(depJson, "quest_npc_dependency_index", 0);

    Object metaObj = root.get("_meta");
    if(!(metaObj instanceof Map<?, ?>)) {
      return new LinkedHashMap<Integer, QuestSemanticModel>();
    }
    @SuppressWarnings("unchecked")
    Map<String, Object> meta = (Map<String, Object>) metaObj;
    String sourceDirectory = stringOf(meta.get("sourceDirectory"));

    Path questLuc = resolveQuestLucPath(sourceDirectory);
    if(questLuc == null || !Files.exists(questLuc)) {
      return new LinkedHashMap<Integer, QuestSemanticModel>();
    }

    byte[] data = Files.readAllBytes(questLuc);
    LuaChunk chunk = new Lua50ChunkParser().parse(data);
    QuestSemanticExtractor extractor = new QuestSemanticExtractor();
    QuestSemanticExtractor.ExtractionResult extraction = extractor.extract(chunk);

    Map<Integer, QuestSemanticModel> out = new LinkedHashMap<Integer, QuestSemanticModel>();
    for(QuestSemanticModel model : extraction.quests) {
      if(model != null && model.questId > 0) {
        out.put(Integer.valueOf(model.questId), model);
      }
    }
    return out;
  }

  private Path resolveQuestLucPath(String sourceDirectory) {
    if(sourceDirectory == null || sourceDirectory.trim().isEmpty()) {
      return null;
    }
    Path sourcePath = Paths.get(sourceDirectory.trim());
    if(!Files.exists(sourcePath)) {
      return null;
    }

    Path scriptDir = sourcePath;
    if(sourcePath.getFileName() != null && "npc-lua".equalsIgnoreCase(sourcePath.getFileName().toString())) {
      scriptDir = sourcePath.getParent();
    }
    if(scriptDir == null) {
      return null;
    }

    List<String> candidates = new ArrayList<String>();
    candidates.add("quest.luc");
    candidates.add("questbak.luc");
    candidates.add("quest - 副本.luc");

    for(String name : candidates) {
      Path candidate = scriptDir.resolve(name);
      if(Files.exists(candidate) && Files.isRegularFile(candidate)) {
        return candidate;
      }
    }
    return null;
  }

  private QuestGoal copyGoal(QuestGoal source) {
    QuestGoal out = new QuestGoal();
    if(source == null) {
      return out;
    }
    out.needLevel = source.needLevel;
    for(ItemRequirement item : source.items) {
      if(item == null) {
        continue;
      }
      ItemRequirement copy = new ItemRequirement();
      copy.meetCount = item.meetCount;
      copy.itemId = item.itemId;
      copy.itemCount = item.itemCount;
      out.items.add(copy);
    }
    for(KillRequirement monster : source.monsters) {
      if(monster == null) {
        continue;
      }
      KillRequirement copy = new KillRequirement();
      copy.monsterId = monster.monsterId;
      copy.killCount = monster.killCount;
      out.monsters.add(copy);
    }
    return out;
  }

  private QuestSemanticModel.Reward copyReward(QuestSemanticModel.Reward source) {
    QuestSemanticModel.Reward copy = new QuestSemanticModel.Reward();
    if(source == null) {
      return copy;
    }
    copy.type = source.type;
    copy.id = source.id;
    copy.count = source.count;
    copy.money = source.money;
    copy.exp = source.exp;
    copy.fame = source.fame;
    copy.pvppoint = source.pvppoint;
    copy.skillIds.addAll(source.skillIds);
    copy.extraFields.putAll(source.extraFields);
    copy.fieldOrder.addAll(source.fieldOrder);
    return copy;
  }

  private int intFromConditions(Map<String, Object> conditions, String key) {
    if(conditions == null || key == null) {
      return 0;
    }
    Object value = conditions.get(key);
    return intOf(value);
  }

  private String mapDependencyType(String type) {
    if(type == null) {
      return "";
    }
    String normalized = type.trim().toLowerCase(Locale.ROOT);
    if(normalized.startsWith("goal")) {
      return "goal_access";
    }
    if(normalized.startsWith("reward")) {
      return "reward_access";
    }
    if("set_quest_state".equals(normalized) || "qdata".equals(normalized) || "directindex".equals(normalized) || "needlevel".equals(normalized)) {
      return "state_transition";
    }
    return "";
  }

  private String mapRoleToDependencyType(String role) {
    if(role == null) {
      return "";
    }
    String up = role.trim().toUpperCase(Locale.ROOT);
    if("GOAL_VERIFY".equals(up)) {
      return "goal_access";
    }
    if("REWARD_TRIGGER".equals(up)) {
      return "reward_access";
    }
    if("STATE_CHECK".equals(up) || "STATE_ADVANCE".equals(up)) {
      return "state_transition";
    }
    return "";
  }

  private int parseNpcIdFromFile(String file) {
    if(file == null) {
      return 0;
    }
    String normalized = file.toLowerCase(Locale.ROOT);
    int idx = normalized.indexOf("npc_");
    if(idx < 0) {
      return 0;
    }
    int start = idx + 4;
    int end = start;
    while(end < normalized.length() && Character.isDigit(normalized.charAt(end))) {
      end++;
    }
    if(end <= start) {
      return 0;
    }
    return parseIntSafe(normalized.substring(start, end));
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

  private int intOf(Object value) {
    if(value instanceof Number) {
      return ((Number) value).intValue();
    }
    if(value instanceof String) {
      return parseIntSafe((String) value);
    }
    return 0;
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

  private static void printUsage() {
    System.out.println("Usage:");
    System.out.println("  java -cp build unluac.semantic.QuestNpcGraphBuilder <quest_npc_dependency_index.json> <quest_modification_propagation.json> <graph_snapshot.json>");
  }

  public static final class BuildResult {
    public QuestNpcDependencyGraph graph;
    public int totalQuestNodes;
    public int totalNpcNodes;
    public int totalEdges;
    public final List<Integer> highRiskQuestIds = new ArrayList<Integer>();
    public final List<List<String>> stronglyConnectedComponents = new ArrayList<List<String>>();
  }

  public static final class GraphSnapshot {
    public String generatedAt;
    public int totalQuestNodes;
    public int totalNpcNodes;
    public int totalEdges;
    public final List<Integer> highRiskQuestIds = new ArrayList<Integer>();
    public final List<List<String>> stronglyConnectedComponents = new ArrayList<List<String>>();

    public String toJson() {
      StringBuilder sb = new StringBuilder();
      sb.append("{\n");
      sb.append("  \"generatedAt\": \"").append(escapeJson(generatedAt)).append("\",\n");
      sb.append("  \"totalQuestNodes\": ").append(totalQuestNodes).append(",\n");
      sb.append("  \"totalNpcNodes\": ").append(totalNpcNodes).append(",\n");
      sb.append("  \"totalEdges\": ").append(totalEdges).append(",\n");
      sb.append("  \"highRiskQuestIds\": [");
      for(int i = 0; i < highRiskQuestIds.size(); i++) {
        if(i > 0) {
          sb.append(", ");
        }
        sb.append(highRiskQuestIds.get(i).intValue());
      }
      sb.append("],\n");

      sb.append("  \"stronglyConnectedComponents\": [");
      if(!stronglyConnectedComponents.isEmpty()) {
        sb.append("\n");
      }
      for(int i = 0; i < stronglyConnectedComponents.size(); i++) {
        if(i > 0) {
          sb.append(",\n");
        }
        List<String> component = stronglyConnectedComponents.get(i);
        sb.append("    [");
        for(int j = 0; j < component.size(); j++) {
          if(j > 0) {
            sb.append(", ");
          }
          sb.append("\"").append(escapeJson(component.get(j))).append("\"");
        }
        sb.append("]");
      }
      if(!stronglyConnectedComponents.isEmpty()) {
        sb.append("\n");
      }
      sb.append("  ]\n");
      sb.append("}\n");
      return sb.toString();
    }
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
