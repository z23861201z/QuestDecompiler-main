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

import unluac.chunk.Lua50ChunkParser;
import unluac.chunk.LuaChunk;

public class QuestModificationPropagationAnalyzer {

  private static final Charset UTF8 = Charset.forName("UTF-8");

  public static void main(String[] args) throws Exception {
    if(args.length < 4) {
      printUsage();
      return;
    }

    Path oldLuc = Paths.get(args[0]);
    Path newLuc = Paths.get(args[1]);
    Path graphJson = Paths.get(args[2]);
    Path reportOut = Paths.get(args[3]);

    QuestModificationPropagationAnalyzer analyzer = new QuestModificationPropagationAnalyzer();
    PropagationReport report = analyzer.analyze(oldLuc, newLuc, graphJson, reportOut);

    System.out.println("changed_quest_count=" + report.quests.size());
    System.out.println("affectedNpcCount=" + report.affectedNpcCount);
    System.out.println("rewriteRequiredCount=" + report.rewriteRequiredCount);
    System.out.println("autoSafeCount=" + report.autoSafeCount);
    System.out.println("output=" + reportOut.toAbsolutePath());
  }

  public PropagationReport analyze(Path oldLuc,
                                   Path newLuc,
                                   Path graphJson,
                                   Path reportOut) throws Exception {
    if(oldLuc == null || !Files.exists(oldLuc)) {
      throw new IllegalStateException("old luc not found: " + oldLuc);
    }
    if(newLuc == null || !Files.exists(newLuc)) {
      throw new IllegalStateException("new luc not found: " + newLuc);
    }
    if(graphJson == null || !Files.exists(graphJson)) {
      throw new IllegalStateException("graph json not found: " + graphJson);
    }

    Map<Integer, QuestSemanticModel> oldMap = loadQuestModels(oldLuc);
    Map<Integer, QuestSemanticModel> newMap = loadQuestModels(newLuc);
    GraphIndex graph = loadGraph(graphJson);

    List<QuestChange> changes = detectChanges(oldMap, newMap);

    PropagationReport report = new PropagationReport();
    report.generatedAt = OffsetDateTime.now().format(DateTimeFormatter.ISO_OFFSET_DATE_TIME);

    Set<String> affectedNpcKeys = new LinkedHashSet<String>();
    int rewriteRequired = 0;
    int autoSafe = 0;

    for(QuestChange change : changes) {
      QuestPropagation entry = new QuestPropagation();
      entry.questId = change.questId;
      entry.modificationType.addAll(change.modificationTypes);

      GraphQuestNode graphQuest = graph.quests.get(Integer.valueOf(change.questId));
      if(graphQuest != null) {
        for(GraphNpcRelation relation : graphQuest.npcRelations) {
          AffectedNpc affected = new AffectedNpc();
          affected.npcId = relation.npcId;
          affected.file = relation.file;
          affected.roles.addAll(relation.roles);

          String risk = evaluateRisk(change.modificationTypes);
          affected.riskLevel = risk;
          affected.reason = buildReason(change.modificationTypes, relation);
          affected.rewriteRequired = isRewriteRequired(change.modificationTypes, relation);
          affected.propagationPath = buildPath(change.questId, relation);

          entry.affectedNpcs.add(affected);

          String npcKey = affected.npcId + "@" + affected.file;
          affectedNpcKeys.add(npcKey);
          if(affected.rewriteRequired) {
            rewriteRequired++;
          }
        }
      }

      entry.affectedNpcCount = entry.affectedNpcs.size();
      entry.safeToAutoApply = isSafeToAutoApply(entry);
      if(entry.safeToAutoApply) {
        autoSafe++;
      }

      report.quests.add(entry);
    }

    Collections.sort(report.quests, new Comparator<QuestPropagation>() {
      @Override
      public int compare(QuestPropagation a, QuestPropagation b) {
        return Integer.compare(a.questId, b.questId);
      }
    });

    report.affectedNpcCount = affectedNpcKeys.size();
    report.rewriteRequiredCount = rewriteRequired;
    report.autoSafeCount = autoSafe;

    if(reportOut.getParent() != null && !Files.exists(reportOut.getParent())) {
      Files.createDirectories(reportOut.getParent());
    }
    Files.write(reportOut, report.toJson().getBytes(UTF8));
    return report;
  }

