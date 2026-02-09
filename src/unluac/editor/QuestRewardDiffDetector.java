package unluac.editor;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Objects;

public class QuestRewardDiffDetector {

  public QuestRewardDiffReport detect(QuestReward before, QuestReward after) {
    QuestReward left = before == null ? new QuestReward() : before;
    QuestReward right = after == null ? new QuestReward() : after;

    QuestRewardDiffReport report = new QuestRewardDiffReport();
    compareInt(report, "exp", left.exp, right.exp);
    compareInt(report, "fame", left.fame, right.fame);
    compareInt(report, "money", left.money, right.money);
    compareInt(report, "pvppoint", left.pvppoint, right.pvppoint);
    compareList(report, "skillIds", left.skillIds, right.skillIds);
    compareList(report, "fieldOrder", left.fieldOrder, right.fieldOrder);

    List<Integer> leftItemIds = left.toItemIdList();
    List<Integer> rightItemIds = right.toItemIdList();
    compareList(report, "getItem.itemIds", leftItemIds, rightItemIds);

    List<Integer> leftItemCounts = left.toItemCountList();
    List<Integer> rightItemCounts = right.toItemCountList();
    compareList(report, "getItem.itemCounts", leftItemCounts, rightItemCounts);

    compareMap(report, "extraFields", left.extraFields, right.extraFields);
    return report;
  }

  private void compareInt(QuestRewardDiffReport report, String key, int before, int after) {
    if(before != after) {
      report.addChange(key, Integer.valueOf(before), Integer.valueOf(after));
    }
  }

  private void compareList(QuestRewardDiffReport report, String key, List<?> before, List<?> after) {
    if(!Objects.equals(before, after)) {
      report.addChange(key, before, after);
    }
  }

  private void compareMap(QuestRewardDiffReport report,
                          String key,
                          Map<String, Object> before,
                          Map<String, Object> after) {
    if(!Objects.equals(before, after)) {
      report.addChange(key, before, after);
    }
  }

  public static final class QuestRewardDiffReport {
    public final List<RewardFieldChange> changes = new ArrayList<RewardFieldChange>();

    public boolean hasChanges() {
      return !changes.isEmpty();
    }

    public void addChange(String field, Object before, Object after) {
      RewardFieldChange change = new RewardFieldChange();
      change.field = field;
      change.before = before;
      change.after = after;
      changes.add(change);
    }

    public String toText() {
      if(changes.isEmpty()) {
        return "reward diff: no changes";
      }
      StringBuilder sb = new StringBuilder();
      sb.append("reward diff:\n");
      for(RewardFieldChange change : changes) {
        sb.append("- ").append(change.field)
            .append(" | before=").append(String.valueOf(change.before))
            .append(" | after=").append(String.valueOf(change.after))
            .append('\n');
      }
      return sb.toString();
    }
  }

  public static final class RewardFieldChange {
    public String field;
    public Object before;
    public Object after;
  }
}

