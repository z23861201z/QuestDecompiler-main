package unluac.editor;

import java.nio.charset.Charset;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.ArrayList;
import java.util.Collections;
import java.util.LinkedHashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import unluac.chunk.Lua50ChunkParser;
import unluac.chunk.Lua50StructureValidator;
import unluac.chunk.LuaChunk;
import unluac.semantic.NpcScriptModel;
import unluac.semantic.QuestEditorCli;
import unluac.semantic.QuestSemanticCsvTool;
import unluac.semantic.QuestSemanticExtractor;
import unluac.semantic.QuestSemanticJson;
import unluac.semantic.QuestSemanticModel;
import unluac.semantic.NpcSemanticExtractor;
import unluac.semantic.ScriptTypeDetector;
import unluac.semantic.ItemRequirement;
import unluac.semantic.KillRequirement;
import unluac.semantic.QuestGoal;

public class QuestEditorService {

  private static final String ANSWER_PREFIX = "ANSWER_";

  public ScriptTypeDetector.DetectionResult detectScriptType(Path lucPath) throws Exception {
    ScriptTypeDetector detector = new ScriptTypeDetector();
    return detector.inspect(lucPath);
  }

  public NpcScriptModel loadNpcScript(Path lucPath) throws Exception {
    NpcSemanticExtractor extractor = new NpcSemanticExtractor();
    return extractor.extract(lucPath);
  }

  public List<QuestEditorModel> loadFromLuc(Path lucPath) throws Exception {
    byte[] data = Files.readAllBytes(lucPath);

    Lua50ChunkParser parser = new Lua50ChunkParser();
    LuaChunk chunk = parser.parse(data);

    QuestSemanticExtractor extractor = new QuestSemanticExtractor();
    QuestSemanticExtractor.ExtractionResult extraction = extractor.extract(chunk);

    List<QuestSemanticCsvTool.CsvQuestRow> rows = new ArrayList<QuestSemanticCsvTool.CsvQuestRow>();
    for(QuestSemanticModel model : extraction.quests) {
      rows.add(QuestSemanticCsvTool.CsvQuestRow.fromModel(model));
    }

    Map<Integer, Map<String, String>> boundFieldValueByQuest = collectBoundStringValues(extraction.fieldBindings);
    Map<Integer, Map<Integer, String>> dialogLineFieldByQuest = collectDialogLineFieldMap(extraction.fieldBindings);
    Map<Integer, QuestReward> rewardByQuest = buildEditorRewardByQuest(extraction.quests);

    List<QuestEditorModel> out = new ArrayList<QuestEditorModel>();
    for(QuestSemanticCsvTool.CsvQuestRow row : rows) {
      QuestEditorModel model = new QuestEditorModel();
      model.questId = row.questId;
      model.title = row.title;
      model.description = row.description;

      QuestReward reward = rewardByQuest.get(Integer.valueOf(row.questId));
      if(reward == null) {
        reward = new QuestReward();
      }
      model.rewardExp = reward.exp;
      model.rewardFame = reward.fame;
      model.rewardMoney = reward.money;
      model.rewardPvppoint = reward.pvppoint;
      model.rewardItemIdJson = toJsonIntArray(row.rewardItemId);
      model.rewardItemCountJson = toJsonIntArray(row.rewardItemCount);
      List<Integer> skillIds = row.rewardSkillIds;
      if((skillIds == null || skillIds.isEmpty()) && reward != null) {
        skillIds = reward.skillIds;
      }
      model.rewardSkillIdsJson = toJsonIntArray(skillIds == null ? Collections.<Integer>emptyList() : skillIds);
      model.rewardExtraFieldsJson = QuestSemanticJson.toJsonObject(reward.extraFields);
      List<String> order = reward.fieldOrder.isEmpty() ? defaultRewardFieldOrder(reward) : reward.fieldOrder;
      model.rewardFieldOrderJson = QuestSemanticJson.toJsonArrayString(order);
      model.preQuestIdsJson = toJsonIntArray(row.preQuestIds);
      model.dialogLinesJson = unluac.semantic.QuestSemanticJson.toJsonArrayString(row.dialogLines);
      model.conditionJson = unluac.semantic.QuestSemanticJson.toJsonObject(row.conditions);
      model.dialogTree = row.dialogTree;
      model.goal = cloneGoal(row.goal);
      model.conditionMap.putAll(row.conditions);

      Map<String, String> bound = boundFieldValueByQuest.get(Integer.valueOf(row.questId));
      if(bound != null) {
        model.dialogBindingValues.putAll(bound);
      }

      Map<Integer, String> lineFieldMap = dialogLineFieldByQuest.get(Integer.valueOf(row.questId));
      if(lineFieldMap != null) {
        model.dialogLineFieldByIndex.putAll(lineFieldMap);
      }

      model.stage = buildStageModel(model, row);
      model.originalReward = reward.copy();
      model.dialogJsonModel = buildDialogJsonModel(model, model.stage);
      model.dirty = false;
      out.add(model);
    }
    return out;
  }

