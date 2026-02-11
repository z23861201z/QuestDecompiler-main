package unluac.web.support;

import java.nio.charset.Charset;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.Map;

public final class PhaseSelfCheckUtil {

  private static final Charset UTF8 = Charset.forName("UTF-8");

  private PhaseSelfCheckUtil() {
  }

  public static void verifyJsonOutput(Path jsonPath, String label) throws Exception {
    PhasePathUtil.verifyFileExistsAndNotEmpty(jsonPath, label);
  }

  public static void verifyJsonArtifacts(Map<String, Path> jsonArtifacts) throws Exception {
    if(jsonArtifacts == null) {
      return;
    }
    for(Map.Entry<String, Path> entry : jsonArtifacts.entrySet()) {
      String label = entry.getKey();
      Path path = entry.getValue();
      verifyJsonOutput(path, label);
      verifySummaryFinalStatusSafe(path, label);
    }
  }

  public static void verifySummaryFinalStatusSafe(Path summaryJsonPath, String label) throws Exception {
    if(summaryJsonPath == null) {
      return;
    }
    verifyJsonOutput(summaryJsonPath, label);
    String text = new String(Files.readAllBytes(summaryJsonPath), UTF8);
    String compact = text.replaceAll("\\s+", "");
    if(compact.contains("\"finalStatus\"")) {
      if(!compact.contains("\"finalStatus\":\"SAFE\"")) {
        throw new IllegalStateException(label + " finalStatus is not SAFE: " + summaryJsonPath);
      }
    }
  }
}
