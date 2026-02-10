package unluac.semantic;

import java.nio.charset.Charset;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.OffsetDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Set;

public class RuntimeConsistencyValidator {

  private static final Charset UTF8 = Charset.forName("UTF-8");

  public static void main(String[] args) throws Exception {
    Path rewrittenNpcDir = args.length >= 1
        ? Paths.get(args[0])
        : Paths.get("npc-lua-auto-rewritten");
    Path dependencyIndexPath = args.length >= 2
        ? Paths.get(args[1])
        : Paths.get("reports", "auto_rewrite_dependency_index.json");
    Path propagationV2Path = args.length >= 3
        ? Paths.get(args[2])
        : Paths.get("reports", "quest_modification_propagation_v2.json");
    Path reportOut = args.length >= 4
        ? Paths.get(args[3])
        : Paths.get("reports", "runtime_final_validation.json");

    RuntimeConsistencyValidator validator = new RuntimeConsistencyValidator();
    ValidationReport report = validator.validate(rewrittenNpcDir, dependencyIndexPath, propagationV2Path, reportOut);

    System.out.println("rewrittenNpcDir=" + rewrittenNpcDir.toAbsolutePath());
    System.out.println("dependencyIndex=" + dependencyIndexPath.toAbsolutePath());
    System.out.println("propagationV2=" + propagationV2Path.toAbsolutePath());
    System.out.println("reportOut=" + reportOut.toAbsolutePath());
    System.out.println("totalValidatedQuests=" + report.totalValidatedQuests);
    System.out.println("totalValidatedNpcs=" + report.totalValidatedNpcs);
    System.out.println("failedCount=" + report.failedCount);
    System.out.println("finalStatus=" + report.finalStatus);
  }

  public ValidationReport validate(Path rewrittenNpcDir,
                                   Path dependencyIndexPath,
                                   Path propagationV2Path,
                                   Path reportOut) throws Exception {
    if(rewrittenNpcDir == null || !Files.exists(rewrittenNpcDir) || !Files.isDirectory(rewrittenNpcDir)) {
      throw new IllegalStateException("rewritten npc dir not found: " + rewrittenNpcDir);
    }
    if(dependencyIndexPath == null || !Files.exists(dependencyIndexPath)) {
      throw new IllegalStateException("dependency index not found: " + dependencyIndexPath);
    }
    if(propagationV2Path == null || !Files.exists(propagationV2Path)) {
      throw new IllegalStateException("propagation v2 not found: " + propagationV2Path);
    }

    QuestNpcGraphBuilder graphBuilder = new QuestNpcGraphBuilder();
    QuestNpcDependencyGraph graph = graphBuilder.buildGraph(dependencyIndexPath, propagationV2Path, false);

    ValidationReport report = new ValidationReport();
    report.generatedAt = OffsetDateTime.now().format(DateTimeFormatter.ISO_OFFSET_DATE_TIME);
    report.totalValidatedQuests = graph.questNodes.size();
    report.totalValidatedNpcs = graph.npcNodes.size();

    Set<String> existingNpcFiles = collectNpcFiles(rewrittenNpcDir);

    validateNoHardcodedIndexes(graph, report);
    validateReferencedNpcFilesExist(graph, existingNpcFiles, report);
    validateNpcReferencedQuestIds(graph, report);
    validateRiskLevelThreshold(graph, report);
    validateRewardStructureConsistency(propagationV2Path, report);

    report.failedCount = report.failureDetails.size();
    report.finalStatus = report.failedCount == 0 ? "SAFE" : "UNSAFE";

    if(reportOut.getParent() != null && !Files.exists(reportOut.getParent())) {
      Files.createDirectories(reportOut.getParent());
    }
    Files.write(reportOut, report.toJson().getBytes(UTF8));
    return report;
  }

  private void validateNoHardcodedIndexes(QuestNpcDependencyGraph graph, ValidationReport report) {
    for(NpcNode npcNode : graph.npcNodes.values()) {
      if(npcNode == null || npcNode.hardcodedGoalIndexes == null || npcNode.hardcodedGoalIndexes.isEmpty()) {
        continue;
      }
      FailureDetail detail = new FailureDetail();
      detail.rule = "RULE_1_NO_HARDCODED_GOAL_INDEX";
      detail.entityType = "NPC";
      detail.entityId = npcNode.filePath;
      detail.message = "hardcodedGoalIndexes=" + npcNode.hardcodedGoalIndexes.toString();
      report.failureDetails.add(detail);
    }
  }

