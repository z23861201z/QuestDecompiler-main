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

public class QuestModificationAutoPropagator {

  private static final Charset UTF8 = Charset.forName("UTF-8");

  public static void main(String[] args) throws Exception {
    if(args.length < 2) {
      printUsage();
      return;
    }

    Path npcLuaDir = Paths.get(args[0]);
    Path propagationV2Path = Paths.get(args[1]);
    Path rewrittenNpcDir = args.length >= 3
        ? Paths.get(args[2])
        : Paths.get("npc-lua-auto-rewritten");
    Path planOut = args.length >= 4
        ? Paths.get(args[3])
        : Paths.get("reports", "auto_rewrite_plan.json");
    Path diffOut = args.length >= 5
        ? Paths.get(args[4])
        : Paths.get("reports", "auto_rewrite_diff.txt");
    Path consistencyOut = args.length >= 6
        ? Paths.get(args[5])
        : Paths.get("reports", "runtime_consistency_report.json");

    QuestModificationAutoPropagator propagator = new QuestModificationAutoPropagator();
    AutoRewriteResult result = propagator.execute(npcLuaDir, propagationV2Path, rewrittenNpcDir, planOut, diffOut, consistencyOut);

    System.out.println("npc_dir=" + npcLuaDir.toAbsolutePath());
    System.out.println("propagation_v2=" + propagationV2Path.toAbsolutePath());
    System.out.println("rewritten_dir=" + rewrittenNpcDir.toAbsolutePath());
    System.out.println("auto_plan=" + planOut.toAbsolutePath());
    System.out.println("auto_diff=" + diffOut.toAbsolutePath());
    System.out.println("consistency_report=" + consistencyOut.toAbsolutePath());
    System.out.println("targetedQuestCount=" + result.targetedQuestCount);
    System.out.println("targetedNpcCount=" + result.targetedNpcCount);
    System.out.println("rewrittenFiles=" + result.rewrittenFiles);
    System.out.println("validationStatus=" + result.validationStatus);
  }

  public AutoRewriteResult execute(Path npcLuaDir,
                                   Path propagationV2Path,
                                   Path rewrittenNpcDir,
                                   Path planOut,
                                   Path diffOut,
                                   Path consistencyOut) throws Exception {
    if(npcLuaDir == null || !Files.exists(npcLuaDir) || !Files.isDirectory(npcLuaDir)) {
      throw new IllegalStateException("npc lua directory not found: " + npcLuaDir);
    }
    if(propagationV2Path == null || !Files.exists(propagationV2Path)) {
      throw new IllegalStateException("propagation v2 not found: " + propagationV2Path);
    }

    Map<String, Object> root = QuestSemanticJson.parseObject(
        new String(Files.readAllBytes(propagationV2Path), UTF8), "quest_modification_propagation_v2", 0);

    TargetSelection selection = selectTargets(root);
    writeAutoRewritePlan(selection, planOut);

    NpcHardcodeRewriter.RewriteOutput rewriteOutput = NpcHardcodeRewriter.rewriteSelected(
        npcLuaDir, rewrittenNpcDir, planOut, diffOut, new ArrayList<String>(selection.targetNpcFiles));

    QuestNpcDependencyScanner.DependencyIndex rewrittenIndex = QuestNpcDependencyScanner.scanDirectory(rewrittenNpcDir);
    Path rewrittenIndexOut = Paths.get("reports", "auto_rewrite_dependency_index.json");
    QuestNpcDependencyScanner.writeIndex(rewrittenIndex, rewrittenIndexOut);

    AutoRewriteResult result = buildConsistencyResult(selection, rewriteOutput, rewrittenIndex, npcLuaDir, rewrittenNpcDir);
    writeConsistencyReport(result, consistencyOut);
    return result;
  }

