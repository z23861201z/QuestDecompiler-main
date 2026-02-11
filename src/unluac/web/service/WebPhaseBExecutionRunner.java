package unluac.web.service;

import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;

import unluac.web.request.Phase2Request;
import unluac.web.request.Phase3Request;
import unluac.web.request.Phase4Request;
import unluac.web.result.PhaseResult;
import unluac.web.result.PhaseStatus;
import unluac.web.support.ExecutionReportWriter;

public final class WebPhaseBExecutionRunner {

  public static void main(String[] args) throws Exception {
    Path questLuc = args.length >= 1 ? Paths.get(args[0]) : Paths.get("new.luc");
    Path npcDir = args.length >= 2 ? Paths.get(args[1]) : Paths.get("npc-lua-autofixed");
    String jdbcUrl = args.length >= 3
        ? args[2]
        : "jdbc:mysql://127.0.0.1:3306/ghost_game?useUnicode=true&characterEncoding=utf8&serverTimezone=UTC&useSSL=false&allowPublicKeyRetrieval=true";
    String user = args.length >= 4 ? args[3] : "root";
    String password = args.length >= 5 ? args[4] : "root";

    List<PhaseResult<?>> timeline = new ArrayList<PhaseResult<?>>();

    Phase2Service phase2Service = new Phase2Service();
    Phase2Request phase2Request = new Phase2Request();
    phase2Request.workingDirectory = Paths.get(".");
    phase2Request.questLuc = questLuc;
    phase2Request.npcDir = npcDir;
    PhaseResult<?> phase2 = phase2Service.execute(phase2Request);
    timeline.add(phase2);
    ensureSuccess(phase2);

    Phase25Service phase25Service = new Phase25Service();
    unluac.web.request.Phase25Request phase25Request = new unluac.web.request.Phase25Request();
    phase25Request.workingDirectory = Paths.get(".");
    PhaseResult<?> phase25 = phase25Service.execute(phase25Request);
    timeline.add(phase25);
    ensureSuccess(phase25);

    Phase3Service phase3Service = new Phase3Service();
    Phase3Request phase3Request = new Phase3Request();
    phase3Request.workingDirectory = Paths.get(".");
    phase3Request.jdbcUrl = jdbcUrl;
    phase3Request.user = user;
    phase3Request.password = password;
    PhaseResult<?> phase3 = phase3Service.execute(phase3Request);
    timeline.add(phase3);
    ensureSuccess(phase3);

    Phase4Service phase4Service = new Phase4Service();
    Phase4Request phase4Request = new Phase4Request();
    phase4Request.workingDirectory = Paths.get(".");
    phase4Request.jdbcUrl = jdbcUrl;
    phase4Request.user = user;
    phase4Request.password = password;
    PhaseResult<?> phase4 = phase4Service.execute(phase4Request);
    timeline.add(phase4);
    ensureSuccess(phase4);

    Path report = ExecutionReportWriter.write(timeline);
    System.out.println("webPhaseBReport=" + report.toAbsolutePath());
  }

  private static void ensureSuccess(PhaseResult<?> result) {
    if(result == null || result.status != PhaseStatus.SUCCESS) {
      throw new IllegalStateException("phase execution failed: " + (result == null ? "null" : result.phaseName));
    }
  }
}
