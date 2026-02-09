package unluac.editor;

import javax.swing.SwingUtilities;
import javax.swing.UIManager;

public class QuestEditorMain {

  public static void main(String[] args) {
    try {
      UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName());
    } catch(Exception ignored) {
    }

    SwingUtilities.invokeLater(new Runnable() {
      @Override
      public void run() {
        QuestEditorFrame frame = new QuestEditorFrame();
        frame.setVisible(true);
      }
    });
  }
}

