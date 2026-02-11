package unluac.web.result;

import java.util.LinkedHashMap;
import java.util.Map;

public final class WebApiResponse {

  public String phaseName;
  public String status;
  public long elapsedMs;
  public final Map<String, String> artifacts = new LinkedHashMap<String, String>();
  public WebApiError error;

  public static WebApiResponse fromPhaseResult(PhaseResult<?> result) {
    WebApiResponse out = new WebApiResponse();
    if(result == null) {
      out.phaseName = "";
      out.status = PhaseStatus.FAILED.name();
      out.elapsedMs = 0L;
      return out;
    }
    out.phaseName = safe(result.phaseName);
    out.status = result.status == null ? PhaseStatus.FAILED.name() : result.status.name();
    out.elapsedMs = result.elapsedMs;
    if(result.artifacts != null) {
      out.artifacts.putAll(result.artifacts);
    }
    out.error = WebApiError.fromPhaseError(result.error);
    return out;
  }

  public static WebApiResponse failure(String phaseName, Throwable ex) {
    WebApiResponse out = new WebApiResponse();
    out.phaseName = safe(phaseName);
    out.status = PhaseStatus.FAILED.name();
    out.elapsedMs = 0L;
    out.error = WebApiError.fromThrowable(ex);
    return out;
  }

  private static String safe(String value) {
    return value == null ? "" : value;
  }
}

