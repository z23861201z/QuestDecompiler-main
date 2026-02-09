package unluac.semantic;

import java.nio.charset.Charset;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import unluac.chunk.Lua50ChunkParser;
import unluac.chunk.LuaChunk;


public class QuestSemanticCsvTool {

  public static final String CSV_HEADER =
      "quest_id,title,description,pre_quest_ids,reward_exp,reward_item_id,reward_item_count,reward_skill_ids,dialog_lines_json,condition_json";

  public static void main(String[] args) throws Exception {
    if(args.length < 1) {
      printUsage();
      return;
    }

    String command = args[0];
    if("export".equalsIgnoreCase(command)) {
      if(args.length != 3) {
        printUsage();
        return;
      }
      exportCsv(Paths.get(args[1]), Paths.get(args[2]));
      return;
    }

    if("import".equalsIgnoreCase(command)) {
      if(args.length != 3) {
        printUsage();
        return;
      }
      importCsv(Paths.get(args[1]), Paths.get(args[2]));
      return;
    }

    throw new IllegalStateException("unknown command: " + command);
  }

  public static void exportCsv(Path inputLuc, Path outputCsv) throws Exception {
    byte[] data = Files.readAllBytes(inputLuc);
    Lua50ChunkParser parser = new Lua50ChunkParser();
    LuaChunk chunk = parser.parse(data);

    QuestSemanticExtractor extractor = new QuestSemanticExtractor();
    QuestSemanticExtractor.ExtractionResult result = extractor.extract(chunk);

    List<QuestSemanticModel> models = new ArrayList<QuestSemanticModel>(result.quests);
    Collections.sort(models, new Comparator<QuestSemanticModel>() {
      @Override
      public int compare(QuestSemanticModel a, QuestSemanticModel b) {
        return Integer.compare(a.questId, b.questId);
      }
    });

    List<String> lines = new ArrayList<String>();
    lines.add(CSV_HEADER);

    for(QuestSemanticModel model : models) {
      CsvQuestRow row = CsvQuestRow.fromModel(model);
      lines.add(row.toCsvLine());
    }

    Files.write(outputCsv, lines, Charset.forName("UTF-8"));

    System.out.println("mode=export");
    System.out.println("input=" + inputLuc);
    System.out.println("output_csv=" + outputCsv);
    System.out.println("quest_count=" + models.size());
  }

  public static List<CsvQuestRow> importCsv(Path inputCsv) throws Exception {
    String text = new String(Files.readAllBytes(inputCsv), Charset.forName("UTF-8"));
    List<String[]> rows = parseCsv(text);
    if(rows.isEmpty()) {
      throw new IllegalStateException("csv is empty");
    }
    String[] header = rows.get(0);
    if(header.length > 0 && header[0] != null && header[0].startsWith("\uFEFF")) {
      header[0] = header[0].substring(1);
    }
    String expected = CSV_HEADER;
    String actual = joinHeader(header);
    if(!expected.equals(actual)) {
      throw new IllegalStateException("csv header mismatch\nexpected=" + expected + "\nactual=" + actual);
    }

    List<CsvQuestRow> out = new ArrayList<CsvQuestRow>();
    Map<Integer, Boolean> seen = new LinkedHashMap<Integer, Boolean>();

    for(int i = 1; i < rows.size(); i++) {
      String[] row = rows.get(i);
      if(row.length == 0) {
        continue;
      }
      if(row.length < 10) {
        throw new IllegalStateException("invalid csv row " + (i + 1));
      }
      CsvQuestRow q = CsvQuestRow.fromCsvRow(row, i + 1);
      if(seen.containsKey(Integer.valueOf(q.questId))) {
        throw new IllegalStateException("duplicate quest_id at row " + (i + 1) + ": " + q.questId);
      }
      seen.put(Integer.valueOf(q.questId), Boolean.TRUE);
      out.add(q);
    }

    Collections.sort(out, new Comparator<CsvQuestRow>() {
      @Override
      public int compare(CsvQuestRow a, CsvQuestRow b) {
        return Integer.compare(a.questId, b.questId);
      }
    });

    return out;
  }

  public static void importCsv(Path inputCsv, Path outputJson) throws Exception {
    List<CsvQuestRow> rows = importCsv(inputCsv);
    List<QuestSemanticModel> models = new ArrayList<QuestSemanticModel>();
    for(CsvQuestRow row : rows) {
      models.add(row.toModel());
    }

    String json = QuestSemanticJson.toJson(models);
    Files.write(outputJson, json.getBytes(Charset.forName("UTF-8")));

    System.out.println("mode=import");
    System.out.println("input_csv=" + inputCsv);
    System.out.println("output_json=" + outputJson);
    System.out.println("quest_count=" + models.size());
  }

