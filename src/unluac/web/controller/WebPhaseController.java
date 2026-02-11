package unluac.web.controller;

import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.databind.ObjectMapper;

import unluac.web.request.Phase25Request;
import unluac.web.request.Phase2Request;
import unluac.web.request.Phase3Request;
import unluac.web.request.Phase4Request;
import unluac.web.request.Phase5ExportRequest;
import unluac.web.request.PipelineFullRequest;
import unluac.web.result.PhaseResult;
import unluac.web.result.WebApiResponse;
import unluac.web.service.Phase25Service;
import unluac.web.service.Phase2Service;
import unluac.web.service.Phase3Service;
import unluac.web.service.Phase4Service;
import unluac.web.service.Phase5ExportService;
import unluac.web.support.WebApiExecutionLogger;
import unluac.web.support.WebApiReportWriter;
import unluac.web.support.WebApiValidator;

@RestController
@RequestMapping(path = "/api", produces = MediaType.APPLICATION_JSON_VALUE)
public class WebPhaseController {

  private static final String DEFAULT_JDBC = "jdbc:mysql://127.0.0.1:3306/ghost_game"
      + "?useUnicode=true&characterEncoding=utf8&serverTimezone=UTC&useSSL=false&allowPublicKeyRetrieval=true";

  private final ObjectMapper mapper = new ObjectMapper();

  private final Phase2Service phase2Service = new Phase2Service();
  private final Phase25Service phase25Service = new Phase25Service();
  private final Phase3Service phase3Service = new Phase3Service();
  private final Phase4Service phase4Service = new Phase4Service();
  private final Phase5ExportService phase5ExportService = new Phase5ExportService();

  @PostMapping(path = "/phase2/run", consumes = MediaType.APPLICATION_JSON_VALUE)
  public WebApiResponse runPhase2(@RequestBody(required = false) Phase2Request request) {
    long startedAt = System.currentTimeMillis();
    WebApiResponse response;
    try {
      Phase2Request req = normalizePhase2(request);
      PhaseResult<?> result = phase2Service.execute(req);
      response = WebApiResponse.fromPhaseResult(result);
      WebApiValidator.validateSuccess(response);
      writeApiArtifacts("/api/phase2/run", req, response, startedAt);
      return response;
    } catch(Throwable ex) {
      response = WebApiResponse.failure("Phase2", ex);
      writeApiArtifactsQuietly("/api/phase2/run", request, response, startedAt);
      return response;
    }
  }

  @PostMapping(path = "/phase3/run", consumes = MediaType.APPLICATION_JSON_VALUE)
  public WebApiResponse runPhase3(@RequestBody(required = false) Phase3Request request) {
    long startedAt = System.currentTimeMillis();
    WebApiResponse response;
    try {
      ensurePhase25();

      Phase3Request req = normalizePhase3(request);
      PhaseResult<?> result = phase3Service.execute(req);
      response = WebApiResponse.fromPhaseResult(result);
      WebApiValidator.validateSuccess(response);
      writeApiArtifacts("/api/phase3/run", req, response, startedAt);
      return response;
    } catch(Throwable ex) {
      response = WebApiResponse.failure("Phase3Write", ex);
      writeApiArtifactsQuietly("/api/phase3/run", request, response, startedAt);
      return response;
    }
  }

  @PostMapping(path = "/phase4/exportQuest", consumes = MediaType.APPLICATION_JSON_VALUE)
  public WebApiResponse exportQuest(@RequestBody(required = false) Phase4Request request) {
    long startedAt = System.currentTimeMillis();
    WebApiResponse response;
    try {
      Phase4Request req = normalizePhase4(request);
      PhaseResult<?> result = phase4Service.execute(req);
      response = WebApiResponse.fromPhaseResult(result);
      WebApiValidator.validateSuccess(response);
      WebApiValidator.validatePhase4Or5ExportArtifacts(response);
      writeApiArtifacts("/api/phase4/exportQuest", req, response, startedAt);
      return response;
    } catch(Throwable ex) {
      response = WebApiResponse.failure("Phase4Export", ex);
      writeApiArtifactsQuietly("/api/phase4/exportQuest", request, response, startedAt);
      return response;
    }
  }

