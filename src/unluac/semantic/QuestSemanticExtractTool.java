package unluac.semantic;

import java.nio.charset.Charset;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import unluac.chunk.Lua50ChunkParser;
import unluac.chunk.LuaChunk;

public class QuestSemanticExtractTool {

  public static void main(String[] args) throws Exception {
    if(args.length < 2) {
      printUsage();
      return;
    }

    Path inputLuc = Paths.get(args[0]);
    Path outputJson = Paths.get(args[1]);
    Path outputRuleHits = args.length >= 3 ? Paths.get(args[2]) : null;

    byte[] data = Files.readAllBytes(inputLuc);
    Lua50ChunkParser parser = new Lua50ChunkParser();
    LuaChunk chunk = parser.parse(data);

    QuestSemanticExtractor extractor = new QuestSemanticExtractor();
    QuestSemanticExtractor.ExtractionResult result = extractor.extract(chunk);

    String json = toJson(result.quests);
    Files.write(outputJson, json.getBytes(Charset.forName("UTF-8")));

    if(outputRuleHits != null) {
      List<String> lines = new ArrayList<String>();
      lines.add("rule_id,function_path,pc,offset,detail");
      for(QuestSemanticExtractor.RuleHit hit : result.ruleHits) {
        lines.add(csv(hit.ruleId)
            + "," + csv(hit.functionPath)
            + "," + hit.pc
            + "," + hit.offset
            + "," + csv(hit.detail));
      }
      Files.write(outputRuleHits, lines, Charset.forName("UTF-8"));
    }

    System.out.println("input=" + inputLuc);
    System.out.println("output_json=" + outputJson);
    if(outputRuleHits != null) {
      System.out.println("output_rule_hits=" + outputRuleHits);
    }
    System.out.println("quest_count=" + result.quests.size());
    System.out.println("rule_hit_count=" + result.ruleHits.size());
  }

  private static String toJson(List<QuestSemanticModel> quests) {
    return QuestSemanticJson.toJson(quests);
  }

  private static String csv(String value) {
    if(value == null) {
      value = "";
    }
    boolean quote = false;
    for(int i = 0; i < value.length(); i++) {
      char c = value.charAt(i);
      if(c == ',' || c == '"' || c == '\r' || c == '\n') {
        quote = true;
        break;
      }
    }
    if(!quote) {
      return value;
    }
    String escaped = value.replace("\"", "\"\"");
    return "\"" + escaped + "\"";
  }

  private static void printUsage() {
    System.out.println("Usage:");
    System.out.println("  java -cp build unluac.semantic.QuestSemanticExtractTool <input.luc> <output.json> [rule_hits.csv]");
  }
}
