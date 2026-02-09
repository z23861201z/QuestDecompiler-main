package unluac.editor;

public class DialogLine {

  public static final String TYPE_TEXT = "TEXT";
  public static final String TYPE_ANSWER = "ANSWER";
  public static final String BRANCH_YES = "YES";
  public static final String BRANCH_NO = "NO";
  public static final String BRANCH_IF_NO = "IF_NO";
  public static final String BRANCH_LAST_INFO = "LAST_INFO";
  public static final String BRANCH_LAST_ANSWER_PREFIX = "LAST_ANSWER_";

  public String type = TYPE_TEXT;
  public String branch = "";
  public String text = "";

  public DialogLine copy() {
    DialogLine out = new DialogLine();
    out.type = this.type;
    out.branch = this.branch;
    out.text = this.text;
    return out;
  }
}
