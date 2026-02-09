package unluac.editor;

import java.nio.file.Paths;
import java.util.List;

public class QuestEditorIdempotenceTestExample {

  public static void main(String[] args) throws Exception {
    QuestEditorService service = new QuestEditorService();
    List<QuestEditorModel> rows = service.loadForEditor(Paths.get(args[0]));

    QuestEditorModel sample = rows.isEmpty() ? null : rows.get(0);
    if(sample != null) {
      QuestDialogJsonModel model = sample.dialogJsonModel == null ? new QuestDialogJsonModel() : sample.dialogJsonModel.copy();
      String json = QuestDialogJsonValidator.toJson(model);
      QuestDialogJsonModel parsed = QuestDialogJsonValidator.parseAndValidate(json);
      service.applyDialogJsonModel(sample, parsed);
      service.markDirty(sample);
    }

    QuestEditorIdempotenceCheck.main(new String[] { args[0] });
  }
}