  private AutoRewriteResult buildConsistencyResult(TargetSelection selection,
                                                   NpcHardcodeRewriter.RewriteOutput rewriteOutput,
                                                   QuestNpcDependencyScanner.DependencyIndex rewrittenIndex,
                                                   Path npcLuaDir,
                                                   Path rewrittenNpcDir) {
    AutoRewriteResult result = new AutoRewriteResult();
    result.generatedAt = OffsetDateTime.now().format(DateTimeFormatter.ISO_OFFSET_DATE_TIME);
    result.sourceNpcDir = npcLuaDir.toAbsolutePath().toString();
    result.rewrittenNpcDir = rewrittenNpcDir.toAbsolutePath().toString();
    result.scannedFiles = rewriteOutput.scannedFiles;
    result.rewrittenFiles = rewriteOutput.rewrittenFiles;
    result.rewrittenLineCount = rewriteOutput.rewrittenLineCount;
    result.targetedQuestIds.addAll(selection.targetQuestIds);
    result.targetedNpcFiles.addAll(selection.targetNpcFiles);
    result.targetedQuestCount = result.targetedQuestIds.size();
    result.targetedNpcCount = result.targetedNpcFiles.size();

    for(String questId : selection.unmatchedQuestIds) {
      result.unmatchedQuestIds.add(questId);
    }

    Map<String, List<QuestNpcDependencyScanner.AccessEntry>> byFileHardcoded = collectRemainingHardcodedByFile(rewrittenIndex);
    for(String file : result.targetedNpcFiles) {
      List<QuestNpcDependencyScanner.AccessEntry> entries = byFileHardcoded.get(file);
      if(entries == null || entries.isEmpty()) {
        continue;
      }
      for(QuestNpcDependencyScanner.AccessEntry access : entries) {
        result.remainingHardcodedGoalIndexes.add(file + ":line=" + access.line + ":index=" + access.index);
      }
    }

    Set<String> rewrittenFiles = listNpcFiles(rewrittenNpcDir);
    for(String file : result.targetedNpcFiles) {
      if(!rewrittenFiles.contains(normalizePath(file))) {
        result.brokenReferences.add(file + ":missing_in_rewritten_dir");
      }
    }

    if(!result.remainingHardcodedGoalIndexes.isEmpty() || !result.brokenReferences.isEmpty()) {
      result.validationStatus = "FAIL";
    } else {
      result.validationStatus = "PASS";
    }

    Collections.sort(result.targetedQuestIds);
    Collections.sort(result.targetedNpcFiles, String.CASE_INSENSITIVE_ORDER);
    Collections.sort(result.unmatchedQuestIds, String.CASE_INSENSITIVE_ORDER);
    Collections.sort(result.brokenReferences, String.CASE_INSENSITIVE_ORDER);
    Collections.sort(result.remainingHardcodedGoalIndexes, String.CASE_INSENSITIVE_ORDER);
    return result;
  }

  private Map<String, List<QuestNpcDependencyScanner.AccessEntry>> collectRemainingHardcodedByFile(
      QuestNpcDependencyScanner.DependencyIndex index) {
    Map<String, List<QuestNpcDependencyScanner.AccessEntry>> out = new LinkedHashMap<String, List<QuestNpcDependencyScanner.AccessEntry>>();
    if(index == null || index.quests == null) {
      return out;
    }

    for(QuestNpcDependencyScanner.QuestDependencyRecord record : index.quests.values()) {
      if(record == null || record.npcFiles == null) {
        continue;
      }
      for(QuestNpcDependencyScanner.NpcReference ref : record.npcFiles) {
        if(ref == null || ref.file == null || ref.access == null) {
          continue;
        }
        String file = normalizePath(ref.file);
        List<QuestNpcDependencyScanner.AccessEntry> bucket = out.get(file);
        if(bucket == null) {
          bucket = new ArrayList<QuestNpcDependencyScanner.AccessEntry>();
          out.put(file, bucket);
        }
        for(QuestNpcDependencyScanner.AccessEntry access : ref.access) {
          if(access == null) {
            continue;
          }
          if(access.hardcodedIndex && "goal.getItem".equals(access.type)) {
            bucket.add(access);
          }
        }
      }
    }

    return out;
  }

  private Set<String> listNpcFiles(Path dir) {
    Set<String> out = new LinkedHashSet<String>();
    if(dir == null || !Files.exists(dir) || !Files.isDirectory(dir)) {
      return out;
    }
    try {
      Files.walk(dir)
          .filter(Files::isRegularFile)
          .forEach(path -> {
            String name = path.getFileName().toString().toLowerCase(Locale.ROOT);
            if(name.startsWith("npc_") && name.endsWith(".lua")) {
              out.add(normalizePath(dir.relativize(path).toString()));
            }
          });
    } catch(Exception ignored) {
    }
    return out;
  }

