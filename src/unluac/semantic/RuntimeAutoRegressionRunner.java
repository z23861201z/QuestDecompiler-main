package unluac.semantic;

import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.nio.charset.Charset;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.OffsetDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import java.util.Map;

public class RuntimeAutoRegressionRunner {

  private static final Charset UTF8 = Charset.forName("UTF-8");

  public static void main(String[] args) throws Exception {
    Path startNpcDir = args.length >= 1
        ? Paths.get(args[0])
        : Paths.get("npc-lua-auto-rewritten");
    Path propagationV2Path = args.length >= 2
        ? Paths.get(args[1])
        : Paths.get("reports", "quest_modification_propagation_v2.json");
    Path finalReportPath = args.length >= 3
        ? Paths.get(args[2])
        : Paths.get("reports", "runtime_regression_final.json");
    int maxRounds = args.length >= 4
        ? intOf(args[3], 5)
        : 5;

    RuntimeAutoRegressionRunner runner = new RuntimeAutoRegressionRunner();
    FinalReport report = runner.run(startNpcDir, propagationV2Path, finalReportPath, maxRounds);

    System.out.println("startNpcDir=" + startNpcDir.toAbsolutePath());
    System.out.println("propagationV2Path=" + propagationV2Path.toAbsolutePath());
    System.out.println("finalReportPath=" + finalReportPath.toAbsolutePath());
    System.out.println("roundsExecuted=" + report.roundsExecuted);
    System.out.println("finalStatus=" + report.finalStatus);
    System.out.println("safeRound=" + report.safeRound);
  }

  public FinalReport run(Path startNpcDir,
                         Path propagationV2Path,
                         Path finalReportPath,
                         int maxRounds) throws Exception {
    if(startNpcDir == null || !Files.exists(startNpcDir) || !Files.isDirectory(startNpcDir)) {
      throw new IllegalStateException("start npc dir not found: " + startNpcDir);
    }
    if(propagationV2Path == null || !Files.exists(propagationV2Path)) {
      throw new IllegalStateException("propagation v2 json not found: " + propagationV2Path);
    }

    Path regressionBase = Paths.get("reports", "runtime_regression_rounds");
    Path npcOutBase = Paths.get("npc-lua-regression");
    if(!Files.exists(regressionBase)) {
      Files.createDirectories(regressionBase);
    }
    if(!Files.exists(npcOutBase)) {
      Files.createDirectories(npcOutBase);
    }

    FinalReport finalReport = new FinalReport();
    finalReport.generatedAt = OffsetDateTime.now().format(DateTimeFormatter.ISO_OFFSET_DATE_TIME);
    finalReport.maxRounds = maxRounds;
    finalReport.initialNpcDir = startNpcDir.toAbsolutePath().toString();

    Path currentNpcDir = startNpcDir;
    for(int round = 1; round <= maxRounds; round++) {
      RoundReport roundReport = new RoundReport();
      roundReport.round = round;
      roundReport.inputNpcDir = currentNpcDir.toAbsolutePath().toString();

      Path roundDir = regressionBase.resolve("round_" + round);
      if(!Files.exists(roundDir)) {
        Files.createDirectories(roundDir);
      }

      Path beforeIndex = roundDir.resolve("dependency_before.json");
      Path beforeValidation = roundDir.resolve("validation_before.json");
      Path classification = roundDir.resolve("classification.json");
      Path autofixReport = roundDir.resolve("autofix_report.json");

      runAndRecord(roundReport,
          "unluac.semantic.QuestNpcDependencyScanner",
          currentNpcDir.toString(),
          beforeIndex.toString());

      runAndRecord(roundReport,
          "unluac.semantic.RuntimeConsistencyValidator",
          currentNpcDir.toString(),
          beforeIndex.toString(),
          propagationV2Path.toString(),
          beforeValidation.toString());

      String beforeStatus = readValidationStatus(beforeValidation);
      roundReport.preValidationStatus = beforeStatus;
      roundReport.beforeValidationPath = beforeValidation.toAbsolutePath().toString();

      if("SAFE".equals(beforeStatus)) {
        finalReport.finalStatus = "SAFE";
        finalReport.safeRound = round;
        finalReport.rounds.add(roundReport);
        finalReport.roundsExecuted = round;
        finalReport.finalNpcDir = currentNpcDir.toAbsolutePath().toString();
        writeFinalReport(finalReportPath, finalReport);
        return finalReport;
      }

      runAndRecord(roundReport,
          "unluac.semantic.RuntimeFailurePatternClassifier",
          beforeValidation.toString(),
          beforeIndex.toString(),
          currentNpcDir.toString(),
          classification.toString());
      roundReport.classificationPath = classification.toAbsolutePath().toString();
      roundReport.classifiedFailureCount = readIntField(classification, "totalFailures");

      Path nextNpcDir = npcOutBase.resolve("round_" + round);
      runAndRecord(roundReport,
          "unluac.semantic.RuntimeAutoFixDispatcher",
          classification.toString(),
          currentNpcDir.toString(),
          nextNpcDir.toString(),
          autofixReport.toString());
      roundReport.autoFixReportPath = autofixReport.toAbsolutePath().toString();
      roundReport.fixedCount = readIntField(autofixReport, "fixedCount");
      roundReport.skippedCount = readIntField(autofixReport, "skippedCount");

      Path afterIndex = roundDir.resolve("dependency_after.json");
      Path afterValidation = roundDir.resolve("validation_after.json");
      runAndRecord(roundReport,
          "unluac.semantic.QuestNpcDependencyScanner",
          nextNpcDir.toString(),
          afterIndex.toString());

      runAndRecord(roundReport,
          "unluac.semantic.RuntimeConsistencyValidator",
          nextNpcDir.toString(),
          afterIndex.toString(),
          propagationV2Path.toString(),
          afterValidation.toString());

      roundReport.postValidationStatus = readValidationStatus(afterValidation);
      roundReport.afterValidationPath = afterValidation.toAbsolutePath().toString();
      roundReport.outputNpcDir = nextNpcDir.toAbsolutePath().toString();

      finalReport.rounds.add(roundReport);
      finalReport.roundsExecuted = round;

      currentNpcDir = nextNpcDir;
      if("SAFE".equals(roundReport.postValidationStatus)) {
        finalReport.finalStatus = "SAFE";
        finalReport.safeRound = round;
        finalReport.finalNpcDir = currentNpcDir.toAbsolutePath().toString();
        writeFinalReport(finalReportPath, finalReport);
        return finalReport;
      }
    }

    finalReport.finalStatus = "UNSAFE";
    finalReport.safeRound = -1;
    finalReport.finalNpcDir = currentNpcDir.toAbsolutePath().toString();
    finalReport.terminatedByMaxRounds = true;
    writeFinalReport(finalReportPath, finalReport);
    return finalReport;
  }

