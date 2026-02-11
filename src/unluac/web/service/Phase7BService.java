package unluac.web.service;

import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.LinkedHashMap;
import java.util.Map;

import unluac.semantic.Phase7BNpcTextModelBuilder;
import unluac.web.request.Phase7BRequest;
import unluac.web.result.PhaseResult;
import unluac.web.support.PhaseExceptionUtil;
import unluac.web.support.PhasePathUtil;
import unluac.web.support.PhaseSelfCheckUtil;

public final class Phase7BService {

  private static final String DEFAULT_JDBC = "jdbc:mysql://127.0.0.1:3306/ghost_game"
      + "?useUnicode=true&characterEncoding=utf8&serverTimezone=UTC&useSSL=false&allowPublicKeyRetrieval=true";

  public PhaseResult<Phase7BNpcTextModelBuilder.Result> execute(Phase7BRequest request) {
    Path workDir = null;
    PhaseResult<Phase7BNpcTextModelBuilder.Result> result = null;
    try {
      if(request == null) {
        throw new IllegalArgumentException("request is required");
      }
      workDir = PhasePathUtil.resolveWorkingDirectory(request == null ? null : request.workingDirectory);
      result = PhaseResult.start("Phase7B", workDir.toString());

      Path phase7AReport = PhasePathUtil.resolvePath(workDir,
          request.phase7AReport == null ? Paths.get("reports", "phase7A_npc_text_extraction.json") : request.phase7AReport);
      Path ddlOutput = PhasePathUtil.resolvePath(workDir,
          request.ddlOutput == null ? Paths.get("reports", "phase7B_npc_text_model_ddl.sql") : request.ddlOutput);
      Path docOutput = PhasePathUtil.resolvePath(workDir,
          request.docOutput == null ? Paths.get("docs", "phase7B_npc_text_model_summary.md") : request.docOutput);

      PhasePathUtil.ensureParent(ddlOutput);
      PhasePathUtil.ensureParent(docOutput);

      String jdbcUrl = request.jdbcUrl == null ? DEFAULT_JDBC : request.jdbcUrl;
      String user = request.user == null ? "root" : request.user;
      String password = request.password == null ? "root" : request.password;

      Phase7BNpcTextModelBuilder service = new Phase7BNpcTextModelBuilder();
      Phase7BNpcTextModelBuilder.Result payload = service.build(phase7AReport, ddlOutput, docOutput, jdbcUrl, user, password);

      Map<String, Path> checks = new LinkedHashMap<String, Path>();
      checks.put("phase7AReportJson", phase7AReport);
      PhaseSelfCheckUtil.verifyJsonArtifacts(checks);
      PhasePathUtil.verifyFileExistsAndNotEmpty(ddlOutput, "phase7BDdl");
      PhasePathUtil.verifyFileExistsAndNotEmpty(docOutput, "phase7BDoc");

      result.addArtifact("phase7BDdlSql", ddlOutput.toString());
      result.addArtifact("phase7BDocMd", docOutput.toString());
      return result.success(payload);
    } catch(Throwable ex) {
      if(result == null) {
        result = PhaseResult.start("Phase7B", workDir == null ? "" : workDir.toString());
      }
      return result.fail(PhaseExceptionUtil.toPhaseError(ex));
    }
  }
}
