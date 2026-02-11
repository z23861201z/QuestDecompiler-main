package unluac.web.service;

import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.LinkedHashMap;
import java.util.Map;

import unluac.semantic.Phase7ANpcTextExtractionSystem;
import unluac.web.request.Phase7ARequest;
import unluac.web.result.PhaseResult;
import unluac.web.support.PhaseExceptionUtil;
import unluac.web.support.PhasePathUtil;
import unluac.web.support.PhaseSelfCheckUtil;

public final class Phase7AService {

  private static final String DEFAULT_JDBC = "jdbc:mysql://127.0.0.1:3306/ghost_game"
      + "?useUnicode=true&characterEncoding=utf8&serverTimezone=UTC&useSSL=false&allowPublicKeyRetrieval=true";

  public PhaseResult<Phase7ANpcTextExtractionSystem.ExtractionReport> execute(Phase7ARequest request) {
    Path workDir = null;
    PhaseResult<Phase7ANpcTextExtractionSystem.ExtractionReport> result = null;
    try {
      if(request == null) {
        throw new IllegalArgumentException("request is required");
      }
      workDir = PhasePathUtil.resolveWorkingDirectory(request == null ? null : request.workingDirectory);
      result = PhaseResult.start("Phase7A", workDir.toString());

      Path npcDir = PhasePathUtil.resolvePath(workDir, require(request.npcDir, "npcDir"));
      Path reportOutput = PhasePathUtil.resolvePath(workDir,
          request.reportOutput == null ? Paths.get("reports", "phase7A_npc_text_extraction.json") : request.reportOutput);
      Path ddlOutput = PhasePathUtil.resolvePath(workDir,
          request.ddlOutput == null ? Paths.get("reports", "phase7A_npc_dialogue_text_ddl.sql") : request.ddlOutput);
      PhasePathUtil.ensureParent(reportOutput);
      PhasePathUtil.ensureParent(ddlOutput);

      String jdbcUrl = request.jdbcUrl == null ? DEFAULT_JDBC : request.jdbcUrl;
      String user = request.user == null ? "root" : request.user;
      String password = request.password == null ? "root" : request.password;

      Phase7ANpcTextExtractionSystem service = new Phase7ANpcTextExtractionSystem();
      Phase7ANpcTextExtractionSystem.ExtractionReport payload = service.scanAndStore(npcDir, reportOutput, ddlOutput, jdbcUrl, user, password);

      Map<String, Path> checks = new LinkedHashMap<String, Path>();
      checks.put("phase7AReportJson", reportOutput);
      PhaseSelfCheckUtil.verifyJsonArtifacts(checks);
      PhasePathUtil.verifyFileExistsAndNotEmpty(ddlOutput, "phase7ADdl");

      result.addArtifact("phase7AReportJson", reportOutput.toString());
      result.addArtifact("phase7ADdlSql", ddlOutput.toString());
      return result.success(payload);
    } catch(Throwable ex) {
      if(result == null) {
        result = PhaseResult.start("Phase7A", workDir == null ? "" : workDir.toString());
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