  public List<QuestEditorModel> loadForEditor(Path lucPath) throws Exception {
    List<QuestEditorModel> rows = loadFromLuc(lucPath);
    for(QuestEditorModel row : rows) {
      sanitizeStageForSafeSave(row);
      row.dialogJsonModel = buildDialogJsonModel(row, row.stage);
      row.dirty = false;
    }
    return rows;
  }

  public QuestEditorSaveResult savePatchedLuc(Path sourceLuc,
                                              List<QuestEditorModel> rows,
                                              Path outputLuc) throws Exception {
    Path csvPath = createTempCsvPath(outputLuc, "quest_editor_gui_input");
    Path workingOutput = createTempLucPath(outputLuc, "quest_editor_gui_output");

    Path mappingPath = Paths.get(outputLuc.toString() + ".mapping.csv");
    try {
      writeCsv(csvPath, rows);
      if(Files.size(csvPath) <= QuestSemanticCsvTool.CSV_HEADER.length() + 2) {
        Files.copy(sourceLuc, outputLuc, StandardCopyOption.REPLACE_EXISTING);
        if(Files.exists(mappingPath)) {
          Files.delete(mappingPath);
        }
        Files.write(mappingPath,
            Collections.singletonList("quest_id,field_key,function_path,constant_index,constant_type,old_value,new_value,max_bytes,new_bytes,length_ok,action"),
            Charset.forName("UTF-8"));
      } else {
        unluac.semantic.QuestSemanticPatchApplier.apply(sourceLuc, csvPath, workingOutput, mappingPath);
        Files.move(workingOutput, outputLuc, StandardCopyOption.REPLACE_EXISTING);
      }
    } finally {
      deleteIfExistsQuietly(csvPath);
      deleteIfExistsQuietly(workingOutput);
    }

    byte[] before = Files.readAllBytes(sourceLuc);
    byte[] after = Files.readAllBytes(outputLuc);

    Lua50ChunkParser parser = new Lua50ChunkParser();
    LuaChunk beforeChunk = parser.parse(before);
    List<QuestEditorCli.DiffItemView> diffs = QuestEditorCli.buildDiffView(before, after, beforeChunk);

    int constantDiff = 0;
    int nonConstantDiff = 0;
    for(QuestEditorCli.DiffItemView diff : diffs) {
      if(diff.constantArea) {
        constantDiff++;
      } else {
        nonConstantDiff++;
      }
    }

    Lua50StructureValidator validator = new Lua50StructureValidator(before);
    Lua50StructureValidator.ValidationReport report = validator.validateLuc(after);
    if(!report.structureConsistent) {
      throw new IllegalStateException("structure validation failed\n" + report.toTextReport());
    }

    int modifiedQuestCount = countModifiedQuests(mappingPath);
    String rewardDiffSummary = buildRewardDiffSummary(rows);

    QuestEditorSaveResult result = new QuestEditorSaveResult();
    result.modifiedQuestCount = modifiedQuestCount;
    result.diffTotal = diffs.size();
    result.constantDiff = constantDiff;
    result.nonConstantDiff = nonConstantDiff;
    result.mappingPath = mappingPath.toString();
    result.validationSummary = report.toTextReport();
    result.rewardDiffSummary = rewardDiffSummary;
    return result;
  }

  private void sanitizeStageForSafeSave(QuestEditorModel row) {
    if(row == null || row.stage == null) {
      return;
    }

    List<String> dialogLines = parseDialogLinesJson(row.dialogLinesJson);

    initializeDialogStageLines(row.stage, dialogLines);
    fillLegacyStageFieldsFromDialogStageLines(row.stage, row.description);
  }

  public void markDirty(QuestEditorModel row) {
    if(row != null) {
      row.dirty = true;
    }
  }

  public void applyDialogJsonModel(QuestEditorModel row, QuestDialogJsonModel model) {
    if(row == null) {
      return;
    }
    if(row.stage == null) {
      row.stage = new QuestStageModel();
    }

    QuestDialogJsonModel next = model == null ? new QuestDialogJsonModel() : model.copy();
    row.dialogJsonModel = next;

    List<String> lines = dialogModelToLines(next);
    row.dialogLinesJson = QuestSemanticJson.toJsonArrayString(lines);
    initializeDialogStageLines(row.stage, lines);
    fillLegacyStageFieldsFromDialogStageLines(row.stage, row.description);
    if(!isBlank(row.stage.startDialog)) {
      row.description = row.stage.startDialog;
    }
  }

