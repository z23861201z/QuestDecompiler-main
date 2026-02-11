package unluac.web.request;

import java.nio.file.Path;

public final class Phase7DRequest extends BasePhaseRequest {
  public Path sourceNpcDir;
  public Path exportedNpcDir;
  public Path reportOutput;
  public String jdbcUrl;
  public String user;
  public String password;
}