  private void runAndRecord(RoundReport roundReport,
                            String className,
                            String... args) throws Exception {
    ProcessResult result = runJava(className, args);
    roundReport.commands.add(result.command);
    roundReport.commandOutputs.add(result.output);
    roundReport.exitCodes.add(Integer.valueOf(result.exitCode));
    if(result.exitCode != 0) {
      throw new IllegalStateException("command failed: " + result.command + "\n" + result.output);
    }
  }

  private ProcessResult runJava(String className, String... args) throws Exception {
    List<String> command = new ArrayList<String>();
    command.add(resolveJavaBin());
    command.add("-cp");
    command.add(System.getProperty("java.class.path"));
    command.add(className);
    if(args != null) {
      for(String arg : args) {
        command.add(arg);
      }
    }

    ProcessBuilder pb = new ProcessBuilder(command);
    pb.redirectErrorStream(true);
    Process process = pb.start();

    ByteArrayOutputStream out = new ByteArrayOutputStream();
    try(InputStream in = process.getInputStream()) {
      byte[] buf = new byte[4096];
      int read;
      while((read = in.read(buf)) >= 0) {
        out.write(buf, 0, read);
      }
    }

    int exit = process.waitFor();
    ProcessResult result = new ProcessResult();
    result.command = joinCommand(command);
    result.output = new String(out.toByteArray(), UTF8);
    result.exitCode = exit;
    return result;
  }

  private String resolveJavaBin() {
    Path javaBin = Paths.get(System.getProperty("java.home"), "bin", "java");
    if(Files.exists(javaBin)) {
      return javaBin.toString();
    }
    return "java";
  }

  private String joinCommand(List<String> command) {
    StringBuilder sb = new StringBuilder();
    for(int i = 0; i < command.size(); i++) {
      if(i > 0) {
        sb.append(' ');
      }
      String token = command.get(i);
      if(token.indexOf(' ') >= 0) {
        sb.append('"').append(token).append('"');
      } else {
        sb.append(token);
      }
    }
    return sb.toString();
  }

  private String readValidationStatus(Path reportPath) throws Exception {
    Map<String, Object> root = QuestSemanticJson.parseObject(
        new String(Files.readAllBytes(reportPath), UTF8), "runtime_validation", 0);
    String status = stringOf(root.get("finalStatus")).trim();
    return status.isEmpty() ? "UNSAFE" : status.toUpperCase(Locale.ROOT);
  }

  private int readIntField(Path jsonPath, String key) throws Exception {
    Map<String, Object> root = QuestSemanticJson.parseObject(
        new String(Files.readAllBytes(jsonPath), UTF8), key, 0);
    Object value = root.get(key);
    if(value instanceof Number) {
      return ((Number) value).intValue();
    }
    try {
      return Integer.parseInt(stringOf(value).trim());
    } catch(Exception ex) {
      return 0;
    }
  }

  private String stringOf(Object value) {
    return value == null ? "" : String.valueOf(value);
  }

  private void writeFinalReport(Path finalReportPath, FinalReport report) throws Exception {
    if(finalReportPath.getParent() != null && !Files.exists(finalReportPath.getParent())) {
      Files.createDirectories(finalReportPath.getParent());
    }
    Files.write(finalReportPath, report.toJson().getBytes(UTF8));
  }