  private void writeCsv(Path csvPath, List<QuestEditorModel> rows) throws Exception {
    List<String> lines = new ArrayList<String>();
    lines.add(QuestSemanticCsvTool.CSV_HEADER);

    Map<Integer, Boolean> seen = new LinkedHashMap<Integer, Boolean>();
    for(QuestEditorModel row : rows) {
      if(seen.containsKey(Integer.valueOf(row.questId))) {
        throw new IllegalStateException("duplicate quest_id: " + row.questId);
      }
      seen.put(Integer.valueOf(row.questId), Boolean.TRUE);

      if(!row.dirty) {
        continue;
      }

      applyStageBackToLegacyFields(row);

      String rewardIdJson = row.rewardItemIdJson == null || row.rewardItemIdJson.trim().isEmpty() ? "[]" : row.rewardItemIdJson.trim();
      String rewardCountJson = row.rewardItemCountJson == null || row.rewardItemCountJson.trim().isEmpty() ? "[]" : row.rewardItemCountJson.trim();
      String rewardSkillJson = row.rewardSkillIdsJson == null || row.rewardSkillIdsJson.trim().isEmpty() ? "[]" : row.rewardSkillIdsJson.trim();
      String rewardExtraJson = row.rewardExtraFieldsJson == null || row.rewardExtraFieldsJson.trim().isEmpty() ? "{}" : row.rewardExtraFieldsJson.trim();
      String rewardFieldOrderJson = row.rewardFieldOrderJson == null || row.rewardFieldOrderJson.trim().isEmpty() ? "[]" : row.rewardFieldOrderJson.trim();
      String preQuestJson = row.preQuestIdsJson == null || row.preQuestIdsJson.trim().isEmpty() ? "[]" : row.preQuestIdsJson.trim();
      String dialogJson = row.dialogLinesJson == null || row.dialogLinesJson.trim().isEmpty() ? "[]" : row.dialogLinesJson.trim();
      String condJson = row.conditionJson == null || row.conditionJson.trim().isEmpty() ? "{}" : row.conditionJson.trim();

      QuestEditorValidator.validateJsonIntArray(rewardIdJson, "reward_item_id");
      QuestEditorValidator.validateJsonIntArray(rewardCountJson, "reward_item_count");
      QuestEditorValidator.validateJsonIntArray(rewardSkillJson, "reward_skill_ids");
      QuestSemanticJson.parseObject(rewardExtraJson, "reward_extra_fields", 0);
      QuestSemanticJson.parseStringArray(rewardFieldOrderJson, "reward_field_order", 0);
      QuestEditorValidator.validateJsonIntArray(preQuestJson, "pre_quest_ids");

      int idLen = QuestEditorValidator.parseIntArray(rewardIdJson).size();
      int countLen = QuestEditorValidator.parseIntArray(rewardCountJson).size();
      if(idLen != countLen) {
        throw new IllegalStateException("quest_id=" + row.questId + " reward_item_id/reward_item_count 长度不一致");
      }

      String mergedConditionJson = mergeRewardConditions(condJson, rewardExtraJson, rewardFieldOrderJson);

      lines.add(csv(Integer.toString(row.questId)) + ","
          + csv(nonNull(row.title)) + ","
          + csv(nonNull(row.description)) + ","
          + csv(preQuestJson) + ","
          + csv(Integer.toString(row.rewardExp)) + ","
          + csv(rewardIdJson) + ","
          + csv(rewardCountJson) + ","
          + csv(rewardSkillJson) + ","
          + csv(dialogJson) + ","
          + csv(mergedConditionJson));

      row.dirty = false;
    }

    Files.write(csvPath, lines, Charset.forName("UTF-8"));
  }

