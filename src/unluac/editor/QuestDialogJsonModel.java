package unluac.editor;

import java.util.ArrayList;
import java.util.List;

public class QuestDialogJsonModel {

  public final List<DialogLine> start = new ArrayList<DialogLine>();
  public final List<DialogLine> progress = new ArrayList<DialogLine>();
  public final List<DialogLine> complete = new ArrayList<DialogLine>();

  public void clear() {
    start.clear();
    progress.clear();
    complete.clear();
  }

  public QuestDialogJsonModel copy() {
    QuestDialogJsonModel out = new QuestDialogJsonModel();
    copyList(start, out.start);
    copyList(progress, out.progress);
    copyList(complete, out.complete);
    return out;
  }

  private void copyList(List<DialogLine> source, List<DialogLine> target) {
    if(source == null || target == null) {
      return;
    }
    for(DialogLine line : source) {
      if(line == null) {
        continue;
      }
      target.add(line.copy());
    }
  }
}
