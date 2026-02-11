package unluac.web.service;

import java.nio.file.Path;
import java.nio.file.Paths;

import unluac.semantic.Phase4QuestLucExporter;
import unluac.web.request.Phase4ExportRequest;
import unluac.web.result.PhaseResult;
import unluac.web.support.PhaseExceptionUtil;
import unluac.web.support.PhasePathUtil;

public final class Phase4ExportService {

  private static final String DEFAULT_JDBC = "jdbc:mysql://127.0.0.1:3306/ghost_game"
      + "?useUnicode=true&characterEncoding=utf8&serverTimezone=UTC&useSSL=false&allowPublicKeyRetrieval=true";

  public PhaseResult<Phase4QuestLucExporter.ExportResult> execute(Phase4ExportRequest request) {
    Path workDir = null;
    PhaseResult<Phase4QuestLucExporter.ExportResult> result = null;
    try {
      if(request == null) {
        throw new IllegalArgumentException("request is required");
      }
      workDir = PhasePathUtil.resolveWorkingDirectory(request == null ? null : request.workingDirectory);
      result = PhaseResult.start("Phase4Export", workDir.toString());

      Path output = PhasePathUtil.resolvePath(workDir,
          request.output == null ? Paths.get("reports", "phase4_exported_quest.lua") : request.output);
      PhasePathUtil.ensureParent(output);

      String jdbcUrl = request.jdbcUrl == null ? DEFAULT_JDBC : request.jdbcUrl;
      String user = request.user == null ? "root" : request.user;
      String password = request.password == null ? "root" : request.password;

      Phase4QuestLucExporter service = new Phase4QuestLucExporter();
      Phase4QuestLucExporter.ExportResult payload = service.export(output, jdbcUrl, user, password);

      PhasePathUtil.verifyFileExistsAndNotEmpty(output, "phase4ExportLua");
      result.addArtifact("phase4ExportLua", output.toString());
      return result.success(payload);
    } catch(Throwable ex) {
      if(result == null) {
        result = PhaseResult.start("Phase4Export", workDir == null ? "" : workDir.toString());
      }
      return result.fail(PhaseExceptionUtil.toPhaseError(ex));
    }
  }
}
