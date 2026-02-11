package unluac.web.request;

import java.nio.file.Path;

public final class Phase5ExportRequest extends BasePhaseRequest {
  public Path phase2NpcIndex;
  public Path outputDir;
  public Path summaryOutput;
  public String jdbcUrl;
  public String user;
  public String password;
}

