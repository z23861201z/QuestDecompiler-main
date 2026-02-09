package unluac.semantic;

import java.nio.charset.Charset;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Collections;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import unluac.chunk.Lua50ChunkParser;
import unluac.chunk.LuaChunk;
import unluac.editor.QuestEditorModel;
import unluac.editor.QuestReward;

public class QuestModificationRiskValidator {

  private static final Charset UTF8 = Charset.forName("UTF-8");

  public static void main(String[] args) throws Exception {
    if(args.length < 3) {
      printUsage();
      return;
    }

    Path sourceLuc = Paths.get(args[0]);
    Path editedCsv = Paths.get(args[1]);
    Path npcLuaDirectory = Paths.get(args[2]);
    Path indexOut = args.length >= 4
        ? Paths.get(args[3])
        : Paths.get("reports", "quest_npc_dependency_index.json");
    Path reportOut = args.length >= 5
        ? Paths.get(args[4])
        : Paths.get("reports", "quest_modification_risk_report.json");

    List<QuestSemanticCsvTool.CsvQuestRow> editedRows = QuestSemanticCsvTool.importCsv(editedCsv);
    ValidationResult result = validateBeforeSaveCsv(sourceLuc, editedRows, npcLuaDirectory, indexOut, reportOut);

    System.out.println("source_luc=" + sourceLuc.toAbsolutePath());
    System.out.println("edited_csv=" + editedCsv.toAbsolutePath());
    System.out.println("npc_dir=" + npcLuaDirectory.toAbsolutePath());
    System.out.println("index_json=" + indexOut.toAbsolutePath());
    System.out.println("risk_json=" + reportOut.toAbsolutePath());
    System.out.println("blocked=" + result.blocked);
    System.out.println("issue_count=" + result.issues.size());
  }

  public static ValidationResult validateBeforeSave(Path sourceLuc,
                                                    List<QuestEditorModel> rows,
                                                    Path npcLuaDirectory,
                                                    Path indexOut,
                                                    Path riskOut) throws Exception {
    QuestNpcDependencyScanner.DependencyIndex index = QuestNpcDependencyScanner.scanDirectory(npcLuaDirectory);
    QuestNpcDependencyScanner.writeIndex(index, indexOut);

    List<QuestDelta> deltas = detectQuestDeltasFromEditorRows(sourceLuc, rows);
    return validate(index, deltas, riskOut);
  }

  public static ValidationResult validateBeforeSaveCsv(Path sourceLuc,
                                                       List<QuestSemanticCsvTool.CsvQuestRow> rows,
                                                       Path npcLuaDirectory,
                                                       Path indexOut,
                                                       Path riskOut) throws Exception {
    QuestNpcDependencyScanner.DependencyIndex index = QuestNpcDependencyScanner.scanDirectory(npcLuaDirectory);
    QuestNpcDependencyScanner.writeIndex(index, indexOut);

    List<QuestDelta> deltas = detectQuestDeltas(sourceLuc, rows);
    return validate(index, deltas, riskOut);
  }

  public static ValidationResult validate(QuestNpcDependencyScanner.DependencyIndex index,
                                          List<QuestDelta> deltas,
                                          Path riskOut) throws Exception {
    ValidationResult result = new ValidationResult();
    if(index == null || deltas == null || deltas.isEmpty()) {
      writeReport(result, riskOut);
      return result;
    }

    Map<String, QuestNpcDependencyScanner.QuestDependencyRecord> byQuest = index.quests;
    for(QuestDelta delta : deltas) {
      QuestNpcDependencyScanner.QuestDependencyRecord dep = byQuest.get(Integer.toString(delta.questId));
      if(dep == null || dep.npcFiles.isEmpty()) {
        continue;
      }

      for(String modificationType : delta.modificationTypes) {
        if(!isBlockingType(modificationType)) {
          continue;
        }

        RiskIssue issue = new RiskIssue();
        issue.questId = delta.questId;
        issue.modificationType = modificationType;
        for(QuestNpcDependencyScanner.NpcReference ref : dep.npcFiles) {
          AffectedNpc affected = new AffectedNpc();
          affected.file = ref.file;
          affected.risk = ref.riskLevel;
          affected.reason = buildReason(modificationType, ref);
          issue.affectedNpcFiles.add(affected);
        }
        result.issues.add(issue);
      }
    }

    result.blocked = !result.issues.isEmpty();
    writeReport(result, riskOut);
    if(result.blocked) {
      throw new IllegalStateException("quest modification risk detected, see report: " + riskOut.toAbsolutePath());
    }
    return result;
  }

