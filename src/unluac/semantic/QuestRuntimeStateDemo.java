package unluac.semantic;

import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.List;
import java.util.Map;

import unluac.chunk.Lua50ChunkParser;
import unluac.chunk.LuaChunk;

public class QuestRuntimeStateDemo {

  public static void main(String[] args) throws Exception {
    if(args.length < 1) {
      System.out.println("Usage: java -cp build unluac.semantic.QuestRuntimeStateDemo <quest.luc>");
      return;
    }

    byte[] data = Files.readAllBytes(Paths.get(args[0]));
    LuaChunk chunk = new Lua50ChunkParser().parse(data);
    QuestSemanticExtractor extractor = new QuestSemanticExtractor();
    QuestSemanticExtractor.ExtractionResult extracted = extractor.extract(chunk);

    if(extracted.quests.isEmpty()) {
      System.out.println("No quest semantic model extracted");
      return;
    }

    QuestRuntimeAstMapper mapper = new QuestRuntimeAstMapper();
    Map<Integer, QuestRuntimeState> init = mapper.mapInitialStates(extracted.quests);

    QuestSemanticModel model = extracted.quests.get(0);
    QuestRuntimeStateMachine machine = new QuestRuntimeStateMachine();
    QuestRuntimeState state = init.get(Integer.valueOf(model.questId));
    if(state == null) {
      state = machine.initial(model.questId);
    }

    QuestRuntimeGoalSnapshot goal = new QuestRuntimeGoalSnapshot();
    goal.playerLevel = Math.max(1, model.goal == null ? 1 : model.goal.needLevel);
    if(model.goal != null) {
      for(ItemRequirement item : model.goal.items) {
        goal.setItemCount(item.itemId, item.itemCount);
      }
      for(KillRequirement kill : model.goal.monsters) {
        goal.setKillCount(kill.monsterId, kill.killCount);
      }
    }

    print("INIT", state, null);
    QuestRuntimeStateMachine.TransitionResult open = machine.apply(state, model, QuestRuntimeStateMachine.ACTION_OPEN, goal);
    state = open.after;
    print("OPEN", state, open.events);

    QuestRuntimeStateMachine.TransitionResult next = machine.apply(state, model, QuestRuntimeStateMachine.ACTION_NEXT, goal);
    state = next.after;
    print("NEXT", state, next.events);

    QuestRuntimeStateMachine.TransitionResult yes = machine.apply(state, model, QuestRuntimeStateMachine.ACTION_SELECT_QUEST_YES, goal);
    state = yes.after;
    print("QUEST_YES", state, yes.events);

    QuestRuntimeStateMachine.TransitionResult server = machine.onServerState(state, 2, state.currentDialogIndex, true, model);
    state = server.after;
    print("SERVER", state, server.events);
  }

  private static void print(String tag, QuestRuntimeState state, List<String> events) {
    StringBuilder sb = new StringBuilder();
    sb.append(tag)
      .append(" qid=").append(state.questId)
      .append(" state=").append(state.state)
      .append(" dialogIndex=").append(state.currentDialogIndex)
      .append(" complete=").append(state.isComplete);
    if(events != null && !events.isEmpty()) {
      sb.append(" events=").append(events);
    }
    System.out.println(sb.toString());
  }
}
