package unluac.semantic;

import java.util.HashMap;
import java.util.Map;

public class QuestRuntimeGoalSnapshot {

  public int playerLevel;
  private final Map<Integer, Integer> itemCounts = new HashMap<Integer, Integer>();
  private final Map<Integer, Integer> killCounts = new HashMap<Integer, Integer>();

  public QuestRuntimeGoalSnapshot() {
    this.playerLevel = 0;
  }

  public void setItemCount(int itemId, int count) {
    this.itemCounts.put(Integer.valueOf(itemId), Integer.valueOf(Math.max(0, count)));
  }

  public int getItemCount(int itemId) {
    Integer value = this.itemCounts.get(Integer.valueOf(itemId));
    return value == null ? 0 : value.intValue();
  }

  public void setKillCount(int monsterId, int count) {
    this.killCounts.put(Integer.valueOf(monsterId), Integer.valueOf(Math.max(0, count)));
  }

  public int getKillCount(int monsterId) {
    Integer value = this.killCounts.get(Integer.valueOf(monsterId));
    return value == null ? 0 : value.intValue();
  }
}

