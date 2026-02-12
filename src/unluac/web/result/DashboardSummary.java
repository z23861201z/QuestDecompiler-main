package unluac.web.result;

import java.util.ArrayList;
import java.util.List;

public final class DashboardSummary {
  public int questCount;
  public int npcCount;
  public int itemCount;
  public int mapCount;
  public int fashionCount;
  public final List<String> recentExportReports = new ArrayList<String>();
  public final List<String> timeline = new ArrayList<String>();
}
