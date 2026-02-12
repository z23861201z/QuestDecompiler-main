# Phase2/3/4 + Extractor 字段补全改动记录（2026-02-12）

## 1. 目标与范围
- 目标：补全 Quest 主链路在 `reward/conditions` 维度的语义缺失，避免 `DB -> Lua/LUC` 导出时丢字段。
- 范围：`QuestSemanticExtractor`、`Phase2LucDataExtractionSystem`、`Phase3DatabaseWriter`、`Phase3DbConsistencyValidator`、`Phase4QuestLucExporter`、`Phase4QuestExportValidator`。
- 非目标：不改 NPC 导出逻辑，不改 Phase5，不做结构重写。

## 2. 代码改动记录（逐文件）

### 2.1 `src/unluac/semantic/QuestSemanticExtractor.java`
- 新增识别字段：
  - `needItem`
  - `deleteItem`
- 改动点：
  - 将 `needItem/deleteItem` 纳入 `QUEST_KEYS` 与 `CONDITION_KEYS`。
  - 在建模阶段把 `needItem/deleteItem` 写入 `model.conditions`。
- 目的：
  - 修复 Extractor 层面对条件字段抽取不完整的问题。

### 2.2 `src/unluac/semantic/Phase2LucDataExtractionSystem.java`
- 新增输出字段：
  - `conditions`（完整条件对象）
  - `goal.extra`
  - `reward.fame`
  - `reward.pvppoint`
  - `reward.mileage`
  - `reward.skills`
  - `reward.extra`
- 改动点：
  - `extractQuestData(...)` 调用 `fillConditions(...)`。
  - `fillReward(...)` 累加并输出扩展奖励字段。
  - `writeQuestReport(...)` 写出 `conditions`。
- 目的：
  - 修复 Phase2 报告仅输出 `reward.exp/gold/items` 的结构损失。

### 2.3 `src/unluac/semantic/Phase3DatabaseWriter.java`
- Schema 增量补全：
  - `quest_main` 新增列：
    - `reward_fame`
    - `reward_pvppoint`
    - `reward_mileage`
    - `reward_extra_json`
    - `goal_extra_json`
    - `conditions_json`
  - 新增表：
    - `quest_reward_skill(quest_id, seq_index, skill_id, ...)`
- 兼容逻辑：
  - `createSchema(...)` 中通过 `ensureColumnExists(...)` 进行增量补列（兼容旧库）。
- 写入逻辑：
  - `insertQuestData(...)` 增加扩展列写入与 `quest_reward_skill` 批量写入。
- 统计补充：
  - 新增 `totalRewardSkillRows`。

### 2.4 `src/unluac/semantic/Phase3DbConsistencyValidator.java`
- 对比项补全：
  - `rewardFame/rewardPvppoint/rewardMileage`
  - `reward.skills`
  - `conditions`
  - `goal.extra`
  - `reward.extra`
- DB 回读补全：
  - 从 `quest_main` 读取新增 JSON 列；
  - 从 `quest_reward_skill` 读取技能奖励顺序。
- 目的：
  - 修复 Phase3 只验证“旧子集字段”的问题。

### 2.5 `src/unluac/semantic/Phase4QuestLucExporter.java`
- DB 读取补全：
  - `quest_main` 扩展列
  - `quest_reward_skill`
- 导出补全：
  - `reward` 下输出：
    - `fame`
    - `pvppoint`
    - `mileage`
    - `getSkill`
  - 顶层输出 `conditions` 对应字段（如 `needQuest/requstItem/needItem/deleteItem`）。
  - `goal.extra` 的扩展字段输出。
- 目的：
  - 保证 DB 数据可恢复到扩展字段语义。

### 2.6 `src/unluac/semantic/Phase4QuestExportValidator.java`
- 校验项补全：
  - `reward.fame/reward.pvppoint/reward.mileage/reward.getSkill`
  - `conditions`
  - `goal.extra`
- 目的：
  - 修复 “SAFE 但只覆盖旧字段子集” 的误判问题。

