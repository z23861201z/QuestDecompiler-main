import java.nio.charset.StandardCharsets;
import java.nio.file.*;
import java.util.regex.*;

public class CheckDialogTreeJson {
  public static void main(String[] args) throws Exception {
    String s = new String(Files.readAllBytes(Paths.get(args[0])), StandardCharsets.UTF_8);
    int total = 0;
    int nonEmptyTree = 0;
    int hasOption = 0;

    Pattern questPattern = Pattern.compile("\\{\\s*\\\"questId\\\"\\s*:\\s*(\\d+)", Pattern.DOTALL);
    Matcher qm = questPattern.matcher(s);
    int[] starts = new int[5000];
    int[] qids = new int[5000];
    int idx=0;
    while(qm.find()) {
      starts[idx] = qm.start();
      qids[idx] = Integer.parseInt(qm.group(1));
      idx++;
      if(idx >= starts.length) break;
    }

    for(int i=0;i<idx;i++) {
      int from = starts[i];
      int to = (i+1<idx) ? starts[i+1] : s.length();
      String block = s.substring(from, to);
      total++;

      boolean textNotEmpty = block.matches("(?s).*\\\"text\\\"\\s*:\\s*\\\"(?!\\\").+?\\\".*");
      boolean optionNotEmpty = block.matches("(?s).*\\\"optionText\\\"\\s*:\\s*\\\"(?!\\\").+?\\\".*");
      if(textNotEmpty || optionNotEmpty) {
        nonEmptyTree++;
      }
      if(optionNotEmpty) {
        hasOption++;
      }
    }

    System.out.println("quest_total=" + total);
    System.out.println("dialog_tree_non_empty=" + nonEmptyTree);
    System.out.println("dialog_tree_with_option=" + hasOption);
  }
}
