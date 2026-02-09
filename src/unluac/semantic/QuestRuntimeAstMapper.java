package unluac.semantic;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import unluac.chunk.LuaChunk;

public class QuestRuntimeAstMapper {

  public Map<Integer, QuestRuntimeState> mapInitialStates(LuaChunk chunk) {
    QuestSemanticExtractor extractor = new QuestSemanticExtractor();
    QuestSemanticExtractor.ExtractionResult extracted = extractor.extract(chunk);
    return mapInitialStates(extracted.quests);
  }

  public Map<Integer, QuestRuntimeState> mapInitialStates(List<QuestSemanticModel> models) {
    if(models == null) {
      return Collections.emptyMap();
    }
    Map<Integer, QuestRuntimeState> out = new LinkedHashMap<Integer, QuestRuntimeState>();
    QuestRuntimeStateMachine machine = new QuestRuntimeStateMachine();

    List<QuestSemanticModel> ordered = new ArrayList<QuestSemanticModel>(models);
    Collections.sort(ordered, new Comparator<QuestSemanticModel>() {
      @Override
      public int compare(QuestSemanticModel left, QuestSemanticModel right) {
        return Integer.compare(left.questId, right.questId);
      }
    });

    for(QuestSemanticModel model : ordered) {
      if(model == null || model.questId <= 0) {
        continue;
      }
      QuestRuntimeState state = machine.initial(model.questId);
      state.currentDialogIndex = resolveStartIndex(model);
      state.state = QuestRuntimeStateMachine.STATE_IDLE;
      state.isComplete = false;
      out.put(Integer.valueOf(model.questId), state);
    }
    return out;
  }

  public int resolveStartIndex(QuestSemanticModel model) {
    if(model == null) {
      return 0;
    }
    if(model.dialogLines != null && !model.dialogLines.isEmpty()) {
      for(int i = 0; i < model.dialogLines.size(); i++) {
        String line = model.dialogLines.get(i);
        if(line == null) {
          continue;
        }
        if(!line.startsWith("ANSWER_")) {
          return i;
        }
      }
      return 0;
    }
    if(model.dialogTree != null && model.dialogTree.nodes != null && !model.dialogTree.nodes.isEmpty()) {
      return 0;
    }
    return 0;
  }

  public String buildAstMappingSummary(QuestSemanticModel model) {
    if(model == null) {
      return "quest=null";
    }
    StringBuilder sb = new StringBuilder();
    sb.append("questId=").append(model.questId);
    sb.append(";title=").append(safe(model.title));
    sb.append(";contentsCount=").append(model.dialogLines == null ? 0 : model.dialogLines.size());
    sb.append(";answerPrefixCount=").append(countAnswerPrefix(model.dialogLines));
    sb.append(";goalItems=").append(model.goal == null ? 0 : model.goal.items.size());
    sb.append(";goalMonsters=").append(model.goal == null ? 0 : model.goal.monsters.size());
    sb.append(";rewards=").append(model.rewards == null ? 0 : model.rewards.size());
    return sb.toString();
  }

  private int countAnswerPrefix(List<String> lines) {
    if(lines == null || lines.isEmpty()) {
      return 0;
    }
    int count = 0;
    for(String line : lines) {
      if(line != null && line.startsWith("ANSWER_")) {
        count++;
      }
    }
    return count;
  }

  private String safe(String value) {
    return value == null ? "" : value;
  }
}

