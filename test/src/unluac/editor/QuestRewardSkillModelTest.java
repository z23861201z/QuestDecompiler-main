package unluac.editor;

import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.List;

import unluac.semantic.QuestSemanticCsvTool;
import unluac.semantic.QuestSemanticPatchApplier;

public class QuestRewardSkillModelTest {

  public static void main(String[] args) throws Exception {
    testRewardRoundTripInService();
    testPatchFieldMappingForRewardSkillIds();
    System.out.println("QuestRewardSkillModelTest passed");
  }

  private static void testRewardRoundTripInService() {
    QuestEditorModel model = new QuestEditorModel();
    model.questId = 2019;
    model.dirty = true;
    model.stage = new QuestStageModel();

    model.stage.reward.exp = 123;
    model.stage.reward.fame = 5;
    model.stage.reward.money = 88;
    model.stage.reward.pvppoint = 9;
    model.stage.reward.skillIds.add(Integer.valueOf(10601));
    model.stage.reward.skillIds.add(Integer.valueOf(10602));

    List<Integer> ids = new ArrayList<Integer>();
    ids.add(Integer.valueOf(8881041));
    ids.add(Integer.valueOf(8881042));
    List<Integer> counts = new ArrayList<Integer>();
    counts.add(Integer.valueOf(100));
    counts.add(Integer.valueOf(1));
    model.stage.reward.loadItemsFromLists(ids, counts);

    model.rewardItemIdJson = "[]";
    model.rewardItemCountJson = "[]";
    model.rewardSkillIdsJson = "[]";
    model.conditionJson = "{}";

    QuestEditorService service = new QuestEditorService();
    service.markDirty(model);

    // call private method: applyStageBackToLegacyFields
    invokePrivate(service, "applyStageBackToLegacyFields", new Class<?>[] { QuestEditorModel.class }, new Object[] { model });

    assertEquals(123, model.rewardExp, "rewardExp");
    assertEquals(5, model.rewardFame, "rewardFame");
    assertEquals(88, model.rewardMoney, "rewardMoney");
    assertEquals(9, model.rewardPvppoint, "rewardPvppoint");
    assertEquals("[8881041,8881042]", model.rewardItemIdJson, "rewardItemIdJson");
    assertEquals("[100,1]", model.rewardItemCountJson, "rewardItemCountJson");
    assertEquals("[10601,10602]", model.rewardSkillIdsJson, "rewardSkillIdsJson");
    assertEquals("{}", model.rewardExtraFieldsJson, "rewardExtraFieldsJson");
    assertTrue(model.rewardFieldOrderJson != null && model.rewardFieldOrderJson.contains("exp"), "rewardFieldOrderJson");
    assertTrue(model.conditionJson.contains("\"reward_fame\":5"), "condition reward_fame");
    assertTrue(model.conditionJson.contains("\"reward_money\":88"), "condition reward_money");
    assertTrue(model.conditionJson.contains("\"reward_pvppoint\":9"), "condition reward_pvppoint");
  }

  private static void testPatchFieldMappingForRewardSkillIds() throws Exception {
    QuestSemanticCsvTool.CsvQuestRow row = new QuestSemanticCsvTool.CsvQuestRow();
    row.rewardSkillIds.add(Integer.valueOf(10601));
    row.rewardSkillIds.add(Integer.valueOf(10602));

    Method method = QuestSemanticPatchApplier.class.getDeclaredMethod(
        "pickNumericFieldUpdate",
        String.class,
        QuestSemanticCsvTool.CsvQuestRow.class);
    method.setAccessible(true);

    Double first = (Double) method.invoke(null, "reward_skill_ids[0]", row);
    Double second = (Double) method.invoke(null, "reward_skill_ids[1]", row);
    Double missing = (Double) method.invoke(null, "reward_skill_ids[2]", row);

    assertEquals(Double.valueOf(10601D), first, "reward_skill_ids[0]");
    assertEquals(Double.valueOf(10602D), second, "reward_skill_ids[1]");
    assertEquals(null, missing, "reward_skill_ids[2]");
  }

  private static Object invokePrivate(Object target, String methodName, Class<?>[] types, Object[] args) {
    try {
      Method m = target.getClass().getDeclaredMethod(methodName, types);
      m.setAccessible(true);
      return m.invoke(target, args);
    } catch(Exception ex) {
      throw new IllegalStateException(ex);
    }
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
