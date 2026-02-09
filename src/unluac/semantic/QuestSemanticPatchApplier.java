package unluac.semantic;

import java.nio.ByteBuffer;
import java.nio.ByteOrder;
import java.nio.charset.Charset;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import unluac.chunk.Lua50ChunkParser;
import unluac.chunk.Lua50StructureValidator;
import unluac.chunk.LuaChunk;

public class QuestSemanticPatchApplier {

  public static void main(String[] args) throws Exception {
    if(args.length < 4) {
      printUsage();
      return;
    }

    Path inputLuc = Paths.get(args[0]);
    Path inputCsv = Paths.get(args[1]);
    Path outputLuc = Paths.get(args[2]);
    Path mappingOut = Paths.get(args[3]);

    apply(inputLuc, inputCsv, outputLuc, mappingOut);
  }

  public static void apply(Path inputLuc, Path inputCsv, Path outputLuc, Path mappingOut) throws Exception {
    byte[] original = Files.readAllBytes(inputLuc);
    byte[] patched = original.clone();

    Lua50ChunkParser parser = new Lua50ChunkParser();
    LuaChunk chunk = parser.parse(patched);

    QuestSemanticExtractor extractor = new QuestSemanticExtractor();
    QuestSemanticExtractor.ExtractionResult extracted = extractor.extract(chunk);

    List<QuestSemanticCsvTool.CsvQuestRow> editedRows = QuestSemanticCsvTool.importCsv(inputCsv);
    Map<Integer, QuestSemanticCsvTool.CsvQuestRow> rowByQuest = new HashMap<Integer, QuestSemanticCsvTool.CsvQuestRow>();
    for(QuestSemanticCsvTool.CsvQuestRow row : editedRows) {
      rowByQuest.put(Integer.valueOf(row.questId), row);
    }

    Map<Integer, QuestSemanticModel> oldByQuest = new LinkedHashMap<Integer, QuestSemanticModel>();
    for(QuestSemanticModel model : extracted.quests) {
      oldByQuest.put(Integer.valueOf(model.questId), model);
    }

    List<PatchBinding> bindings = buildFieldConstantBindings(extracted, chunk);
    List<PatchAction> actions = new ArrayList<PatchAction>();

    for(PatchBinding binding : bindings) {
      QuestSemanticModel oldModel = oldByQuest.get(Integer.valueOf(binding.questId));
      QuestSemanticCsvTool.CsvQuestRow editedRow = rowByQuest.get(Integer.valueOf(binding.questId));
      if(oldModel == null || editedRow == null) {
        continue;
      }

      PatchAction action = decidePatchAction(binding, oldModel, editedRow, chunk);
      if(action != null) {
        actions.add(action);
      }
    }

    for(PatchAction action : actions) {
      applyActionInConstantArea(patched, chunk, action);
    }

    Files.write(outputLuc, patched);

    LuaChunk afterChunk = parser.parse(patched);
    verifyNoInstructionOrPrototypeChanges(chunk, afterChunk);

    Lua50StructureValidator validator = new Lua50StructureValidator(original);
    Lua50StructureValidator.ValidationReport report = validator.validateLuc(patched);
    if(!report.structureConsistent) {
      throw new IllegalStateException("structure validation failed after semantic patch\n" + report.toTextReport());
    }

    List<String> mappingLines = new ArrayList<String>();
    mappingLines.add("quest_id,field_key,function_path,constant_index,constant_type,old_value,new_value,max_bytes,new_bytes,length_ok,action");
    for(PatchAction action : actions) {
      mappingLines.add(action.toCsvLine());
    }
    Files.write(mappingOut, mappingLines, Charset.forName("UTF-8"));

    System.out.println("input=" + inputLuc);
    System.out.println("csv=" + inputCsv);
    System.out.println("output=" + outputLuc);
    System.out.println("mapping=" + mappingOut);
    System.out.println("action_count=" + actions.size());
    System.out.println("structure_consistent=" + report.structureConsistent);
  }

