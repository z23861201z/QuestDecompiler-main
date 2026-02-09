package unluac.editor;

import java.lang.reflect.Method;
import java.util.List;

import unluac.semantic.QuestSemanticJson;

public class QuestDialogAnswerBranchTest {

  public static void main(String[] args) throws Exception {
    testJsonValidatorRequiresAnswerBranch();
    testJsonValidatorAcceptsIfNo();
    testJsonValidatorAcceptsLastBranchesForText();
    testPrettyJsonRoundTrip();
    testAstParseAnswerBranch();
    testAstGenerateAnswerBranch();
    testAstGenerateTextLastBranches();
    testApplyDialogJsonModelRoundTrip();
    System.out.println("QuestDialogAnswerBranchTest passed");
  }

  private static void testJsonValidatorRequiresAnswerBranch() {
    String invalid = "{\"start\":[{\"type\":\"ANSWER\",\"text\":\"x\"}],\"progress\":[],\"complete\":[]}";
    boolean failed = false;
    try {
      QuestDialogJsonValidator.parseAndValidate(invalid);
    } catch(IllegalStateException expected) {
      failed = true;
    }
    assertTrue(failed, "missing ANSWER branch must fail");
  }

  private static void testJsonValidatorAcceptsIfNo() {
    String json = "{"
        + "\"start\":[{\"type\":\"ANSWER\",\"branch\":\"IF_NO\",\"text\":\"if no\"}],"
        + "\"progress\":[],"
        + "\"complete\":[]"
        + "}";
    QuestDialogJsonModel model = QuestDialogJsonValidator.parseAndValidate(json);
    assertEquals(1, model.start.size(), "if_no size");
    assertEquals(DialogLine.BRANCH_IF_NO, model.start.get(0).branch, "if_no branch");
  }

  private static void testJsonValidatorAcceptsLastBranchesForText() {
    String json = "{"
        + "\"start\":["
        + "{\"type\":\"TEXT\",\"branch\":\"LAST_ANSWER_1\",\"text\":\"accept\"},"
        + "{\"type\":\"TEXT\",\"branch\":\"LAST_INFO\",\"text\":\"progress\"}"
        + "],"
        + "\"progress\":[],"
        + "\"complete\":[]"
        + "}";
    QuestDialogJsonModel model = QuestDialogJsonValidator.parseAndValidate(json);
    assertEquals(2, model.start.size(), "start size");
    assertEquals("LAST_ANSWER_1", model.start.get(0).branch, "last answer branch");
    assertEquals("LAST_INFO", model.start.get(1).branch, "last info branch");
  }

  private static void testPrettyJsonRoundTrip() {
    QuestDialogJsonModel model = new QuestDialogJsonModel();
    DialogLine line = new DialogLine();
    line.type = DialogLine.TYPE_TEXT;
    line.text = "line";
    model.start.add(line);

    String pretty = QuestDialogJsonValidator.toJson(model);
    assertTrue(pretty.contains("\n"), "pretty json should contain line breaks");

    QuestDialogJsonModel parsed = QuestDialogJsonValidator.parseAndValidate(pretty);
    assertEquals(1, parsed.start.size(), "pretty parse start size");
    assertEquals("line", parsed.start.get(0).text, "pretty parse text");
  }

  private static void testAstParseAnswerBranch() throws Exception {
    QuestEditorService service = new QuestEditorService();
    Method toDialogLine = QuestEditorService.class.getDeclaredMethod("toDialogLine", String.class, int.class);
    toDialogLine.setAccessible(true);

    DialogLine yes = (DialogLine) toDialogLine.invoke(service, "ANSWER_YES:accept", Integer.valueOf(0));
    assertEquals(DialogLine.TYPE_ANSWER, yes.type, "yes type");
    assertEquals(DialogLine.BRANCH_YES, yes.branch, "yes branch");
    assertEquals("accept", yes.text, "yes text");

    DialogLine no = (DialogLine) toDialogLine.invoke(service, "ANSWER_NO:decline", Integer.valueOf(1));
    assertEquals(DialogLine.TYPE_ANSWER, no.type, "no type");
    assertEquals(DialogLine.BRANCH_NO, no.branch, "no branch");
    assertEquals("decline", no.text, "no text");

    DialogLine ifNo = (DialogLine) toDialogLine.invoke(service, "ANSWER_IF_NO:deny", Integer.valueOf(2));
    assertEquals(DialogLine.TYPE_ANSWER, ifNo.type, "if_no type");
    assertEquals(DialogLine.BRANCH_IF_NO, ifNo.branch, "if_no branch");
    assertEquals("deny", ifNo.text, "if_no text");
  }

