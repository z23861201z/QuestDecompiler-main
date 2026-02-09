package unluac.semantic;

import java.util.ArrayList;
import java.util.List;

public class DialogNode {

  public String text;
  public final List<DialogOption> options = new ArrayList<DialogOption>();
  public final List<DialogNode> next = new ArrayList<DialogNode>();

  public DialogNode() {
    this.text = "";
  }

  public DialogNode copyShallowWithoutNext() {
    DialogNode out = new DialogNode();
    out.text = this.text;
    for(DialogOption option : this.options) {
      out.options.add(option == null ? null : option.copy());
    }
    return out;
  }
}