  private boolean isSafeToAutoApply(QuestPropagation entry) {
    if(entry == null) {
      return true;
    }
    for(AffectedNpc npc : entry.affectedNpcs) {
      if(npc.rewriteRequired) {
        return false;
      }
      if("HIGH".equals(npc.riskLevel) || "MEDIUM".equals(npc.riskLevel)) {
        return false;
      }
    }
    return true;
  }

  private boolean isRewriteRequired(List<String> modificationTypes, GraphNpcRelation relation) {
    if(modificationTypes == null) {
      return false;
    }
    if(hasType(modificationTypes, "QUEST_ID_CHANGED")
        || hasType(modificationTypes, "GOAL_DELETED")
        || hasType(modificationTypes, "REWARD_DELETED")) {
      return true;
    }
    if(hasType(modificationTypes, "GOAL_ITEM_COUNT_CHANGED") || hasType(modificationTypes, "REWARD_STRUCTURE_CHANGED")) {
      return relation != null && (relation.hasRole("GOAL_VERIFY") || relation.hasRole("REWARD_TRIGGER") || relation.hasRole("STATE_ADVANCE"));
    }
    return false;
  }

  private String evaluateRisk(List<String> modificationTypes) {
    if(modificationTypes == null || modificationTypes.isEmpty()) {
      return "LOW";
    }
    if(hasType(modificationTypes, "QUEST_ID_CHANGED")
        || hasType(modificationTypes, "GOAL_DELETED")
        || hasType(modificationTypes, "REWARD_DELETED")) {
      return "HIGH";
    }
    if(hasType(modificationTypes, "GOAL_ITEM_COUNT_CHANGED")
        || hasType(modificationTypes, "REWARD_STRUCTURE_CHANGED")) {
      return "MEDIUM";
    }
    return "LOW";
  }

  private String buildReason(List<String> modificationTypes, GraphNpcRelation relation) {
    if(modificationTypes == null || modificationTypes.isEmpty()) {
      return "no structural change";
    }
    if(hasType(modificationTypes, "QUEST_ID_CHANGED")) {
      return "questId changed, NPC runtime reference may break";
    }
    if(hasType(modificationTypes, "GOAL_DELETED")) {
      return relation != null && relation.hasRole("GOAL_VERIFY")
          ? "goal removed while NPC has GOAL_VERIFY role"
          : "goal removed";
    }
    if(hasType(modificationTypes, "REWARD_DELETED")) {
      return relation != null && relation.hasRole("REWARD_TRIGGER")
          ? "reward removed while NPC has REWARD_TRIGGER role"
          : "reward removed";
    }
    if(hasType(modificationTypes, "GOAL_ITEM_COUNT_CHANGED")) {
      return relation != null && relation.hasRole("GOAL_VERIFY")
          ? "goal.getItem size changed and NPC verifies goal"
          : "goal.getItem size changed";
    }
    if(hasType(modificationTypes, "REWARD_STRUCTURE_CHANGED")) {
      return relation != null && relation.hasRole("REWARD_TRIGGER")
          ? "reward structure changed and NPC triggers reward flow"
          : "reward structure changed";
    }
    if(hasType(modificationTypes, "NEED_LEVEL_CHANGED")) {
      return "needLevel changed";
    }
    if(hasType(modificationTypes, "TEXT_CHANGED")) {
      return "dialog/text content changed";
    }
    return "quest structure changed";
  }

  private String buildPath(int questId, GraphNpcRelation relation) {
    if(relation == null) {
      return "quest:" + questId;
    }
    return "quest:" + questId + " -> npc:" + relation.file + "(id=" + relation.npcId + ") -> roles:" + relation.roles;
  }

  private boolean hasType(List<String> types, String target) {
    for(String type : types) {
      if(target.equals(type)) {
        return true;
      }
    }
    return false;
  }

