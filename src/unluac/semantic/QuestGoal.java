package unluac.semantic;

import java.util.ArrayList;
import java.util.List;

public class QuestGoal {

  public int needLevel;
  public final List<ItemRequirement> items = new ArrayList<ItemRequirement>();
  public final List<KillRequirement> monsters = new ArrayList<KillRequirement>();
}