  private void applyStageBackToLegacyFields(QuestEditorModel row) {
    if(row == null || row.stage == null) {
      return;
    }

    if(!row.dirty) {
      return;
    }

    QuestStageModel stage = row.stage;

    if(row.dialogJsonModel == null) {
      row.dialogJsonModel = buildDialogJsonModel(row, stage);
    }

    rebuildDialogModelFromStage(row.dialogJsonModel, stage);
    row.dialogLinesJson = toDialogLinesJson(row.dialogJsonModel);

    if(stage.dialogStageLines != null && !stage.dialogStageLines.isEmpty()) {
      fillLegacyStageFieldsFromDialogStageLines(stage, row.description);
    }

    Map<String, Object> conditionMap = parseConditionJson(row.conditionJson, row.conditionMap);

    if(stage.goal != null) {
      row.goal = cloneGoal(stage.goal);
      if(stage.goal.needLevel > 0) {
        conditionMap.put("needLevel", Integer.valueOf(stage.goal.needLevel));
      }
    }

    if(stage.reward != null) {
      row.rewardExp = stage.reward.exp;
      row.rewardFame = stage.reward.fame;
      row.rewardMoney = stage.reward.money;
      row.rewardPvppoint = stage.reward.pvppoint;
      row.rewardItemIdJson = toJsonIntArray(stage.reward.toItemIdList());
      row.rewardItemCountJson = toJsonIntArray(stage.reward.toItemCountList());
      row.rewardSkillIdsJson = toJsonIntArray(stage.reward.skillIds);
      row.rewardExtraFieldsJson = QuestSemanticJson.toJsonObject(stage.reward.extraFields);
      List<String> order = stage.reward.fieldOrder;
      if(order == null || order.isEmpty()) {
        order = defaultRewardFieldOrder(stage.reward);
      }
      row.rewardFieldOrderJson = QuestSemanticJson.toJsonArrayString(order);

      conditionMap.put("reward_fame", Integer.valueOf(stage.reward.fame));
      conditionMap.put("reward_money", Integer.valueOf(stage.reward.money));
      conditionMap.put("reward_pvppoint", Integer.valueOf(stage.reward.pvppoint));
    }

    if((row.rewardExtraFieldsJson == null || row.rewardExtraFieldsJson.trim().isEmpty()) && row.originalReward != null) {
      row.rewardExtraFieldsJson = QuestSemanticJson.toJsonObject(row.originalReward.extraFields);
    }
    if((row.rewardFieldOrderJson == null || row.rewardFieldOrderJson.trim().isEmpty()) && row.originalReward != null) {
      row.rewardFieldOrderJson = QuestSemanticJson.toJsonArrayString(row.originalReward.fieldOrder);
    }

    row.conditionMap.clear();
    row.conditionMap.putAll(conditionMap);
    row.conditionJson = QuestSemanticJson.toJsonObject(conditionMap);

    if(!isBlank(stage.startDialog)) {
      row.description = stage.startDialog;
    }

    if(row.stage != null) {
      initializeDialogStageLines(row.stage, parseDialogLinesJson(row.dialogLinesJson));
      fillLegacyStageFieldsFromDialogStageLines(row.stage, row.description);
    }
  }

  private QuestStageModel buildStageModel(QuestEditorModel editorModel, QuestSemanticCsvTool.CsvQuestRow row) {
    QuestStageModel stage = new QuestStageModel();
    stage.goal = cloneGoal(row.goal);

    stage.reward.exp = row.rewardExp;
    stage.reward.fame = editorModel.rewardFame;
    stage.reward.money = editorModel.rewardMoney;
    stage.reward.pvppoint = editorModel.rewardPvppoint;
    stage.reward.loadItemsFromLists(row.rewardItemId, row.rewardItemCount);
    if(row.rewardSkillIds != null) {
      stage.reward.skillIds.addAll(row.rewardSkillIds);
    }
    if(editorModel.rewardExtraFieldsJson != null && !editorModel.rewardExtraFieldsJson.trim().isEmpty()) {
      stage.reward.extraFields.putAll(parseObjectSafe(editorModel.rewardExtraFieldsJson, "reward_extra_fields"));
    }
    if(editorModel.rewardFieldOrderJson != null && !editorModel.rewardFieldOrderJson.trim().isEmpty()) {
      stage.reward.fieldOrder.addAll(QuestSemanticJson.parseStringArray(editorModel.rewardFieldOrderJson, "reward_field_order", 0));
    }
    if(stage.reward.fieldOrder.isEmpty()) {
      stage.reward.fieldOrder.addAll(defaultRewardFieldOrder(stage.reward));
    }

    List<String> dialogLines = row.dialogLines == null ? Collections.<String>emptyList() : row.dialogLines;

    initializeDialogStageLines(stage, dialogLines);
    fillLegacyStageFieldsFromDialogStageLines(stage, row.description);

    String boundDescription = editorModel.dialogBindingValues.get("description");
    if(!isBlank(boundDescription) && isBlank(stage.startDialog)) {
      stage.startDialog = boundDescription;
    }

    return stage;
  }

  

  private void initializeDialogStageLines(QuestStageModel stage, List<String> dialogLines) {
    stage.dialogStageLines.clear();
    stage.dialogStageLineIndices.clear();

    if(dialogLines == null) {
      return;
    }

    for(int i = 0; i < dialogLines.size(); i++) {
      String line = dialogLines.get(i);
      if(line == null) {
        line = "";
      }
      stage.dialogStageLines.add(line);
      stage.dialogStageLineIndices.add(Integer.valueOf(i));
    }
  }

