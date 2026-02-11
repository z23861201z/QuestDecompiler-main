package unluac.web.service;

import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.LinkedHashMap;
import java.util.Map;

import unluac.semantic.Phase3DatabaseWriter;
import unluac.web.request.Phase3WriteRequest;
import unluac.web.result.PhaseResult;
import unluac.web.support.PhaseExceptionUtil;
import unluac.web.support.PhasePathUtil;
import unluac.web.support.PhaseSelfCheckUtil;

public final class Phase3WriteService {

  private static final String DEFAULT_JDBC = "jdbc:mysql://127.0.0.1:3306/ghost_game"
      + "?useUnicode=true&characterEncoding=utf8&serverTimezone=UTC&useSSL=false&allowPublicKeyRetrieval=true";

  public PhaseResult<Phase3DatabaseWriter.InsertSummary> execute(Phase3WriteRequest request) {
    Path workDir = null;
    PhaseResult<Phase3DatabaseWriter.InsertSummary> result = null;
    try {
      if(request == null) {
        throw new IllegalArgumentException("request is required");
      }
      workDir = PhasePathUtil.resolveWorkingDirectory(request == null ? null : request.workingDirectory);
      result = PhaseResult.start("Phase3Write", workDir.toString());

      Path phase2QuestJson = PhasePathUtil.resolvePath(workDir,
          request.phase2QuestJson == null ? Paths.get("reports", "phase2_quest_data.json") : request.phase2QuestJson);
      Path phase25GraphJson = PhasePathUtil.resolvePath(workDir,
          request.phase25GraphJson == null ? Paths.get("reports", "phase2_5_quest_npc_dependency_graph.json") : request.phase25GraphJson);
      Path summaryOutput = PhasePathUtil.resolvePath(workDir,
          request.summaryOutput == null ? Paths.get("reports", "phase3_db_insert_summary.json") : request.summaryOutput);

      PhasePathUtil.ensureParent(summaryOutput);

      String jdbcUrl = request.jdbcUrl == null ? DEFAULT_JDBC : request.jdbcUrl;
      String user = request.user == null ? "root" : request.user;
      String password = request.password == null ? "root" : request.password;

      Phase3DatabaseWriter service = new Phase3DatabaseWriter();
      Phase3DatabaseWriter.InsertSummary payload = service.write(phase2QuestJson, phase25GraphJson, summaryOutput, jdbcUrl, user, password);

      Map<String, Path> checks = new LinkedHashMap<String, Path>();
      checks.put("phase3InsertSummaryJson", summaryOutput);
      PhaseSelfCheckUtil.verifyJsonArtifacts(checks);

      result.addArtifact("phase3InsertSummaryJson", summaryOutput.toString());
      return result.success(payload);
    } catch(Throwable ex) {
      if(result == null) {
        result = PhaseResult.start("Phase3Write", workDir == null ? "" : workDir.toString());
      }
      return result.fail(PhaseExceptionUtil.toPhaseError(ex));
    }
  }
}
