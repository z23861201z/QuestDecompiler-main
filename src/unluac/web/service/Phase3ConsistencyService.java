package unluac.web.service;

import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.LinkedHashMap;
import java.util.Map;

import unluac.semantic.Phase3DbConsistencyValidator;
import unluac.web.request.Phase3ConsistencyRequest;
import unluac.web.result.PhaseResult;
import unluac.web.support.PhaseExceptionUtil;
import unluac.web.support.PhasePathUtil;
import unluac.web.support.PhaseSelfCheckUtil;

public final class Phase3ConsistencyService {

  private static final String DEFAULT_JDBC = "jdbc:mysql://127.0.0.1:3306/ghost_game"
      + "?useUnicode=true&characterEncoding=utf8&serverTimezone=UTC&useSSL=false&allowPublicKeyRetrieval=true";

  public PhaseResult<Phase3DbConsistencyValidator.ValidationReport> execute(Phase3ConsistencyRequest request) {
    Path workDir = null;
    PhaseResult<Phase3DbConsistencyValidator.ValidationReport> result = null;
    try {
      if(request == null) {
        throw new IllegalArgumentException("request is required");
      }
      workDir = PhasePathUtil.resolveWorkingDirectory(request == null ? null : request.workingDirectory);
      result = PhaseResult.start("Phase3Consistency", workDir.toString());

      Path phase2QuestJson = PhasePathUtil.resolvePath(workDir,
          request.phase2QuestJson == null ? Paths.get("reports", "phase2_quest_data.json") : request.phase2QuestJson);
      Path output = PhasePathUtil.resolvePath(workDir,
          request.output == null ? Paths.get("reports", "phase3_db_roundtrip_validation.json") : request.output);
      PhasePathUtil.ensureParent(output);

      String jdbcUrl = request.jdbcUrl == null ? DEFAULT_JDBC : request.jdbcUrl;
      String user = request.user == null ? "root" : request.user;
      String password = request.password == null ? "root" : request.password;

      Phase3DbConsistencyValidator service = new Phase3DbConsistencyValidator();
      Phase3DbConsistencyValidator.ValidationReport payload = service.validate(phase2QuestJson, output, jdbcUrl, user, password);

      Map<String, Path> checks = new LinkedHashMap<String, Path>();
      checks.put("phase3ConsistencyJson", output);
      PhaseSelfCheckUtil.verifyJsonArtifacts(checks);

      result.addArtifact("phase3ConsistencyJson", output.toString());
      return result.success(payload);
    } catch(Throwable ex) {
      if(result == null) {
        result = PhaseResult.start("Phase3Consistency", workDir == null ? "" : workDir.toString());
      }
      return result.fail(PhaseExceptionUtil.toPhaseError(ex));
    }
  }
}
