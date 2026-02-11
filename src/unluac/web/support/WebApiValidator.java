package unluac.web.support;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Map;

import unluac.web.result.WebApiResponse;

public final class WebApiValidator {

  private WebApiValidator() {
  }

  public static void validateSuccess(WebApiResponse response) {
    if(response == null) {
      throw new IllegalStateException("response is null");
    }
    if(!"SUCCESS".equalsIgnoreCase(response.status)) {
      throw new IllegalStateException("status is not SUCCESS: " + response.status);
    }
  }

  public static void validatePhase4Or5ExportArtifacts(WebApiResponse response) {
    if(response == null) {
      return;
    }
    Map<String, String> artifacts = response.artifacts;
    if(artifacts == null || artifacts.isEmpty()) {
      return;
    }
    if("Phase4Export".equals(response.phaseName)) {
      String value = artifacts.get("phase4ExportLua");
      if(value == null) {
        throw new IllegalStateException("Phase4 artifact phase4ExportLua missing");
      }
      assertPathExists(value, "Phase4 export file");
      return;
    }
    if("Phase5Export".equals(response.phaseName)) {
      String dir = artifacts.get("phase5OutputDir");
      if(dir == null) {
        throw new IllegalStateException("Phase5 artifact phase5OutputDir missing");
      }
      Path base = Paths.get(dir);
      if(!Files.exists(base) || !Files.isDirectory(base)) {
        throw new IllegalStateException("Phase5 export directory missing: " + base.toAbsolutePath());
      }
      if(!containsLua(base)) {
        throw new IllegalStateException("Phase5 export directory has no .lua files: " + base.toAbsolutePath());
      }
    }
  }

  private static void assertPathExists(String path, String label) {
    Path p = Paths.get(path);
    if(!Files.exists(p)) {
      throw new IllegalStateException(label + " missing: " + p.toAbsolutePath());
    }
  }

  private static boolean containsLua(Path dir) {
    try(java.util.stream.Stream<Path> stream = Files.walk(dir)) {
      return stream.anyMatch(p -> Files.isRegularFile(p) && p.getFileName().toString().toLowerCase().endsWith(".lua"));
    } catch(Exception ex) {
      throw new IllegalStateException("failed to inspect directory: " + dir.toAbsolutePath(), ex);
    }
  }
}