  private List<QuestChange> detectChanges(Map<Integer, QuestSemanticModel> oldMap,
                                          Map<Integer, QuestSemanticModel> newMap) {
    Set<Integer> union = new LinkedHashSet<Integer>();
    union.addAll(oldMap.keySet());
    union.addAll(newMap.keySet());

    List<QuestChange> out = new ArrayList<QuestChange>();
    for(Integer idObj : union) {
      if(idObj == null) {
        continue;
      }
      int questId = idObj.intValue();
      QuestSemanticModel oldModel = oldMap.get(Integer.valueOf(questId));
      QuestSemanticModel newModel = newMap.get(Integer.valueOf(questId));

      QuestChange change = new QuestChange();
      change.questId = questId;

      if(oldModel == null || newModel == null) {
        change.modificationTypes.add("QUEST_ID_CHANGED");
        out.add(change);
        continue;
      }

      boolean oldHasGoal = hasGoal(oldModel);
      boolean newHasGoal = hasGoal(newModel);
      if(oldHasGoal && !newHasGoal) {
        change.modificationTypes.add("GOAL_DELETED");
      }

      int oldGoalItemCount = goalItemCount(oldModel);
      int newGoalItemCount = goalItemCount(newModel);
      if(oldGoalItemCount != newGoalItemCount) {
        change.modificationTypes.add("GOAL_ITEM_COUNT_CHANGED");
      }

      boolean oldHasReward = hasReward(oldModel);
      boolean newHasReward = hasReward(newModel);
      if(oldHasReward && !newHasReward) {
        change.modificationTypes.add("REWARD_DELETED");
      } else if(oldHasReward || newHasReward) {
        if(!rewardSignature(oldModel).equals(rewardSignature(newModel))) {
          change.modificationTypes.add("REWARD_STRUCTURE_CHANGED");
        }
      }

      int oldNeedLevel = needLevel(oldModel);
      int newNeedLevel = needLevel(newModel);
      if(oldNeedLevel != newNeedLevel) {
        change.modificationTypes.add("NEED_LEVEL_CHANGED");
      }

      if(isTextChanged(oldModel, newModel)) {
        change.modificationTypes.add("TEXT_CHANGED");
      }

      if(!change.modificationTypes.isEmpty()) {
        out.add(change);
      }
    }
    return out;
  }

  private boolean hasGoal(QuestSemanticModel model) {
    if(model == null || model.goal == null) {
      return false;
    }
    if(model.goal.needLevel > 0) {
      return true;
    }
    return !model.goal.items.isEmpty() || !model.goal.monsters.isEmpty();
  }

  private int goalItemCount(QuestSemanticModel model) {
    if(model == null || model.goal == null || model.goal.items == null) {
      return 0;
    }
    return model.goal.items.size();
  }

  private boolean hasReward(QuestSemanticModel model) {
    if(model == null || model.rewards == null || model.rewards.isEmpty()) {
      return false;
    }
    for(QuestSemanticModel.Reward reward : model.rewards) {
      if(reward == null) {
        continue;
      }
      if(reward.id != 0 || reward.count != 0 || reward.exp != 0 || reward.fame != 0 || reward.money != 0 || reward.pvppoint != 0) {
        return true;
      }
      if(!reward.skillIds.isEmpty()) {
        return true;
      }
      if(!reward.extraFields.isEmpty()) {
        return true;
      }
    }
    return false;
  }

  private String rewardSignature(QuestSemanticModel model) {
    if(model == null || model.rewards == null || model.rewards.isEmpty()) {
      return "";
    }
    StringBuilder sb = new StringBuilder();
    sb.append("count=").append(model.rewards.size()).append(';');
    for(QuestSemanticModel.Reward reward : model.rewards) {
      if(reward == null) {
        sb.append("null;");
        continue;
      }
      sb.append(reward.type).append('|')
          .append(reward.id).append('|')
          .append(reward.count).append('|')
          .append(reward.money).append('|')
          .append(reward.exp).append('|')
          .append(reward.fame).append('|')
          .append(reward.pvppoint).append('|')
          .append(reward.skillIds).append('|')
          .append(reward.extraFields.keySet()).append('|')
          .append(reward.fieldOrder).append(';');
    }
    return sb.toString();
  }

