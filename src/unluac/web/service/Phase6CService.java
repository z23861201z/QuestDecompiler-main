package unluac.web.service;

import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.LinkedHashMap;
import java.util.Map;

import unluac.semantic.Phase6CDbDrivenExportValidator;
import unluac.web.request.Phase6CRequest;
import unluac.web.result.PhaseResult;
import unluac.web.support.PhaseExceptionUtil;
import unluac.web.support.PhasePathUtil;
import unluac.web.support.PhaseSelfCheckUtil;

public final class Phase6CService {

  public PhaseResult<Phase6CDbDrivenExportValidator.ValidationReport> execute(Phase6CRequest request) {
    Path workDir = null;
    PhaseResult<Phase6CDbDrivenExportValidator.ValidationReport> result = null;
    try {
      if(request == null) {
        throw new IllegalArgumentException("request is required");
      }
      workDir = PhasePathUtil.resolveWorkingDirectory(request == null ? null : request.workingDirectory);
      result = PhaseResult.start("Phase6C", workDir.toString());

      Path phase2NpcIndex = PhasePathUtil.resolvePath(workDir,
          request.phase2NpcIndex == null ? Paths.get("reports", "phase2_npc_reference_index.json") : request.phase2NpcIndex);
      Path baselineNpcDir = PhasePathUtil.resolvePath(workDir,
          request.baselineNpcDir == null ? Paths.get("reports", "phase5_exported_npc") : request.baselineNpcDir);
      Path outputNpcDir = PhasePathUtil.resolvePath(workDir,
          request.outputNpcDir == null ? Paths.get("reports", "phase6C_db_driven_export") : request.outputNpcDir);
      Path reportPath = PhasePathUtil.resolvePath(workDir,
          request.reportPath == null ? Paths.get("reports", "phase6C_db_driven_validation.json") : request.reportPath);
      PhasePathUtil.ensureParent(reportPath);

      Phase6CDbDrivenExportValidator service = new Phase6CDbDrivenExportValidator();
      Phase6CDbDrivenExportValidator.ValidationReport payload = service.run(phase2NpcIndex, baselineNpcDir, outputNpcDir, reportPath);

      Map<String, Path> checks = new LinkedHashMap<String, Path>();
      checks.put("phase6CValidationJson", reportPath);
      PhaseSelfCheckUtil.verifyJsonArtifacts(checks);

      result.addArtifact("phase6COutputNpcDir", outputNpcDir.toString());
      result.addArtifact("phase6CValidationJson", reportPath.toString());
      return result.success(payload);
    } catch(Throwable ex) {
      if(result == null) {
        result = PhaseResult.start("Phase6C", workDir == null ? "" : workDir.toString());
      }
      return result.fail(PhaseExceptionUtil.toPhaseError(ex));
    }
  }
}