  public static List<PatchBinding> buildFieldConstantBindings(QuestSemanticExtractor.ExtractionResult extracted,
                                                              LuaChunk chunk) {
    List<PatchBinding> out = new ArrayList<PatchBinding>();
    for(QuestSemanticExtractor.FieldBinding binding : extracted.fieldBindings) {
      if(binding.constantIndex < 0) {
        continue;
      }
      LuaChunk.Function function = findFunction(chunk.mainFunction, binding.sourceFunctionPath);
      if(function == null) {
        continue;
      }
      if(binding.constantIndex >= function.constants.size()) {
        continue;
      }

      LuaChunk.Constant constant = function.constants.get(binding.constantIndex);
      PatchBinding mapped = new PatchBinding();
      mapped.questId = binding.questId;
      mapped.fieldKey = binding.fieldKey;
      mapped.functionPath = function.path;
      mapped.constantIndex = binding.constantIndex;
      mapped.constant = constant;
      mapped.sourcePc = binding.sourcePc;
      mapped.sourceFunctionPath = binding.sourceFunctionPath;

      if("string".equals(binding.valueType)) {
        mapped.valueType = PatchValueType.STRING;
        mapped.oldStringValue = binding.stringValue;
      } else if("number".equals(binding.valueType)) {
        mapped.valueType = PatchValueType.NUMBER;
        mapped.oldNumberValue = binding.numberValue == null ? 0D : binding.numberValue.doubleValue();
      } else {
        continue;
      }
      out.add(mapped);
    }
    return out;
  }

  private static PatchAction decidePatchAction(PatchBinding binding,
                                               QuestSemanticModel oldModel,
                                               QuestSemanticCsvTool.CsvQuestRow edited,
                                               LuaChunk chunk) {
    if(binding.valueType == PatchValueType.STRING) {
      String next = null;
      if("title".equals(binding.fieldKey)) {
        next = edited.title;
      } else if("description".equals(binding.fieldKey)) {
        next = edited.description;
      } else if(binding.fieldKey != null && binding.fieldKey.startsWith("dialog_lines_json[")) {
        Integer index = parseDialogIndex(binding.fieldKey);
        if(index == null || index.intValue() < 0) {
          return null;
        }
        if(edited.dialogLines.isEmpty()) {
          return null;
        }
        if(index.intValue() >= edited.dialogLines.size()) {
          next = edited.dialogLines.get(edited.dialogLines.size() - 1);
        } else {
          next = edited.dialogLines.get(index.intValue());
        }
      } else if(binding.fieldKey != null && binding.fieldKey.startsWith("reward_extra.")) {
        String extraKey = binding.fieldKey.substring("reward_extra.".length());
        Object value = edited.conditions == null ? null : edited.conditions.get("reward_extra_fields");
        if(value instanceof Map<?, ?>) {
          @SuppressWarnings("unchecked")
          Map<String, Object> map = (Map<String, Object>) value;
          Object target = map.get(extraKey);
          if(target != null) {
            next = String.valueOf(target);
          }
        }
      } else {
        return null;
      }
      String current = binding.oldStringValue == null ? "" : binding.oldStringValue;
      if(next == null) {
        next = "";
      }
      if(current.equals(next)) {
        return null;
      }

      int maxBytes = maxWritableStringBytes(binding.constant);
      int newBytes = next.getBytes(Charset.forName(System.getProperty("unluac.stringCharset", "GBK"))).length;

      PatchAction action = new PatchAction();
      action.questId = binding.questId;
      action.fieldKey = binding.fieldKey;
      action.functionPath = binding.functionPath;
      action.constantIndex = binding.constantIndex;
      action.constantType = "string";
      action.oldValue = current;
      action.newValue = next;
      action.maxBytes = maxBytes;
      action.newBytes = newBytes;
      action.lengthOk = newBytes <= maxBytes;
      action.binding = binding;
      action.action = action.lengthOk ? "patch_string" : "reject_overflow";
      return action;
    }

    if(binding.valueType == PatchValueType.NUMBER) {
      Double next = pickNumericFieldUpdate(binding.fieldKey, edited);
      if(next == null) {
        return null;
      }
      if(Double.compare(binding.oldNumberValue, next.doubleValue()) == 0) {
        return null;
      }

      PatchAction action = new PatchAction();
      action.questId = binding.questId;
      action.fieldKey = binding.fieldKey;
      action.functionPath = binding.functionPath;
      action.constantIndex = binding.constantIndex;
      action.constantType = "number";
      action.oldValue = numericToString(binding.oldNumberValue);
      action.newValue = numericToString(next.doubleValue());
      action.maxBytes = chunk.header.numberSize;
      action.newBytes = chunk.header.numberSize;
      action.lengthOk = true;
      action.binding = binding;
      action.action = "patch_number";
      return action;
    }

    return null;
  }

