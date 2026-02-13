# Quest Table Whitelist

| 表名 | 用途 | 来源Phase | 是否核心 | 备注 |
|---|---|---|---|---|
| quest_main | 任务主表 | Phase3写入/Phase4读取 | 是 | Quest头字段权威来源 |
| quest_contents | 任务contents顺序文本 | Phase3写入/Phase4读取 | 是 | 保序导出 |
| quest_answer | 任务answer顺序文本 | Phase3写入/Phase4读取 | 是 | 保序导出 |
| quest_info | 任务info顺序文本 | Phase3写入/Phase4读取 | 是 | 保序导出 |
| quest_goal_getitem | goal.getItem结构 | Phase3写入/Phase4读取 | 是 | 条件类索引结构 |
| quest_goal_killmonster | goal.killMonster结构 | Phase3写入/Phase4读取 | 是 | 条件类索引结构 |
| quest_goal_meetnpc | goal.meetNpc结构 | Phase3写入/Phase4读取 | 是 | 条件类索引结构 |
| quest_reward_item | reward.getItem结构 | Phase3写入/Phase4读取 | 是 | 奖励类索引结构 |
| quest_reward_skill | reward.getSkill结构 | Phase3写入/Phase4读取 | 是 | 奖励技能结构 |
| quest_requst_item | requstItem原始结构 | Phase3写入/Phase4读取 | 是 | 保持原始JSON结构 |
| npc_quest_reference | NPC↔Quest依赖索引 | Phase3写入/Phase5读取 | 是 | 影响NPC导出范围判定 |