  private static String joinHeader(String[] header) {
    StringBuilder sb = new StringBuilder();
    for(int i = 0; i < header.length; i++) {
      if(i > 0) {
        sb.append(',');
      }
      sb.append(header[i] == null ? "" : header[i]);
    }
    return sb.toString();
  }

  private static List<String[]> parseCsv(String text) {
    List<String[]> rows = new ArrayList<String[]>();
    List<String> fields = new ArrayList<String>();
    StringBuilder current = new StringBuilder();
    boolean inQuotes = false;

    for(int i = 0; i < text.length(); i++) {
      char ch = text.charAt(i);
      if(inQuotes) {
        if(ch == '"') {
          if(i + 1 < text.length() && text.charAt(i + 1) == '"') {
            current.append('"');
            i++;
          } else {
            inQuotes = false;
          }
        } else {
          current.append(ch);
        }
      } else {
        if(ch == '"') {
          inQuotes = true;
        } else if(ch == ',') {
          fields.add(current.toString());
          current.setLength(0);
        } else if(ch == '\n') {
          fields.add(current.toString());
          current.setLength(0);
          rows.add(fields.toArray(new String[0]));
          fields = new ArrayList<String>();
        } else if(ch == '\r') {
          continue;
        } else {
          current.append(ch);
        }
      }
    }

    if(inQuotes) {
      throw new IllegalStateException("unterminated quote in csv");
    }

    if(current.length() > 0 || !fields.isEmpty()) {
      fields.add(current.toString());
      rows.add(fields.toArray(new String[0]));
    }
    return rows;
  }

  private static String csv(String value) {
    if(value == null) {
      value = "";
    }
    boolean quote = false;
    for(int i = 0; i < value.length(); i++) {
      char c = value.charAt(i);
      if(c == ',' || c == '"' || c == '\r' || c == '\n') {
        quote = true;
        break;
      }
    }
    if(!quote) {
      return value;
    }
    String escaped = value.replace("\"", "\"\"");
    return "\"" + escaped + "\"";
  }

  private static void printUsage() {
    System.out.println("Usage:");
    System.out.println("  export: java -cp build unluac.semantic.QuestSemanticCsvTool export <input.luc> <output.csv>");
    System.out.println("  import: java -cp build unluac.semantic.QuestSemanticCsvTool import <input.csv> <output.json>");
    System.out.println("CSV header:");
    System.out.println("  " + CSV_HEADER);
  }

  public static final class CsvQuestRow {
    public int questId;
    public String title;
    public String description;
    public List<Integer> preQuestIds = new ArrayList<Integer>();
    public int rewardExp;
    public List<Integer> rewardItemId = new ArrayList<Integer>();
    public List<Integer> rewardItemCount = new ArrayList<Integer>();
    public List<Integer> rewardSkillIds = new ArrayList<Integer>();
    public List<String> dialogLines = new ArrayList<String>();
    public QuestDialogTree dialogTree = new QuestDialogTree();
    public QuestGoal goal = new QuestGoal();
    public Map<String, Object> conditions = new LinkedHashMap<String, Object>();

    public static CsvQuestRow fromModel(QuestSemanticModel model) {
      CsvQuestRow row = new CsvQuestRow();
      row.questId = model.questId;
      row.title = model.title == null ? "" : model.title;
      row.description = model.description == null ? "" : model.description;
      row.preQuestIds.addAll(model.preQuestIds);
      row.dialogLines.addAll(model.dialogLines);
      row.dialogTree = model.dialogTree;
      row.goal = model.goal;
      row.conditions.putAll(model.conditions);

      int exp = 0;
      int fame = 0;
      int money = 0;
      int pvppoint = 0;
      Map<String, Object> rewardExtra = new LinkedHashMap<String, Object>();
      List<String> rewardFieldOrder = new ArrayList<String>();
      for(QuestSemanticModel.Reward reward : model.rewards) {
        exp += reward.exp;
        fame += reward.fame;
        money += reward.money;
        pvppoint += reward.pvppoint;
        if(reward.id > 0 && reward.count > 0) {
          row.rewardItemId.add(Integer.valueOf(reward.id));
          row.rewardItemCount.add(Integer.valueOf(reward.count));
        }
        if(reward.skillIds != null && !reward.skillIds.isEmpty()) {
          for(Integer skillId : reward.skillIds) {
            if(skillId != null && skillId.intValue() > 0) {
              row.rewardSkillIds.add(Integer.valueOf(skillId.intValue()));
            }
          }
        }
        if(reward.extraFields != null && !reward.extraFields.isEmpty()) {
          rewardExtra.putAll(reward.extraFields);
        }
        if(reward.fieldOrder != null) {
          for(String key : reward.fieldOrder) {
            if(key == null || key.trim().isEmpty()) {
              continue;
            }
            if(!rewardFieldOrder.contains(key)) {
              rewardFieldOrder.add(key);
            }
          }
        }
      }
      row.rewardExp = exp;
      row.conditions.put("reward_fame", Integer.valueOf(fame));
      row.conditions.put("reward_money", Integer.valueOf(money));
      row.conditions.put("reward_pvppoint", Integer.valueOf(pvppoint));
      row.conditions.put("reward_extra_fields", rewardExtra);
      row.conditions.put("reward_field_order", rewardFieldOrder);
      return row;
    }

