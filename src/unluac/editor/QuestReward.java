package unluac.editor;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public class QuestReward {

  public int exp;
  public int fame;
  public int money;
  public int pvppoint;
  public final List<ItemReward> items = new ArrayList<ItemReward>();
  public final List<Integer> skillIds = new ArrayList<Integer>();
  public final Map<String, Object> extraFields = new LinkedHashMap<String, Object>();
  public final List<String> fieldOrder = new ArrayList<String>();

  public static final class ItemReward {
    public int itemId;
    public int itemCount;
  }

  public List<Integer> toItemIdList() {
    List<Integer> out = new ArrayList<Integer>();
    for(ItemReward item : items) {
      if(item == null) {
        continue;
      }
      out.add(Integer.valueOf(item.itemId));
    }
    return out;
  }

  public List<Integer> toItemCountList() {
    List<Integer> out = new ArrayList<Integer>();
    for(ItemReward item : items) {
      if(item == null) {
        continue;
      }
      out.add(Integer.valueOf(item.itemCount));
    }
    return out;
  }

  public void loadItemsFromLists(List<Integer> itemIds, List<Integer> itemCounts) {
    items.clear();
    if(itemIds == null || itemCounts == null) {
      return;
    }
    int size = Math.min(itemIds.size(), itemCounts.size());
    for(int i = 0; i < size; i++) {
      ItemReward item = new ItemReward();
      item.itemId = itemIds.get(i).intValue();
      item.itemCount = itemCounts.get(i).intValue();
      items.add(item);
    }
  }

  public QuestReward copy() {
    QuestReward out = new QuestReward();
    out.exp = exp;
    out.fame = fame;
    out.money = money;
    out.pvppoint = pvppoint;
    for(ItemReward item : items) {
      if(item == null) {
        continue;
      }
      ItemReward copy = new ItemReward();
      copy.itemId = item.itemId;
      copy.itemCount = item.itemCount;
      out.items.add(copy);
    }
    out.skillIds.addAll(skillIds);
    out.extraFields.putAll(extraFields);
    out.fieldOrder.addAll(fieldOrder);
    return out;
  }
}
