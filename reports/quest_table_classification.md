# Quest Table Classification

- 数据库范围：ghost_game 中表名包含 `quest` / `npc` 的表。
- 分类依据：`src/`、`resources/` 实际 SQL 引用 + Phase3/Phase4 代码入口。

## A类：被 Phase2/Phase3 写入的核心表（实际由 Phase3 写入）

| 表名 | 写入入口 | 证据 |
|---|---|---|
| quest_main | Phase3DatabaseWriter | Phase3DatabaseWriter.writeQuestData() |
| quest_contents | Phase3DatabaseWriter | Phase3DatabaseWriter.writeQuestData() |
| quest_answer | Phase3DatabaseWriter | Phase3DatabaseWriter.writeQuestData() |
| quest_info | Phase3DatabaseWriter | Phase3DatabaseWriter.writeQuestData() |
| quest_goal_getitem | Phase3DatabaseWriter | Phase3DatabaseWriter.writeQuestData() |
| quest_goal_killmonster | Phase3DatabaseWriter | Phase3DatabaseWriter.writeQuestData() |
| quest_goal_meetnpc | Phase3DatabaseWriter | Phase3DatabaseWriter.writeQuestData() |
| quest_reward_item | Phase3DatabaseWriter | Phase3DatabaseWriter.writeQuestData() |
| quest_reward_skill | Phase3DatabaseWriter | Phase3DatabaseWriter.writeQuestData() |
| quest_requst_item | Phase3DatabaseWriter | Phase3DatabaseWriter.writeQuestData() |
| npc_quest_reference | Phase3DatabaseWriter | Phase3DatabaseWriter.insertNpcReferences() |

## B类：被 Phase4 读取的导出相关表

| 表名 | 读取入口 | 证据 |
|---|---|---|
| quest_main | Phase4QuestLucExporter.loadFromDb() | src/unluac/semantic/Phase4QuestLucExporter.java |
| quest_contents | Phase4QuestLucExporter.loadFromDb() | src/unluac/semantic/Phase4QuestLucExporter.java |
| quest_answer | Phase4QuestLucExporter.loadFromDb() | src/unluac/semantic/Phase4QuestLucExporter.java |
| quest_info | Phase4QuestLucExporter.loadFromDb() | src/unluac/semantic/Phase4QuestLucExporter.java |
| quest_goal_getitem | Phase4QuestLucExporter.loadFromDb() | src/unluac/semantic/Phase4QuestLucExporter.java |
| quest_goal_killmonster | Phase4QuestLucExporter.loadFromDb() | src/unluac/semantic/Phase4QuestLucExporter.java |
| quest_goal_meetnpc | Phase4QuestLucExporter.loadFromDb() | src/unluac/semantic/Phase4QuestLucExporter.java |
| quest_reward_item | Phase4QuestLucExporter.loadFromDb() | src/unluac/semantic/Phase4QuestLucExporter.java |
| quest_reward_skill | Phase4QuestLucExporter.loadFromDb() | src/unluac/semantic/Phase4QuestLucExporter.java |
| quest_requst_item | Phase4QuestLucExporter.loadFromDb() | src/unluac/semantic/Phase4QuestLucExporter.java |

## C类：代码中无引用（疑似废弃）

- 本次扫描结果：`0` 张（未发现 quest/npc 范围内无引用表）。

## 备注
- `npc_dialogue_text`、`npc_text_edit_map` 为 Phase7 文本链路表，属于活跃使用表，不归入废弃。
- `quest_table_code_usage_scan.md` 中 `<dynamic:table>` 为动态 SQL 占位，已在白名单中显式约束。
