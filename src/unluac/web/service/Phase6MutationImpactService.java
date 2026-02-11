package unluac.web.service;

import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.LinkedHashMap;
import java.util.Map;

import unluac.semantic.Phase6DbMutationAndImpactValidator;
import unluac.web.request.Phase6MutationImpactRequest;
import unluac.web.result.PhaseResult;
import unluac.web.support.PhaseExceptionUtil;
import unluac.web.support.PhasePathUtil;
import unluac.web.support.PhaseSelfCheckUtil;

public final class Phase6MutationImpactService {

  public PhaseResult<Phase6DbMutationAndImpactValidator.ValidationReport> execute(Phase6MutationImpactRequest request) {
    Path workDir = null;
    PhaseResult<Phase6DbMutationAndImpactValidator.ValidationReport> result = null;
    try {
      if(request == null) {
        throw new IllegalArgumentException("request is required");
      }
      workDir = PhasePathUtil.resolveWorkingDirectory(request == null ? null : request.workingDirectory);
      result = PhaseResult.start("Phase6MutationImpact", workDir.toString());

      Path graphPath = PhasePathUtil.resolvePath(workDir,
          request.graphPath == null ? Paths.get("reports", "phase2_5_quest_npc_dependency_graph.json") : request.graphPath);
      Path baselineDir = PhasePathUtil.resolvePath(workDir,
          request.baselineDir == null ? Paths.get("reports", "phase5_exported_npc") : request.baselineDir);
      Path afterDir = PhasePathUtil.resolvePath(workDir,
          request.afterDir == null ? Paths.get("reports", "phase6_export_after_mutation") : request.afterDir);
      Path reportPath = PhasePathUtil.resolvePath(workDir,
          request.reportPath == null ? Paths.get("reports", "phase6_mutation_validation.json") : request.reportPath);
      PhasePathUtil.ensureParent(reportPath);

      Phase6DbMutationAndImpactValidator service = new Phase6DbMutationAndImpactValidator();
      Phase6DbMutationAndImpactValidator.ValidationReport payload = service.run(graphPath, baselineDir, afterDir, reportPath);

      Map<String, Path> checks = new LinkedHashMap<String, Path>();
      checks.put("phase6ValidationJson", reportPath);
      PhaseSelfCheckUtil.verifyJsonArtifacts(checks);

      result.addArtifact("phase6AfterDir", afterDir.toString());
      result.addArtifact("phase6ValidationJson", reportPath.toString());
      return result.success(payload);
    } catch(Throwable ex) {
      if(result == null) {
        result = PhaseResult.start("Phase6MutationImpact", workDir == null ? "" : workDir.toString());
      }
      return result.fail(PhaseExceptionUtil.toPhaseError(ex));
    }
  }
}
