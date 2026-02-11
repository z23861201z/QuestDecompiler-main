package unluac.web.service;

import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.LinkedHashMap;
import java.util.Map;

import unluac.semantic.Phase4QuestExportValidator;
import unluac.web.request.Phase4ValidateRequest;
import unluac.web.result.PhaseResult;
import unluac.web.support.PhaseExceptionUtil;
import unluac.web.support.PhasePathUtil;
import unluac.web.support.PhaseSelfCheckUtil;

public final class Phase4ValidateService {

  public PhaseResult<Phase4QuestExportValidator.ValidationResult> execute(Phase4ValidateRequest request) {
    Path workDir = null;
    PhaseResult<Phase4QuestExportValidator.ValidationResult> result = null;
    try {
      if(request == null) {
        throw new IllegalArgumentException("request is required");
      }
      workDir = PhasePathUtil.resolveWorkingDirectory(request == null ? null : request.workingDirectory);
      result = PhaseResult.start("Phase4Validate", workDir.toString());

      Path originalQuestLuc = PhasePathUtil.resolvePath(workDir, require(request.originalQuestLuc, "originalQuestLuc"));
      Path exportedQuestLua = PhasePathUtil.resolvePath(workDir,
          request.exportedQuestLua == null ? Paths.get("reports", "phase4_exported_quest.lua") : request.exportedQuestLua);
      Path output = PhasePathUtil.resolvePath(workDir,
          request.output == null ? Paths.get("reports", "phase4_export_validation.json") : request.output);
      PhasePathUtil.ensureParent(output);

      Phase4QuestExportValidator service = new Phase4QuestExportValidator();
      Phase4QuestExportValidator.ValidationResult payload = service.validate(originalQuestLuc, exportedQuestLua, output);

      Map<String, Path> checks = new LinkedHashMap<String, Path>();
      checks.put("phase4ValidationJson", output);
      PhaseSelfCheckUtil.verifyJsonArtifacts(checks);

      result.addArtifact("phase4ValidationJson", output.toString());
      return result.success(payload);
    } catch(Throwable ex) {
      if(result == null) {
        result = PhaseResult.start("Phase4Validate", workDir == null ? "" : workDir.toString());
      }
      return result.fail(PhaseExceptionUtil.toPhaseError(ex));
    }
  }

  private Path require(Path value, String name) {
    if(value == null) {
      throw new IllegalArgumentException(name + " is required");
    }
    return value;
  }
}
