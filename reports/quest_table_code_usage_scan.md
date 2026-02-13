# Quest/NPC Table Code Usage Scan

- Scan roots: src/, resources/
- Files scanned: 270
- SQL-like references found: 86
- @Entity/@Table hits: 0
- MyBatis/XML/jdbcTemplate hits: 6
- resources/ 目录状态：未发现（本次扫描实际覆盖 src/ 全量文件）。

## Entity / ORM 结果
- 未发现 @Entity 或 @Table(...) 注解映射。

## MyBatis 结果
- 未发现 MyBatis XML Mapper（<select>/<insert>/<update>/<delete>）。

## 表级汇总

| 表名 | 引用次数 | 涉及类数 | 操作类型 |
|---|---:|---:|---|
| <dynamic:table> | 10 | 3 | 动态SQL |
| npc_dialogue_text | 2 | 1 | 删除 / 写入 |
| npc_quest_reference | 7 | 5 | 写入 / 读取 |
| npc_text_edit_map | 9 | 5 | 读取 / DDL / 更新 |
| quest_answer | 2 | 2 | 写入 / 读取 |
| quest_contents | 6 | 5 | 写入 / 读取 / 更新 |
| quest_goal_getitem | 4 | 4 | 写入 / 读取 |
| quest_goal_killmonster | 3 | 3 | 写入 / 读取 |
| quest_goal_meetnpc | 3 | 3 | 写入 / 读取 |
| quest_info | 2 | 2 | 写入 / 读取 |
| quest_main | 22 | 10 | DDL / 写入 / 读取 / 更新 |
| quest_requst_item | 2 | 2 | 写入 / 读取 |
| quest_reward_item | 12 | 7 | 写入 / 读取 / 更新 |
| quest_reward_skill | 2 | 2 | 写入 / 读取 |

## 逐表证据（类 / 方法 / 操作）

### <dynamic:table>

| 文件 | 类 | 方法 | 操作类型 | 行号 | 证据片段 |
|---|---|---|---|---:|---|
| src\unluac\semantic\Phase3DbConsistencyValidator.java | Phase3DbConsistencyValidator | loadStringArray | 动态SQL | 176 | FROM " + table |
| src\unluac\semantic\Phase3DbConsistencyValidator.java | Phase3DbConsistencyValidator | loadPairArray | 动态SQL | 208 | FROM " + table |
| src\unluac\semantic\Phase3DbConsistencyValidator.java | Phase3DbConsistencyValidator | loadIntArray | 动态SQL | 241 | FROM " + table |
| src\unluac\semantic\Phase4QuestLucExporter.java | Phase4QuestLucExporter | loadStringArray | 动态SQL | 216 | FROM " + table |
| src\unluac\semantic\Phase4QuestLucExporter.java | Phase4QuestLucExporter | loadPairArray | 动态SQL | 247 | FROM " + table |
| src\unluac\semantic\Phase4QuestLucExporter.java | Phase4QuestLucExporter | loadIntArray | 动态SQL | 281 | FROM " + table |
| src\unluac\web\service\AdminQuestService.java | AdminQuestService | replaceTextArray | 动态SQL | 168 | DELETE FROM " + table |
| src\unluac\web\service\AdminQuestService.java | AdminQuestService | replaceTextArray | 动态SQL | 175 | INSERT INTO " + table |
| src\unluac\web\service\AdminQuestService.java | AdminQuestService | replaceTextArray | 动态SQL | 178 | INSERT INTO " + table |
| src\unluac\web\service\AdminQuestService.java | AdminQuestService | loadTextArray | 动态SQL | 199 | FROM " + table |

### npc_dialogue_text

| 文件 | 类 | 方法 | 操作类型 | 行号 | 证据片段 |
|---|---|---|---|---:|---|
| src\unluac\semantic\Phase7ANpcTextExtractionSystem.java | Phase7ANpcTextExtractionSystem | upsertIntoDatabase | 删除 | 573 | DELETE FROM npc_dialogue_text |
| src\unluac\semantic\Phase7ANpcTextExtractionSystem.java | Phase7ANpcTextExtractionSystem | upsertIntoDatabase | 写入 | 576 | INSERT INTO npc_dialogue_text |

### npc_quest_reference

