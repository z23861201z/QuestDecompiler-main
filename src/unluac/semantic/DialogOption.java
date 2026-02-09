package unluac.semantic;

public class DialogOption {

  public String optionText;
  public int nextNodeIndex;

  public DialogOption() {
    this.optionText = "";
    this.nextNodeIndex = -1;
  }

  public DialogOption copy() {
    DialogOption out = new DialogOption();
    out.optionText = this.optionText;
    out.nextNodeIndex = this.nextNodeIndex;
    return out;
  }
}

