package unluac.web.service;

import java.nio.charset.Charset;
import java.nio.file.DirectoryStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.OffsetDateTime;
import java.time.format.DateTimeFormatter;

import unluac.semantic.QuestSemanticJson;
import unluac.web.request.Phase4Request;
import unluac.web.request.Phase5ExportRequest;
import unluac.web.result.PhaseDExportReport;
import unluac.web.result.WebApiResponse;
import unluac.web.support.WebApiValidator;
import unluac.web.support.WebJdbcSupport;

public final class PhaseDOrchestrationService {

  private static final Charset UTF8 = Charset.forName("UTF-8");

  private final Phase4Service phase4Service = new Phase4Service();
  private final Phase5ExportService phase5ExportService = new Phase5ExportService();

  public PhaseDExportReport exportAll(String jdbcUrl,
                                      String user,
                                      String password,
                                      Path workDir,
                                      Path phase4Output,
                                      Path phase5OutputDir,
                                      Path phase5SummaryOutput,
                                      long beforeTextId,
                                      String beforeModifiedText) throws Exception {
    long startedAt = System.currentTimeMillis();
    Path wd = workDir == null ? Paths.get(".").toAbsolutePath().normalize() : workDir.toAbsolutePath().normalize();
    Path phase4Out = phase4Output == null ? wd.resolve(Paths.get("reports", "phase4_exported_quest.lua")) : resolve(wd, phase4Output);
    Path phase5OutDir = phase5OutputDir == null ? wd.resolve(Paths.get("reports", "phase5_exported_npc")) : resolve(wd, phase5OutputDir);
    Path phase5Summary = phase5SummaryOutput == null ? wd.resolve(Paths.get("reports", "phase5_export_summary.json")) : resolve(wd, phase5SummaryOutput);

    long beforeQuestTs = Files.exists(phase4Out) ? Files.getLastModifiedTime(phase4Out).toMillis() : 0L;
    long beforeNpcTs = latestLuaTimestamp(phase5OutDir);

    Phase4Request phase4Request = new Phase4Request();
    phase4Request.workingDirectory = wd;
    phase4Request.jdbcUrl = jdbcUrl;
    phase4Request.user = user;
    phase4Request.password = password;
    phase4Request.output = phase4Out;
    WebApiResponse phase4Resp = WebApiResponse.fromPhaseResult(phase4Service.execute(phase4Request));
    WebApiValidator.validateSuccess(phase4Resp);
    WebApiValidator.validatePhase4Or5ExportArtifacts(phase4Resp);

    Phase5ExportRequest phase5Request = new Phase5ExportRequest();
    phase5Request.workingDirectory = wd;
    phase5Request.jdbcUrl = jdbcUrl;
    phase5Request.user = user;
    phase5Request.password = password;
    phase5Request.outputDir = phase5OutDir;
    phase5Request.summaryOutput = phase5Summary;
    WebApiResponse phase5Resp = WebApiResponse.fromPhaseResult(phase5ExportService.execute(phase5Request));
    WebApiValidator.validateSuccess(phase5Resp);
    WebApiValidator.validatePhase4Or5ExportArtifacts(phase5Resp);

    long afterQuestTs = Files.exists(phase4Out) ? Files.getLastModifiedTime(phase4Out).toMillis() : 0L;
    long afterNpcTs = latestLuaTimestamp(phase5OutDir);

    PhaseDExportReport report = new PhaseDExportReport();
    report.generatedAt = OffsetDateTime.now().format(DateTimeFormatter.ISO_OFFSET_DATE_TIME);
    report.elapsedMs = System.currentTimeMillis() - startedAt;
    report.questExportFileCount = Files.exists(phase4Out) ? 1 : 0;
    report.npcExportFileCount = countLuaFiles(phase5OutDir);
    report.dbChanged = checkDbChanged(jdbcUrl, user, password, beforeTextId, beforeModifiedText);
    report.exportTimestampChanged = afterQuestTs > beforeQuestTs || afterNpcTs > beforeNpcTs;
    report.finalStatus = report.dbChanged && report.exportTimestampChanged ? "SAFE" : "FAILED";
    report.note = "dbChanged=" + report.dbChanged + ", exportTimestampChanged=" + report.exportTimestampChanged;
    report.artifacts.put("phase4ExportLua", phase4Out.toString());
    report.artifacts.put("phase5OutputDir", phase5OutDir.toString());
    report.artifacts.put("phase5Summary", phase5Summary.toString());

    Path reportPath = writePhaseDReport(wd.resolve("reports"), report);
    report.artifacts.put("phaseDReport", reportPath.toString());
    return report;
  }