| 文件 | 类 | 方法 | 操作类型 | 行号 | 证据片段 |
|---|---|---|---|---:|---|
| src\unluac\semantic\Phase3DatabaseWriter.java | Phase3DatabaseWriter | insertNpcReferences | 写入 | 460 | INSERT INTO npc_quest_reference |
| src\unluac\semantic\Phase5NpcLucExporter.java | Phase5NpcLucExporter | loadDbSnapshot | 读取 | 202 | FROM npc_quest_reference |
| src\unluac\semantic\Phase6CDbDrivenExportValidator.java | Phase6CDbDrivenExportValidator | queryNpcFilesByQuestId | 读取 | 163 | FROM npc_quest_reference |
| src\unluac\web\controller\AdminController.java | AdminController | dashboard | 读取 | 59 | FROM npc_quest_reference |
| src\unluac\web\service\AdminNpcTextService.java | AdminNpcTextService | list | 读取 | 41 | FROM npc_quest_reference |
| src\unluac\web\service\AdminNpcTextService.java | AdminNpcTextService | list | 读取 | 45 | FROM npc_quest_reference |
| src\unluac\web\service\AdminNpcTextService.java | AdminNpcTextService | count | 读取 | 110 | FROM npc_quest_reference |

### npc_text_edit_map

| 文件 | 类 | 方法 | 操作类型 | 行号 | 证据片段 |
|---|---|---|---|---:|---|
| src\unluac\semantic\Phase7NpcLucBinaryExporter.java | Phase7NpcLucBinaryExporter | loadMutations | 读取 | 204 | FROM npc_text_edit_map |
| src\unluac\web\controller\AdminController.java | AdminController | dashboard | 读取 | 57 | FROM npc_text_edit_map |
| src\unluac\web\service\AdminNpcTextService.java | AdminNpcTextService | list | 读取 | 40 | FROM npc_text_edit_map |
| src\unluac\web\service\AdminNpcTextService.java | AdminNpcTextService | save | 更新 | 93 | UPDATE npc_text_edit_map |
| src\unluac\web\service\AdminNpcTextService.java | AdminNpcTextService | count | 读取 | 107 | FROM npc_text_edit_map |
| src\unluac\web\service\AdminNpcTextService.java | AdminNpcTextService | ensureUpdatedAtColumn | DDL | 139 | ALTER TABLE npc_text_edit_map |
| src\unluac\web\service\PhaseDOrchestrationService.java | PhaseDOrchestrationService | checkDbChanged | 读取 | 98 | FROM npc_text_edit_map |
| src\unluac\web\service\PhaseDOrchestrationService.java | PhaseDOrchestrationService | pickNpcSample | 读取 | 192 | FROM npc_text_edit_map |
| src\unluac\web\support\AdminRecentModifiedService.java | AdminRecentModifiedService | findNpcTextRecentModifiedAt | 读取 | 42 | FROM npc_text_edit_map |

### quest_answer

| 文件 | 类 | 方法 | 操作类型 | 行号 | 证据片段 |
|---|---|---|---|---:|---|
| src\unluac\semantic\Phase3DatabaseWriter.java | Phase3DatabaseWriter | insertQuestData | 写入 | 317 | INSERT INTO quest_answer |
| src\unluac\web\support\AdminRecentModifiedService.java | AdminRecentModifiedService | findQuestRecentModifiedAt | 读取 | 17 | FROM quest_answer |

### quest_contents

| 文件 | 类 | 方法 | 操作类型 | 行号 | 证据片段 |
|---|---|---|---|---:|---|
| src\unluac\semantic\Phase3DatabaseWriter.java | Phase3DatabaseWriter | insertQuestData | 写入 | 316 | INSERT INTO quest_contents |
| src\unluac\semantic\Phase5NpcLucExporter.java | Phase5NpcLucExporter | loadQuestModels | 读取 | 239 | FROM quest_contents |
| src\unluac\semantic\Phase6BForcedHighReferenceMutationValidator.java | Phase6BForcedHighReferenceMutationValidator | mutateDatabase | 更新 | 194 | UPDATE quest_contents |
| src\unluac\semantic\Phase6DbMutationAndImpactValidator.java | Phase6DbMutationAndImpactValidator | mutateDatabase | 读取 | 110 | FROM quest_contents |
| src\unluac\semantic\Phase6DbMutationAndImpactValidator.java | Phase6DbMutationAndImpactValidator | mutateDatabase | 更新 | 136 | UPDATE quest_contents |
| src\unluac\web\support\AdminRecentModifiedService.java | AdminRecentModifiedService | findQuestRecentModifiedAt | 读取 | 16 | FROM quest_contents |

### quest_goal_getitem

| 文件 | 类 | 方法 | 操作类型 | 行号 | 证据片段 |
|---|---|---|---|---:|---|
| src\unluac\semantic\Phase3DatabaseWriter.java | Phase3DatabaseWriter | insertQuestData | 写入 | 318 | INSERT INTO quest_goal_getitem |
| src\unluac\semantic\Phase5NpcLucExporter.java | Phase5NpcLucExporter | loadDbSnapshot | 读取 | 197 | FROM quest_goal_getitem |
| src\unluac\web\controller\AdminController.java | AdminController | dashboard | 读取 | 60 | FROM quest_goal_getitem |
| src\unluac\web\support\AdminRecentModifiedService.java | AdminRecentModifiedService | findQuestRecentModifiedAt | 读取 | 19 | FROM quest_goal_getitem |

