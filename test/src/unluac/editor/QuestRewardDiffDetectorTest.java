package unluac.editor;

public class QuestRewardDiffDetectorTest {

  public static void main(String[] args) {
    testDetectChanges();
    testNoChanges();
    System.out.println("QuestRewardDiffDetectorTest passed");
  }

  private static void testDetectChanges() {
    QuestReward before = new QuestReward();
    before.exp = 100;
    before.fame = 1;
    before.fieldOrder.add("exp");
    before.fieldOrder.add("fame");
    before.extraFields.put("bonus", Integer.valueOf(1));

    QuestReward after = before.copy();
    after.exp = 200;
    after.fame = 2;
    after.fieldOrder.add("money");
    after.extraFields.put("bonus", Integer.valueOf(2));

    QuestRewardDiffDetector detector = new QuestRewardDiffDetector();
    QuestRewardDiffDetector.QuestRewardDiffReport report = detector.detect(before, after);
    assertTrue(report.hasChanges(), "must detect reward changes");
    assertTrue(report.toText().contains("exp"), "contains exp change");
    assertTrue(report.toText().contains("extraFields"), "contains extraFields change");
  }

  private static void testNoChanges() {
    QuestReward reward = new QuestReward();
    reward.exp = 10;
    reward.fieldOrder.add("exp");

    QuestRewardDiffDetector detector = new QuestRewardDiffDetector();
    QuestRewardDiffDetector.QuestRewardDiffReport report = detector.detect(reward, reward.copy());
    assertTrue(!report.hasChanges(), "copy should be equal");
  }

  private static void assertTrue(boolean condition, String label) {
    if(!condition) {
      throw new IllegalStateException("assertTrue failed: " + label);
    }
  }
}

