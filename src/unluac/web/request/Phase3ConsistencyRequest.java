package unluac.web.request;

import java.nio.file.Path;

public final class Phase3ConsistencyRequest extends BasePhaseRequest {
  public Path phase2QuestJson;
  public Path output;
  public String jdbcUrl;
  public String user;
  public String password;
}

