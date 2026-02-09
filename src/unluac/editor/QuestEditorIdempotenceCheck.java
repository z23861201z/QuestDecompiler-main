package unluac.editor;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.security.MessageDigest;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class QuestEditorIdempotenceCheck {

  public static void main(String[] args) throws Exception {
    if(args.length != 1) {
      System.out.println("Usage: java -cp build unluac.editor.QuestEditorIdempotenceCheck <quest.luc>");
      return;
    }

    Path source = Paths.get(args[0]);
    QuestEditorService service = new QuestEditorService();

    List<QuestEditorModel> rows1 = service.loadForEditor(source);
    if(!rows1.isEmpty()) {
      QuestEditorModel sample = rows1.get(0);
      QuestDialogJsonModel model = sample.dialogJsonModel == null ? new QuestDialogJsonModel() : sample.dialogJsonModel.copy();
      String json = QuestDialogJsonValidator.toJson(model);
      QuestDialogJsonModel parsed = QuestDialogJsonValidator.parseAndValidate(json);
      service.applyDialogJsonModel(sample, parsed);
      service.markDirty(sample);
    }
    Path out1 = createTempLuc(source, "idem1");
    service.savePatchedLuc(source, rows1, out1);

    List<QuestEditorModel> rows2 = service.loadForEditor(out1);
    if(!rows2.isEmpty()) {
      QuestEditorModel sample = rows2.get(0);
      QuestDialogJsonModel model = sample.dialogJsonModel == null ? new QuestDialogJsonModel() : sample.dialogJsonModel.copy();
      String json = QuestDialogJsonValidator.toJson(model);
      QuestDialogJsonModel parsed = QuestDialogJsonValidator.parseAndValidate(json);
      service.applyDialogJsonModel(sample, parsed);
      service.markDirty(sample);
    }
    Path out2 = createTempLuc(source, "idem2");
    service.savePatchedLuc(out1, rows2, out2);

    byte[] bytes1 = Files.readAllBytes(out1);
    byte[] bytes2 = Files.readAllBytes(out2);

    String hash1 = sha256(bytes1);
    String hash2 = sha256(bytes2);

    System.out.println("out1=" + out1);
    System.out.println("out2=" + out2);
    System.out.println("sha256_1=" + hash1);
    System.out.println("sha256_2=" + hash2);
    System.out.println("byte_equal=" + Arrays.equals(bytes1, bytes2));

    List<Integer> diffOffsets = diffOffsets(bytes1, bytes2, 20);
    System.out.println("diff_count=" + diffOffsets.size());
    if(!diffOffsets.isEmpty()) {
      System.out.println("diff_offsets=" + diffOffsets);
      throw new IllegalStateException("idempotence check failed");
    }
  }

  private static Path createTempLuc(Path base, String prefix) throws Exception {
    Path dir = base.getParent() == null ? Paths.get(".") : base.getParent();
    return Files.createTempFile(dir, prefix + ".", ".luc");
  }

  private static String sha256(byte[] data) throws Exception {
    MessageDigest md = MessageDigest.getInstance("SHA-256");
    byte[] digest = md.digest(data);
    StringBuilder sb = new StringBuilder();
    for(byte b : digest) {
      sb.append(String.format("%02x", b));
    }
    return sb.toString();
  }

  private static List<Integer> diffOffsets(byte[] a, byte[] b, int limit) {
    List<Integer> out = new ArrayList<Integer>();
    int max = Math.min(a.length, b.length);
    for(int i = 0; i < max; i++) {
      if(a[i] != b[i]) {
        out.add(Integer.valueOf(i));
        if(out.size() >= limit) {
          return out;
        }
      }
    }
    if(a.length != b.length && out.size() < limit) {
      out.add(Integer.valueOf(max));
    }
    return out;
  }
}
