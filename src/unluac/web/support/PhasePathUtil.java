package unluac.web.support;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

public final class PhasePathUtil {

  private PhasePathUtil() {
  }

  public static Path resolveWorkingDirectory(Path workingDirectory) throws Exception {
    Path out = workingDirectory == null ? Paths.get(".") : workingDirectory;
    if(!out.isAbsolute()) {
      out = Paths.get(".").toAbsolutePath().normalize().resolve(out).normalize();
    }
    if(!Files.exists(out)) {
      Files.createDirectories(out);
    }
    return out;
  }

  public static Path resolvePath(Path workingDirectory, Path candidate) {
    if(candidate == null) {
      return null;
    }
    if(candidate.isAbsolute()) {
      return candidate.normalize();
    }
    return workingDirectory.resolve(candidate).normalize();
  }

  public static void ensureParent(Path filePath) throws Exception {
    if(filePath == null) {
      return;
    }
    Path parent = filePath.getParent();
    if(parent != null && !Files.exists(parent)) {
      Files.createDirectories(parent);
    }
  }

  public static void verifyFileExistsAndNotEmpty(Path filePath, String label) throws Exception {
    if(filePath == null) {
      throw new IllegalStateException(label + " path is null");
    }
    if(!Files.exists(filePath) || !Files.isRegularFile(filePath)) {
      throw new IllegalStateException(label + " file not found: " + filePath);
    }
    if(Files.size(filePath) <= 0L) {
      throw new IllegalStateException(label + " file is empty: " + filePath);
    }
  }
}