  @SuppressWarnings("unchecked")
  private TargetSelection selectTargets(Map<String, Object> root) {
    TargetSelection out = new TargetSelection();
    if(root == null) {
      return out;
    }

    Object questsObj = root.get("quests");
    if(!(questsObj instanceof List<?>)) {
      return out;
    }

    for(Object questObj : (List<Object>) questsObj) {
      if(!(questObj instanceof Map<?, ?>)) {
        continue;
      }
      Map<String, Object> quest = (Map<String, Object>) questObj;
      int questId = intOf(quest.get("questId"));
      if(questId <= 0) {
        continue;
      }

      boolean rewriteRequired = boolOf(quest.get("rewriteRequired"));
      if(!rewriteRequired) {
        continue;
      }

      out.targetQuestIds.add(Integer.valueOf(questId));

      Object filesObj = quest.get("affectedNpcFiles");
      if(!(filesObj instanceof List<?>)) {
        out.unmatchedQuestIds.add(Integer.toString(questId));
        continue;
      }

      int before = out.targetNpcFiles.size();
      for(Object fileObj : (List<Object>) filesObj) {
        String file = normalizePath(stringOf(fileObj));
        if(!file.isEmpty()) {
          out.targetNpcFiles.add(file);
        }
      }
      if(out.targetNpcFiles.size() == before) {
        out.unmatchedQuestIds.add(Integer.toString(questId));
      }
    }

    List<Integer> questIds = new ArrayList<Integer>(out.targetQuestIds);
    Collections.sort(questIds);
    out.targetQuestIds.clear();
    out.targetQuestIds.addAll(questIds);

    List<String> npcFiles = new ArrayList<String>(out.targetNpcFiles);
    Collections.sort(npcFiles, String.CASE_INSENSITIVE_ORDER);
    out.targetNpcFiles.clear();
    out.targetNpcFiles.addAll(npcFiles);

    List<String> unmatched = new ArrayList<String>(out.unmatchedQuestIds);
    Collections.sort(unmatched, new Comparator<String>() {
      @Override
      public int compare(String a, String b) {
        return Integer.compare(intOfStatic(a), intOfStatic(b));
      }
    });
    out.unmatchedQuestIds.clear();
    out.unmatchedQuestIds.addAll(unmatched);
    return out;
  }

  private void writeAutoRewritePlan(TargetSelection selection, Path planOut) throws Exception {
    if(planOut.getParent() != null && !Files.exists(planOut.getParent())) {
      Files.createDirectories(planOut.getParent());
    }

    StringBuilder sb = new StringBuilder();
    sb.append("{\n");
    sb.append("  \"generatedAt\": \"")
        .append(escape(OffsetDateTime.now().format(DateTimeFormatter.ISO_OFFSET_DATE_TIME))).append("\",\n");
    sb.append("  \"targetedQuestIds\": [");
    for(int i = 0; i < selection.targetQuestIds.size(); i++) {
      if(i > 0) {
        sb.append(", ");
      }
      sb.append(selection.targetQuestIds.get(i).intValue());
    }
    sb.append("],\n");
    sb.append("  \"targetedNpcFiles\": [");
    List<String> npcFiles = new ArrayList<String>(selection.targetNpcFiles);
    for(int i = 0; i < npcFiles.size(); i++) {
      if(i > 0) {
        sb.append(", ");
      }
      sb.append('"').append(escape(npcFiles.get(i))).append('"');
    }
    sb.append("],\n");
    sb.append("  \"unmatchedQuestIds\": [");
    List<String> unmatched = new ArrayList<String>(selection.unmatchedQuestIds);
    for(int i = 0; i < unmatched.size(); i++) {
      if(i > 0) {
        sb.append(", ");
      }
      sb.append('"').append(escape(unmatched.get(i))).append('"');
    }
    sb.append("]\n");
    sb.append("}\n");

    Files.write(planOut, sb.toString().getBytes(UTF8));
  }

  private void writeConsistencyReport(AutoRewriteResult result, Path consistencyOut) throws Exception {
    if(consistencyOut.getParent() != null && !Files.exists(consistencyOut.getParent())) {
      Files.createDirectories(consistencyOut.getParent());
    }
    Files.write(consistencyOut, result.toJson().getBytes(UTF8));
  }

  private static int intOfStatic(String value) {
    try {
      return Integer.parseInt(value);
    } catch(Exception ex) {
      return Integer.MAX_VALUE;
    }
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

  private String normalizePath(String value) {
    if(value == null) {
      return "";
    }
    return value.replace('\\', '/').trim();
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

  private static void printUsage() {
    System.out.println("Usage:");
    System.out.println("  java -cp build unluac.semantic.QuestModificationAutoPropagator <npc-lua-dir> <quest_modification_propagation_v2.json> [rewritten-npc-dir] [auto-plan.json] [auto-diff.txt] [runtime-consistency-report.json]");
  }

  private static final class TargetSelection {
    final List<Integer> targetQuestIds = new ArrayList<Integer>();
    final Set<String> targetNpcFiles = new LinkedHashSet<String>();
    final Set<String> unmatchedQuestIds = new LinkedHashSet<String>();
  }
}