  private int needLevel(QuestSemanticModel model) {
    if(model == null) {
      return 0;
    }
    if(model.goal != null && model.goal.needLevel > 0) {
      return model.goal.needLevel;
    }
    Object value = model.conditions == null ? null : model.conditions.get("needLevel");
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

  private boolean isTextChanged(QuestSemanticModel oldModel, QuestSemanticModel newModel) {
    if(!safe(oldModel.title).equals(safe(newModel.title))) {
      return true;
    }
    if(!safe(oldModel.description).equals(safe(newModel.description))) {
      return true;
    }
    if(oldModel.dialogLines == null && newModel.dialogLines == null) {
      return false;
    }
    if(oldModel.dialogLines == null || newModel.dialogLines == null) {
      return true;
    }
    if(oldModel.dialogLines.size() != newModel.dialogLines.size()) {
      return true;
    }
    for(int i = 0; i < oldModel.dialogLines.size(); i++) {
      if(!safe(oldModel.dialogLines.get(i)).equals(safe(newModel.dialogLines.get(i)))) {
        return true;
      }
    }
    return false;
  }

  private Map<Integer, QuestSemanticModel> loadQuestModels(Path lucPath) throws Exception {
    byte[] data = Files.readAllBytes(lucPath);
    LuaChunk chunk = new Lua50ChunkParser().parse(data);
    QuestSemanticExtractor extractor = new QuestSemanticExtractor();
    QuestSemanticExtractor.ExtractionResult extraction = extractor.extract(chunk);

    Map<Integer, QuestSemanticModel> out = new LinkedHashMap<Integer, QuestSemanticModel>();
    for(QuestSemanticModel model : extraction.quests) {
      if(model == null || model.questId <= 0) {
        continue;
      }
      out.put(Integer.valueOf(model.questId), model);
    }
    return out;
  }

  @SuppressWarnings("unchecked")
  private GraphIndex loadGraph(Path graphJsonPath) throws Exception {
    String json = new String(Files.readAllBytes(graphJsonPath), UTF8);
    Map<String, Object> root = QuestSemanticJson.parseObject(json, "quest_npc_graph", 0);

    GraphIndex graph = new GraphIndex();
    Object questsObj = root.get("quests");
    if(!(questsObj instanceof Map<?, ?>)) {
      return graph;
    }

    Map<String, Object> quests = (Map<String, Object>) questsObj;
    for(Map.Entry<String, Object> entry : quests.entrySet()) {
      int questId = parseIntSafe(entry.getKey());
      if(questId <= 0) {
        continue;
      }
      if(!(entry.getValue() instanceof Map<?, ?>)) {
        continue;
      }
      Map<String, Object> nodeMap = (Map<String, Object>) entry.getValue();
      GraphQuestNode node = new GraphQuestNode();
      node.questId = questId;
      node.questName = stringOf(nodeMap.get("questName"));

      Object relationsObj = nodeMap.get("npcRelations");
      if(relationsObj instanceof List<?>) {
        for(Object relationObj : (List<Object>) relationsObj) {
          if(!(relationObj instanceof Map<?, ?>)) {
            continue;
          }
          Map<String, Object> relationMap = (Map<String, Object>) relationObj;
          GraphNpcRelation relation = new GraphNpcRelation();
          relation.npcId = intOf(relationMap.get("npcId"));
          relation.file = stringOf(relationMap.get("file"));
          relation.readsGoal = boolOf(relationMap.get("readsGoal"));
          relation.writesState = boolOf(relationMap.get("writesState"));
          relation.callsReward = boolOf(relationMap.get("callsReward"));

          Object rolesObj = relationMap.get("roles");
          if(rolesObj instanceof List<?>) {
            for(Object roleObj : (List<Object>) rolesObj) {
              String role = stringOf(roleObj);
              if(!role.isEmpty()) {
                relation.roles.add(role);
              }
            }
          }

          node.npcRelations.add(relation);
        }
      }
      graph.quests.put(Integer.valueOf(questId), node);
    }
    return graph;
  }

  private String safe(String text) {
    return text == null ? "" : text;
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
    System.out.println("  java -cp build unluac.semantic.QuestModificationPropagationAnalyzer <old.luc> <new.luc> <quest_npc_graph.json> <output.json>");
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

  private static final class QuestChange {
    int questId;
    final List<String> modificationTypes = new ArrayList<String>();
  }

  private static final class GraphIndex {
    final Map<Integer, GraphQuestNode> quests = new LinkedHashMap<Integer, GraphQuestNode>();
  }

  private static final class GraphQuestNode {
    int questId;
    String questName = "";
    final List<GraphNpcRelation> npcRelations = new ArrayList<GraphNpcRelation>();
  }

  private static final class GraphNpcRelation {
    int npcId;
    String file = "";
    final List<String> roles = new ArrayList<String>();
    boolean readsGoal;
    boolean writesState;
    boolean callsReward;

    boolean hasRole(String role) {
      for(String current : roles) {
        if(role.equals(current)) {
          return true;
        }
      }
      return false;
    }
  }

  public static final class PropagationReport {
    public String generatedAt;
    public int affectedNpcCount;
    public int rewriteRequiredCount;
    public int autoSafeCount;
    public final List<QuestPropagation> quests = new ArrayList<QuestPropagation>();

    public String toJson() {
      StringBuilder sb = new StringBuilder();
      sb.append("{\n");
      sb.append("  \"generatedAt\": \"").append(escapeJson(generatedAt)).append("\",\n");
      sb.append("  \"affectedNpcCount\": ").append(affectedNpcCount).append(",\n");
      sb.append("  \"rewriteRequiredCount\": ").append(rewriteRequiredCount).append(",\n");
      sb.append("  \"autoSafeCount\": ").append(autoSafeCount).append(",\n");
      sb.append("  \"quests\": [");

      if(!quests.isEmpty()) {
        sb.append("\n");
      }
      for(int i = 0; i < quests.size(); i++) {
        if(i > 0) {
          sb.append(",\n");
        }
        sb.append(quests.get(i).toJson("    "));
      }
      if(!quests.isEmpty()) {
        sb.append("\n");
      }
      sb.append("  ]\n");
      sb.append("}\n");
      return sb.toString();
    }
  }

  public static final class QuestPropagation {
    public int questId;
    public final List<String> modificationType = new ArrayList<String>();
    public int affectedNpcCount;
    public final List<AffectedNpc> affectedNpcs = new ArrayList<AffectedNpc>();
    public boolean safeToAutoApply;

    String toJson(String indent) {
      String next = indent + "  ";
      StringBuilder sb = new StringBuilder();
      sb.append(indent).append("{\n");
      sb.append(next).append("\"questId\": ").append(questId).append(",\n");
      sb.append(next).append("\"modificationType\": [");
      for(int i = 0; i < modificationType.size(); i++) {
        if(i > 0) {
          sb.append(", ");
        }
        sb.append("\"").append(escapeJson(modificationType.get(i))).append("\"");
      }
      sb.append("],\n");
      sb.append(next).append("\"affectedNpcCount\": ").append(affectedNpcCount).append(",\n");
      sb.append(next).append("\"affectedNpcs\": [");

      if(!affectedNpcs.isEmpty()) {
        sb.append("\n");
      }
      for(int i = 0; i < affectedNpcs.size(); i++) {
        if(i > 0) {
          sb.append(",\n");
        }
        sb.append(affectedNpcs.get(i).toJson(next + "  "));
      }
      if(!affectedNpcs.isEmpty()) {
        sb.append("\n").append(next);
      }
      sb.append("],\n");
      sb.append(next).append("\"safeToAutoApply\": ").append(safeToAutoApply).append("\n");
      sb.append(indent).append("}");
      return sb.toString();
    }
  }

  public static final class AffectedNpc {
    public int npcId;
    public String file = "";
    public String riskLevel = "LOW";
    public String reason = "";
    public boolean rewriteRequired;
    public String propagationPath = "";
    public final List<String> roles = new ArrayList<String>();

    String toJson(String indent) {
      String next = indent + "  ";
      StringBuilder sb = new StringBuilder();
      sb.append(indent).append("{\n");
      sb.append(next).append("\"npcId\": ").append(npcId).append(",\n");
      sb.append(next).append("\"file\": \"").append(escapeJson(file)).append("\",\n");
      sb.append(next).append("\"riskLevel\": \"").append(escapeJson(riskLevel)).append("\",\n");
      sb.append(next).append("\"reason\": \"").append(escapeJson(reason)).append("\",\n");
      sb.append(next).append("\"rewriteRequired\": ").append(rewriteRequired).append(",\n");
      sb.append(next).append("\"propagationPath\": \"").append(escapeJson(propagationPath)).append("\",\n");
      sb.append(next).append("\"roles\": [");
      for(int i = 0; i < roles.size(); i++) {
        if(i > 0) {
          sb.append(", ");
        }
        sb.append("\"").append(escapeJson(roles.get(i))).append("\"");
      }
      sb.append("]\n");
      sb.append(indent).append("}");
      return sb.toString();
    }
  }
}