  @PostMapping(path = "/phase5/exportNpc", consumes = MediaType.APPLICATION_JSON_VALUE)
  public WebApiResponse exportNpc(@RequestBody(required = false) Phase5ExportRequest request) {
    long startedAt = System.currentTimeMillis();
    WebApiResponse response;
    try {
      Phase5ExportRequest req = normalizePhase5(request);
      PhaseResult<?> result = phase5ExportService.execute(req);
      response = WebApiResponse.fromPhaseResult(result);
      WebApiValidator.validateSuccess(response);
      WebApiValidator.validatePhase4Or5ExportArtifacts(response);
      writeApiArtifacts("/api/phase5/exportNpc", req, response, startedAt);
      return response;
    } catch(Throwable ex) {
      response = WebApiResponse.failure("Phase5Export", ex);
      writeApiArtifactsQuietly("/api/phase5/exportNpc", request, response, startedAt);
      return response;
    }
  }

  @PostMapping(path = "/pipeline/full", consumes = MediaType.APPLICATION_JSON_VALUE)
  public List<WebApiResponse> runFullPipeline(@RequestBody(required = false) PipelineFullRequest request) {
    long startedAt = System.currentTimeMillis();
    List<WebApiResponse> responses = new ArrayList<WebApiResponse>();
    try {
      PipelineFullRequest req = normalizePipeline(request);

      Phase2Request phase2Req = new Phase2Request();
      phase2Req.workingDirectory = req.workingDirectory;
      phase2Req.questLuc = req.questLuc;
      phase2Req.npcDir = req.npcDir;
      WebApiResponse phase2Resp = WebApiResponse.fromPhaseResult(phase2Service.execute(phase2Req));
      WebApiValidator.validateSuccess(phase2Resp);
      responses.add(phase2Resp);

      Phase25Request phase25Req = new Phase25Request();
      phase25Req.workingDirectory = req.workingDirectory;
      WebApiResponse phase25Resp = WebApiResponse.fromPhaseResult(phase25Service.execute(phase25Req));
      WebApiValidator.validateSuccess(phase25Resp);
      responses.add(phase25Resp);

      Phase3Request phase3Req = new Phase3Request();
      phase3Req.workingDirectory = req.workingDirectory;
      phase3Req.jdbcUrl = req.jdbcUrl;
      phase3Req.user = req.user;
      phase3Req.password = req.password;
      WebApiResponse phase3Resp = WebApiResponse.fromPhaseResult(phase3Service.execute(phase3Req));
      WebApiValidator.validateSuccess(phase3Resp);
      responses.add(phase3Resp);

      Phase4Request phase4Req = new Phase4Request();
      phase4Req.workingDirectory = req.workingDirectory;
      phase4Req.jdbcUrl = req.jdbcUrl;
      phase4Req.user = req.user;
      phase4Req.password = req.password;
      phase4Req.output = req.phase4QuestOutput;
      WebApiResponse phase4Resp = WebApiResponse.fromPhaseResult(phase4Service.execute(phase4Req));
      WebApiValidator.validateSuccess(phase4Resp);
      WebApiValidator.validatePhase4Or5ExportArtifacts(phase4Resp);
      responses.add(phase4Resp);

      Phase5ExportRequest phase5Req = new Phase5ExportRequest();
      phase5Req.workingDirectory = req.workingDirectory;
      phase5Req.jdbcUrl = req.jdbcUrl;
      phase5Req.user = req.user;
      phase5Req.password = req.password;
      phase5Req.outputDir = req.phase5OutputDir;
      phase5Req.summaryOutput = req.phase5SummaryOutput;
      WebApiResponse phase5Resp = WebApiResponse.fromPhaseResult(phase5ExportService.execute(phase5Req));
      WebApiValidator.validateSuccess(phase5Resp);
      WebApiValidator.validatePhase4Or5ExportArtifacts(phase5Resp);
      responses.add(phase5Resp);

      writeApiArtifacts("/api/pipeline/full", req, responses, startedAt);
      return responses;
    } catch(Throwable ex) {
      responses.add(WebApiResponse.failure("pipeline/full", ex));
      writeApiArtifactsQuietly("/api/pipeline/full", request, responses, startedAt);
      return responses;
    }
  }

  private void ensurePhase25() {
    Phase25Request req = new Phase25Request();
    req.workingDirectory = Paths.get(".");
    PhaseResult<?> result = phase25Service.execute(req);
    WebApiResponse response = WebApiResponse.fromPhaseResult(result);
    WebApiValidator.validateSuccess(response);
  }

  private Phase2Request normalizePhase2(Phase2Request request) {
    Phase2Request req = request == null ? new Phase2Request() : request;
    if(req.workingDirectory == null) {
      req.workingDirectory = Paths.get(".");
    }
    if(req.questLuc == null) {
      req.questLuc = Paths.get("new.luc");
    }
    if(req.npcDir == null) {
      req.npcDir = Paths.get("npc-lua-autofixed");
    }
    return req;
  }