  private void fillLegacyStageFieldsFromDialogStageLines(QuestStageModel stage, String fallbackDescription) {
    stage.startDialog = "";
    stage.startDialogLineIndex = -1;

    stage.options.clear();
    stage.optionLineIndices.clear();

    stage.progressInfo = "";
    stage.progressInfoLineIndex = -1;

    stage.completionDialog = "";
    stage.completionDialogLineIndex = -1;

    int nonAnswerSeen = 0;
    int max = Math.min(stage.dialogStageLines.size(), stage.dialogStageLineIndices.size());
    for(int i = 0; i < max; i++) {
      String line = stage.dialogStageLines.get(i);
      int lineIndex = stage.dialogStageLineIndices.get(i).intValue();

      if(isAnswerLine(line)) {
        stage.options.add(parseAnswerOptionText(line));
        stage.optionLineIndices.add(Integer.valueOf(lineIndex));
        continue;
      }

      if(stage.startDialogLineIndex < 0) {
        stage.startDialogLineIndex = lineIndex;
        stage.startDialog = nonNull(line);
      } else if(nonAnswerSeen == 1) {
        stage.progressInfoLineIndex = lineIndex;
        stage.progressInfo = nonNull(line);
      } else {
        stage.completionDialogLineIndex = lineIndex;
        stage.completionDialog = nonNull(line);
      }
      nonAnswerSeen++;
    }

    if(isBlank(stage.startDialog)) {
      stage.startDialog = nonNull(fallbackDescription);
    }
  }

  private List<String> parseDialogLinesJson(String json) {
    String text = json == null ? "[]" : json.trim();
    if(text.isEmpty()) {
      text = "[]";
    }
    try {
      return QuestSemanticJson.parseStringArray(text, "dialog_lines_json", 0);
    } catch(Exception ex) {
      return new ArrayList<String>();
    }
  }

  private QuestDialogJsonModel buildDialogJsonModel(QuestEditorModel row, QuestStageModel stage) {
    QuestDialogJsonModel model = new QuestDialogJsonModel();
    if(stage == null || stage.dialogStageLines == null || stage.dialogStageLines.isEmpty()) {
      return model;
    }

    List<String> rawLines = stage.dialogStageLines;
    int answerOrdinal = 0;
    int lastAnswerTextIndex = 0;
    for(int i = 0; i < stage.dialogStageLines.size(); i++) {
      String raw = stage.dialogStageLines.get(i);
      DialogLine dialogLine = toDialogLine(raw, answerOrdinal);
      String sourceField = row == null ? "" : row.dialogLineFieldByIndex.get(Integer.valueOf(i));
      if(sourceField != null && sourceField.endsWith(".answer") && DialogLine.TYPE_TEXT.equals(dialogLine.type)) {
        lastAnswerTextIndex++;
        dialogLine.branch = DialogLine.BRANCH_LAST_ANSWER_PREFIX + lastAnswerTextIndex;
      } else if(sourceField != null && sourceField.endsWith(".info") && DialogLine.TYPE_TEXT.equals(dialogLine.type)) {
        dialogLine.branch = DialogLine.BRANCH_LAST_INFO;
      }
      if(DialogLine.TYPE_ANSWER.equals(dialogLine.type)) {
        answerOrdinal++;
      }
      model.start.add(dialogLine);
    }
    return model;
  }

  private String toDialogLinesJson(QuestDialogJsonModel model) {
    List<String> lines = dialogModelToLines(model);
    return QuestSemanticJson.toJsonArrayString(lines);
  }

  private void rebuildDialogModelFromStage(QuestDialogJsonModel model, QuestStageModel stage) {
    if(model == null) {
      return;
    }
    List<DialogLine> normalized = normalizeDialogLines(model.start);
    model.clear();
    model.start.addAll(normalized);
  }

  private List<DialogLine> normalizeDialogLines(List<DialogLine> source) {
    List<DialogLine> out = new ArrayList<DialogLine>();
    if(source == null) {
      return out;
    }
    int textAnswerIndex = 0;
    for(int i = 0; i < source.size(); i++) {
      DialogLine in = source.get(i);
      DialogLine line = in == null ? new DialogLine() : in.copy();

      String type = line.type == null ? "" : line.type.trim();
      String branch = line.branch == null ? "" : line.branch.trim();
      String text = nonNull(line.text);

      if(DialogLine.TYPE_ANSWER.equals(type)) {
        line.type = DialogLine.TYPE_ANSWER;
        if(DialogLine.BRANCH_NO.equals(branch)) {
          line.branch = DialogLine.BRANCH_NO;
        } else if(DialogLine.BRANCH_IF_NO.equals(branch)) {
          line.branch = DialogLine.BRANCH_IF_NO;
        } else {
          line.branch = DialogLine.BRANCH_YES;
        }
        line.text = text;
      } else {
        line.type = DialogLine.TYPE_TEXT;
        if(branch.startsWith(DialogLine.BRANCH_LAST_ANSWER_PREFIX)) {
          textAnswerIndex++;
          line.branch = DialogLine.BRANCH_LAST_ANSWER_PREFIX + textAnswerIndex;
        } else if(DialogLine.BRANCH_LAST_INFO.equals(branch)) {
          line.branch = DialogLine.BRANCH_LAST_INFO;
        } else {
          line.branch = "";
        }
        line.text = text;
      }
      out.add(line);
    }
    return out;
  }

