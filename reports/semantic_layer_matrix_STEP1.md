# Semantic Layer Matrix — STEP1

## 扫描范围（仅以下 6 个文件）
- `src/unluac/semantic/QuestSemanticExtractor.java`
- `src/unluac/semantic/QuestSemanticModel.java`
- `src/unluac/semantic/Phase2LucDataExtractionSystem.java`
- `src/unluac/semantic/Phase3DatabaseWriter.java`
- `src/unluac/semantic/Phase4QuestLucExporter.java`
- `src/unluac/semantic/Phase4QuestExportValidator.java`

---

## 字段承载矩阵

| 字段 | Extractor 是否识别（证据） | Phase2 是否输出 JSON（证据） | Phase3 是否建表/落库（证据） | Phase4 是否读取并导出（证据） | Validator 是否校验（证据） | 是否存在键名漂移 |
|---|---|---|---|---|---|---|
| `goal.getItem` | 是：`CONDITION_KEYS.add("getItem")`（`QuestSemanticExtractor.java:69-74`）；`fillQuestGoalFromValue()`读取`getItem`（`QuestSemanticExtractor.java:1074-1077`） | 是：从`model.goal.items`写入`record.goal.getItem`（`Phase2LucDataExtractionSystem.java:260-269`）；JSON键为`"getItem"`（`Phase2LucDataExtractionSystem.java:1790,1797`） | 是：表`quest_goal_getitem`（`Phase3DatabaseWriter.java:178-186`）；解析`goal.get("getItem")`并入库（`Phase3DatabaseWriter.java:424-427,271,317-325`） | 是：读取`quest_goal_getitem`（`Phase4QuestLucExporter.java:144`）；导出`goal.getItem`（`Phase4QuestLucExporter.java:280-283`） | 是：校验`goal.getItem`（`Phase4QuestExportValidator.java:103`）；解析导出值`goal.get("getItem")`（`Phase4QuestExportValidator.java:290-292`） | 否 |
| `goal.killMonster` | 是：`CONDITION_KEYS.add("killMonster")`（`QuestSemanticExtractor.java:73`）；`fillQuestGoalFromValue()`读取`killMonster`（`QuestSemanticExtractor.java:1078-1080`） | 是：从`model.goal.monsters`写入`record.goal.killMonster`（`Phase2LucDataExtractionSystem.java:270-277`）；JSON键为`"killMonster"`（`Phase2LucDataExtractionSystem.java:1791,1798`） | 是：表`quest_goal_killmonster`（`Phase3DatabaseWriter.java:188-196`）；解析`goal.get("killMonster")`并入库（`Phase3DatabaseWriter.java:428-430,272,327-335`） | 是：读取`quest_goal_killmonster`（`Phase4QuestLucExporter.java:145`）；导出`goal.killMonster`（`Phase4QuestLucExporter.java:284-286`） | 是：校验`goal.killMonster`（`Phase4QuestExportValidator.java:104`）；解析导出值`goal.get("killMonster")`（`Phase4QuestExportValidator.java:290-293`） | 否 |
| `requstItem` | 是：`QUEST_KEYS/CONDITION_KEYS`包含`requstItem`（`QuestSemanticExtractor.java:52,71`）；解析并写入`conditions`，且并入`fillQuestItemRequirements(model.goal, requestItem)`（`QuestSemanticExtractor.java:799-803`） | 否（字段本名不输出）：Phase2输出对象仅含`goal/reward/needLevel/bQLoop`（`Phase2LucDataExtractionSystem.java:1246-1254`）；`QuestRecord`无`requstItem`字段（`Phase2LucDataExtractionSystem.java:1878-1886`） | 否（字段本名不落库）：DDL无`requstItem`列/表（`Phase3DatabaseWriter.java:142-215`）；仅写`goal/reward`结构（`Phase3DatabaseWriter.java:424-438`） | 否：导出结构无`requstItem`（`Phase4QuestLucExporter.java:266-302`）；`QuestRecord`无该字段（`Phase4QuestLucExporter.java:579-593`） | 否：比对字段不含`requstItem`（`Phase4QuestExportValidator.java:93-107`）；`QuestValue`无该字段（`Phase4QuestExportValidator.java:694-705`） | 是（语义并入`goal.getItem`） |
| `needItem` | 否：Extractor键集合无`needItem`（`QuestSemanticExtractor.java:41-75`） | 否：输出结构无`needItem`（`Phase2LucDataExtractionSystem.java:1246-1254`）；`QuestRecord`无该字段（`Phase2LucDataExtractionSystem.java:1878-1886`） | 否：DDL与写入逻辑无`needItem`（`Phase3DatabaseWriter.java:142-215,424-438`） | 否：读取与导出无`needItem`（`Phase4QuestLucExporter.java:118-148,266-302`） | 否：校验项无`needItem`（`Phase4QuestExportValidator.java:93-107,694-705`） | 是（字段丢失） |
| `reward.getItem` | 部分识别：`isKnownRewardFieldKey`包含`getItem`（`QuestSemanticExtractor.java:1041-1051`）；`rewardFromTable`无`getItem`专门分支，落入`extraFields`（`QuestSemanticExtractor.java:1424-1474`）；`REWARD_KEYS`无`getItem`（`QuestSemanticExtractor.java:59-67`） | 否（原键名不保留）：仅输出`reward.items`（`Phase2LucDataExtractionSystem.java:338-342,1845-1856`） | 否（原键名不保留）：表为`quest_reward_item`（`Phase3DatabaseWriter.java:207-215`），读取`reward.get("items")`（`Phase3DatabaseWriter.java:433-438`） | 否（原键名不保留）：导出`reward.items`（`Phase4QuestLucExporter.java:295-297`） | 否（按`reward.items`校验）：`comparePairList(...,"reward.items",...)`（`Phase4QuestExportValidator.java:106`）；解析`reward.get("items")`（`Phase4QuestExportValidator.java:295-298`） | 是（`getItem -> items`） |
| `reward.getSkill` | 是：`REWARD_KEYS.add("getSkill")`（`QuestSemanticExtractor.java:63`）；绑定采集`collectRewardSkillBindings`（`QuestSemanticExtractor.java:963-966,1487-1525`）；入模到`reward.skillIds`（`QuestSemanticExtractor.java:1464-1468`，`QuestSemanticModel.java:29`） | 否：`fillReward()`仅处理`exp/money/id/count`（`Phase2LucDataExtractionSystem.java:336-342`）；`RewardBlock`无技能字段（`Phase2LucDataExtractionSystem.java:1845-1857`） | 否：DDL/写入无技能字段（`Phase3DatabaseWriter.java:142-215,433-438`） | 否：读取/导出无技能字段（`Phase4QuestLucExporter.java:120-147,292-297,579-593`） | 否：校验项无技能字段（`Phase4QuestExportValidator.java:93-107,694-705`） | 是（字段丢失） |
| `reward.money` | 是：`REWARD_KEYS.add("money")`（`QuestSemanticExtractor.java:59`）；`reward.money`入模（`QuestSemanticExtractor.java:1424-1429`，`QuestSemanticModel.java:25`） | 是（但改名）：`record.reward.gold += reward.money`（`Phase2LucDataExtractionSystem.java:337`）；JSON输出键`"gold"`（`Phase2LucDataExtractionSystem.java:1847,1854`） | 是（但改名）：`quest_main.reward_gold`（`Phase3DatabaseWriter.java:147-149`）；解析`reward.get("gold")`（`Phase3DatabaseWriter.java:435`） | 是（但改名）：读`reward_gold`（`Phase4QuestLucExporter.java:120,135`）；导出键`gold`（`Phase4QuestLucExporter.java:294`） | 是（但按`gold`校验）：校验`reward.gold`（`Phase4QuestExportValidator.java:97,296-297`）；源端`rewardGold += reward.money`（`Phase4QuestExportValidator.java:194-196`） | 是（`money -> gold`） |
| `reward.exp` | 是：`REWARD_KEYS.add("exp")`（`QuestSemanticExtractor.java:60`）；`reward.exp`入模（`QuestSemanticExtractor.java:1454-1459`，`QuestSemanticModel.java:26`） | 是：`record.reward.exp += reward.exp`（`Phase2LucDataExtractionSystem.java:336`）；JSON键`"exp"`（`Phase2LucDataExtractionSystem.java:1846,1853`） | 是：`quest_main.reward_exp`（`Phase3DatabaseWriter.java:147,267`）；解析`reward.get("exp")`（`Phase3DatabaseWriter.java:434`） | 是：读`reward_exp`（`Phase4QuestLucExporter.java:120,134`）；导出`exp`（`Phase4QuestLucExporter.java:293`） | 是：校验`reward.exp`（`Phase4QuestExportValidator.java:96`）；解析`reward.get("exp")`（`Phase4QuestExportValidator.java:296`） | 否 |
| `reward.fame` | 是：`REWARD_KEYS.add("fame")`（`QuestSemanticExtractor.java:61`）；`reward.fame`入模（`QuestSemanticExtractor.java:1434-1439`，`QuestSemanticModel.java:27`） | 否：`fillReward()`未处理`fame`（`Phase2LucDataExtractionSystem.java:336-342`）；`RewardBlock`仅`exp/gold/items`（`Phase2LucDataExtractionSystem.java:1845-1857`） | 否：DDL无`reward_fame`（`Phase3DatabaseWriter.java:142-149`）；落库仅`exp/gold/items`（`Phase3DatabaseWriter.java:433-438`） | 否：读取/导出无`fame`（`Phase4QuestLucExporter.java:120-147,292-297,579-593`） | 否：比较项无`fame`（`Phase4QuestExportValidator.java:93-107`） | 是（字段丢失） |
| `reward.pvppoint` | 是：`REWARD_KEYS.add("pvppoint")`（`QuestSemanticExtractor.java:62`）；`reward.pvppoint`入模（`QuestSemanticExtractor.java:1444-1449`，`QuestSemanticModel.java:28`） | 否：Phase2未处理`pvppoint`（`Phase2LucDataExtractionSystem.java:336-342,1845-1857`） | 否：Phase3无`pvppoint`列/落库（`Phase3DatabaseWriter.java:142-215,433-438`） | 否：Phase4无`pvppoint`读取/导出（`Phase4QuestLucExporter.java:120-147,292-297`） | 否：Validator无`pvppoint`比较（`Phase4QuestExportValidator.java:93-107`） | 是（字段丢失） |
| `reward.mileage` | 部分识别（无显式建模）：`REWARD_KEYS`不含`mileage`（`QuestSemanticExtractor.java:59-67`）；`rewardFromTable`要求先命中`REWARD_KEYS`才建`Reward`（`QuestSemanticExtractor.java:1382-1390`）；未知键仅走`extraFields`（`QuestSemanticExtractor.java:1473`） | 否：Phase2未处理`mileage`（`Phase2LucDataExtractionSystem.java:336-342,1845-1857`） | 否：Phase3无`mileage`结构（`Phase3DatabaseWriter.java:142-215,433-438`） | 否：Phase4无`mileage`读取/导出（`Phase4QuestLucExporter.java:120-147,292-297`） | 否：Validator无`mileage`比较（`Phase4QuestExportValidator.java:93-107`） | 是（字段丢失） |

---

## 结论标记（仅事实）

1. 条件字段中，`goal.getItem`、`goal.killMonster`为全链路承载；`requstItem`仅在 Extractor 识别并被并入`goal.getItem`；`needItem`全链路缺失。  
2. 奖励字段中，`reward.exp`为全链路承载；`reward.money`存在系统性键名漂移（`money -> gold`）；`reward.getItem`存在系统性键名漂移（`getItem -> items`）。  
3. `reward.getSkill`、`reward.fame`、`reward.pvppoint`、`reward.mileage`未形成 Phase2~Phase4~Validator 的完整承载闭环。  

---

## 完整性自检

- 字段集合已逐项覆盖：`goal.getItem`、`goal.killMonster`、`requstItem`、`needItem`、`reward.getItem`、`reward.getSkill`、`reward.money`、`reward.exp`、`reward.fame`、`reward.pvppoint`、`reward.mileage`。  
- 每项判断均附源码行号证据。  
- 本次仅生成分析文档，未修改业务代码。  

