package unluac.web.service;

import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.LinkedHashMap;
import java.util.Map;

import unluac.semantic.Phase7CNpcTextExporter;
import unluac.web.request.Phase7CRequest;
import unluac.web.result.PhaseResult;
import unluac.web.support.PhaseExceptionUtil;
import unluac.web.support.PhasePathUtil;
import unluac.web.support.PhaseSelfCheckUtil;

public final class Phase7CService {

  private static final String DEFAULT_JDBC = "jdbc:mysql://127.0.0.1:3306/ghost_game"
      + "?useUnicode=true&characterEncoding=utf8&serverTimezone=UTC&useSSL=false&allowPublicKeyRetrieval=true";

  public PhaseResult<Phase7CNpcTextExporter.ExportValidationReport> execute(Phase7CRequest request) {
    Path workDir = null;
    PhaseResult<Phase7CNpcTextExporter.ExportValidationReport> result = null;
    try {
      if(request == null) {
        throw new IllegalArgumentException("request is required");
      }
      workDir = PhasePathUtil.resolveWorkingDirectory(request == null ? null : request.workingDirectory);
      result = PhaseResult.start("Phase7C", workDir.toString());

      Path sourceNpcDir = PhasePathUtil.resolvePath(workDir, require(request.sourceNpcDir, "sourceNpcDir"));
      Path outputDir = PhasePathUtil.resolvePath(workDir,
          request.outputDir == null ? Paths.get("reports", "phase7C_exported_npc") : request.outputDir);
      Path reportOutput = PhasePathUtil.resolvePath(workDir,
          request.reportOutput == null ? Paths.get("reports", "phase7C_export_validation.json") : request.reportOutput);
      PhasePathUtil.ensureParent(reportOutput);

      String jdbcUrl = request.jdbcUrl == null ? DEFAULT_JDBC : request.jdbcUrl;
      String user = request.user == null ? "root" : request.user;
      String password = request.password == null ? "root" : request.password;

      Phase7CNpcTextExporter service = new Phase7CNpcTextExporter();
      Phase7CNpcTextExporter.ExportValidationReport payload = service.export(sourceNpcDir, outputDir, reportOutput, jdbcUrl, user, password);

      Map<String, Path> checks = new LinkedHashMap<String, Path>();
      checks.put("phase7CReportJson", reportOutput);
      PhaseSelfCheckUtil.verifyJsonArtifacts(checks);

      result.addArtifact("phase7COutputDir", outputDir.toString());
      result.addArtifact("phase7CReportJson", reportOutput.toString());
      return result.success(payload);
    } catch(Throwable ex) {
      if(result == null) {
        result = PhaseResult.start("Phase7C", workDir == null ? "" : workDir.toString());
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
