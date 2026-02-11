package unluac.web.controller;

import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.OffsetDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Collections;
import java.util.List;

import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.databind.ObjectMapper;

import unluac.web.request.AdminNpcTextSaveRequest;
import unluac.web.request.AdminQuestSaveRequest;
import unluac.web.result.AdminNpcTextItem;
import unluac.web.result.AdminQuestDetail;
import unluac.web.result.AdminQuestListItem;
import unluac.web.result.DashboardSummary;
import unluac.web.result.PhaseDExportReport;
import unluac.web.result.WebApiResponse;
import unluac.web.service.AdminNpcTextService;
import unluac.web.service.AdminQuestService;
import unluac.web.service.PhaseDOrchestrationService;
import unluac.web.support.WebApiExecutionLogger;
import unluac.web.support.WebApiReportWriter;
import unluac.web.support.WebJdbcSupport;

@RestController
@RequestMapping(path = "/api/admin", produces = MediaType.APPLICATION_JSON_VALUE)
public class AdminController {

  private static final String DEFAULT_JDBC = "jdbc:mysql://127.0.0.1:3306/ghost_game"
      + "?useUnicode=true&characterEncoding=utf8&serverTimezone=UTC&useSSL=false&allowPublicKeyRetrieval=true";

  private final ObjectMapper mapper = new ObjectMapper();
  private final AdminQuestService questService = new AdminQuestService();
  private final AdminNpcTextService npcTextService = new AdminNpcTextService();
  private final PhaseDOrchestrationService orchestrationService = new PhaseDOrchestrationService();

  @GetMapping(path = "/dashboard")
  public DashboardSummary dashboard() throws Exception {
    DashboardSummary out = new DashboardSummary();
    try(Connection connection = WebJdbcSupport.open(DEFAULT_JDBC, "root", "root")) {
      out.questCount = queryCount(connection, "SELECT COUNT(*) FROM quest_main");
      out.npcCount = queryCount(connection, "SELECT COUNT(DISTINCT npcFile) FROM npc_text_edit_map");
    }

    Path reportsDir = Paths.get("reports");
    if(java.nio.file.Files.exists(reportsDir)) {
      try(java.util.stream.Stream<Path> stream = java.nio.file.Files.list(reportsDir)) {
        stream.filter(p -> java.nio.file.Files.isRegularFile(p))
            .filter(p -> p.getFileName().toString().startsWith("web_phaseD_export_report_"))
            .sorted((a, b) -> Long.compare(b.toFile().lastModified(), a.toFile().lastModified()))
            .limit(5)
            .forEach(p -> out.recentExportReports.add(p.toString()));
      }
    }
    out.timeline.add("luc -> read -> DB -> web edit -> export");
    out.timeline.add("updatedAt=" + OffsetDateTime.now().format(DateTimeFormatter.ISO_OFFSET_DATE_TIME));
    return out;
  }

  @GetMapping(path = "/quests")
  public List<AdminQuestListItem> questList(@RequestParam(name = "keyword", required = false) String keyword,
                                            @RequestParam(name = "limit", required = false, defaultValue = "100") int limit) throws Exception {
    return questService.list(DEFAULT_JDBC, "root", "root", keyword, limit);
  }

  @GetMapping(path = "/quests/{questId}")
  public AdminQuestDetail questDetail(@PathVariable("questId") int questId) throws Exception {
    return questService.detail(DEFAULT_JDBC, "root", "root", questId);
  }

  @PostMapping(path = "/quests/{questId}/save", consumes = MediaType.APPLICATION_JSON_VALUE)
  public WebApiResponse saveQuest(@PathVariable("questId") int questId,
                                  @RequestBody AdminQuestSaveRequest request) {
    long started = System.currentTimeMillis();
    WebApiResponse response = new WebApiResponse();
    response.phaseName = "AdminQuestSave";
    try {
      int changed = questService.save(DEFAULT_JDBC, "root", "root", questId, request);
      response.status = "SUCCESS";
      response.elapsedMs = System.currentTimeMillis() - started;
      response.artifacts.put("changedRows", Integer.toString(changed));
      writeOpsArtifacts("/api/admin/quests/{questId}/save", request, response, started);
      return response;
    } catch(Throwable ex) {
      response.status = "FAILED";
      response.elapsedMs = System.currentTimeMillis() - started;
      response.error = unluac.web.result.WebApiError.fromThrowable(ex);
      writeOpsArtifactsQuietly("/api/admin/quests/{questId}/save", request, response, started);
      return response;
    }
  }

