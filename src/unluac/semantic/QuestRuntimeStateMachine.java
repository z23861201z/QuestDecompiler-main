package unluac.semantic;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class QuestRuntimeStateMachine {

  public static final int STATE_IDLE = 0;
  public static final int STATE_DIALOG = 1;
  public static final int STATE_CHOICE = 2;
  public static final int STATE_GOAL_CHECK = 3;
  public static final int STATE_REWARD_PENDING = 4;
  public static final int STATE_FINISHED = 5;

  public static final int ACTION_OPEN = 100;
  public static final int ACTION_NEXT = 101;
  public static final int ACTION_PREV = 102;
  public static final int ACTION_SELECT_YES = 103;
  public static final int ACTION_SELECT_NO = 104;
  public static final int ACTION_SELECT_END = 105;
  public static final int ACTION_SELECT_QUEST_YES = 106;
  public static final int ACTION_SELECT_QUEST_NO = 107;
  public static final int ACTION_REENTER = 108;

  private static final int UI_NEXT = 49001;
  private static final int UI_NEXT_ALT = 49399;
  private static final int UI_PREV = 49002;
  private static final int UI_REENTER = 49003;
  private static final int UI_YES = 49004;
  private static final int UI_NO = 49005;
  private static final int UI_END = 49006;
  private static final int UI_IF_NO = 49007;
  private static final int UI_QUEST_YES = 49015;
  private static final int UI_QUEST_NO = 49016;

  public QuestRuntimeState initial(int questId) {
    QuestRuntimeState state = new QuestRuntimeState();
    state.questId = questId;
    state.state = STATE_IDLE;
    state.currentDialogIndex = 0;
    state.isComplete = false;
    return state;
  }

  public TransitionResult apply(
      QuestRuntimeState current,
      QuestSemanticModel model,
      int action,
      QuestRuntimeGoalSnapshot goalSnapshot) {
    if(current == null) {
      throw new IllegalStateException("state is null");
    }
    if(model == null) {
      throw new IllegalStateException("model is null");
    }

    QuestRuntimeState next = current.copy();
    TransitionResult result = new TransitionResult();
    result.before = current.copy();
    result.after = next;
    result.questId = next.questId;

    if(next.questId <= 0) {
      next.questId = model.questId;
      result.events.add("quest_bind:" + next.questId);
    }

    switch(action) {
      case ACTION_OPEN:
        handleOpen(next, model, result);
        break;
      case ACTION_NEXT:
        handleMove(next, model, +1, UI_NEXT, result);
        break;
      case ACTION_PREV:
        handleMove(next, model, -1, UI_PREV, result);
        break;
      case ACTION_REENTER:
        handleReenter(next, model, result);
        break;
      case ACTION_SELECT_YES:
        handleSelect(next, model, "ANSWER_YES:", UI_YES, goalSnapshot, result);
        break;
      case ACTION_SELECT_NO:
        handleSelect(next, model, "ANSWER_NO:", UI_NO, goalSnapshot, result);
        break;
      case ACTION_SELECT_END:
        handleSelect(next, model, "ANSWER_END:", UI_END, goalSnapshot, result);
        break;
      case ACTION_SELECT_QUEST_YES:
        handleSelect(next, model, "ANSWER_QUEST_YES:", UI_QUEST_YES, goalSnapshot, result);
        break;
      case ACTION_SELECT_QUEST_NO:
        handleSelect(next, model, "ANSWER_QUEST_NO:", UI_QUEST_NO, goalSnapshot, result);
        break;
      default:
        throw new IllegalStateException("unsupported action: " + action);
    }

    return result;
  }

  private void handleOpen(QuestRuntimeState state, QuestSemanticModel model, TransitionResult result) {
    state.state = STATE_DIALOG;
    state.currentDialogIndex = clampDialogIndex(0, model);
    state.isComplete = false;
    result.uiCode = UI_REENTER;
    result.events.add("dialog_open");
    result.currentContents = contentsAt(model, state.currentDialogIndex);
    result.visibleAnswers.clear();
    result.visibleAnswers.addAll(collectVisibleAnswers(model, state.currentDialogIndex));
  }

  private void handleMove(
      QuestRuntimeState state,
      QuestSemanticModel model,
      int delta,
      int uiCode,
      TransitionResult result) {
    state.state = STATE_DIALOG;
    state.currentDialogIndex = clampDialogIndex(state.currentDialogIndex + delta, model);
    result.uiCode = delta > 0 ? UI_NEXT : uiCode;
    if(delta > 0 && result.uiCode == UI_NEXT && state.currentDialogIndex > 0) {
      String line = contentsAt(model, state.currentDialogIndex);
      if(line != null && line.startsWith("ANSWER_")) {
        result.uiCode = UI_NEXT_ALT;
      }
    }
    result.events.add(delta > 0 ? "dialog_next" : "dialog_prev");
    result.currentContents = contentsAt(model, state.currentDialogIndex);
    result.visibleAnswers.clear();
    result.visibleAnswers.addAll(collectVisibleAnswers(model, state.currentDialogIndex));
  }

  private void handleReenter(QuestRuntimeState state, QuestSemanticModel model, TransitionResult result) {
    state.state = STATE_DIALOG;
    state.currentDialogIndex = clampDialogIndex(state.currentDialogIndex, model);
    result.uiCode = UI_REENTER;
    result.events.add("dialog_reenter");
    result.currentContents = contentsAt(model, state.currentDialogIndex);
    result.visibleAnswers.clear();
    result.visibleAnswers.addAll(collectVisibleAnswers(model, state.currentDialogIndex));
  }

  private void handleSelect(
      QuestRuntimeState state,
      QuestSemanticModel model,
      String selector,
      int uiCode,
      QuestRuntimeGoalSnapshot goalSnapshot,
      TransitionResult result) {
    state.state = STATE_CHOICE;
    result.uiCode = uiCode;
    result.selectedAnswerType = selector;

    int selectedIndex = findNextAnswerLine(model, state.currentDialogIndex, selector);
    if(selectedIndex >= 0) {
      state.currentDialogIndex = selectedIndex;
    }

    if("ANSWER_QUEST_NO:".equals(selector)) {
      state.state = STATE_IDLE;
      state.isComplete = false;
      result.events.add("quest_giveup:packet_0x007B");
      result.currentContents = contentsAt(model, state.currentDialogIndex);
      return;
    }

    if("ANSWER_NO:".equals(selector)) {
      state.state = STATE_DIALOG;
      result.events.add("dialog_no_continue:packet_0x007D");
      result.currentContents = contentsAt(model, state.currentDialogIndex);
      return;
    }

    if("ANSWER_END:".equals(selector)) {
      state.state = STATE_IDLE;
      result.events.add("dialog_end");
      result.currentContents = contentsAt(model, state.currentDialogIndex);
      return;
    }

    state.state = STATE_GOAL_CHECK;
    boolean goalMet = evaluateGoal(model, goalSnapshot);
    result.goalSatisfied = goalMet;
    if(goalMet) {
      state.state = STATE_REWARD_PENDING;
      result.events.add("goal_met:packet_0x007C");
      result.events.add("status_wait_server_0x0080");
      state.isComplete = false;
      result.pendingRewards.clear();
      result.pendingRewards.addAll(collectRewards(model));
    } else {
      state.state = STATE_DIALOG;
      state.isComplete = false;
      result.events.add("goal_not_met");
    }

    if("ANSWER_QUEST_YES:".equals(selector)) {
      result.events.add("quest_yes_branch");
    } else {
      result.events.add("dialog_yes_branch");
    }
    result.currentContents = contentsAt(model, state.currentDialogIndex);
    result.visibleAnswers.clear();
    result.visibleAnswers.addAll(collectVisibleAnswers(model, state.currentDialogIndex));
  }

  public TransitionResult onServerState(
      QuestRuntimeState current,
      int serverState,
      int serverStep,
      boolean refresh027A,
      QuestSemanticModel model) {
    if(current == null) {
      throw new IllegalStateException("state is null");
    }
    if(model == null) {
      throw new IllegalStateException("model is null");
    }

    QuestRuntimeState next = current.copy();
    TransitionResult result = new TransitionResult();
    result.before = current.copy();
    result.after = next;
    result.questId = next.questId;

    next.state = STATE_DIALOG;
    next.currentDialogIndex = clampDialogIndex(serverStep, model);
    result.uiCode = refresh027A ? 0x027A : 0x0080;
    result.events.add("server_state_apply:" + serverState);
    result.currentContents = contentsAt(model, next.currentDialogIndex);
    result.visibleAnswers.clear();
    result.visibleAnswers.addAll(collectVisibleAnswers(model, next.currentDialogIndex));

    if(serverState >= 2) {
      next.state = STATE_FINISHED;
      next.isComplete = true;
      result.events.add("quest_complete_confirmed");
    }
    return result;
  }

  public String resolveContentsLine(QuestSemanticModel model, int index) {
    return contentsAt(model, index);
  }

  public List<String> resolveVisibleAnswers(QuestSemanticModel model, int index) {
    return collectVisibleAnswers(model, index);
  }

  public boolean evaluateGoal(QuestSemanticModel model, QuestRuntimeGoalSnapshot snapshot) {
    if(model.goal == null) {
      return true;
    }
    if(snapshot == null) {
      return false;
    }

    if(model.goal.needLevel > 0 && snapshot.playerLevel < model.goal.needLevel) {
      return false;
    }

    for(ItemRequirement item : model.goal.items) {
      int owned = snapshot.getItemCount(item.itemId);
      if(owned < item.itemCount) {
        return false;
      }
    }

    for(KillRequirement kill : model.goal.monsters) {
      int killed = snapshot.getKillCount(kill.monsterId);
      if(killed < kill.killCount) {
        return false;
      }
    }
    return true;
  }

  private List<QuestSemanticModel.Reward> collectRewards(QuestSemanticModel model) {
    if(model.rewards == null || model.rewards.isEmpty()) {
      return Collections.emptyList();
    }
    List<QuestSemanticModel.Reward> out = new ArrayList<QuestSemanticModel.Reward>();
    out.addAll(model.rewards);
    return out;
  }

  private int findNextAnswerLine(QuestSemanticModel model, int fromIndex, String prefix) {
    if(model.dialogLines == null || model.dialogLines.isEmpty()) {
      return -1;
    }
    int start = Math.max(0, fromIndex);
    for(int i = start; i < model.dialogLines.size(); i++) {
      String line = model.dialogLines.get(i);
      if(line == null) {
        continue;
      }
      if(line.startsWith(prefix)) {
        return i;
      }
    }
    return -1;
  }

  private List<String> collectVisibleAnswers(QuestSemanticModel model, int fromIndex) {
    if(model.dialogLines == null || model.dialogLines.isEmpty()) {
      return Collections.emptyList();
    }
    List<String> out = new ArrayList<String>();
    int start = Math.max(0, fromIndex);
    for(int i = start; i < model.dialogLines.size(); i++) {
      String line = model.dialogLines.get(i);
      if(line == null) {
        continue;
      }
      if(line.startsWith("ANSWER_")) {
        out.add(line);
        continue;
      }
      if(!out.isEmpty()) {
        break;
      }
    }

    if(out.isEmpty() && model.dialogTree != null && model.dialogTree.nodes != null && !model.dialogTree.nodes.isEmpty()) {
      int index = Math.min(Math.max(0, fromIndex), model.dialogTree.nodes.size() - 1);
      DialogNode node = model.dialogTree.nodes.get(index);
      if(node != null && node.options != null) {
        for(DialogOption option : node.options) {
          if(option != null && option.optionText != null && !option.optionText.trim().isEmpty()) {
            out.add("ANSWER_YES:" + option.optionText);
          }
        }
      }
    }
    return out;
  }

  private String contentsAt(QuestSemanticModel model, int index) {
    if(model.dialogLines == null || model.dialogLines.isEmpty()) {
      if(model.description != null && !model.description.trim().isEmpty()) {
        return model.description;
      }
      return "";
    }
    int i = clampDialogIndex(index, model);
    String line = model.dialogLines.get(i);
    return line == null ? "" : line;
  }

  private int clampDialogIndex(int value, QuestSemanticModel model) {
    if(model.dialogLines == null || model.dialogLines.isEmpty()) {
      return 0;
    }
    if(value < 0) {
      return 0;
    }
    if(value >= model.dialogLines.size()) {
      return model.dialogLines.size() - 1;
    }
    return value;
  }

  public static final class TransitionResult {
    public QuestRuntimeState before;
    public QuestRuntimeState after;
    public int questId;
    public int uiCode;
    public String currentContents;
    public String selectedAnswerType;
    public boolean goalSatisfied;
    public final List<String> visibleAnswers = new ArrayList<String>();
    public final List<String> events = new ArrayList<String>();
    public final List<QuestSemanticModel.Reward> pendingRewards = new ArrayList<QuestSemanticModel.Reward>();
  }
}