  private boolean checkDbChanged(String jdbcUrl,
                                 String user,
                                 String password,
                                 long textId,
                                 String beforeModifiedText) throws Exception {
    if(textId <= 0L) {
      return false;
    }
    try(Connection connection = WebJdbcSupport.open(jdbcUrl, user, password)) {
      String sql = "SELECT modifiedText FROM npc_text_edit_map WHERE textId=?";
      try(PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setLong(1, textId);
        try(ResultSet rs = ps.executeQuery()) {
          if(!rs.next()) {
            return false;
          }
          String current = rs.getString("modifiedText");
          if(beforeModifiedText == null) {
            return current != null;
          }
          return !beforeModifiedText.equals(current);
        }
      }
    }
  }

  private Path resolve(Path workDir, Path path) {
    if(path == null) {
      return null;
    }
    return path.isAbsolute() ? path.normalize() : workDir.resolve(path).normalize();
  }

  private int countLuaFiles(Path dir) throws Exception {
    if(dir == null || !Files.exists(dir)) {
      return 0;
    }
    int count = 0;
    try(java.util.stream.Stream<Path> stream = Files.walk(dir)) {
      java.util.Iterator<Path> it = stream.iterator();
      while(it.hasNext()) {
        Path p = it.next();
        if(Files.isRegularFile(p) && p.getFileName().toString().toLowerCase().endsWith(".lua")) {
          count++;
        }
      }
    }
    return count;
  }

  private long latestLuaTimestamp(Path dir) throws Exception {
    if(dir == null || !Files.exists(dir)) {
      return 0L;
    }
    long latest = 0L;
    try(java.util.stream.Stream<Path> stream = Files.walk(dir)) {
      java.util.Iterator<Path> it = stream.iterator();
      while(it.hasNext()) {
        Path p = it.next();
        if(Files.isRegularFile(p) && p.getFileName().toString().toLowerCase().endsWith(".lua")) {
          long ts = Files.getLastModifiedTime(p).toMillis();
          if(ts > latest) {
            latest = ts;
          }
        }
      }
    }
    return latest;
  }

  private Path writePhaseDReport(Path reportDir, PhaseDExportReport report) throws Exception {
    if(!Files.exists(reportDir)) {
      Files.createDirectories(reportDir);
    }
    String timestamp = DateTimeFormatter.ofPattern("yyyyMMdd_HHmmss_SSS").format(OffsetDateTime.now());
    Path out = reportDir.resolve("web_phaseD_export_report_" + timestamp + ".json");

    StringBuilder sb = new StringBuilder();
    sb.append("{\n");
    sb.append("  \"generatedAt\": ").append(QuestSemanticJson.jsonString(safe(report.generatedAt))).append(",\n");
    sb.append("  \"finalStatus\": ").append(QuestSemanticJson.jsonString(safe(report.finalStatus))).append(",\n");
    sb.append("  \"elapsedMs\": ").append(report.elapsedMs).append(",\n");
    sb.append("  \"questExportFileCount\": ").append(report.questExportFileCount).append(",\n");
    sb.append("  \"npcExportFileCount\": ").append(report.npcExportFileCount).append(",\n");
    sb.append("  \"dbChanged\": ").append(report.dbChanged).append(",\n");
    sb.append("  \"exportTimestampChanged\": ").append(report.exportTimestampChanged).append(",\n");
    sb.append("  \"note\": ").append(QuestSemanticJson.jsonString(safe(report.note))).append(",\n");
    sb.append("  \"artifacts\": {");
    int index = 0;
    for(java.util.Map.Entry<String, String> entry : report.artifacts.entrySet()) {
      if(index++ > 0) {
        sb.append(',');
      }
      sb.append(QuestSemanticJson.jsonString(entry.getKey())).append(':').append(QuestSemanticJson.jsonString(entry.getValue()));
    }
    sb.append("}\n");
    sb.append("}\n");
    Files.write(out, sb.toString().getBytes(UTF8));
    return out;
  }

  public NpcSample pickNpcSample(String jdbcUrl, String user, String password) throws Exception {
    try(Connection connection = WebJdbcSupport.open(jdbcUrl, user, password)) {
      String sql = "SELECT textId, npcFile, rawText, modifiedText FROM npc_text_edit_map ORDER BY textId ASC LIMIT 1";
      try(PreparedStatement ps = connection.prepareStatement(sql);
          ResultSet rs = ps.executeQuery()) {
        if(!rs.next()) {
          throw new IllegalStateException("npc_text_edit_map has no rows");
        }
        NpcSample sample = new NpcSample();
        sample.textId = rs.getLong("textId");
        sample.npcFile = rs.getString("npcFile");
        sample.rawText = rs.getString("rawText");
        sample.modifiedText = rs.getString("modifiedText");
        return sample;
      }
    }
  }

  public static final class NpcSample {
    public long textId;
    public String npcFile;
    public String rawText;
    public String modifiedText;
  }

  private String safe(String value) {
    return value == null ? "" : value;
  }
}
