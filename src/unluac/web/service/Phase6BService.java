package unluac.web.service;

import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.LinkedHashMap;
import java.util.Map;

import unluac.semantic.Phase6BForcedHighReferenceMutationValidator;
import unluac.web.request.Phase6BRequest;
import unluac.web.result.PhaseResult;
import unluac.web.support.PhaseExceptionUtil;
import unluac.web.support.PhasePathUtil;
import unluac.web.support.PhaseSelfCheckUtil;

public final class Phase6BService {

  public PhaseResult<Phase6BForcedHighReferenceMutationValidator.ValidationReport> execute(Phase6BRequest request) {
    Path workDir = null;
    PhaseResult<Phase6BForcedHighReferenceMutationValidator.ValidationReport> result = null;
    try {
      if(request == null) {
        throw new IllegalArgumentException("request is required");
      }
      workDir = PhasePathUtil.resolveWorkingDirectory(request == null ? null : request.workingDirectory);
      result = PhaseResult.start("Phase6B", workDir.toString());

      Path graphPath = PhasePathUtil.resolvePath(workDir,
          request.graphPath == null ? Paths.get("reports", "phase2_5_quest_npc_dependency_graph.json") : request.graphPath);
      Path baselineDir = PhasePathUtil.resolvePath(workDir,
          request.baselineDir == null ? Paths.get("reports", "phase5_exported_npc") : request.baselineDir);
      Path afterDir = PhasePathUtil.resolvePath(workDir,
          request.afterDir == null ? Paths.get("reports", "phase6B_export_after_mutation") : request.afterDir);
      Path reportPath = PhasePathUtil.resolvePath(workDir,
          request.reportPath == null ? Paths.get("reports", "phase6B_mutation_validation.json") : request.reportPath);
      PhasePathUtil.ensureParent(reportPath);

      Phase6BForcedHighReferenceMutationValidator service = new Phase6BForcedHighReferenceMutationValidator();
      Phase6BForcedHighReferenceMutationValidator.ValidationReport payload = service.run(graphPath, baselineDir, afterDir, reportPath);

      Map<String, Path> checks = new LinkedHashMap<String, Path>();
      checks.put("phase6BValidationJson", reportPath);
      PhaseSelfCheckUtil.verifyJsonArtifacts(checks);

      result.addArtifact("phase6BAfterDir", afterDir.toString());
      result.addArtifact("phase6BValidationJson", reportPath.toString());
      return result.success(payload);
    } catch(Throwable ex) {
      if(result == null) {
        result = PhaseResult.start("Phase6B", workDir == null ? "" : workDir.toString());
      }
      return result.fail(PhaseExceptionUtil.toPhaseError(ex));
    }
  }
}