  public static List<QuestDelta> detectQuestDeltas(Path sourceLuc) throws Exception {
    byte[] data = Files.readAllBytes(sourceLuc);
    Lua50ChunkParser parser = new Lua50ChunkParser();
    LuaChunk chunk = parser.parse(data);
    QuestSemanticExtractor extractor = new QuestSemanticExtractor();
    QuestSemanticExtractor.ExtractionResult extraction = extractor.extract(chunk);

    Map<Integer, QuestSemanticModel> original = new LinkedHashMap<Integer, QuestSemanticModel>();
    for(QuestSemanticModel model : extraction.quests) {
      original.put(Integer.valueOf(model.questId), model);
    }
    return buildNoChangeDeltas(original);
  }

  public static List<QuestDelta> detectQuestDeltas(Path sourceLuc,
                                                   List<QuestSemanticCsvTool.CsvQuestRow> editedRows) throws Exception {
    byte[] data = Files.readAllBytes(sourceLuc);
    Lua50ChunkParser parser = new Lua50ChunkParser();
    LuaChunk chunk = parser.parse(data);
    QuestSemanticExtractor extractor = new QuestSemanticExtractor();
    QuestSemanticExtractor.ExtractionResult extraction = extractor.extract(chunk);

    Map<Integer, QuestSemanticModel> original = new LinkedHashMap<Integer, QuestSemanticModel>();
    for(QuestSemanticModel model : extraction.quests) {
      original.put(Integer.valueOf(model.questId), model);
    }

    if(editedRows == null || editedRows.isEmpty()) {
      return Collections.emptyList();
    }

    List<QuestDelta> out = new ArrayList<QuestDelta>();
    for(QuestSemanticCsvTool.CsvQuestRow row : editedRows) {
      if(row == null) {
        continue;
      }
      QuestSemanticModel before = original.get(Integer.valueOf(row.questId));
      if(before == null) {
        continue;
      }

      QuestDelta delta = new QuestDelta();
      delta.questId = row.questId;

      if(row.questId != before.questId) {
        delta.modificationTypes.add("questId_changed");
      }

      QuestGoal beforeGoal = before.goal == null ? new QuestGoal() : before.goal;
      QuestGoal afterGoal = row.goal == null ? new QuestGoal() : row.goal;
      if(before.goal != null && row.goal == null) {
        delta.modificationTypes.add("goal_deleted");
      }

      int beforeGetItemCount = beforeGoal.items == null ? 0 : beforeGoal.items.size();
      int afterGetItemCount = afterGoal.items == null ? 0 : afterGoal.items.size();
      if(beforeGetItemCount != afterGetItemCount) {
        delta.modificationTypes.add("getItem_count_changed");
      }

      if(!sameGoalItemOrder(beforeGoal, afterGoal)) {
        delta.modificationTypes.add("goal_array_order_changed");
      }

      List<QuestReward.ItemReward> beforeItems = flattenRewardItems(before);
      List<QuestReward.ItemReward> afterItems = toItemRewards(row);
      if(!sameRewardItemOrder(beforeItems, afterItems)) {
        delta.modificationTypes.add("reward_array_order_changed");
      }

      if(hasRewardDeleted(before, row)) {
        delta.modificationTypes.add("reward_deleted");
      }

      if(!delta.modificationTypes.isEmpty()) {
        out.add(delta);
      }
    }
    return out;
  }