  private static Double pickNumericFieldUpdate(String fieldKey, QuestSemanticCsvTool.CsvQuestRow edited) {
    if("pre_quest_ids".equals(fieldKey)) {
      if(edited.preQuestIds.isEmpty()) {
        return Double.valueOf(0D);
      }
      return Double.valueOf(edited.preQuestIds.get(0).doubleValue());
    }
    if("condition_json.needLevel".equals(fieldKey)) {
      Object value = edited.conditions.get("needLevel");
      if(value instanceof Number) {
        return Double.valueOf(((Number) value).doubleValue());
      }
      return null;
    }
    if("reward_exp".equals(fieldKey)) {
      return Double.valueOf(edited.rewardExp);
    }
    if("reward_fame".equals(fieldKey)) {
      return numericFromCondition(edited.conditions, "reward_fame");
    }
    if("reward_money".equals(fieldKey)) {
      return numericFromCondition(edited.conditions, "reward_money");
    }
    if("reward_pvppoint".equals(fieldKey)) {
      return numericFromCondition(edited.conditions, "reward_pvppoint");
    }
    Integer skillIndex = parseIndexedField(fieldKey, "reward_skill_ids[");
    if(skillIndex != null) {
      if(skillIndex.intValue() < 0 || skillIndex.intValue() >= edited.rewardSkillIds.size()) {
        return null;
      }
      return Double.valueOf(edited.rewardSkillIds.get(skillIndex.intValue()).doubleValue());
    }
    if(fieldKey != null && fieldKey.startsWith("reward_extra.")) {
      String extraKey = fieldKey.substring("reward_extra.".length());
      Object rewardExtra = edited.conditions == null ? null : edited.conditions.get("reward_extra_fields");
      if(rewardExtra instanceof Map<?, ?>) {
        @SuppressWarnings("unchecked")
        Map<String, Object> map = (Map<String, Object>) rewardExtra;
        Object value = map.get(extraKey);
        if(value instanceof Number) {
          return Double.valueOf(((Number) value).doubleValue());
        }
        if(value instanceof String) {
          try {
            return Double.valueOf(Double.parseDouble(((String) value).trim()));
          } catch(Exception ignored) {
          }
        }
      }
      return null;
    }
    if("reward_item_id".equals(fieldKey)) {
      if(edited.rewardItemId.isEmpty()) {
        return null;
      }
      return Double.valueOf(edited.rewardItemId.get(0).doubleValue());
    }
    if("reward_item_count".equals(fieldKey)) {
      if(edited.rewardItemCount.isEmpty()) {
        return null;
      }
      return Double.valueOf(edited.rewardItemCount.get(0).doubleValue());
    }
    return null;
  }

  private static Double numericFromCondition(Map<String, Object> conditions, String key) {
    if(conditions != null) {
      Object value = conditions.get(key);
      if(value instanceof Number) {
        return Double.valueOf(((Number) value).doubleValue());
      }
      if(value instanceof String) {
        try {
          return Double.valueOf(Double.parseDouble(((String) value).trim()));
        } catch(Exception ignored) {
        }
      }
    }
    return null;
  }

