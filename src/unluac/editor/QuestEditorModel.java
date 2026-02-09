package unluac.editor;

import java.util.LinkedHashMap;
import java.util.Map;

import unluac.semantic.QuestDialogTree;
import unluac.semantic.QuestGoal;

public class QuestEditorModel {

  public int questId;
  public String title;
  public String description;

  public int rewardExp;
  public int rewardFame;
  public int rewardMoney;
  public int rewardPvppoint;
  public String rewardItemIdJson;
  public String rewardItemCountJson;
  public String rewardSkillIdsJson;
  public String rewardExtraFieldsJson;
  public String rewardFieldOrderJson;

  public String preQuestIdsJson;
  public String dialogLinesJson;
  public QuestDialogTree dialogTree = new QuestDialogTree();
  public QuestGoal goal = new QuestGoal();
  public String conditionJson;

  public QuestStageModel stage = new QuestStageModel();
  public QuestReward originalReward = new QuestReward();
  public QuestDialogJsonModel dialogJsonModel = new QuestDialogJsonModel();
  public boolean dirty;

  public final Map<String, Object> conditionMap = new LinkedHashMap<String, Object>();
  public final Map<String, String> dialogBindingValues = new LinkedHashMap<String, String>();
  public final Map<Integer, String> dialogLineFieldByIndex = new LinkedHashMap<Integer, String>();
}