  private List<String> dialogModelToLines(QuestDialogJsonModel model) {
    List<String> out = new ArrayList<String>();
    if(model == null) {
      return out;
    }
    appendSectionLines(out, model.start);
    appendSectionLines(out, model.progress);
    appendSectionLines(out, model.complete);
    return out;
  }

  private void appendSectionLines(List<String> out, List<DialogLine> section) {
    if(section == null) {
      return;
    }
    for(DialogLine dialogLine : section) {
      if(dialogLine == null) {
        out.add("");
        continue;
      }
      out.add(toAstLine(dialogLine));
    }
  }

  private DialogLine toDialogLine(String raw, int answerOrdinal) {
    DialogLine out = new DialogLine();
    String line = nonNull(raw);
    if(isAnswerLine(line)) {
      out.type = DialogLine.TYPE_ANSWER;
      out.branch = extractAnswerBranch(line, answerOrdinal);
      out.text = parseAnswerOptionText(line);
    } else {
      out.type = DialogLine.TYPE_TEXT;
      out.branch = "";
      out.text = line;
    }
    return out;
  }

  private String toAstLine(DialogLine dialogLine) {
    if(dialogLine == null) {
      return "";
    }
    String text = nonNull(dialogLine.text);

    if(DialogLine.BRANCH_LAST_INFO.equals(dialogLine.branch)) {
      return text;
    }

    if(!DialogLine.TYPE_ANSWER.equals(dialogLine.type)) {
      return text;
    }

    String branch = dialogLine.branch == null ? "" : dialogLine.branch.trim();
    String token;
    if(DialogLine.BRANCH_NO.equals(branch)) {
      token = "ANSWER_NO";
    } else if(DialogLine.BRANCH_IF_NO.equals(branch)) {
      token = "ANSWER_IF_NO";
    } else {
      token = "ANSWER_YES";
    }
    return token + ":" + text;
  }

  private String extractAnswerBranch(String line, int fallbackOrdinal) {
    String value = nonNull(line).trim();
    if(!value.startsWith(ANSWER_PREFIX)) {
      return fallbackOrdinal == 0 ? DialogLine.BRANCH_YES : DialogLine.BRANCH_NO;
    }
    int split = answerSplitIndex(value);
    String token = split > 0 ? value.substring(0, split) : value;
    if("ANSWER_YES".equals(token)) {
      return DialogLine.BRANCH_YES;
    }
    if("ANSWER_NO".equals(token)) {
      return DialogLine.BRANCH_NO;
    }
    if("ANSWER_IF_NO".equals(token)) {
      return DialogLine.BRANCH_IF_NO;
    }
    return fallbackOrdinal == 0 ? DialogLine.BRANCH_YES : DialogLine.BRANCH_NO;
  }

  private Map<Integer, Map<Integer, String>> collectDialogLineFieldMap(List<QuestSemanticExtractor.FieldBinding> fieldBindings) {
    Map<Integer, Map<Integer, String>> out = new LinkedHashMap<Integer, Map<Integer, String>>();
    for(QuestSemanticExtractor.FieldBinding binding : fieldBindings) {
      if(binding == null || binding.fieldKey == null) {
        continue;
      }
      if(!binding.fieldKey.startsWith("dialog_lines_json[")) {
        continue;
      }
      int close = binding.fieldKey.indexOf(']');
      if(close <= "dialog_lines_json[".length()) {
        continue;
      }
      String indexText = binding.fieldKey.substring("dialog_lines_json[".length(), close).trim();
      if(indexText.isEmpty()) {
        continue;
      }
      int index;
      try {
        index = Integer.parseInt(indexText);
      } catch(Exception ex) {
        continue;
      }
      String suffix = "";
      if(close + 1 < binding.fieldKey.length() && binding.fieldKey.charAt(close + 1) == '.') {
        suffix = binding.fieldKey.substring(close + 1);
      }

      Map<Integer, String> byIndex = out.get(Integer.valueOf(binding.questId));
      if(byIndex == null) {
        byIndex = new LinkedHashMap<Integer, String>();
        out.put(Integer.valueOf(binding.questId), byIndex);
      }
      byIndex.put(Integer.valueOf(index), "dialog_lines_json[" + index + "]" + suffix);
    }
    return out;
  }

