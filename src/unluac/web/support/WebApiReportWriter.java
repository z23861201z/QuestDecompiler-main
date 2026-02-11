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
import unluac.web.result.WebApiError;
import unluac.web.result.WebApiResponse;

public final class WebApiReportWriter {

  private static final Charset UTF8 = Charset.forName("UTF-8");

  private WebApiReportWriter() {
  }

  public static Path write(String endpoint, List<WebApiResponse> responses) throws Exception {
    if(responses == null) {
      responses = new ArrayList<WebApiResponse>();
    }
    Path reportDir = Paths.get("reports");
    if(!Files.exists(reportDir)) {
      Files.createDirectories(reportDir);
    }
    String timestamp = DateTimeFormatter.ofPattern("yyyyMMdd_HHmmss_SSS").format(OffsetDateTime.now());
    Path out = reportDir.resolve("web_phaseC_api_report_" + timestamp + ".json");

    StringBuilder sb = new StringBuilder();
    sb.append("{\n");
    sb.append("  \"generatedAt\": ").append(QuestSemanticJson.jsonString(OffsetDateTime.now().format(DateTimeFormatter.ISO_OFFSET_DATE_TIME))).append(",\n");
    sb.append("  \"endpoint\": ").append(QuestSemanticJson.jsonString(safe(endpoint))).append(",\n");
    sb.append("  \"finalStatus\": ").append(QuestSemanticJson.jsonString(resolveFinalStatus(responses))).append(",\n");
    sb.append("  \"resultCount\": ").append(responses.size()).append(",\n");
    sb.append("  \"results\": [\n");
    for(int i = 0; i < responses.size(); i++) {
      if(i > 0) {
        sb.append(",\n");
      }
      appendResponse(sb, responses.get(i));
    }
    sb.append("\n  ]\n");
    sb.append("}\n");

    Files.write(out, sb.toString().getBytes(UTF8));
    return out;
  }

  private static String resolveFinalStatus(List<WebApiResponse> responses) {
    if(responses == null || responses.isEmpty()) {
      return "FAILED";
    }
    for(WebApiResponse response : responses) {
      if(response == null || response.status == null || !"SUCCESS".equalsIgnoreCase(response.status)) {
        return "FAILED";
      }
    }
    return "SAFE";
  }

  private static void appendResponse(StringBuilder sb, WebApiResponse response) {
    sb.append("    {\n");
    sb.append("      \"phaseName\": ").append(QuestSemanticJson.jsonString(safe(response == null ? null : response.phaseName))).append(",\n");
    sb.append("      \"status\": ").append(QuestSemanticJson.jsonString(safe(response == null ? null : response.status))).append(",\n");
    sb.append("      \"elapsedMs\": ").append(response == null ? 0L : response.elapsedMs).append(",\n");
    sb.append("      \"artifacts\": ").append(toArtifactsJson(response == null ? null : response.artifacts)).append(",\n");
    sb.append("      \"error\": ").append(toErrorJson(response == null ? null : response.error)).append("\n");
    sb.append("    }");
  }

  private static String toArtifactsJson(Map<String, String> artifacts) {
    if(artifacts == null || artifacts.isEmpty()) {
      return "{}";
    }
    StringBuilder sb = new StringBuilder();
    sb.append("{");
    int index = 0;
    for(Map.Entry<String, String> entry : artifacts.entrySet()) {
      if(index++ > 0) {
        sb.append(',');
      }
      sb.append(QuestSemanticJson.jsonString(safe(entry.getKey()))).append(':');
      sb.append(QuestSemanticJson.jsonString(safe(entry.getValue())));
    }
    sb.append("}");
    return sb.toString();
  }

  private static String toErrorJson(WebApiError error) {
    if(error == null) {
      return "null";
    }
    StringBuilder sb = new StringBuilder();
    sb.append("{");
    sb.append("\"exceptionType\":").append(QuestSemanticJson.jsonString(safe(error.exceptionType))).append(',');
    sb.append("\"message\":").append(QuestSemanticJson.jsonString(safe(error.message)));
    sb.append("}");
    return sb.toString();
  }

  private static String safe(String value) {
    return value == null ? "" : value;
  }
}