  public static List<QuestDelta> detectQuestDeltasFromEditorRows(Path sourceLuc, List<QuestEditorModel> editedRows) throws Exception {
    byte[] data = Files.readAllBytes(sourceLuc);
    Lua50ChunkParser parser = new Lua50ChunkParser();
    LuaChunk chunk = parser.parse(data);
    QuestSemanticExtractor extractor = new QuestSemanticExtractor();
    QuestSemanticExtractor.ExtractionResult extraction = extractor.extract(chunk);

    Map<Integer, QuestSemanticModel> original = new LinkedHashMap<Integer, QuestSemanticModel>();
    for(QuestSemanticModel model : extraction.quests) {
      original.put(Integer.valueOf(model.questId), model);
    }

    List<QuestDelta> out = new ArrayList<QuestDelta>();
    if(editedRows == null) {
      return out;
    }
    for(QuestEditorModel row : editedRows) {
      if(row == null || !row.dirty) {
        continue;
      }
      QuestSemanticModel before = original.get(Integer.valueOf(row.questId));
      if(before == null) {
        continue;
      }

      QuestDelta delta = new QuestDelta();
      delta.questId = row.questId;

      if(row.questId != before.questId) {
        delta.modificationTypes.add("questId_changed");
      }

      QuestGoal beforeGoal = before.goal == null ? new QuestGoal() : before.goal;
      QuestGoal afterGoal = row.goal == null ? new QuestGoal() : row.goal;

      if(before.goal != null && row.goal == null) {
        delta.modificationTypes.add("goal_deleted");
      }

      int beforeGetItemCount = beforeGoal.items == null ? 0 : beforeGoal.items.size();
      int afterGetItemCount = afterGoal.items == null ? 0 : afterGoal.items.size();
      if(beforeGetItemCount != afterGetItemCount) {
        delta.modificationTypes.add("getItem_count_changed");
      }

      if(!sameGoalItemOrder(beforeGoal, afterGoal)) {
        delta.modificationTypes.add("goal_array_order_changed");
      }

      List<QuestReward.ItemReward> beforeItems = flattenRewardItems(before);
      List<QuestReward.ItemReward> afterItems = toItemRewards(row);
      if(!sameRewardItemOrder(beforeItems, afterItems)) {
        delta.modificationTypes.add("reward_array_order_changed");
      }

      if(hasRewardDeleted(before, row)) {
        delta.modificationTypes.add("reward_deleted");
      }

      if(!delta.modificationTypes.isEmpty()) {
        out.add(delta);
      }
    }
    return out;
  }

  private static List<QuestDelta> buildNoChangeDeltas(Map<Integer, QuestSemanticModel> original) {
    if(original == null || original.isEmpty()) {
      return Collections.emptyList();
    }
    return new ArrayList<QuestDelta>();
  }

  private static boolean sameGoalItemOrder(QuestGoal before, QuestGoal after) {
    List<ItemRequirement> a = before.items == null ? Collections.<ItemRequirement>emptyList() : before.items;
    List<ItemRequirement> b = after.items == null ? Collections.<ItemRequirement>emptyList() : after.items;
    if(a.size() != b.size()) {
      return false;
    }
    for(int i = 0; i < a.size(); i++) {
      ItemRequirement x = a.get(i);
      ItemRequirement y = b.get(i);
      if(x == null && y == null) {
        continue;
      }
      if(x == null || y == null) {
        return false;
      }
      if(x.itemId != y.itemId || x.itemCount != y.itemCount || x.meetCount != y.meetCount) {
        return false;
      }
    }
    return true;
  }

  private static List<QuestReward.ItemReward> flattenRewardItems(QuestSemanticModel before) {
    List<QuestReward.ItemReward> out = new ArrayList<QuestReward.ItemReward>();
    if(before == null || before.rewards == null) {
      return out;
    }
    for(QuestSemanticModel.Reward reward : before.rewards) {
      if(reward == null || reward.id <= 0 || reward.count <= 0) {
        continue;
      }
      QuestReward.ItemReward item = new QuestReward.ItemReward();
      item.itemId = reward.id;
      item.itemCount = reward.count;
      out.add(item);
    }
    return out;
  }

