import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import unluac.editor.QuestEditorModel;
import unluac.editor.QuestEditorService;

public class RepeatGrowthCheck {
  private static int count1206(List<QuestEditorModel> rows) {
    for(QuestEditorModel row : rows) {
      if(row.questId == 1206) {
        return row.stage.dialogStageLines.size();
      }
    }
    return -1;
  }

  public static void main(String[] args) throws Exception {
    QuestEditorService service = new QuestEditorService();
    Path current = Paths.get("D:/TitanGames/GhostOnline/zChina/Script/quest.luc");

    for(int i=1; i<=5; i++) {
      List<QuestEditorModel> rows = service.loadForEditor(current);
      int c = count1206(rows);
      System.out.println("cycle=" + i + " input=" + current + " lines1206=" + c);
      Path next = Paths.get("out/repeat_cycle_" + i + ".luc");
      service.savePatchedLuc(current, rows, next);
      current = next;
    }

    List<QuestEditorModel> finalRows = service.loadForEditor(current);
    System.out.println("final lines1206=" + count1206(finalRows));
  }
}