## 3. SQL 迁移脚本（增量）
- 主脚本：`documentation/sql/phase2_4_field_completion_migration.sql`
- 回滚脚本：`documentation/sql/phase2_4_field_completion_rollback.sql`

> 说明：代码内 `Phase3DatabaseWriter.createSchema(...)` 已内置幂等增量逻辑，SQL 文件用于手工预迁移或审计留档。

## 4. 实际执行命令记录

```bash
javac -encoding UTF-8 -d build -cp build -sourcepath src \
  src/unluac/semantic/QuestSemanticExtractor.java \
  src/unluac/semantic/Phase2LucDataExtractionSystem.java \
  src/unluac/semantic/Phase3DatabaseWriter.java \
  src/unluac/semantic/Phase3DbConsistencyValidator.java \
  src/unluac/semantic/Phase4QuestLucExporter.java \
  src/unluac/semantic/Phase4QuestExportValidator.java

java -cp build unluac.semantic.Phase2LucDataExtractionSystem \
  "D:/TitanGames/GhostOnline/zChina/Script/quest.luc" \
  "D:/TitanGames/GhostOnline/zChina/Script/npc-lua-generated" \
  "reports/phase2_quest_data.json" \
  "reports/phase2_npc_reference_index.json" \
  "reports/phase2_scan_summary.json"

java -cp build unluac.semantic.Phase25QuestNpcDependencyMapper \
  "reports/phase2_quest_data.json" \
  "reports/phase2_npc_reference_index.json" \
  "reports/phase2_5_quest_npc_dependency_graph.json" \
  "reports/phase2_5_dependency_summary.json"

java -cp "build;lib/mysql-connector-j-8.4.0.jar" unluac.semantic.Phase3DatabaseWriter \
  "reports/phase2_quest_data.json" \
  "reports/phase2_5_quest_npc_dependency_graph.json" \
  "reports/phase3_db_insert_summary.json" \
  "jdbc:mysql://127.0.0.1:3306/ghost_game?useUnicode=true&characterEncoding=utf8&serverTimezone=Asia/Shanghai&useSSL=false&allowPublicKeyRetrieval=true" \
  "root" "root"

java -cp "build;lib/mysql-connector-j-8.4.0.jar" unluac.semantic.Phase3DbConsistencyValidator \
  "reports/phase2_quest_data.json" \
  "reports/phase3_db_roundtrip_validation.json" \
  "jdbc:mysql://127.0.0.1:3306/ghost_game?useUnicode=true&characterEncoding=utf8&serverTimezone=Asia/Shanghai&useSSL=false&allowPublicKeyRetrieval=true" \
  "root" "root"

java -cp "build;lib/mysql-connector-j-8.4.0.jar" unluac.semantic.Phase4QuestLucExporter \
  "reports/phase4_exported_quest.lua" \
  "jdbc:mysql://127.0.0.1:3306/ghost_game?useUnicode=true&characterEncoding=utf8&serverTimezone=Asia/Shanghai&useSSL=false&allowPublicKeyRetrieval=true" \
  "root" "root"

java -cp build unluac.semantic.Phase4QuestExportValidator \
  "D:/TitanGames/GhostOnline/zChina/Script/quest.luc" \
  "reports/phase4_exported_quest.lua" \
  "reports/phase4_export_validation.json"
```

## 5. 验证结果记录
- `reports/phase2_scan_summary.json`：
  - `totalNpcFilesScanned = 468`
  - `missingFiles = []`
  - `parsingErrors = []`
- `reports/phase3_db_insert_summary.json`：
  - `totalRewardSkillRows = 273`
- `reports/phase3_db_roundtrip_validation.json`：
  - `mismatchCount = 0`
  - `finalStatus = SAFE`
- `reports/phase4_export_validation.json`：
  - `mismatchCount = 0`
  - `finalStatus = SAFE`

## 6. 风险与回滚点（提交说明必带）
- 风险级别：高（触及核心链路 Phase2/3/4 + Extractor）。
- 回滚点：
  1. 代码回滚到本次改动前版本；
  2. 执行 `documentation/sql/phase2_4_field_completion_rollback.sql`；
  3. 重新跑 `Phase2 -> Phase3 -> Phase4` 验证。
