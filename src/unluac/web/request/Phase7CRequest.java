package unluac.web.request;

import java.nio.file.Path;

public final class Phase7CRequest extends BasePhaseRequest {
  public Path sourceNpcDir;
  public Path outputDir;
  public Path reportOutput;
  public String jdbcUrl;
  public String user;
  public String password;
}