    public QuestSemanticModel toModel() {
      QuestSemanticModel model = new QuestSemanticModel();
      model.questId = questId;
      model.title = title;
      model.description = description;
      model.preQuestIds.addAll(preQuestIds);
      model.dialogLines.addAll(dialogLines);
      model.dialogTree = dialogTree;
      model.goal = goal;
      model.conditions.putAll(conditions);

      if(rewardExp != 0) {
        QuestSemanticModel.Reward expReward = new QuestSemanticModel.Reward();
        expReward.type = "exp";
        expReward.exp = rewardExp;
        model.rewards.add(expReward);
      }

      for(int i = 0; i < rewardItemId.size(); i++) {
        QuestSemanticModel.Reward itemReward = new QuestSemanticModel.Reward();
        itemReward.type = "item";
        itemReward.id = rewardItemId.get(i).intValue();
        itemReward.count = rewardItemCount.get(i).intValue();
        model.rewards.add(itemReward);
      }

      if(!rewardSkillIds.isEmpty()) {
        QuestSemanticModel.Reward skillReward = new QuestSemanticModel.Reward();
        skillReward.type = "skill";
        skillReward.skillIds.addAll(rewardSkillIds);
        model.rewards.add(skillReward);
      }
      return model;
    }

    public String toCsvLine() {
      StringBuilder sb = new StringBuilder();
      sb.append(csv(Integer.toString(questId))).append(',');
      sb.append(csv(title)).append(',');
      sb.append(csv(description)).append(',');
      sb.append(csv(QuestSemanticJson.toJsonArrayInt(preQuestIds))).append(',');
      sb.append(csv(Integer.toString(rewardExp))).append(',');
      sb.append(csv(QuestSemanticJson.toJsonArrayInt(rewardItemId))).append(',');
      sb.append(csv(QuestSemanticJson.toJsonArrayInt(rewardItemCount))).append(',');
      sb.append(csv(QuestSemanticJson.toJsonArrayInt(rewardSkillIds))).append(',');
      sb.append(csv(QuestSemanticJson.toJsonArrayString(dialogLines))).append(',');
      sb.append(csv(QuestSemanticJson.toJsonObject(conditions)));
      return sb.toString();
    }

    public static CsvQuestRow fromCsvRow(String[] row, int rowNumber) {
      CsvQuestRow out = new CsvQuestRow();
      out.questId = Integer.parseInt(nonNull(row[0]));
      out.title = nonNull(row[1]);
      out.description = nonNull(row[2]);

      out.preQuestIds = QuestSemanticJson.parseIntArray(nonNull(row[3]), "pre_quest_ids", rowNumber);
      out.rewardExp = Integer.parseInt(nonNull(row[4]));
      out.rewardItemId = QuestSemanticJson.parseIntArray(nonNull(row[5]), "reward_item_id", rowNumber);
      out.rewardItemCount = QuestSemanticJson.parseIntArray(nonNull(row[6]), "reward_item_count", rowNumber);
      out.rewardSkillIds = QuestSemanticJson.parseIntArray(nonNull(row[7]), "reward_skill_ids", rowNumber);
      if(out.rewardItemId.size() != out.rewardItemCount.size()) {
        throw new IllegalStateException("row " + rowNumber + " reward_item_id/reward_item_count length mismatch");
      }

      out.dialogLines = QuestSemanticJson.parseStringArray(nonNull(row[8]), "dialog_lines_json", rowNumber);
      out.conditions = QuestSemanticJson.parseObject(nonNull(row[9]), "condition_json", rowNumber);
      return out;
    }

    private static String nonNull(String value) {
      return value == null ? "" : value;
    }
  }
}
