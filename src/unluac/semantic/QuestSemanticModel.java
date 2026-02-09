package unluac.semantic;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public class QuestSemanticModel {

  public int questId;
  public String title;
  public String description;
  public final List<Integer> preQuestIds = new ArrayList<Integer>();
  public final List<Reward> rewards = new ArrayList<Reward>();
  public final List<String> dialogLines = new ArrayList<String>();
  public QuestDialogTree dialogTree = new QuestDialogTree();
  public QuestGoal goal = new QuestGoal();
  public final Map<String, Object> conditions = new LinkedHashMap<String, Object>();
  public final Map<String, Object> completionConditions = new LinkedHashMap<String, Object>();

  public static final class Reward {
    public String type;
    public int id;
    public int count;
    public int money;
    public int exp;
    public int fame;
    public int pvppoint;
    public final List<Integer> skillIds = new ArrayList<Integer>();
    public final Map<String, Object> extraFields = new LinkedHashMap<String, Object>();
    public final List<String> fieldOrder = new ArrayList<String>();
  }
}