  private Phase3Request normalizePhase3(Phase3Request request) {
    Phase3Request req = request == null ? new Phase3Request() : request;
    if(req.workingDirectory == null) {
      req.workingDirectory = Paths.get(".");
    }
    if(req.jdbcUrl == null || req.jdbcUrl.trim().isEmpty()) {
      req.jdbcUrl = DEFAULT_JDBC;
    }
    if(req.user == null || req.user.trim().isEmpty()) {
      req.user = "root";
    }
    if(req.password == null) {
      req.password = "root";
    }
    return req;
  }

  private Phase4Request normalizePhase4(Phase4Request request) {
    Phase4Request req = request == null ? new Phase4Request() : request;
    if(req.workingDirectory == null) {
      req.workingDirectory = Paths.get(".");
    }
    if(req.jdbcUrl == null || req.jdbcUrl.trim().isEmpty()) {
      req.jdbcUrl = DEFAULT_JDBC;
    }
    if(req.user == null || req.user.trim().isEmpty()) {
      req.user = "root";
    }
    if(req.password == null) {
      req.password = "root";
    }
    return req;
  }

  private Phase5ExportRequest normalizePhase5(Phase5ExportRequest request) {
    Phase5ExportRequest req = request == null ? new Phase5ExportRequest() : request;
    if(req.workingDirectory == null) {
      req.workingDirectory = Paths.get(".");
    }
    if(req.jdbcUrl == null || req.jdbcUrl.trim().isEmpty()) {
      req.jdbcUrl = DEFAULT_JDBC;
    }
    if(req.user == null || req.user.trim().isEmpty()) {
      req.user = "root";
    }
    if(req.password == null) {
      req.password = "root";
    }
    return req;
  }

  private PipelineFullRequest normalizePipeline(PipelineFullRequest request) {
    PipelineFullRequest req = request == null ? new PipelineFullRequest() : request;
    if(req.workingDirectory == null) {
      req.workingDirectory = Paths.get(".");
    }
    if(req.questLuc == null) {
      req.questLuc = Paths.get("new.luc");
    }
    if(req.npcDir == null) {
      req.npcDir = Paths.get("npc-lua-autofixed");
    }
    if(req.jdbcUrl == null || req.jdbcUrl.trim().isEmpty()) {
      req.jdbcUrl = DEFAULT_JDBC;
    }
    if(req.user == null || req.user.trim().isEmpty()) {
      req.user = "root";
    }
    if(req.password == null) {
      req.password = "root";
    }
    if(req.phase4QuestOutput == null) {
      req.phase4QuestOutput = Paths.get("reports", "phase4_exported_quest.lua");
    }
    if(req.phase5OutputDir == null) {
      req.phase5OutputDir = Paths.get("reports", "phase5_exported_npc");
    }
    if(req.phase5SummaryOutput == null) {
      req.phase5SummaryOutput = Paths.get("reports", "phase5_export_summary.json");
    }
    return req;
  }

  private void writeApiArtifacts(String endpoint,
                                 Object request,
                                 WebApiResponse response,
                                 long startedAt) throws Exception {
    writeApiArtifacts(endpoint, request, Collections.singletonList(response), startedAt);
  }

  private void writeApiArtifacts(String endpoint,
                                 Object request,
                                 List<WebApiResponse> responses,
                                 long startedAt) throws Exception {
    long finishedAt = System.currentTimeMillis();
    Path reportPath = WebApiReportWriter.write(endpoint, responses);
    String requestJson = mapper.writeValueAsString(request == null ? new Object() : request);
    String responseJson = mapper.writeValueAsString(responses);
    Path logPath = WebApiExecutionLogger.write(endpoint, requestJson, responseJson, startedAt, finishedAt);

    for(WebApiResponse response : responses) {
      if(response != null) {
        response.artifacts.put("webApiReport", reportPath.toString());
        response.artifacts.put("webApiLog", logPath.toString());
      }
    }
  }

  private void writeApiArtifactsQuietly(String endpoint,
                                        Object request,
                                        WebApiResponse response,
                                        long startedAt) {
    try {
      writeApiArtifacts(endpoint, request, response, startedAt);
    } catch(Throwable ignored) {
    }
  }

  private void writeApiArtifactsQuietly(String endpoint,
                                        Object request,
                                        List<WebApiResponse> responses,
                                        long startedAt) {
    try {
      writeApiArtifacts(endpoint, request, responses, startedAt);
    } catch(Throwable ignored) {
    }
  }
}

