package unluac.web.request;

import java.nio.file.Path;

public final class Phase6MutationImpactRequest extends BasePhaseRequest {
  public Path graphPath;
  public Path baselineDir;
  public Path afterDir;
  public Path reportPath;
}