  private static Integer parseIndexedField(String fieldKey, String prefix) {
    if(fieldKey == null || prefix == null || !fieldKey.startsWith(prefix)) {
      return null;
    }
    int close = fieldKey.indexOf(']', prefix.length());
    if(close < 0) {
      return null;
    }
    String indexText = fieldKey.substring(prefix.length(), close).trim();
    if(indexText.isEmpty()) {
      return null;
    }
    try {
      return Integer.valueOf(Integer.parseInt(indexText));
    } catch(Exception ex) {
      return null;
    }
  }

  private static Integer parseDialogIndex(String fieldKey) {
    if(fieldKey == null) {
      return null;
    }
    String prefix = "dialog_lines_json[";
    if(!fieldKey.startsWith(prefix)) {
      return null;
    }
    int close = fieldKey.indexOf(']', prefix.length());
    if(close < 0) {
      return null;
    }
    String indexText = fieldKey.substring(prefix.length(), close).trim();
    if(indexText.isEmpty()) {
      return null;
    }
    try {
      return Integer.valueOf(Integer.parseInt(indexText));
    } catch(Exception ex) {
      return null;
    }
  }

  private static int maxWritableStringBytes(LuaChunk.Constant constant) {
    if(constant == null || constant.stringValue == null) {
      return 0;
    }
    int len = constant.stringValue.lengthField;
    if(len <= 0) {
      return 0;
    }
    return len - 1;
  }

  private static void applyActionInConstantArea(byte[] patched, LuaChunk chunk, PatchAction action) {
    if("reject_overflow".equals(action.action)) {
      throw new IllegalStateException(
          "string overflow quest=" + action.questId
          + " field=" + action.fieldKey
          + " maxBytes=" + action.maxBytes
          + " newBytes=" + action.newBytes);
    }

    if("patch_string".equals(action.action)) {
      patchStringConstantFixedSize(patched, chunk.header, action.binding.constant, action.newValue, Charset.forName(System.getProperty("unluac.stringCharset", "GBK")));
      return;
    }

    if("patch_number".equals(action.action)) {
      byte[] raw = encodeNumberRaw(action.newValue, chunk.header);
      System.arraycopy(raw, 0, patched, action.binding.constant.valueOffset, raw.length);
      action.binding.constant.rawNumberBytes = raw;
      return;
    }

    throw new IllegalStateException("unknown patch action: " + action.action);
  }

  private static void patchStringConstantFixedSize(byte[] target,
                                                   LuaChunk.Header header,
                                                   LuaChunk.Constant constant,
                                                   String replacement,
                                                   Charset charset) {
    if(constant == null || constant.stringValue == null || constant.stringValue.decodedBytes == null) {
      throw new IllegalStateException("invalid string constant");
    }
    int length = constant.stringValue.lengthField;
    if(length <= 0) {
      throw new IllegalStateException("cannot patch zero-length string");
    }
    int contentLength = length - 1;
    byte[] replacementBytes = replacement.getBytes(charset);
    if(replacementBytes.length > contentLength) {
      throw new IllegalStateException("replacement too long for fixed-size patch: " + replacementBytes.length + ">" + contentLength);
    }

    byte[] decoded = constant.stringValue.decodedBytes.clone();
    for(int i = 0; i < contentLength; i++) {
      decoded[i] = 0;
    }
    System.arraycopy(replacementBytes, 0, decoded, 0, replacementBytes.length);
    decoded[length - 1] = 0;

    byte[] raw = decoded.clone();
    if(header.encodedStrings && raw.length > 0) {
      for(int i = 0; i < raw.length - 1; i++) {
        raw[i] = (byte) ((raw[i] + (i + 1)) & 0xFF);
      }
    }
    System.arraycopy(raw, 0, target, constant.stringValue.dataOffset, raw.length);
    constant.stringValue.decodedBytes = decoded;
    constant.stringValue.text = replacement;
  }

