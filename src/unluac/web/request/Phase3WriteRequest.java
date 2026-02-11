package unluac.web.request;

import java.nio.file.Path;

public class Phase3WriteRequest extends BasePhaseRequest {
  public Path phase2QuestJson;
  public Path phase25GraphJson;
  public Path summaryOutput;
  public String jdbcUrl;
  public String user;
  public String password;
}
