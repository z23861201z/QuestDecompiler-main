package unluac.web.result;

import java.util.ArrayList;
import java.util.List;

public final class AdminQuestDetail {
  public int questId;
  public String name;
  public Integer needLevel;
  public Integer bqLoop;
  public Integer rewardExp;
  public Integer rewardGold;
  public final List<String> contents = new ArrayList<String>();
  public final List<String> answer = new ArrayList<String>();
  public final List<String> info = new ArrayList<String>();
}

