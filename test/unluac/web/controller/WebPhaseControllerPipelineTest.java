package unluac.web.controller;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Comparator;
import java.util.Optional;
import java.util.stream.Stream;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;

@SpringBootTest
@AutoConfigureMockMvc
public class WebPhaseControllerPipelineTest {

  @Autowired
  private MockMvc mockMvc;

  @Test
  public void pipelineFullGeneratesApiReportAndLog() throws Exception {
    Path reportsDir = Paths.get("reports");
    Path logsDir = Paths.get("logs");

    Path beforeReport = latestFile(reportsDir, "web_phaseC_api_report_", ".json");
    Path beforeLog = latestFile(logsDir, "web_api_execution_", ".log");

    mockMvc.perform(post("/api/pipeline/full")
            .contentType(MediaType.APPLICATION_JSON)
            .content("{}"))
        .andExpect(status().isOk())
        .andExpect(jsonPath("$[0].status").value("SUCCESS"));

    Path afterReport = latestFile(reportsDir, "web_phaseC_api_report_", ".json");
    Path afterLog = latestFile(logsDir, "web_api_execution_", ".log");

    if(afterReport == null) {
      throw new IllegalStateException("web_phaseC_api_report was not generated");
    }
    if(afterLog == null) {
      throw new IllegalStateException("web_api_execution log was not generated");
    }
    if(beforeReport != null && beforeReport.equals(afterReport)) {
      throw new IllegalStateException("no new api report generated");
    }
    if(beforeLog != null && beforeLog.equals(afterLog)) {
      throw new IllegalStateException("no new api log generated");
    }

    String reportJson = new String(Files.readAllBytes(afterReport), "UTF-8");
    if(!reportJson.contains("\"finalStatus\": \"SAFE\"") && !reportJson.contains("\"finalStatus\":\"SAFE\"")) {
      throw new IllegalStateException("api report finalStatus is not SAFE: " + afterReport.toAbsolutePath());
    }

    String responseText = new String(Files.readAllBytes(afterReport), "UTF-8");
    if(!responseText.contains("\"Phase4Export\"")) {
      throw new IllegalStateException("api report missing Phase4Export");
    }
    if(!responseText.contains("\"Phase5Export\"")) {
      throw new IllegalStateException("api report missing Phase5Export");
    }

    Path phase4Lua = Paths.get("reports", "phase4_exported_quest.lua");
    if(!Files.exists(phase4Lua) || Files.size(phase4Lua) <= 0L) {
      throw new IllegalStateException("phase4 exported quest lua missing: " + phase4Lua.toAbsolutePath());
    }

    Path phase5Dir = Paths.get("reports", "phase5_exported_npc");
    if(!Files.exists(phase5Dir) || !Files.isDirectory(phase5Dir)) {
      throw new IllegalStateException("phase5 output dir missing: " + phase5Dir.toAbsolutePath());
    }
    if(!containsLua(phase5Dir)) {
      throw new IllegalStateException("phase5 output dir has no .lua: " + phase5Dir.toAbsolutePath());
    }
  }

  private static Path latestFile(Path dir, String prefix, String suffix) throws IOException {
    if(dir == null || !Files.exists(dir) || !Files.isDirectory(dir)) {
      return null;
    }
    try(Stream<Path> stream = Files.list(dir)) {
      Optional<Path> latest = stream
          .filter(Files::isRegularFile)
          .filter(p -> {
            String name = p.getFileName().toString();
            return name.startsWith(prefix) && name.endsWith(suffix);
          })
          .max(Comparator.comparingLong(p -> p.toFile().lastModified()));
      return latest.orElse(null);
    }
  }

  private static boolean containsLua(Path dir) throws IOException {
    try(Stream<Path> stream = Files.walk(dir)) {
      return stream.anyMatch(p -> Files.isRegularFile(p) && p.getFileName().toString().toLowerCase().endsWith(".lua"));
    }
  }
}
