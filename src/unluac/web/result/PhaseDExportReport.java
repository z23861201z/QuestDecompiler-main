package unluac.web.result;

import java.util.LinkedHashMap;
import java.util.Map;

public final class PhaseDExportReport {
  public String generatedAt;
  public String finalStatus;
  public long elapsedMs;
  public int questExportFileCount;
  public int npcExportFileCount;
  public boolean dbChanged;
  public boolean exportTimestampChanged;
  public final Map<String, String> artifacts = new LinkedHashMap<String, String>();
  public String note;
}

