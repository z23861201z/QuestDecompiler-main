package unluac.web.result;

import java.util.LinkedHashMap;
import java.util.Map;

public final class PhaseResult<T> {

  public String phaseName;
  public PhaseStatus status;
  public long startedAt;
  public long finishedAt;
  public long elapsedMs;
  public String workingDirectory;
  public final Map<String, String> artifacts = new LinkedHashMap<String, String>();
  public T payload;
  public PhaseError error;

  public static <T> PhaseResult<T> start(String phaseName, String workingDirectory) {
    PhaseResult<T> out = new PhaseResult<T>();
    out.phaseName = phaseName;
    out.workingDirectory = workingDirectory;
    out.startedAt = System.currentTimeMillis();
    return out;
  }

  public PhaseResult<T> addArtifact(String key, String value) {
    if(key != null && value != null) {
      artifacts.put(key, value);
    }
    return this;
  }

  public PhaseResult<T> success(T payload) {
    this.payload = payload;
    this.status = PhaseStatus.SUCCESS;
    this.finishedAt = System.currentTimeMillis();
    this.elapsedMs = this.finishedAt - this.startedAt;
    return this;
  }

  public PhaseResult<T> fail(PhaseError error) {
    this.error = error;
    this.status = PhaseStatus.FAILED;
    this.finishedAt = System.currentTimeMillis();
    this.elapsedMs = this.finishedAt - this.startedAt;
    return this;
  }
}