  private Map<String, Object> parseConditionJson(String conditionJson, Map<String, Object> fallback) {
    String text = conditionJson == null ? "{}" : conditionJson.trim();
    if(text.isEmpty()) {
      text = "{}";
    }
    try {
      return new LinkedHashMap<String, Object>(QuestSemanticJson.parseObject(text, "condition_json", 0));
    } catch(Exception ex) {
      Map<String, Object> out = new LinkedHashMap<String, Object>();
      if(fallback != null) {
        out.putAll(fallback);
      }
      return out;
    }
  }

  private Map<String, Object> parseObjectSafe(String json, String fieldName) {
    String text = json == null ? "{}" : json.trim();
    if(text.isEmpty()) {
      text = "{}";
    }
    try {
      return new LinkedHashMap<String, Object>(QuestSemanticJson.parseObject(text, fieldName, 0));
    } catch(Exception ex) {
      return new LinkedHashMap<String, Object>();
    }
  }

  private Map<Integer, Map<String, String>> collectBoundStringValues(List<QuestSemanticExtractor.FieldBinding> fieldBindings) {
    Map<Integer, Map<String, String>> out = new LinkedHashMap<Integer, Map<String, String>>();
    for(QuestSemanticExtractor.FieldBinding binding : fieldBindings) {
      if(binding == null || !"string".equals(binding.valueType)) {
        continue;
      }
      Map<String, String> byField = out.get(Integer.valueOf(binding.questId));
      if(byField == null) {
        byField = new LinkedHashMap<String, String>();
        out.put(Integer.valueOf(binding.questId), byField);
      }
      byField.put(binding.fieldKey, binding.stringValue == null ? "" : binding.stringValue);
    }
    return out;
  }

  private String parseAnswerOptionText(String rawLine) {
    if(rawLine == null) {
      return "";
    }
    String line = rawLine.trim();
    int split = answerSplitIndex(line);
    if(split >= 0 && split + 1 <= line.length()) {
      return line.substring(split + 1).trim();
    }

    int tokenEnd = detectAnswerTokenEnd(line);
    if(tokenEnd > ANSWER_PREFIX.length() && tokenEnd < line.length()) {
      return line.substring(tokenEnd).trim();
    }

    return line;
  }

  private int answerSplitIndex(String line) {
    int ascii = line.indexOf(':');
    int full = line.indexOf('：');
    if(ascii < 0) {
      return full;
    }
    if(full < 0) {
      return ascii;
    }
    return Math.min(ascii, full);
  }

  private int detectAnswerTokenEnd(String line) {
    if(line == null) {
      return -1;
    }
    if(!line.startsWith(ANSWER_PREFIX)) {
      return -1;
    }
    int index = ANSWER_PREFIX.length();
    while(index < line.length()) {
      char ch = line.charAt(index);
      if((ch >= 'A' && ch <= 'Z') || (ch >= '0' && ch <= '9') || ch == '_') {
        index++;
        continue;
      }
      break;
    }
    return index;
  }

  private boolean isAnswerLine(String line) {
    if(line == null) {
      return false;
    }
    String value = line.trim();
    return value.startsWith(ANSWER_PREFIX);
  }

  private QuestGoal cloneGoal(QuestGoal source) {
    QuestGoal out = new QuestGoal();
    if(source == null) {
      return out;
    }
    out.needLevel = source.needLevel;
    if(source.items != null) {
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
    }
    if(source.monsters != null) {
      for(KillRequirement monster : source.monsters) {
        if(monster == null) {
          continue;
        }
        KillRequirement copy = new KillRequirement();
        copy.monsterId = monster.monsterId;
        copy.killCount = monster.killCount;
        out.monsters.add(copy);
      }
    }
    return out;
  }