  private static int intOf(String text, int fallback) {
    try {
      return Integer.parseInt(text.trim());
    } catch(Exception ex) {
      return fallback;
    }
  }

  public static final class FinalReport {
    public String generatedAt = "";
    public int maxRounds;
    public int roundsExecuted;
    public int safeRound = -1;
    public boolean terminatedByMaxRounds;
    public String initialNpcDir = "";
    public String finalNpcDir = "";
    public String finalStatus = "UNSAFE";
    public final List<RoundReport> rounds = new ArrayList<RoundReport>();

    public String toJson() {
      StringBuilder sb = new StringBuilder();
      sb.append("{\n");
      sb.append("  \"generatedAt\": \"").append(escape(generatedAt)).append("\",\n");
      sb.append("  \"maxRounds\": ").append(maxRounds).append(",\n");
      sb.append("  \"roundsExecuted\": ").append(roundsExecuted).append(",\n");
      sb.append("  \"safeRound\": ").append(safeRound).append(",\n");
      sb.append("  \"terminatedByMaxRounds\": ").append(terminatedByMaxRounds).append(",\n");
      sb.append("  \"initialNpcDir\": \"").append(escape(initialNpcDir)).append("\",\n");
      sb.append("  \"finalNpcDir\": \"").append(escape(finalNpcDir)).append("\",\n");
      sb.append("  \"finalStatus\": \"").append(escape(finalStatus)).append("\",\n");
      sb.append("  \"rounds\": [");
      if(!rounds.isEmpty()) {
        sb.append("\n");
      }
      for(int i = 0; i < rounds.size(); i++) {
        if(i > 0) {
          sb.append(",\n");
        }
        sb.append(rounds.get(i).toJson("    "));
      }
      if(!rounds.isEmpty()) {
        sb.append("\n");
      }
      sb.append("  ]\n");
      sb.append("}\n");
      return sb.toString();
    }
  }

  public static final class RoundReport {
    public int round;
    public String inputNpcDir = "";
    public String outputNpcDir = "";
    public String beforeValidationPath = "";
    public String afterValidationPath = "";
    public String classificationPath = "";
    public String autoFixReportPath = "";
    public String preValidationStatus = "";
    public String postValidationStatus = "";
    public int classifiedFailureCount;
    public int fixedCount;
    public int skippedCount;
    public final List<String> commands = new ArrayList<String>();
    public final List<Integer> exitCodes = new ArrayList<Integer>();
    public final List<String> commandOutputs = new ArrayList<String>();

    public String toJson(String indent) {
      String next = indent + "  ";
      StringBuilder sb = new StringBuilder();
      sb.append(indent).append("{\n");
      sb.append(next).append("\"round\": ").append(round).append(",\n");
      sb.append(next).append("\"inputNpcDir\": \"").append(escape(inputNpcDir)).append("\",\n");
      sb.append(next).append("\"outputNpcDir\": \"").append(escape(outputNpcDir)).append("\",\n");
      sb.append(next).append("\"beforeValidationPath\": \"").append(escape(beforeValidationPath)).append("\",\n");
      sb.append(next).append("\"afterValidationPath\": \"").append(escape(afterValidationPath)).append("\",\n");
      sb.append(next).append("\"classificationPath\": \"").append(escape(classificationPath)).append("\",\n");
      sb.append(next).append("\"autoFixReportPath\": \"").append(escape(autoFixReportPath)).append("\",\n");
      sb.append(next).append("\"preValidationStatus\": \"").append(escape(preValidationStatus)).append("\",\n");
      sb.append(next).append("\"postValidationStatus\": \"").append(escape(postValidationStatus)).append("\",\n");
      sb.append(next).append("\"classifiedFailureCount\": ").append(classifiedFailureCount).append(",\n");
      sb.append(next).append("\"fixedCount\": ").append(fixedCount).append(",\n");
      sb.append(next).append("\"skippedCount\": ").append(skippedCount).append(",\n");
      sb.append(next).append("\"commands\": ").append(toJsonStringArray(commands)).append(",\n");
      sb.append(next).append("\"exitCodes\": ").append(toJsonIntArray(exitCodes)).append(",\n");
      sb.append(next).append("\"commandOutputs\": ").append(toJsonStringArray(commandOutputs)).append("\n");
      sb.append(indent).append("}");
      return sb.toString();
    }
  }

  private static final class ProcessResult {
    String command;
    String output;
    int exitCode;
  }

  private static String toJsonStringArray(List<String> values) {
    StringBuilder sb = new StringBuilder();
    sb.append('[');
    for(int i = 0; i < values.size(); i++) {
      if(i > 0) {
        sb.append(", ");
      }
      sb.append('"').append(escape(values.get(i))).append('"');
    }
    sb.append(']');
    return sb.toString();
  }

  private static String toJsonIntArray(List<Integer> values) {
    StringBuilder sb = new StringBuilder();
    sb.append('[');
    for(int i = 0; i < values.size(); i++) {
      if(i > 0) {
        sb.append(", ");
      }
      sb.append(values.get(i).intValue());
    }
    sb.append(']');
    return sb.toString();
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
