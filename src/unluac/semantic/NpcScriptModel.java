package unluac.semantic;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

public class NpcScriptModel {

  public int npcId;
  public final List<DialogBranch> branches = new ArrayList<DialogBranch>();
  public final List<Integer> relatedQuestIds = new ArrayList<Integer>();

  public static final class DialogBranch {
    public String functionPath = "";
    public int pc = -1;
    public String action = "";
    public String text = "";
    public int questId = 0;
    public int stateValue = Integer.MIN_VALUE;
    public int itemId = 0;
    public int itemCount = 0;
  }

  public void collectQuestIdsFromBranches() {
    Set<Integer> ids = new LinkedHashSet<Integer>();
    for(Integer existing : relatedQuestIds) {
      if(existing != null && existing.intValue() > 0) {
        ids.add(existing);
      }
    }
    for(DialogBranch branch : branches) {
      if(branch != null && branch.questId > 0) {
        ids.add(Integer.valueOf(branch.questId));
      }
    }
    relatedQuestIds.clear();
    relatedQuestIds.addAll(ids);
  }

  public Map<String, Object> toSimpleMap() {
    Map<String, Object> out = new LinkedHashMap<String, Object>();
    out.put("npcId", Integer.valueOf(npcId));
    out.put("relatedQuestIds", new ArrayList<Integer>(relatedQuestIds));
    List<Map<String, Object>> branchList = new ArrayList<Map<String, Object>>();
    for(DialogBranch branch : branches) {
      if(branch == null) {
        continue;
      }
      Map<String, Object> item = new LinkedHashMap<String, Object>();
      item.put("functionPath", branch.functionPath);
      item.put("pc", Integer.valueOf(branch.pc));
      item.put("action", branch.action);
      item.put("text", branch.text);
      item.put("questId", Integer.valueOf(branch.questId));
      item.put("stateValue", Integer.valueOf(branch.stateValue));
      item.put("itemId", Integer.valueOf(branch.itemId));
      item.put("itemCount", Integer.valueOf(branch.itemCount));
      branchList.add(item);
    }
    out.put("branches", branchList);
    return out;
  }
}
