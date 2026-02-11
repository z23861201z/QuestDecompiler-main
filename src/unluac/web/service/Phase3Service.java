package unluac.web.service;

import unluac.semantic.Phase3DatabaseWriter;
import unluac.web.request.Phase3Request;
import unluac.web.result.PhaseResult;

public final class Phase3Service {

  private final Phase3WriteService delegate = new Phase3WriteService();

  public PhaseResult<Phase3DatabaseWriter.InsertSummary> execute(Phase3Request request) {
    return delegate.execute(request);
  }
}

