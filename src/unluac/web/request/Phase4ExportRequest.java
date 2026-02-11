package unluac.web.request;

import java.nio.file.Path;

public class Phase4ExportRequest extends BasePhaseRequest {
  public Path output;
  public String jdbcUrl;
  public String user;
  public String password;
}