  @GetMapping(path = "/npc-texts")
  public List<AdminNpcTextItem> npcTextList(@RequestParam(name = "questId", required = false) Integer questId,
                                            @RequestParam(name = "npcFile", required = false) String npcFile,
                                            @RequestParam(name = "keyword", required = false) String keyword,
                                            @RequestParam(name = "limit", required = false, defaultValue = "200") int limit) throws Exception {
    return npcTextService.list(DEFAULT_JDBC, "root", "root", questId, npcFile, keyword, limit);
  }

  @PostMapping(path = "/npc-texts/{textId}/save", consumes = MediaType.APPLICATION_JSON_VALUE)
  public WebApiResponse saveNpcText(@PathVariable("textId") long textId,
                                    @RequestBody AdminNpcTextSaveRequest request) {
    long started = System.currentTimeMillis();
    WebApiResponse response = new WebApiResponse();
    response.phaseName = "AdminNpcTextSave";
    try {
      int changed = npcTextService.save(DEFAULT_JDBC, "root", "root", textId, request);
      response.status = "SUCCESS";
      response.elapsedMs = System.currentTimeMillis() - started;
      response.artifacts.put("changedRows", Integer.toString(changed));
      writeOpsArtifacts("/api/admin/npc-texts/{textId}/save", request, response, started);
      return response;
    } catch(Throwable ex) {
      response.status = "FAILED";
      response.elapsedMs = System.currentTimeMillis() - started;
      response.error = unluac.web.result.WebApiError.fromThrowable(ex);
      writeOpsArtifactsQuietly("/api/admin/npc-texts/{textId}/save", request, response, started);
      return response;
    }
  }

  @PostMapping(path = "/export/run")
  public PhaseDExportReport runExport() throws Exception {
    PhaseDOrchestrationService.NpcSample sample = orchestrationService.pickNpcSample(DEFAULT_JDBC, "root", "root");
    String beforeText = sample.modifiedText;
    String suffix = " [web-phaseD-" + DateTimeFormatter.ofPattern("yyyyMMddHHmmss").format(OffsetDateTime.now()) + "]";
    AdminNpcTextSaveRequest req = new AdminNpcTextSaveRequest();
    req.modifiedText = (beforeText == null ? sample.rawText : beforeText) + suffix;
    npcTextService.save(DEFAULT_JDBC, "root", "root", sample.textId, req);

    Path workDir = Paths.get(".").toAbsolutePath().normalize();
    Path phase4Out = workDir.resolve(Paths.get("reports", "phase4_exported_quest.lua"));
    Path phase5OutDir = workDir.resolve(Paths.get("reports", "phase5_exported_npc"));
    Path phase5Summary = workDir.resolve(Paths.get("reports", "phase5_export_summary.json"));

    PhaseDExportReport report = orchestrationService.exportAll(
        DEFAULT_JDBC,
        "root",
        "root",
        workDir,
        phase4Out,
        phase5OutDir,
        phase5Summary,
        sample.textId,
        beforeText);
    return report;
  }

  private int queryCount(Connection connection, String sql) throws Exception {
    try(PreparedStatement ps = connection.prepareStatement(sql);
        ResultSet rs = ps.executeQuery()) {
      if(rs.next()) {
        return rs.getInt(1);
      }
      return 0;
    }
  }

  private void writeOpsArtifacts(String endpoint, Object request, WebApiResponse response, long startedAt) throws Exception {
    long finishedAt = System.currentTimeMillis();
    java.nio.file.Path reportPath = WebApiReportWriter.write(endpoint, Collections.singletonList(response));
    String requestJson = mapper.writeValueAsString(request == null ? new Object() : request);
    String responseJson = mapper.writeValueAsString(response);
    java.nio.file.Path logPath = WebApiExecutionLogger.write(endpoint, requestJson, responseJson, startedAt, finishedAt);
    response.artifacts.put("webApiReport", reportPath.toString());
    response.artifacts.put("webApiLog", logPath.toString());
  }

  private void writeOpsArtifactsQuietly(String endpoint, Object request, WebApiResponse response, long startedAt) {
    try {
      writeOpsArtifacts(endpoint, request, response, startedAt);
    } catch(Throwable ignored) {
    }
  }
}