  private static byte[] encodeNumberRaw(String valueText, LuaChunk.Header header) {
    ByteBuffer bb = ByteBuffer.allocate(header.numberSize);
    bb.order(header.isLittleEndian() ? ByteOrder.LITTLE_ENDIAN : ByteOrder.BIG_ENDIAN);
    if(header.numberIntegral) {
      long value = Long.parseLong(valueText);
      if(header.numberSize == 4) {
        bb.putInt((int) value);
      } else if(header.numberSize == 8) {
        bb.putLong(value);
      } else {
        throw new IllegalStateException("unsupported integral number size: " + header.numberSize);
      }
    } else {
      double value = Double.parseDouble(valueText);
      if(header.numberSize == 4) {
        bb.putFloat((float) value);
      } else if(header.numberSize == 8) {
        bb.putDouble(value);
      } else {
        throw new IllegalStateException("unsupported float number size: " + header.numberSize);
      }
    }
    return bb.array();
  }

  private static String numericToString(double value) {
    double rounded = Math.rint(value);
    if(Math.abs(value - rounded) < 0.0000001D) {
      return Long.toString((long) rounded);
    }
    return Double.toString(value);
  }

  private static LuaChunk.Function findFunction(LuaChunk.Function root, String path) {
    if(root == null || path == null) {
      return null;
    }
    if(path.equals(root.path)) {
      return root;
    }
    for(LuaChunk.Function child : root.prototypes) {
      LuaChunk.Function found = findFunction(child, path);
      if(found != null) {
        return found;
      }
    }
    return null;
  }

  private static void verifyNoInstructionOrPrototypeChanges(LuaChunk before, LuaChunk after) {
    verifyFunctionTree(before.mainFunction, after.mainFunction);
  }

  private static void verifyFunctionTree(LuaChunk.Function before, LuaChunk.Function after) {
    if(before.code.size() != after.code.size()) {
      throw new IllegalStateException("instruction count changed at " + before.path);
    }
    for(int i = 0; i < before.code.size(); i++) {
      if(before.code.get(i).value != after.code.get(i).value) {
        throw new IllegalStateException("instruction value changed at " + before.path + "#" + i);
      }
    }
    if(before.prototypes.size() != after.prototypes.size()) {
      throw new IllegalStateException("prototype count changed at " + before.path);
    }
    for(int i = 0; i < before.prototypes.size(); i++) {
      verifyFunctionTree(before.prototypes.get(i), after.prototypes.get(i));
    }
  }

  private static void printUsage() {
    System.out.println("Usage:");
    System.out.println("  java -cp build unluac.semantic.QuestSemanticPatchApplier <input.luc> <edited.csv> <output.luc> <mapping.csv>");
  }

  public enum PatchValueType {
    STRING,
    NUMBER
  }

  public static final class PatchBinding {
    public int questId;
    public String fieldKey;
    public String functionPath;
    public int constantIndex;
    public int sourcePc;
    public String sourceFunctionPath;
    public PatchValueType valueType;
    public String oldStringValue;
    public double oldNumberValue;
    public LuaChunk.Constant constant;
  }

  public static final class PatchAction {
    public int questId;
    public String fieldKey;
    public String functionPath;
    public int constantIndex;
    public String constantType;
    public String oldValue;
    public String newValue;
    public int maxBytes;
    public int newBytes;
    public boolean lengthOk;
    public String action;
    public PatchBinding binding;

    public String toCsvLine() {
      return csv(Integer.toString(questId)) + ","
          + csv(fieldKey) + ","
          + csv(functionPath) + ","
          + csv(Integer.toString(constantIndex)) + ","
          + csv(constantType) + ","
          + csv(oldValue) + ","
          + csv(newValue) + ","
          + csv(Integer.toString(maxBytes)) + ","
          + csv(Integer.toString(newBytes)) + ","
          + csv(Boolean.toString(lengthOk)) + ","
          + csv(action);
    }
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
