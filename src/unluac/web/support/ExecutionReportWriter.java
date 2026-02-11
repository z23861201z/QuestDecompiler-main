package unluac.web.support;

import java.nio.charset.Charset;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.OffsetDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import unluac.semantic.QuestSemanticJson;
import unluac.web.result.PhaseError;
import unluac.web.result.PhaseResult;

public final class ExecutionReportWriter {

  private static final Charset UTF8 = Charset.forName("UTF-8");

  private ExecutionReportWriter() {
  }

  public static Path write(List<PhaseResult<?>> results) throws Exception {
    if(results == null) {
      results = new ArrayList<PhaseResult<?>>();
    }
    Path reportDir = Paths.get("reports");
    if(!Files.exists(reportDir)) {
      Files.createDirectories(reportDir);
    }
    String timestamp = DateTimeFormatter.ofPattern("yyyyMMdd_HHmmss").format(OffsetDateTime.now());
    Path out = reportDir.resolve("web_phaseB_execution_report_" + timestamp + ".json");
    String json = toJson(results);
    Files.write(out, json.getBytes(UTF8));
    return out;
  }

  private static String toJson(List<PhaseResult<?>> results) {
    StringBuilder sb = new StringBuilder();
    sb.append("{\n");
    sb.append("  \"generatedAt\": ").append(QuestSemanticJson.jsonString(OffsetDateTime.now().format(DateTimeFormatter.ISO_OFFSET_DATE_TIME))).append(",\n");
    sb.append("  \"phaseCount\": ").append(results.size()).append(",\n");
    sb.append("  \"phases\": [\n");
    for(int i = 0; i < results.size(); i++) {
      if(i > 0) {
        sb.append(",\n");
      }
      appendPhase(sb, results.get(i));
    }
    sb.append("\n  ]\n");
    sb.append("}\n");
    return sb.toString();
  }

  private static void appendPhase(StringBuilder sb, PhaseResult<?> result) {
    sb.append("    {\n");
    sb.append("      \"phaseName\": ").append(QuestSemanticJson.jsonString(safe(result == null ? null : result.phaseName))).append(",\n");
    sb.append("      \"status\": ").append(QuestSemanticJson.jsonString(result == null || result.status == null ? "" : result.status.name())).append(",\n");
    sb.append("      \"startedAt\": ").append(result == null ? 0L : result.startedAt).append(",\n");
    sb.append("      \"finishedAt\": ").append(result == null ? 0L : result.finishedAt).append(",\n");
    sb.append("      \"elapsedMs\": ").append(result == null ? 0L : result.elapsedMs).append(",\n");
    sb.append("      \"workingDirectory\": ").append(QuestSemanticJson.jsonString(safe(result == null ? null : result.workingDirectory))).append(",\n");
    sb.append("      \"artifacts\": ").append(toArtifactsJson(result)).append(",\n");
    sb.append("      \"error\": ").append(toErrorJson(result == null ? null : result.error)).append("\n");
    sb.append("    }");
  }

  private static String toArtifactsJson(PhaseResult<?> result) {
    if(result == null || result.artifacts == null || result.artifacts.isEmpty()) {
      return "{}";
    }
    StringBuilder sb = new StringBuilder();
    sb.append("{");
    int index = 0;
    for(Map.Entry<String, String> entry : result.artifacts.entrySet()) {
      if(index++ > 0) {
        sb.append(",");
      }
      sb.append("\"").append(escape(entry.getKey())).append("\":");
      sb.append(QuestSemanticJson.jsonString(safe(entry.getValue())));
    }
    sb.append("}");
    return sb.toString();
  }

  private static String toErrorJson(PhaseError error) {
    if(error == null) {
      return "null";
    }
    StringBuilder sb = new StringBuilder();
    sb.append("{");
    sb.append("\"exceptionType\":").append(QuestSemanticJson.jsonString(safe(error.exceptionType))).append(",");
    sb.append("\"message\":").append(QuestSemanticJson.jsonString(safe(error.message))).append(",");
    sb.append("\"stackTrace\":").append(QuestSemanticJson.jsonString(safe(error.stackTrace)));
    sb.append("}");
    return sb.toString();
  }

  private static String safe(String value) {
    return value == null ? "" : value;
  }

  private static String escape(String value) {
    if(value == null) {
      return "";
    }
    return value.replace("\\", "\\\\").replace("\"", "\\\"");
  }
}

