package unluac.web.request;

import java.nio.file.Path;

public final class PipelineFullRequest extends BasePhaseRequest {
  public Path questLuc;
  public Path npcDir;
  public String jdbcUrl;
  public String user;
  public String password;
  public Path phase4QuestOutput;
  public Path phase5OutputDir;
  public Path phase5SummaryOutput;
}

