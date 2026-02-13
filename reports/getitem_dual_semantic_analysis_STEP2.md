# Step-2：getItem 双语义结构审计

## 一、样本审计对象
- `questId=2673`
- `questId=804`
- 样本文件：`reports/structure_audit_20260212_224450/questbak_decompiled.lua`

---

## 二、Lua 原始结构截图片段（行摘录）

### 1) questId=2673（同时出现 `goal.getItem` 与 `reward.getItem`）
```lua
167615:}).goal = {
167616:  getItem = {
167617:    {id = 8911611, count = 50},
167618:    {id = 8911621, count = 50}
167619:  },
167620:  killMonster = {}
167621:}
...
167642:}).reward = {
...
167662:}, {
167663:  getItem = {},
167664:  money = 940850,
167665:  exp = 26300000
167666:}
```

### 2) questId=804（仅 reward 侧出现 `getItem`）
```lua
62274:}).goal = {
62275:  meetNpc = {4313007, 4391912}
62276:}
...
62312:}).reward = {
...
62348:  money = 350000,
62349:  exp = 3000000,
62350:  pvppoint = 4,
62351:  getItem = {
62352:    {id = 8921311, count = 1},
62353:    {id = 8921321, count = 1},
62354:    {id = 8890102, count = 40}
62355:  }
62356:}
```

---

## 三、样本对比结论（只做审计）

| 对比项 | questId=2673 | questId=804 | 结论 |
|---|---|---|---|
| `goal.getItem` 是否存在 | 是（非空） | 否（goal仅`meetNpc`） | 两任务分布不同 |
| `reward.getItem` 是否存在 | 是（空表） | 是（非空） | 两任务分布不同 |
| `getItem` 子项结构 | `{id,count}` | `{id,count}` | 结构同形 |
| `id/count` 字段字面含义 | 物品ID/数量 | 物品ID/数量 | 字面同形同义 |
| 语义角色 | 完成条件所需 | 奖励发放 | 业务语义不同 |

---

## 四、代码分流路径追踪

## 4.1 QuestSemanticExtractor 分流

### A. 条件侧 `goal.getItem`
- 读取 `goal`：`QuestSemanticExtractor.java:811-815`
- `fillQuestGoalFromValue()`读取`getItem`并下沉：`QuestSemanticExtractor.java:1069-1077`
- `fillQuestItemRequirements()`解析`id/itemid`与`count/itemcnt`到`model.goal.items`：`QuestSemanticExtractor.java:1084-1103`

### B. 奖励侧 `reward.getItem`
- 读取 `reward` 总入口：`QuestSemanticExtractor.java:823-833`
- 递归抽取奖励表：`extractRewards()`：`QuestSemanticExtractor.java:1343-1365`
- `rewardFromTable()`奖励对象解析：
  - 命中条件依赖 `REWARD_KEYS`（不含`getItem`）：`QuestSemanticExtractor.java:59-67,1382-1390`
  - `id/itemid/count/itemcnt`映射到`Reward.id/count`：`QuestSemanticExtractor.java:1401-1423`
  - `getItem`是已知奖励键（用于绑定过滤）：`QuestSemanticExtractor.java:1041-1051`

### C. money 字段在 Extractor
- `money`识别并入`Reward.money`：`QuestSemanticExtractor.java:59,1424-1429`
- 绑定键名为`reward_money`：`QuestSemanticExtractor.java:939-944`

---

## 4.2 Phase2 分流写出

- 任务构建时同时调用 `fillGoal()` 与 `fillReward()`：`Phase2LucDataExtractionSystem.java:170-171`

### A. goal 路径
- `model.goal.items -> record.goal.getItem`：`Phase2LucDataExtractionSystem.java:256-269`
- JSON键名保持`goal.getItem`：`Phase2LucDataExtractionSystem.java:1790,1797`

### B. reward 路径
- `fillReward()`使用 `reward.id/count` 生成 `record.reward.items`：`Phase2LucDataExtractionSystem.java:328-343`
- `reward.money`被累计到`reward.gold`：`Phase2LucDataExtractionSystem.java:337`
- JSON奖励结构输出为`exp/gold/items`：`Phase2LucDataExtractionSystem.java:1845-1856`

---

## 4.3 Phase3 落库分流

### A. 表结构
- 条件物品表：`quest_goal_getitem`：`Phase3DatabaseWriter.java:178-186`
- 奖励物品表：`quest_reward_item`：`Phase3DatabaseWriter.java:207-215`
- 奖励数值列：`quest_main.reward_exp/reward_gold`：`Phase3DatabaseWriter.java:142-149`

### B. 入库映射
- `goal.getItem -> quest_goal_getitem`：`Phase3DatabaseWriter.java:425-427,271,317-325`
- `reward.items -> quest_reward_item`：`Phase3DatabaseWriter.java:436-437,274`
- `reward.gold/exp -> quest_main.reward_gold/reward_exp`：`Phase3DatabaseWriter.java:434-435,267`

---

## 4.4 Phase4 导出分流

### A. 读取
- 读取 `quest_goal_getitem`：`Phase4QuestLucExporter.java:144`
- 读取 `quest_reward_item`：`Phase4QuestLucExporter.java:147`
- 读取 `reward_exp/reward_gold`：`Phase4QuestLucExporter.java:120,134-135`

### B. 导出字段名
- 条件侧导出：`goal.getItem`：`Phase4QuestLucExporter.java:280-283`
- 奖励侧导出：`reward.items`：`Phase4QuestLucExporter.java:295-297`
- 奖励数值导出：`reward.exp`、`reward.gold`：`Phase4QuestLucExporter.java:293-294`

---

## 五、DB 表名与导出字段名（本次要求）

| 语义 | DB 表/列 | 导出字段名 |
|---|---|---|
| 条件物品（goal） | `quest_goal_getitem` | `goal.getItem` |
| 奖励物品（reward） | `quest_reward_item` | `reward.items` |
| 奖励经验 | `quest_main.reward_exp` | `reward.exp` |
| 奖励货币 | `quest_main.reward_gold` | `reward.gold` |

---

## 六、审计摘要（仅结论）

1. `goal.getItem` 与 `reward.getItem` 在 Lua 子项上均为 `{id,count}` 同形结构。  
2. 两者在代码中走的是两条不同语义通道：  
   - goal 通道：`model.goal.items -> goal.getItem -> quest_goal_getitem -> goal.getItem`  
   - reward 通道：`model.rewards(id/count) -> reward.items -> quest_reward_item -> reward.items`  
3. `reward.money` 在 Phase2/3/4 通道落为 `gold` 字段名（见上述行号）。  