  private static List<QuestReward.ItemReward> toItemRewards(QuestEditorModel row) {
    if(row == null || row.stage == null || row.stage.reward == null) {
      return Collections.emptyList();
    }
    return row.stage.reward.items;
  }

  private static List<QuestReward.ItemReward> toItemRewards(QuestSemanticCsvTool.CsvQuestRow row) {
    if(row == null || row.rewardItemId == null || row.rewardItemCount == null) {
      return Collections.emptyList();
    }
    int n = Math.min(row.rewardItemId.size(), row.rewardItemCount.size());
    List<QuestReward.ItemReward> out = new ArrayList<QuestReward.ItemReward>(n);
    for(int i = 0; i < n; i++) {
      QuestReward.ItemReward item = new QuestReward.ItemReward();
      item.itemId = row.rewardItemId.get(i).intValue();
      item.itemCount = row.rewardItemCount.get(i).intValue();
      out.add(item);
    }
    return out;
  }

  private static boolean sameRewardItemOrder(List<QuestReward.ItemReward> before, List<QuestReward.ItemReward> after) {
    if(before.size() != after.size()) {
      return false;
    }
    for(int i = 0; i < before.size(); i++) {
      QuestReward.ItemReward a = before.get(i);
      QuestReward.ItemReward b = after.get(i);
      if(a == null && b == null) {
        continue;
      }
      if(a == null || b == null) {
        return false;
      }
      if(a.itemId != b.itemId || a.itemCount != b.itemCount) {
        return false;
      }
    }
    return true;
  }

  private static boolean hasRewardDeleted(QuestSemanticModel before, QuestEditorModel row) {
    int beforeCount = flattenRewardItems(before).size();
    int afterCount = toItemRewards(row).size();
    boolean beforeHasAny = beforeCount > 0 || hasRewardScalar(before);
    boolean afterHasAny = afterCount > 0 || hasRewardScalar(row);
    return beforeHasAny && !afterHasAny;
  }

  private static boolean hasRewardDeleted(QuestSemanticModel before, QuestSemanticCsvTool.CsvQuestRow row) {
    int beforeCount = flattenRewardItems(before).size();
    int afterCount = toItemRewards(row).size();
    boolean beforeHasAny = beforeCount > 0 || hasRewardScalar(before);
    boolean afterHasAny = afterCount > 0 || hasRewardScalar(row);
    return beforeHasAny && !afterHasAny;
  }

  private static boolean hasRewardScalar(QuestSemanticModel before) {
    if(before == null || before.rewards == null) {
      return false;
    }
    for(QuestSemanticModel.Reward reward : before.rewards) {
      if(reward == null) {
        continue;
      }
      if(reward.exp != 0 || reward.fame != 0 || reward.money != 0 || reward.pvppoint != 0) {
        return true;
      }
    }
    return false;
  }

  private static boolean hasRewardScalar(QuestEditorModel row) {
    if(row == null || row.stage == null || row.stage.reward == null) {
      return false;
    }
    QuestReward reward = row.stage.reward;
    return reward.exp != 0 || reward.fame != 0 || reward.money != 0 || reward.pvppoint != 0;
  }

  private static boolean hasRewardScalar(QuestSemanticCsvTool.CsvQuestRow row) {
    if(row == null) {
      return false;
    }
    int fame = intFromConditions(row.conditions, "reward_fame");
    int money = intFromConditions(row.conditions, "reward_money");
    int pvp = intFromConditions(row.conditions, "reward_pvppoint");
    return row.rewardExp != 0 || fame != 0 || money != 0 || pvp != 0;
  }

