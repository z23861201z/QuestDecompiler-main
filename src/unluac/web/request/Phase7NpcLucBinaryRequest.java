package unluac.web.request;

import java.nio.file.Path;

public final class Phase7NpcLucBinaryRequest extends BasePhaseRequest {
  public String npcFileName;
  public Path inputLuc;
  public Path outputLuc;
  public String jdbcUrl;
  public String user;
  public String password;
  public String stringCharset;
}