  private void validateReferencedNpcFilesExist(QuestNpcDependencyGraph graph,
                                               Set<String> existingNpcFiles,
                                               ValidationReport report) {
    for(QuestNode questNode : graph.questNodes.values()) {
      if(questNode == null || questNode.referencedNpcFiles == null) {
        continue;
      }
      for(String npcFile : questNode.referencedNpcFiles) {
        String normalized = normalizePath(npcFile);
        if(normalized.isEmpty() || existingNpcFiles.contains(normalized)) {
          continue;
        }
        FailureDetail detail = new FailureDetail();
        detail.rule = "RULE_2_REFERENCED_NPC_FILE_EXISTS";
        detail.entityType = "QUEST";
        detail.entityId = Integer.toString(questNode.questId);
        detail.message = "missing npc file: " + normalized;
        report.failureDetails.add(detail);
      }
    }
  }

  private void validateNpcReferencedQuestIds(QuestNpcDependencyGraph graph,
                                             ValidationReport report) {
    for(NpcNode npcNode : graph.npcNodes.values()) {
      if(npcNode == null || npcNode.referencedQuestIds == null) {
        continue;
      }
      for(Integer questId : npcNode.referencedQuestIds) {
        if(questId == null) {
          continue;
        }
        if(graph.questNodes.containsKey(questId)) {
          continue;
        }
        FailureDetail detail = new FailureDetail();
        detail.rule = "RULE_3_NPC_REFERENCED_QUEST_EXISTS";
        detail.entityType = "NPC";
        detail.entityId = npcNode.filePath;
        detail.message = "missing quest node for referencedQuestId=" + questId.intValue();
        report.failureDetails.add(detail);
      }
    }
  }

  private void validateRiskLevelThreshold(QuestNpcDependencyGraph graph,
                                          ValidationReport report) {
    for(QuestNode questNode : graph.questNodes.values()) {
      String risk = normalizeRisk(questNode == null ? null : questNode.riskLevel);
      if(riskRank(risk) > riskRank("MEDIUM")) {
        FailureDetail detail = new FailureDetail();
        detail.rule = "RULE_4_RISK_LEVEL_THRESHOLD";
        detail.entityType = "QUEST";
        detail.entityId = questNode == null ? "" : Integer.toString(questNode.questId);
        detail.message = "quest riskLevel=" + risk + " exceeds MEDIUM";
        report.failureDetails.add(detail);
      }
    }

    for(NpcNode npcNode : graph.npcNodes.values()) {
      String risk = normalizeRisk(npcNode == null ? null : npcNode.riskLevel);
      if(riskRank(risk) > riskRank("MEDIUM")) {
        FailureDetail detail = new FailureDetail();
        detail.rule = "RULE_4_RISK_LEVEL_THRESHOLD";
        detail.entityType = "NPC";
        detail.entityId = npcNode == null ? "" : npcNode.filePath;
        detail.message = "npc riskLevel=" + risk + " exceeds MEDIUM";
        report.failureDetails.add(detail);
      }
    }
  }

