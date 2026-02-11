package unluac.web.service;

import unluac.semantic.Phase4QuestLucExporter;
import unluac.web.request.Phase4Request;
import unluac.web.result.PhaseResult;

public final class Phase4Service {

  private final Phase4ExportService delegate = new Phase4ExportService();

  public PhaseResult<Phase4QuestLucExporter.ExportResult> execute(Phase4Request request) {
    return delegate.execute(request);
  }
}