  private Map<Integer, QuestReward> buildEditorRewardByQuest(List<QuestSemanticModel> models) {
    Map<Integer, QuestReward> out = new LinkedHashMap<Integer, QuestReward>();
    if(models == null) {
      return out;
    }
    for(QuestSemanticModel model : models) {
      if(model == null) {
        continue;
      }
      QuestReward reward = new QuestReward();
      Set<String> orderedKeys = new LinkedHashSet<String>();
      if(model.rewards != null) {
        for(QuestSemanticModel.Reward part : model.rewards) {
          if(part == null) {
            continue;
          }
          reward.exp += part.exp;
          reward.fame += part.fame;
          reward.money += part.money;
          reward.pvppoint += part.pvppoint;
          if(part.id > 0 && part.count > 0) {
            QuestReward.ItemReward item = new QuestReward.ItemReward();
            item.itemId = part.id;
            item.itemCount = part.count;
            reward.items.add(item);
          }
          if(part.skillIds != null) {
            reward.skillIds.addAll(part.skillIds);
          }
          if(part.extraFields != null) {
            reward.extraFields.putAll(part.extraFields);
          }
          if(part.fieldOrder != null) {
            orderedKeys.addAll(part.fieldOrder);
          }
        }
      }
      if(orderedKeys.isEmpty()) {
        if(reward.exp != 0) {
          orderedKeys.add("exp");
        }
        if(reward.fame != 0) {
          orderedKeys.add("fame");
        }
        if(reward.money != 0) {
          orderedKeys.add("money");
        }
        if(reward.pvppoint != 0) {
          orderedKeys.add("pvppoint");
        }
        if(!reward.items.isEmpty()) {
          orderedKeys.add("getItem");
        }
        if(!reward.skillIds.isEmpty()) {
          orderedKeys.add("getSkill");
        }
      }
      reward.fieldOrder.addAll(orderedKeys);
      out.put(Integer.valueOf(model.questId), reward);
    }
    return out;
  }

  private String mergeRewardConditions(String conditionJson,
                                       String rewardExtraJson,
                                       String rewardFieldOrderJson) {
    Map<String, Object> condition = parseConditionJson(conditionJson, null);
    Map<String, Object> extra = parseObjectSafe(rewardExtraJson, "reward_extra_fields");
    List<String> order = QuestSemanticJson.parseStringArray(
        rewardFieldOrderJson == null ? "[]" : rewardFieldOrderJson,
        "reward_field_order",
        0);
    condition.put("reward_extra_fields", extra);
    condition.put("reward_field_order", order);
    return QuestSemanticJson.toJsonObject(condition);
  }

  private List<String> defaultRewardFieldOrder(QuestReward reward) {
    List<String> out = new ArrayList<String>();
    if(reward == null) {
      return out;
    }
    if(reward.exp != 0) {
      out.add("exp");
    }
    if(reward.fame != 0) {
      out.add("fame");
    }
    if(reward.money != 0) {
      out.add("money");
    }
    if(reward.pvppoint != 0) {
      out.add("pvppoint");
    }
    if(!reward.items.isEmpty()) {
      out.add("getItem");
    }
    if(!reward.skillIds.isEmpty()) {
      out.add("getSkill");
    }
    for(String key : reward.extraFields.keySet()) {
      if(key == null || key.trim().isEmpty()) {
        continue;
      }
      if(!out.contains(key)) {
        out.add(key);
      }
    }
    return out;
  }

  private int countModifiedQuests(Path mappingPath) throws Exception {
    return QuestEditorCli.countModifiedQuestCountForGui(mappingPath);
  }

  private Path createTempCsvPath(Path base, String prefix) throws Exception {
    Path dir = base.getParent() == null ? Paths.get(".") : base.getParent();
    return Files.createTempFile(dir, prefix + ".", ".csv");
  }

  private Path createTempLucPath(Path base, String prefix) throws Exception {
    Path dir = base.getParent() == null ? Paths.get(".") : base.getParent();
    return Files.createTempFile(dir, prefix + ".", ".luc");
  }

  private String buildRewardDiffSummary(List<QuestEditorModel> rows) {
    StringBuilder sb = new StringBuilder();
    QuestRewardDiffDetector detector = new QuestRewardDiffDetector();
    for(QuestEditorModel row : rows) {
      if(row == null || !row.dirty || row.stage == null || row.stage.reward == null) {
        continue;
      }
      QuestReward before = row.originalReward == null ? new QuestReward() : row.originalReward;
      QuestReward after = row.stage.reward;
      QuestRewardDiffDetector.QuestRewardDiffReport report = detector.detect(before, after);
      if(!report.hasChanges()) {
        continue;
      }
      sb.append("quest_id=").append(row.questId).append('\n');
      sb.append(report.toText());
    }
    return sb.toString();
  }

  private void deleteIfExistsQuietly(Path path) {
    if(path == null) {
      return;
    }
    try {
      Files.deleteIfExists(path);
    } catch(Exception ignored) {
    }
  }

  private static String toJsonIntArray(List<Integer> values) {
    StringBuilder sb = new StringBuilder();
    sb.append('[');
    for(int i = 0; i < values.size(); i++) {
      if(i > 0) {
        sb.append(',');
      }
      sb.append(values.get(i).intValue());
    }
    sb.append(']');
    return sb.toString();
  }

  private static String nonNull(String text) {
    return text == null ? "" : text;
  }

  private static boolean isBlank(String text) {
    return text == null || text.trim().isEmpty();
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
    return "\"" + value.replace("\"", "\"\"") + "\"";
  }
}
