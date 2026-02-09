package unluac.semantic;

public class QuestRuntimeState {

  public int questId;
  public int state;
  public int currentDialogIndex;
  public boolean isComplete;

  public QuestRuntimeState() {
    this.questId = 0;
    this.state = QuestRuntimeStateMachine.STATE_IDLE;
    this.currentDialogIndex = 0;
    this.isComplete = false;
  }

  public QuestRuntimeState copy() {
    QuestRuntimeState out = new QuestRuntimeState();
    out.questId = this.questId;
    out.state = this.state;
    out.currentDialogIndex = this.currentDialogIndex;
    out.isComplete = this.isComplete;
    return out;
  }
}