### quest_goal_killmonster

| 文件 | 类 | 方法 | 操作类型 | 行号 | 证据片段 |
|---|---|---|---|---:|---|
| src\unluac\semantic\Phase3DatabaseWriter.java | Phase3DatabaseWriter | insertQuestData | 写入 | 319 | INSERT INTO quest_goal_killmonster |
| src\unluac\semantic\Phase5NpcLucExporter.java | Phase5NpcLucExporter | loadDbSnapshot | 读取 | 198 | FROM quest_goal_killmonster |
| src\unluac\web\support\AdminRecentModifiedService.java | AdminRecentModifiedService | findQuestRecentModifiedAt | 读取 | 20 | FROM quest_goal_killmonster |

### quest_goal_meetnpc

| 文件 | 类 | 方法 | 操作类型 | 行号 | 证据片段 |
|---|---|---|---|---:|---|
| src\unluac\semantic\Phase3DatabaseWriter.java | Phase3DatabaseWriter | insertQuestData | 写入 | 320 | INSERT INTO quest_goal_meetnpc |
| src\unluac\semantic\Phase5NpcLucExporter.java | Phase5NpcLucExporter | loadDbSnapshot | 读取 | 199 | FROM quest_goal_meetnpc |
| src\unluac\web\support\AdminRecentModifiedService.java | AdminRecentModifiedService | findQuestRecentModifiedAt | 读取 | 21 | FROM quest_goal_meetnpc |

### quest_info

| 文件 | 类 | 方法 | 操作类型 | 行号 | 证据片段 |
|---|---|---|---|---:|---|
| src\unluac\semantic\Phase3DatabaseWriter.java | Phase3DatabaseWriter | insertQuestData | 写入 | 318 | INSERT INTO quest_info |
| src\unluac\web\support\AdminRecentModifiedService.java | AdminRecentModifiedService | findQuestRecentModifiedAt | 读取 | 18 | FROM quest_info |

### quest_main

| 文件 | 类 | 方法 | 操作类型 | 行号 | 证据片段 |
|---|---|---|---|---:|---|
| src\unluac\semantic\Phase3DatabaseWriter.java | Phase3DatabaseWriter | createSchema | DDL | 259 | ALTER TABLE quest_main |
| src\unluac\semantic\Phase3DatabaseWriter.java | Phase3DatabaseWriter | createSchema | DDL | 260 | ALTER TABLE quest_main |
| src\unluac\semantic\Phase3DatabaseWriter.java | Phase3DatabaseWriter | createSchema | DDL | 261 | ALTER TABLE quest_main |
| src\unluac\semantic\Phase3DatabaseWriter.java | Phase3DatabaseWriter | createSchema | DDL | 262 | ALTER TABLE quest_main |
| src\unluac\semantic\Phase3DatabaseWriter.java | Phase3DatabaseWriter | createSchema | DDL | 266 | ALTER TABLE quest_main |
| src\unluac\semantic\Phase3DatabaseWriter.java | Phase3DatabaseWriter | insertQuestData | 写入 | 314 | INSERT INTO quest_main |
| src\unluac\semantic\Phase3DbConsistencyValidator.java | Phase3DbConsistencyValidator | loadQuestMain | 读取 | 153 | FROM quest_main |
| src\unluac\semantic\Phase4QuestLucExporter.java | Phase4QuestLucExporter | loadFromDb | 读取 | 149 | FROM quest_main |
| src\unluac\semantic\Phase5NpcLucExporter.java | Phase5NpcLucExporter | loadDbSnapshot | 读取 | 196 | FROM quest_main |
| src\unluac\semantic\Phase5NpcLucExporter.java | Phase5NpcLucExporter | loadQuestModels | 读取 | 226 | FROM quest_main |
| src\unluac\semantic\Phase6BForcedHighReferenceMutationValidator.java | Phase6BForcedHighReferenceMutationValidator | mutateDatabase | 更新 | 191 | UPDATE quest_main |
| src\unluac\semantic\Phase6CDbDrivenExportValidator.java | Phase6CDbDrivenExportValidator | pickQuestForMutation | 读取 | 114 | FROM quest_main |
| src\unluac\semantic\Phase6CDbDrivenExportValidator.java | Phase6CDbDrivenExportValidator | applyDatabaseMutation | 更新 | 135 | UPDATE quest_main |
| src\unluac\semantic\Phase6DbMutationAndImpactValidator.java | Phase6DbMutationAndImpactValidator | mutateDatabase | 读取 | 109 | FROM quest_main |
| src\unluac\semantic\Phase6DbMutationAndImpactValidator.java | Phase6DbMutationAndImpactValidator | mutateDatabase | 更新 | 134 | UPDATE quest_main |
| src\unluac\web\controller\AdminController.java | AdminController | dashboard | 读取 | 56 | FROM quest_main |
| src\unluac\web\service\AdminQuestService.java | AdminQuestService | list | 读取 | 38 | FROM quest_main |
| src\unluac\web\service\AdminQuestService.java | AdminQuestService | detail | 读取 | 69 | FROM quest_main |
| src\unluac\web\service\AdminQuestService.java | AdminQuestService | count | 读取 | 132 | FROM quest_main |
| src\unluac\web\service\AdminQuestService.java | AdminQuestService | updateQuestName | 更新 | 149 | UPDATE quest_main |
| src\unluac\web\service\AdminQuestService.java | AdminQuestService | touchQuestUpdatedAt | 更新 | 158 | UPDATE quest_main |
| src\unluac\web\support\AdminRecentModifiedService.java | AdminRecentModifiedService | findQuestRecentModifiedAt | 读取 | 15 | FROM quest_main |

