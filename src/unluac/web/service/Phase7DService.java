package unluac.web.service;

import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.LinkedHashMap;
import java.util.Map;

import unluac.semantic.Phase7DTextImpactValidator;
import unluac.web.request.Phase7DRequest;
import unluac.web.result.PhaseResult;
import unluac.web.support.PhaseExceptionUtil;
import unluac.web.support.PhasePathUtil;
import unluac.web.support.PhaseSelfCheckUtil;

public final class Phase7DService {

  private static final String DEFAULT_JDBC = "jdbc:mysql://127.0.0.1:3306/ghost_game"
      + "?useUnicode=true&characterEncoding=utf8&serverTimezone=UTC&useSSL=false&allowPublicKeyRetrieval=true";

  public PhaseResult<Phase7DTextImpactValidator.ValidationReport> execute(Phase7DRequest request) {
    Path workDir = null;
    PhaseResult<Phase7DTextImpactValidator.ValidationReport> result = null;
    try {
      if(request == null) {
        throw new IllegalArgumentException("request is required");
      }
      workDir = PhasePathUtil.resolveWorkingDirectory(request == null ? null : request.workingDirectory);
      result = PhaseResult.start("Phase7D", workDir.toString());

      Path sourceNpcDir = PhasePathUtil.resolvePath(workDir, require(request.sourceNpcDir, "sourceNpcDir"));
      Path exportedNpcDir = PhasePathUtil.resolvePath(workDir,
          request.exportedNpcDir == null ? Paths.get("reports", "phase7C_exported_npc") : request.exportedNpcDir);
      Path reportOutput = PhasePathUtil.resolvePath(workDir,
          request.reportOutput == null ? Paths.get("reports", "phase7D_text_mutation_validation.json") : request.reportOutput);
      PhasePathUtil.ensureParent(reportOutput);

      String jdbcUrl = request.jdbcUrl == null ? DEFAULT_JDBC : request.jdbcUrl;
      String user = request.user == null ? "root" : request.user;
      String password = request.password == null ? "root" : request.password;

      Phase7DTextImpactValidator service = new Phase7DTextImpactValidator();
      Phase7DTextImpactValidator.ValidationReport payload = service.validate(sourceNpcDir, exportedNpcDir, reportOutput, jdbcUrl, user, password);

      Map<String, Path> checks = new LinkedHashMap<String, Path>();
      checks.put("phase7DReportJson", reportOutput);
      PhaseSelfCheckUtil.verifyJsonArtifacts(checks);

      result.addArtifact("phase7DReportJson", reportOutput.toString());
      return result.success(payload);
    } catch(Throwable ex) {
      if(result == null) {
        result = PhaseResult.start("Phase7D", workDir == null ? "" : workDir.toString());
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
