package unluac.semantic;

import java.nio.charset.Charset;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

import unluac.chunk.Lua50ChunkParser;
import unluac.chunk.Lua50StructureValidator;
import unluac.chunk.LuaChunk;

public class QuestEditorCli {

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
      Path inputLuc = Paths.get(args[1]);
      Path outputCsv = Paths.get(args[2]);
      QuestSemanticCsvTool.exportCsv(inputLuc, outputCsv);
      return;
    }

    if("import".equalsIgnoreCase(command)) {
      if(args.length != 4) {
        printUsage();
        return;
      }
      Path inputLuc = Paths.get(args[1]);
      Path inputCsv = Paths.get(args[2]);
      Path outputLuc = Paths.get(args[3]);
      runImportWithValidation(inputLuc, inputCsv, outputLuc);
      return;
    }

    throw new IllegalStateException("unknown command: " + command);
  }

  private static void runImportWithValidation(Path inputLuc, Path inputCsv, Path outputLuc) throws Exception {
    byte[] before = Files.readAllBytes(inputLuc);
    Lua50ChunkParser parser = new Lua50ChunkParser();
    LuaChunk beforeChunk = parser.parse(before);

    Path mappingPath = Paths.get(outputLuc.toString() + ".mapping.csv");
    QuestSemanticPatchApplier.apply(inputLuc, inputCsv, outputLuc, mappingPath);

    byte[] after = Files.readAllBytes(outputLuc);
    LuaChunk afterChunk = parser.parse(after);

    List<DiffItemView> diffs = buildDiffView(before, after, beforeChunk);
    int constantDiff = 0;
    int nonConstantDiff = 0;
    for(DiffItemView diff : diffs) {
      if(diff.constantArea) {
        constantDiff++;
      } else {
        nonConstantDiff++;
      }
    }

    int modifiedQuestCount = countModifiedQuests(mappingPath);

    System.out.println("diff_total=" + diffs.size());
    System.out.println("diff_constant_area=" + constantDiff);
    System.out.println("diff_non_constant_area=" + nonConstantDiff);
    System.out.println("modified_quest_count=" + modifiedQuestCount);

    for(int i = 0; i < diffs.size(); i++) {
      DiffItemView diff = diffs.get(i);
      String area = diff.constantArea ? "constant" : "non-constant";
      System.out.println(String.format(
          "diff[%d] offset=0x%08X %02X->%02X area=%s",
          i,
          diff.offset,
          diff.before,
          diff.after,
          area));
    }

    Lua50StructureValidator validator = new Lua50StructureValidator(before);
    Lua50StructureValidator.ValidationReport report = validator.validateLuc(after);
    System.out.println(report.toTextReport());

    if(!report.structureConsistent) {
      throw new IllegalStateException("structure validation failed");
    }

    if(nonConstantDiff > 0) {
      throw new IllegalStateException("detected non-constant area changes: " + nonConstantDiff);
    }

    verifyInstructionsAndPrototypesUnchanged(beforeChunk, afterChunk);
  }

  private static void verifyInstructionsAndPrototypesUnchanged(LuaChunk before, LuaChunk after) {
    verifyFunctionTree(before.mainFunction, after.mainFunction);
  }

  private static void verifyFunctionTree(LuaChunk.Function before, LuaChunk.Function after) {
    if(before.code.size() != after.code.size()) {
      throw new IllegalStateException("instruction count changed at " + before.path);
    }
    for(int i = 0; i < before.code.size(); i++) {
      if(before.code.get(i).value != after.code.get(i).value) {
        throw new IllegalStateException("instruction changed at " + before.path + "#" + i);
      }
    }
    if(before.prototypes.size() != after.prototypes.size()) {
      throw new IllegalStateException("prototype count changed at " + before.path);
    }
    for(int i = 0; i < before.prototypes.size(); i++) {
      verifyFunctionTree(before.prototypes.get(i), after.prototypes.get(i));
    }
  }

  public static List<DiffItemView> buildDiffView(byte[] before, byte[] after, LuaChunk chunk) {
    List<DiffItemView> out = new ArrayList<DiffItemView>();
    int n = Math.min(before.length, after.length);
    for(int i = 0; i < n; i++) {
      if(before[i] != after[i]) {
        DiffItemView diff = new DiffItemView();
        diff.offset = i;
        diff.before = before[i] & 0xFF;
        diff.after = after[i] & 0xFF;
        diff.constantArea = isInsideAnyConstantArea(chunk.mainFunction, i);
        out.add(diff);
      }
    }
    if(before.length != after.length) {
      int m = Math.max(before.length, after.length);
      for(int i = n; i < m; i++) {
        DiffItemView diff = new DiffItemView();
        diff.offset = i;
        diff.before = i < before.length ? (before[i] & 0xFF) : -1;
        diff.after = i < after.length ? (after[i] & 0xFF) : -1;
        diff.constantArea = false;
        out.add(diff);
      }
    }
    return out;
  }

  private static boolean isInsideAnyConstantArea(LuaChunk.Function function, int offset) {
    if(function == null) {
      return false;
    }
    if(offset >= function.constantsStartOffset && offset < function.constantsEndOffset) {
      return true;
    }
    for(LuaChunk.Function child : function.prototypes) {
      if(isInsideAnyConstantArea(child, offset)) {
        return true;
      }
    }
    return false;
  }

  private static int countModifiedQuests(Path mappingPath) throws Exception {
    if(!Files.exists(mappingPath)) {
      return 0;
    }
    String text = new String(Files.readAllBytes(mappingPath), Charset.forName("UTF-8"));
    List<String[]> rows = parseCsv(text);
    if(rows.size() <= 1) {
      return 0;
    }

    Set<Integer> questIds = new LinkedHashSet<Integer>();
    for(int i = 1; i < rows.size(); i++) {
      String[] row = rows.get(i);
      if(row.length < 11) {
        continue;
      }
      String action = row[10];
      if(!"patch_string".equals(action) && !"patch_number".equals(action)) {
        continue;
      }
      questIds.add(Integer.valueOf(Integer.parseInt(row[0])));
    }
    return questIds.size();
  }

  public static int countModifiedQuestCountForGui(Path mappingPath) throws Exception {
    return countModifiedQuests(mappingPath);
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

  private static void printUsage() {
    System.out.println("Usage:");
    System.out.println("  java QuestEditorCli export <quest.luc> <quest_editor.csv>");
    System.out.println("  java QuestEditorCli import <quest.luc> <quest_editor.csv> <quest_patched.luc>");
  }

  public static final class DiffItemView {
    public int offset;
    public int before;
    public int after;
    public boolean constantArea;
  }
}