  private static int intFromConditions(Map<String, Object> conditions, String key) {
    if(conditions == null || key == null) {
      return 0;
    }
    Object value = conditions.get(key);
    if(value instanceof Number) {
      return ((Number) value).intValue();
    }
    if(value instanceof String) {
      try {
        return Integer.parseInt(((String) value).trim());
      } catch(Exception ex) {
        return 0;
      }
    }
    return 0;
  }

  private static boolean isBlockingType(String type) {
    return "questId_changed".equals(type)
        || "getItem_count_changed".equals(type)
        || "goal_deleted".equals(type)
        || "reward_deleted".equals(type)
        || "goal_array_order_changed".equals(type)
        || "reward_array_order_changed".equals(type);
  }

  private static String buildReason(String modificationType, QuestNpcDependencyScanner.NpcReference ref) {
    if("HIGH".equals(ref.riskLevel)) {
      return "hardcoded getItem index access";
    }
    if("getItem_count_changed".equals(modificationType) || "goal_array_order_changed".equals(modificationType)) {
      return "goal index/array dependent access";
    }
    if("reward_deleted".equals(modificationType) || "reward_array_order_changed".equals(modificationType)) {
      return "reward field referenced in npc";
    }
    return "quest structure dependency detected";
  }

  private static void writeReport(ValidationResult result, Path out) throws Exception {
    Path parent = out.getParent();
    if(parent != null && !Files.exists(parent)) {
      Files.createDirectories(parent);
    }
    Files.write(out, result.toJson().getBytes(UTF8));
  }

  private static void printUsage() {
    System.out.println("Usage:");
    System.out.println("  java -cp build unluac.semantic.QuestModificationRiskValidator <source.luc> <edited.csv> <npc-lua-dir> [index.json] [risk.json]");
  }

  public static final class QuestDelta {
    public int questId;
    public final List<String> modificationTypes = new ArrayList<String>();
  }

  public static final class ValidationResult {
    public boolean blocked;
    public final List<RiskIssue> issues = new ArrayList<RiskIssue>();

    public String toJson() {
      StringBuilder sb = new StringBuilder();
      sb.append("{\n");
      sb.append("  \"blocked\": ").append(blocked).append(",\n");
      sb.append("  \"issues\": [\n");
      for(int i = 0; i < issues.size(); i++) {
        if(i > 0) {
          sb.append(",\n");
        }
        sb.append(issues.get(i).toJson("    "));
      }
      sb.append("\n  ]\n");
      sb.append("}\n");
      return sb.toString();
    }
  }

  public static final class RiskIssue {
    public int questId;
    public String modificationType;
    public final List<AffectedNpc> affectedNpcFiles = new ArrayList<AffectedNpc>();

    public String toJson(String indent) {
      String next = indent + "  ";
      StringBuilder sb = new StringBuilder();
      sb.append(indent).append("{\n");
      sb.append(next).append("\"questId\": ").append(questId).append(",\n");
      sb.append(next).append("\"modificationType\": \"").append(escapeJson(modificationType)).append("\",\n");
      sb.append(next).append("\"affectedNpcFiles\": [\n");
      for(int i = 0; i < affectedNpcFiles.size(); i++) {
        if(i > 0) {
          sb.append(",\n");
        }
        sb.append(affectedNpcFiles.get(i).toJson(next + "  "));
      }
      sb.append("\n").append(next).append("]\n");
      sb.append(indent).append("}");
      return sb.toString();
    }
  }

  public static final class AffectedNpc {
    public String file;
    public String risk;
    public String reason;

    public String toJson(String indent) {
      String next = indent + "  ";
      StringBuilder sb = new StringBuilder();
      sb.append(indent).append("{\n");
      sb.append(next).append("\"file\": \"").append(escapeJson(file)).append("\",\n");
      sb.append(next).append("\"risk\": \"").append(escapeJson(risk)).append("\",\n");
      sb.append(next).append("\"reason\": \"").append(escapeJson(reason)).append("\"\n");
      sb.append(indent).append("}");
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
