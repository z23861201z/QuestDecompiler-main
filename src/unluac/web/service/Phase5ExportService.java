package unluac.web.service;

import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.LinkedHashMap;
import java.util.Map;

import unluac.semantic.Phase5NpcLucExporter;
import unluac.web.request.Phase5ExportRequest;
import unluac.web.result.PhaseResult;
import unluac.web.support.PhaseExceptionUtil;
import unluac.web.support.PhasePathUtil;
import unluac.web.support.PhaseSelfCheckUtil;

public final class Phase5ExportService {

  private static final String DEFAULT_JDBC = "jdbc:mysql://127.0.0.1:3306/ghost_game"
      + "?useUnicode=true&characterEncoding=utf8&serverTimezone=UTC&useSSL=false&allowPublicKeyRetrieval=true";

  public PhaseResult<Phase5NpcLucExporter.ExportSummary> execute(Phase5ExportRequest request) {
    Path workDir = null;
    PhaseResult<Phase5NpcLucExporter.ExportSummary> result = null;
    try {
      if(request == null) {
        throw new IllegalArgumentException("request is required");
      }
      workDir = PhasePathUtil.resolveWorkingDirectory(request == null ? null : request.workingDirectory);
      result = PhaseResult.start("Phase5Export", workDir.toString());

      Path phase2NpcIndex = PhasePathUtil.resolvePath(workDir,
          request.phase2NpcIndex == null ? Paths.get("reports", "phase2_npc_reference_index.json") : request.phase2NpcIndex);
      Path outputDir = PhasePathUtil.resolvePath(workDir,
          request.outputDir == null ? Paths.get("reports", "phase5_exported_npc") : request.outputDir);
      Path summaryOutput = PhasePathUtil.resolvePath(workDir,
          request.summaryOutput == null ? Paths.get("reports", "phase5_export_summary.json") : request.summaryOutput);
      PhasePathUtil.ensureParent(summaryOutput);

      String jdbcUrl = request.jdbcUrl == null ? DEFAULT_JDBC : request.jdbcUrl;
      String user = request.user == null ? "root" : request.user;
      String password = request.password == null ? "root" : request.password;

      Phase5NpcLucExporter service = new Phase5NpcLucExporter();
      Phase5NpcLucExporter.ExportSummary payload = service.export(phase2NpcIndex, outputDir, summaryOutput, jdbcUrl, user, password);

      Map<String, Path> checks = new LinkedHashMap<String, Path>();
      checks.put("phase5ExportSummaryJson", summaryOutput);
      PhaseSelfCheckUtil.verifyJsonArtifacts(checks);

      result.addArtifact("phase5OutputDir", outputDir.toString());
      result.addArtifact("phase5ExportSummaryJson", summaryOutput.toString());
      return result.success(payload);
    } catch(Throwable ex) {
      if(result == null) {
        result = PhaseResult.start("Phase5Export", workDir == null ? "" : workDir.toString());
      }
      return result.fail(PhaseExceptionUtil.toPhaseError(ex));
    }
  }
}
