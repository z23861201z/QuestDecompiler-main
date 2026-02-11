package unluac.web.service;

import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.LinkedHashMap;
import java.util.Map;

import unluac.semantic.Phase5NpcExportValidator;
import unluac.web.request.Phase5ValidateRequest;
import unluac.web.result.PhaseResult;
import unluac.web.support.PhaseExceptionUtil;
import unluac.web.support.PhasePathUtil;
import unluac.web.support.PhaseSelfCheckUtil;

public final class Phase5ValidateService {

  public PhaseResult<Phase5NpcExportValidator.ValidationReport> execute(Phase5ValidateRequest request) {
    Path workDir = null;
    PhaseResult<Phase5NpcExportValidator.ValidationReport> result = null;
    try {
      if(request == null) {
        throw new IllegalArgumentException("request is required");
      }
      workDir = PhasePathUtil.resolveWorkingDirectory(request == null ? null : request.workingDirectory);
      result = PhaseResult.start("Phase5Validate", workDir.toString());

      Path originalDir = PhasePathUtil.resolvePath(workDir, require(request.originalDir, "originalDir"));
      Path exportedDir = PhasePathUtil.resolvePath(workDir,
          request.exportedDir == null ? Paths.get("reports", "phase5_exported_npc") : request.exportedDir);
      Path output = PhasePathUtil.resolvePath(workDir,
          request.output == null ? Paths.get("reports", "phase5_export_validation.json") : request.output);
      PhasePathUtil.ensureParent(output);

      Phase5NpcExportValidator service = new Phase5NpcExportValidator();
      Phase5NpcExportValidator.ValidationReport payload = service.validate(originalDir, exportedDir, output);

      Map<String, Path> checks = new LinkedHashMap<String, Path>();
      checks.put("phase5ValidationJson", output);
      PhaseSelfCheckUtil.verifyJsonArtifacts(checks);

      result.addArtifact("phase5ValidationJson", output.toString());
      return result.success(payload);
    } catch(Throwable ex) {
      if(result == null) {
        result = PhaseResult.start("Phase5Validate", workDir == null ? "" : workDir.toString());
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
