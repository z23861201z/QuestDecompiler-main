package unluac.web.service;

import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.LinkedHashMap;
import java.util.Map;

import unluac.semantic.Phase25QuestNpcDependencyMapper;
import unluac.web.request.Phase25Request;
import unluac.web.result.PhaseResult;
import unluac.web.support.PhaseExceptionUtil;
import unluac.web.support.PhasePathUtil;
import unluac.web.support.PhaseSelfCheckUtil;

public final class Phase25Service {

  public PhaseResult<Phase25QuestNpcDependencyMapper.BuildResult> execute(Phase25Request request) {
    Path workDir = null;
    PhaseResult<Phase25QuestNpcDependencyMapper.BuildResult> result = null;
    try {
      if(request == null) {
        throw new IllegalArgumentException("request is required");
      }
      workDir = PhasePathUtil.resolveWorkingDirectory(request == null ? null : request.workingDirectory);
      result = PhaseResult.start("Phase2.5", workDir.toString());

      Path questInput = PhasePathUtil.resolvePath(workDir,
          request.questInput == null ? Paths.get("reports", "phase2_quest_data.json") : request.questInput);
      Path npcInput = PhasePathUtil.resolvePath(workDir,
          request.npcInput == null ? Paths.get("reports", "phase2_npc_reference_index.json") : request.npcInput);
      Path graphOutput = PhasePathUtil.resolvePath(workDir,
          request.graphOutput == null ? Paths.get("reports", "phase2_5_quest_npc_dependency_graph.json") : request.graphOutput);
      Path summaryOutput = PhasePathUtil.resolvePath(workDir,
          request.summaryOutput == null ? Paths.get("reports", "phase2_5_dependency_summary.json") : request.summaryOutput);

      PhasePathUtil.ensureParent(graphOutput);
      PhasePathUtil.ensureParent(summaryOutput);

      Phase25QuestNpcDependencyMapper service = new Phase25QuestNpcDependencyMapper();
      Phase25QuestNpcDependencyMapper.BuildResult payload = service.build(questInput, npcInput, graphOutput, summaryOutput);

      Map<String, Path> checks = new LinkedHashMap<String, Path>();
      checks.put("phase25GraphJson", graphOutput);
      checks.put("phase25SummaryJson", summaryOutput);
      PhaseSelfCheckUtil.verifyJsonArtifacts(checks);

      result.addArtifact("phase25GraphJson", graphOutput.toString());
      result.addArtifact("phase25SummaryJson", summaryOutput.toString());
      return result.success(payload);
    } catch(Throwable ex) {
      if(result == null) {
        result = PhaseResult.start("Phase2.5", workDir == null ? "" : workDir.toString());
      }
      return result.fail(PhaseExceptionUtil.toPhaseError(ex));
    }
  }
}
