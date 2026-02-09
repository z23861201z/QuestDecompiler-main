package unluac.editor;

import java.util.ArrayList;
import java.util.List;

import unluac.semantic.QuestGoal;

public class QuestStageModel {

  public final List<String> dialogStageLines = new ArrayList<String>();
  public final List<Integer> dialogStageLineIndices = new ArrayList<Integer>();

  public String startDialog = "";
  public int startDialogLineIndex = -1;

  public final List<String> options = new ArrayList<String>();
  public final List<Integer> optionLineIndices = new ArrayList<Integer>();

  public String progressInfo = "";
  public int progressInfoLineIndex = -1;

  public String completionDialog = "";
  public int completionDialogLineIndex = -1;

  public QuestGoal goal = new QuestGoal();
  public QuestReward reward = new QuestReward();
}
