package unluac.web.controller;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import java.io.IOException;
import java.nio.charset.Charset;
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
import org.springframework.test.web.servlet.MvcResult;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

@SpringBootTest
@AutoConfigureMockMvc
public class AdminControllerPhaseDTest {

  @Autowired
  private MockMvc mockMvc;

  private final ObjectMapper mapper = new ObjectMapper();

  @Test
  public void fullFlowModifySaveExportGeneratesPhaseDReport() throws Exception {
    MvcResult questListResult = mockMvc.perform(get("/api/admin/quests").param("page", "1").param("pageSize", "1"))
        .andExpect(status().isOk())
        .andReturn();
    JsonNode questListPage = mapper.readTree(questListResult.getResponse().getContentAsString());
    JsonNode questList = questListPage.path("records");
    if(!questList.isArray() || questList.size() == 0) {
      throw new IllegalStateException("no quest rows found");
    }
    int questId = questList.get(0).get("questId").asInt();

    MvcResult questDetailResult = mockMvc.perform(get("/api/admin/quests/{questId}", questId))
        .andExpect(status().isOk())
        .andReturn();
    JsonNode questDetail = mapper.readTree(questDetailResult.getResponse().getContentAsString());
    String name = questDetail.path("name").asText();
    String newName = name + " [phaseD]";

    String saveQuestPayload = "{"
        + "\"name\":" + json(newName) + ","
        + "\"contents\":[\"phaseD line 1\",\"phaseD line 2\"],"
        + "\"answer\":[\"phaseD answer\"],"
        + "\"info\":[\"phaseD info\"]"
        + "}";
    mockMvc.perform(post("/api/admin/quests/{questId}/save", questId)
            .contentType(MediaType.APPLICATION_JSON)
            .content(saveQuestPayload))
        .andExpect(status().isOk())
        .andExpect(jsonPath("$.status").value("SUCCESS"))
        .andExpect(jsonPath("$.artifacts.afterName").value(newName));

    MvcResult questVerify = mockMvc.perform(get("/api/admin/quests/{questId}", questId))
        .andExpect(status().isOk())
        .andReturn();
    JsonNode questVerifyNode = mapper.readTree(questVerify.getResponse().getContentAsString());
    if(!newName.equals(questVerifyNode.path("name").asText())) {
      throw new IllegalStateException("quest save verification failed");
    }

    MvcResult npcListResult = mockMvc.perform(get("/api/admin/npc-texts").param("page", "1").param("pageSize", "1"))
        .andExpect(status().isOk())
        .andReturn();
    JsonNode npcPage = mapper.readTree(npcListResult.getResponse().getContentAsString());
    JsonNode npcList = npcPage.path("records");
    if(!npcList.isArray() || npcList.size() == 0) {
      throw new IllegalStateException("no npc text rows found");
    }
    JsonNode npc = npcList.get(0);
    long textId = npc.path("textId").asLong();
    String oldModified = npc.path("modifiedText").isNull() ? null : npc.path("modifiedText").asText();
    String oldRaw = npc.path("rawText").asText();
    String newModified = (oldModified == null || oldModified.isEmpty() ? oldRaw : oldModified) + " [phaseD-edit]";

    String saveNpcPayload = "{\"modifiedText\":" + json(newModified) + "}";
    mockMvc.perform(post("/api/admin/npc-texts/{textId}/save", textId)
            .contentType(MediaType.APPLICATION_JSON)
            .content(saveNpcPayload))
        .andExpect(status().isOk())
        .andExpect(jsonPath("$.status").value("SUCCESS"));

    Path beforeReport = latestFile(Paths.get("reports"), "web_phaseD_export_report_", ".json");

    mockMvc.perform(post("/api/admin/export/run").contentType(MediaType.APPLICATION_JSON).content("{}"))
        .andExpect(status().isOk())
        .andExpect(jsonPath("$.finalStatus").value("SAFE"))
        .andExpect(jsonPath("$.elapsedMs").isNumber())
        .andExpect(jsonPath("$.npcExportFileCount").isNumber())
        .andExpect(jsonPath("$.questExportFileCount").isNumber());

    Path afterReport = latestFile(Paths.get("reports"), "web_phaseD_export_report_", ".json");
    if(afterReport == null) {
      throw new IllegalStateException("phaseD report missing");
    }
    if(beforeReport != null && beforeReport.equals(afterReport)) {
      throw new IllegalStateException("phaseD report not updated");
    }

    String reportText = new String(Files.readAllBytes(afterReport), Charset.forName("UTF-8"));
    if(!reportText.contains("\"finalStatus\": \"SAFE\"") && !reportText.contains("\"finalStatus\":\"SAFE\"")) {
      throw new IllegalStateException("phaseD report finalStatus is not SAFE");
    }

    Path phase4File = Paths.get("reports", "phase4_exported_quest.lua");
    if(!Files.exists(phase4File) || Files.size(phase4File) <= 0L) {
      throw new IllegalStateException("phase4 export file missing");
    }
    Path phase5Dir = Paths.get("reports", "phase5_exported_npc");
    if(!Files.exists(phase5Dir) || !containsLua(phase5Dir)) {
      throw new IllegalStateException("phase5 lua exports missing");
    }
  }

  private static String json(String value) {
    if(value == null) {
      return "null";
    }
    String escaped = value
        .replace("\\", "\\\\")
        .replace("\"", "\\\"")
        .replace("\n", "\\n")
        .replace("\r", "\\r")
        .replace("\t", "\\t");
    return "\"" + escaped + "\"";
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
