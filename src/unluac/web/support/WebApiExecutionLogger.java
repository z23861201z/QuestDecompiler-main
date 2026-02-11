package unluac.web.support;

import java.nio.charset.Charset;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.OffsetDateTime;
import java.time.format.DateTimeFormatter;

public final class WebApiExecutionLogger {

  private static final Charset UTF8 = Charset.forName("UTF-8");

  private WebApiExecutionLogger() {
  }

  public static Path write(String endpoint,
                           String requestJson,
                           String responseJson,
                           long startedAt,
                           long finishedAt) throws Exception {
    Path logDir = Paths.get("logs");
    if(!Files.exists(logDir)) {
      Files.createDirectories(logDir);
    }
    String timestamp = DateTimeFormatter.ofPattern("yyyyMMdd_HHmmss_SSS").format(OffsetDateTime.now());
    Path out = logDir.resolve("web_api_execution_" + timestamp + ".log");

    StringBuilder sb = new StringBuilder();
    sb.append("timestamp=").append(OffsetDateTime.now().format(DateTimeFormatter.ISO_OFFSET_DATE_TIME)).append('\n');
    sb.append("endpoint=").append(safe(endpoint)).append('\n');
    sb.append("startedAt=").append(startedAt).append('\n');
    sb.append("finishedAt=").append(finishedAt).append('\n');
    sb.append("elapsedMs=").append(Math.max(0L, finishedAt - startedAt)).append('\n');
    sb.append("request=").append(safe(requestJson)).append('\n');
    sb.append("response=").append(safe(responseJson)).append('\n');

    Files.write(out, sb.toString().getBytes(UTF8));
    return out;
  }

  private static String safe(String value) {
    return value == null ? "" : value;
  }
}