### quest_requst_item

| 文件 | 类 | 方法 | 操作类型 | 行号 | 证据片段 |
|---|---|---|---|---:|---|
| src\unluac\semantic\Phase3DatabaseWriter.java | Phase3DatabaseWriter | insertQuestData | 写入 | 323 | INSERT INTO quest_requst_item |
| src\unluac\semantic\Phase4QuestLucExporter.java | Phase4QuestLucExporter | loadRequstItemArray | 读取 | 326 | FROM quest_requst_item |

### quest_reward_item

| 文件 | 类 | 方法 | 操作类型 | 行号 | 证据片段 |
|---|---|---|---|---:|---|
| src\unluac\semantic\Phase3DatabaseWriter.java | Phase3DatabaseWriter | insertQuestData | 写入 | 321 | INSERT INTO quest_reward_item |
| src\unluac\semantic\Phase5NpcLucExporter.java | Phase5NpcLucExporter | loadDbSnapshot | 读取 | 201 | FROM quest_reward_item |
| src\unluac\semantic\Phase5NpcLucExporter.java | Phase5NpcLucExporter | loadQuestModels | 读取 | 251 | FROM quest_reward_item |
| src\unluac\semantic\Phase6BForcedHighReferenceMutationValidator.java | Phase6BForcedHighReferenceMutationValidator | mutateDatabase | 更新 | 192 | UPDATE quest_reward_item |
| src\unluac\semantic\Phase6BForcedHighReferenceMutationValidator.java | Phase6BForcedHighReferenceMutationValidator | mutateDatabase | 写入 | 193 | INSERT INTO quest_reward_item |
| src\unluac\semantic\Phase6BForcedHighReferenceMutationValidator.java | Phase6BForcedHighReferenceMutationValidator | queryNextRewardSeqIndex | 读取 | 278 | FROM quest_reward_item |
| src\unluac\semantic\Phase6CDbDrivenExportValidator.java | Phase6CDbDrivenExportValidator | pickQuestForMutation | 读取 | 115 | JOIN quest_reward_item |
| src\unluac\semantic\Phase6CDbDrivenExportValidator.java | Phase6CDbDrivenExportValidator | applyDatabaseMutation | 更新 | 136 | UPDATE quest_reward_item |
| src\unluac\semantic\Phase6DbMutationAndImpactValidator.java | Phase6DbMutationAndImpactValidator | mutateDatabase | 读取 | 111 | FROM quest_reward_item |
| src\unluac\semantic\Phase6DbMutationAndImpactValidator.java | Phase6DbMutationAndImpactValidator | mutateDatabase | 更新 | 135 | UPDATE quest_reward_item |
| src\unluac\web\controller\AdminController.java | AdminController | dashboard | 读取 | 58 | FROM quest_reward_item |
| src\unluac\web\support\AdminRecentModifiedService.java | AdminRecentModifiedService | findQuestRecentModifiedAt | 读取 | 22 | FROM quest_reward_item |

### quest_reward_skill

| 文件 | 类 | 方法 | 操作类型 | 行号 | 证据片段 |
|---|---|---|---|---:|---|
| src\unluac\semantic\Phase3DatabaseWriter.java | Phase3DatabaseWriter | insertQuestData | 写入 | 322 | INSERT INTO quest_reward_skill |
| src\unluac\semantic\Phase4QuestLucExporter.java | Phase4QuestLucExporter | loadSkillArray | 读取 | 304 | FROM quest_reward_skill |