  private static void testAstGenerateAnswerBranch() throws Exception {
    QuestEditorService service = new QuestEditorService();
    Method toAstLine = QuestEditorService.class.getDeclaredMethod("toAstLine", DialogLine.class);
    toAstLine.setAccessible(true);

    DialogLine yes = new DialogLine();
    yes.type = DialogLine.TYPE_ANSWER;
    yes.branch = DialogLine.BRANCH_YES;
    yes.text = "go";
    String yesLine = (String) toAstLine.invoke(service, yes);
    assertEquals("ANSWER_YES:go", yesLine, "generate yes line");

    DialogLine no = new DialogLine();
    no.type = DialogLine.TYPE_ANSWER;
    no.branch = DialogLine.BRANCH_NO;
    no.text = "stop";
    String noLine = (String) toAstLine.invoke(service, no);
    assertEquals("ANSWER_NO:stop", noLine, "generate no line");

    DialogLine ifNo = new DialogLine();
    ifNo.type = DialogLine.TYPE_ANSWER;
    ifNo.branch = DialogLine.BRANCH_IF_NO;
    ifNo.text = "reject";
    String ifNoLine = (String) toAstLine.invoke(service, ifNo);
    assertEquals("ANSWER_IF_NO:reject", ifNoLine, "generate if_no line");
  }

  private static void testAstGenerateTextLastBranches() throws Exception {
    QuestEditorService service = new QuestEditorService();
    Method toAstLine = QuestEditorService.class.getDeclaredMethod("toAstLine", DialogLine.class);
    toAstLine.setAccessible(true);

    DialogLine lastAnswer = new DialogLine();
    lastAnswer.type = DialogLine.TYPE_TEXT;
    lastAnswer.branch = DialogLine.BRANCH_LAST_ANSWER_PREFIX + "1";
    lastAnswer.text = "tail answer";
    String answerText = (String) toAstLine.invoke(service, lastAnswer);
    assertEquals("tail answer", answerText, "text LAST_ANSWER emits plain text");

    DialogLine lastInfo = new DialogLine();
    lastInfo.type = DialogLine.TYPE_TEXT;
    lastInfo.branch = DialogLine.BRANCH_LAST_INFO;
    lastInfo.text = "tail info";
    String infoText = (String) toAstLine.invoke(service, lastInfo);
    assertEquals("tail info", infoText, "text LAST_INFO emits plain text");
  }

  private static void testApplyDialogJsonModelRoundTrip() throws Exception {
    QuestEditorService service = new QuestEditorService();
    QuestEditorModel row = new QuestEditorModel();
    row.stage = new QuestStageModel();

    String json = "{"
        + "\"start\":["
        + "{\"type\":\"TEXT\",\"text\":\"你好\"},"
        + "{\"type\":\"ANSWER\",\"branch\":\"YES\",\"text\":\"接受\"},"
        + "{\"type\":\"ANSWER\",\"branch\":\"NO\",\"text\":\"拒绝\"},"
        + "{\"type\":\"ANSWER\",\"branch\":\"IF_NO\",\"text\":\"否定分支\"},"
        + "{\"type\":\"TEXT\",\"branch\":\"LAST_ANSWER_1\",\"text\":\"好的。我去做。\"},"
        + "{\"type\":\"TEXT\",\"branch\":\"LAST_INFO\",\"text\":\"进行中提示\"}"
        + "],"
        + "\"progress\":[],"
        + "\"complete\":[]"
        + "}";

    QuestDialogJsonModel model = QuestDialogJsonValidator.parseAndValidate(json);
    service.applyDialogJsonModel(row, model);

    List<String> lines = QuestSemanticJson.parseStringArray(row.dialogLinesJson, "dialogLinesJson", 0);
    assertEquals(6, lines.size(), "line count");
    assertEquals("你好", lines.get(0), "line[0]");
    assertEquals("ANSWER_YES:接受", lines.get(1), "line[1]");
    assertEquals("ANSWER_NO:拒绝", lines.get(2), "line[2]");
    assertEquals("ANSWER_IF_NO:否定分支", lines.get(3), "line[3]");
    assertEquals("好的。我去做。", lines.get(4), "line[4]");
    assertEquals("进行中提示", lines.get(5), "line[5]");

    QuestDialogJsonModel parsedReload = QuestDialogJsonValidator.parseAndValidate(
        QuestDialogJsonValidator.toJson(model));
    assertEquals(DialogLine.BRANCH_IF_NO, parsedReload.start.get(3).branch, "reload branch keep IF_NO");
  }

  private static void assertTrue(boolean condition, String label) {
    if(!condition) {
      throw new IllegalStateException("assertTrue failed: " + label);
    }
  }

  private static void assertEquals(Object expected, Object actual, String label) {
    if(expected == null && actual == null) {
      return;
    }
    if(expected != null && expected.equals(actual)) {
      return;
    }
    throw new IllegalStateException("assertEquals failed: " + label + " expected=" + expected + " actual=" + actual);
  }
}