  @SuppressWarnings("unchecked")
  private void validateRewardStructureConsistency(Path propagationV2Path,
                                                  ValidationReport report) throws Exception {
    String json = new String(Files.readAllBytes(propagationV2Path), UTF8);
    Map<String, Object> root = QuestSemanticJson.parseObject(json, "quest_modification_propagation_v2", 0);

    Object questsObj = root.get("quests");
    if(!(questsObj instanceof List<?>)) {
      return;
    }

    for(Object questObj : (List<Object>) questsObj) {
      if(!(questObj instanceof Map<?, ?>)) {
        continue;
      }
      Map<String, Object> quest = (Map<String, Object>) questObj;
      int questId = intOf(quest.get("questId"));
      List<String> mods = parseStringList(quest.get("modificationTypes"));
      if(!mods.contains("REWARD_STRUCTURE_CHANGED")) {
        continue;
      }

      String highestRisk = normalizeRisk(stringOf(quest.get("highestRiskLevel")));
      if(riskRank(highestRisk) > riskRank("MEDIUM")) {
        FailureDetail detail = new FailureDetail();
        detail.rule = "RULE_REWARD_STRUCTURE_MATCH";
        detail.entityType = "QUEST";
        detail.entityId = Integer.toString(questId);
        detail.message = "reward modification highestRiskLevel=" + highestRisk + " exceeds MEDIUM";
        report.failureDetails.add(detail);
      }

      Object chainsObj = quest.get("propagationChains");
      if(!(chainsObj instanceof List<?>)) {
        continue;
      }
      for(Object chainObj : (List<Object>) chainsObj) {
        if(!(chainObj instanceof Map<?, ?>)) {
          continue;
        }
        Map<String, Object> chain = (Map<String, Object>) chainObj;
        String risk = normalizeRisk(stringOf(chain.get("riskLevel")));
        if(riskRank(risk) <= riskRank("MEDIUM")) {
          continue;
        }

        String toNode = stringOf(chain.get("toNode"));
        FailureDetail detail = new FailureDetail();
        detail.rule = "RULE_REWARD_STRUCTURE_MATCH";
        detail.entityType = "NPC";
        detail.entityId = normalizeNpcFromVertex(toNode);
        detail.message = "reward propagation chain riskLevel=" + risk + " exceeds MEDIUM";
        report.failureDetails.add(detail);
      }
    }
  }

  private Set<String> collectNpcFiles(Path rewrittenNpcDir) throws Exception {
    Set<String> files = new LinkedHashSet<String>();
    Files.walk(rewrittenNpcDir)
        .filter(Files::isRegularFile)
        .forEach(path -> {
          String name = path.getFileName().toString().toLowerCase(Locale.ROOT);
          if(name.startsWith("npc_") && name.endsWith(".lua")) {
            files.add(normalizePath(rewrittenNpcDir.relativize(path).toString()));
          }
        });
    return files;
  }

  @SuppressWarnings("unchecked")
  private List<String> parseStringList(Object value) {
    if(!(value instanceof List<?>)) {
      return Collections.emptyList();
    }
    List<String> out = new ArrayList<String>();
    for(Object item : (List<Object>) value) {
      String text = stringOf(item).trim().toUpperCase(Locale.ROOT);
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

  private String normalizeNpcFromVertex(String vertex) {
    if(vertex == null) {
      return "";
    }
    String text = vertex.trim();
    if(text.startsWith("N:")) {
      return normalizePath(text.substring(2));
    }
    return normalizePath(text);
  }

  private String normalizePath(String text) {
    if(text == null) {
      return "";
    }
    return text.replace('\\', '/').trim();
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

  public static final class ValidationReport {
    public String generatedAt = "";
    public int totalValidatedQuests;
    public int totalValidatedNpcs;
    public int failedCount;
    public final List<FailureDetail> failureDetails = new ArrayList<FailureDetail>();
    public String finalStatus = "SAFE";

    public String toJson() {
      StringBuilder sb = new StringBuilder();
      sb.append("{\n");
      sb.append("  \"generatedAt\": \"").append(escape(generatedAt)).append("\",\n");
      sb.append("  \"totalValidatedQuests\": ").append(totalValidatedQuests).append(",\n");
      sb.append("  \"totalValidatedNpcs\": ").append(totalValidatedNpcs).append(",\n");
      sb.append("  \"failedCount\": ").append(failedCount).append(",\n");
      sb.append("  \"failureDetails\": [");
      if(!failureDetails.isEmpty()) {
        sb.append("\n");
      }
      for(int i = 0; i < failureDetails.size(); i++) {
        if(i > 0) {
          sb.append(",\n");
        }
        FailureDetail detail = failureDetails.get(i);
        sb.append("    {");
        sb.append("\"rule\": \"").append(escape(detail.rule)).append("\", ");
        sb.append("\"entityType\": \"").append(escape(detail.entityType)).append("\", ");
        sb.append("\"entityId\": \"").append(escape(detail.entityId)).append("\", ");
        sb.append("\"message\": \"").append(escape(detail.message)).append("\"");
        sb.append("}");
      }
      if(!failureDetails.isEmpty()) {
        sb.append("\n");
      }
      sb.append("  ],\n");
      sb.append("  \"finalStatus\": \"").append(escape(finalStatus)).append("\"\n");
      sb.append("}\n");
      return sb.toString();
    }
  }

  public static final class FailureDetail {
    public String rule = "";
    public String entityType = "";
    public String entityId = "";
    public String message = "";
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

