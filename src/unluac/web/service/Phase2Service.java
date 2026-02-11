package unluac.web.service;

import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.LinkedHashMap;
import java.util.Map;

import unluac.semantic.Phase2LucDataExtractionSystem;
import unluac.web.request.Phase2Request;
import unluac.web.result.PhaseResult;
import unluac.web.support.PhaseExceptionUtil;
import unluac.web.support.PhasePathUtil;
import unluac.web.support.PhaseSelfCheckUtil;

public final class Phase2Service {

  public PhaseResult<Phase2LucDataExtractionSystem.Phase2Result> execute(Phase2Request request) {
    Path workDir = null;
    PhaseResult<Phase2LucDataExtractionSystem.Phase2Result> result = null;
    try {
      if(request == null) {
        throw new IllegalArgumentException("request is required");
      }
      workDir = PhasePathUtil.resolveWorkingDirectory(request == null ? null : request.workingDirectory);
      result = PhaseResult.start("Phase2", workDir.toString());

      Path questLuc = PhasePathUtil.resolvePath(workDir, require(request.questLuc, "questLuc"));
      Path npcDir = PhasePathUtil.resolvePath(workDir, require(request.npcDir, "npcDir"));

      Path questOut = PhasePathUtil.resolvePath(workDir,
          request.questOut == null ? Paths.get("reports", "phase2_quest_data.json") : request.questOut);
      Path npcOut = PhasePathUtil.resolvePath(workDir,
          request.npcOut == null ? Paths.get("reports", "phase2_npc_reference_index.json") : request.npcOut);
      Path summaryOut = PhasePathUtil.resolvePath(workDir,
          request.summaryOut == null ? Paths.get("reports", "phase2_scan_summary.json") : request.summaryOut);

      PhasePathUtil.ensureParent(questOut);
      PhasePathUtil.ensureParent(npcOut);
      PhasePathUtil.ensureParent(summaryOut);

      Phase2LucDataExtractionSystem service = new Phase2LucDataExtractionSystem();
      Phase2LucDataExtractionSystem.Phase2Result payload = service.run(questLuc, npcDir, questOut, npcOut, summaryOut);

      Map<String, Path> checks = new LinkedHashMap<String, Path>();
      checks.put("phase2QuestJson", questOut);
      checks.put("phase2NpcIndexJson", npcOut);
      checks.put("phase2SummaryJson", summaryOut);
      PhaseSelfCheckUtil.verifyJsonArtifacts(checks);

      result.addArtifact("phase2QuestJson", questOut.toString());
      result.addArtifact("phase2NpcIndexJson", npcOut.toString());
      result.addArtifact("phase2SummaryJson", summaryOut.toString());
      return result.success(payload);
    } catch(Throwable ex) {
      if(result == null) {
        result = PhaseResult.start("Phase2", workDir == null ? "" : workDir.toString());
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
