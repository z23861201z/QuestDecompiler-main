# quest_semantic_gap_report

## 分析边界
- 仅基于当前工作目录源码与文件：
  - `AGENTS.md`
  - `reports/structure_audit_20260212_224450/step1_keyword_evidence.json`
  - `reports/structure_audit_20260212_224450/questbak_decompiled.lua`
  - `src/unluac/semantic/QuestSemanticExtractor.java`
  - `src/unluac/semantic/Phase2LucDataExtractionSystem.java`
  - `src/unluac/semantic/Phase3DatabaseWriter.java`
  - `src/unluac/semantic/Phase4QuestLucExporter.java`
  - `src/unluac/semantic/Phase4QuestExportValidator.java`
  - `src/unluac/semantic/QuestSemanticModel.java`
- 不包含外部资料，不包含运行时行为推测，不包含代码修改方案。

---

## 1) Lua 任务语义分类表（条件类 vs 奖励类）

| 语义类别 | 字段 | 语义角色 | 源码/样本证据 |
|---|---|---|---|
| 条件类 | `goal.getItem` | 完成条件中的物品收集目标 | `questbak_decompiled.lua:167615-167619` |
| 条件类 | `goal.killMonster` | 完成条件中的击杀目标 | `questbak_decompiled.lua:167620`（同任务段） |
| 条件类 | `requstItem` | 前置需求物品结构 | `questbak_decompiled.lua:167594` |
| 条件类 | `needItem` | 前置需求单值字段 | `questbak_decompiled.lua:839` |
| 奖励类 | `reward.getItem` | 奖励物品列表 | `questbak_decompiled.lua:62351-62355` |
| 奖励类 | `reward.getSkill` | 奖励技能列表 | `questbak_decompiled.lua:1961` |
| 奖励类 | `reward.money` | 奖励货币 | `questbak_decompiled.lua:62348` |
| 奖励类 | `reward.exp` | 奖励经验 | `questbak_decompiled.lua:62349` |
| 奖励类 | `reward.fame` | 奖励声望 | `questbak_decompiled.lua:143` |
| 奖励类 | `reward.pvppoint` | 奖励 PVP 点数 | `questbak_decompiled.lua:62350` |
| 奖励类 | `reward.mileage` | 奖励 mileage 点数 | `questbak_decompiled.lua:124672`, `124785` |

---

## 2) 分层语义承载缺口（字段级）

### 2.1 Extractor 层（`QuestSemanticExtractor`）

**已建模（可识别）**
- `QUEST_KEYS` 含 `requstItem`：`QuestSemanticExtractor.java:42-53`
- `REWARD_KEYS` 含 `money/exp/fame/pvppoint/getSkill/id/count/itemid/itemcnt`：`QuestSemanticExtractor.java:59-67`
- `CONDITION_KEYS` 含 `requstItem/goal/getItem`：`QuestSemanticExtractor.java:69-74`
- `rewardFromTable()` 解析 `money/exp/fame/pvppoint/getSkill`：`QuestSemanticExtractor.java:1424-1469`

**缺失/未承载**
- `mileage` 不在 `REWARD_KEYS`：`QuestSemanticExtractor.java:59-67`（样本中存在 mileage：`questbak_decompiled.lua:124672`）
- `needItem` 不在 `CONDITION_KEYS` / `QUEST_KEYS`：`QuestSemanticExtractor.java:42-75`（样本存在：`questbak_decompiled.lua:839`）

### 2.2 Phase2 层（`Phase2LucDataExtractionSystem`）

**当前承载**
- `goal.getItem/killMonster/meetNpc` 写入输出模型：`Phase2LucDataExtractionSystem.java:260-286`
- `reward` 仅累积：
  - `exp`：`Phase2LucDataExtractionSystem.java:336`
  - `money -> gold`：`Phase2LucDataExtractionSystem.java:337`
  - `id+count -> items[]`：`Phase2LucDataExtractionSystem.java:338-342`

**缺失/语义降级**
- `RewardBlock` 仅有 `exp/gold/items`：`Phase2LucDataExtractionSystem.java:1845-1856`
- 未见 `fame/pvppoint/mileage/getSkill` 的输出承载字段（同文件 `RewardBlock` 与 `fillReward`）。
- 未见 `requstItem`、`needItem` 的输出承载字段（QuestRecord 输出中仅 `goal/reward/needLevel/bQLoop`：`Phase2LucDataExtractionSystem.java:1246-1254`）。

### 2.3 Phase3 层（`Phase3DatabaseWriter`）

**当前承载（DDL）**
- `quest_main`：`reward_exp`, `reward_gold`：`Phase3DatabaseWriter.java:142-149`
- `quest_goal_getitem`：`Phase3DatabaseWriter.java:178-186`
- `quest_reward_item`：`Phase3DatabaseWriter.java:207-215`

**缺失/未承载**
- 未见 `reward_fame`, `reward_pvppoint`, `reward_mileage`, `reward_getSkill`
- 未见 `requstItem`, `needItem` 对应表/列
- 插入逻辑仅写 `reward_exp/reward_gold/reward_items`：`Phase3DatabaseWriter.java:267-274`, `433-438`

### 2.4 Phase4 层（`Phase4QuestLucExporter`）

**当前导出承载**
- DB 读取字段：`reward_exp/reward_gold` + `quest_reward_item`：`Phase4QuestLucExporter.java:120-147`
- 导出字段：`reward.exp`, `reward.gold`, `reward.items`：`Phase4QuestLucExporter.java:292-297`

**缺失/语义偏移**
- 未导出 `reward.fame/pvppoint/mileage/getSkill`
- 未导出 `requstItem/needItem`
- 奖励货币键名由 `money` 变成 `gold`（Phase2/4 一致，但与原始样本键名不一致：样本 `money` 见 `questbak_decompiled.lua:62348`）

### 2.5 AGENTS.md 与当前 DB 描述一致性
- `AGENTS.md` 当前 Quest 表核心字段仅列 `reward_exp/reward_gold` 与 `quest_reward_item`：`AGENTS.md:138-164`
- 与 Phase3 DDL 现状一致，但不覆盖 `fame/pvppoint/mileage/getSkill/requstItem/needItem`。

---

## 3) `getItem` 语义歧义对照（2673 vs 804）

| 样本 | 条件侧 `goal.getItem` | 奖励侧 `reward.getItem` | 观察结论 |
|---|---|---|---|
| `questId=2673` | 存在，且为非空（`questbak_decompiled.lua:167615-167619`） | 存在，但为空 `{}`（`questbak_decompiled.lua:167662-167665`） | 同一任务内同时出现“条件 getItem”和“奖励 getItem”命名同形但语义不同。 |
| `questId=804` | 目标为 `meetNpc`，无 `goal.getItem`（`questbak_decompiled.lua:62274-62276`） | 存在，且为非空列表（`questbak_decompiled.lua:62351-62355`） | `getItem` 在该任务仅出现在奖励侧。 |

**当前链路中的语义分流方式（非结构等价）**
- 条件 `goal.getItem` 走 `goal` 路径：`Phase2LucDataExtractionSystem.java:260-268`
- 奖励 `reward.getItem` 在中间层被收敛为 `reward.items`（`Phase2LucDataExtractionSystem.java:338-342`, `1845-1856`）
- 导出阶段输出键名为 `reward.items`：`Phase4QuestLucExporter.java:295-297`

=> 结论：`getItem` 的“条件语义 vs 奖励语义”在中间层被拆分，但奖励侧原始键名形态（`getItem`）未保留。

---

## 4) 若不修复，DB → luc 阶段的具体风险

1. **字段丢失风险（高）**  
   `fame/pvppoint/mileage/getSkill/requstItem/needItem` 在 Phase2/3/4 无完整承载链路，DB 回写时无法还原这些语义字段。

2. **键名语义漂移风险（高）**  
   奖励货币键从 `money` 落地为 `gold`，奖励物品键从 `getItem` 落地为 `items`；即使数值存在，结构键名已与原始 Lua 语义层不一致。

3. **`getItem` 双语义可读性与审计风险（中-高）**  
   条件侧与奖励侧同名字段在中间层被分流为不同目标结构，若仅看 DB/导出侧，难直接反向确认“来源是 goal 还是 reward”。

4. **验证盲区风险（高）**  
   `Phase4QuestExportValidator` 比对仅覆盖 `reward.exp/reward.gold/reward.items` 与 `goal.*`：`Phase4QuestExportValidator.java:93-107`，未覆盖 `fame/pvppoint/mileage/getSkill/requstItem/needItem`，会导致“未被建模字段丢失”不进入 mismatch。

---

## 5) 自检引用清单（必填）

### 5.1 源码文件路径
- `src/unluac/semantic/QuestSemanticExtractor.java`
- `src/unluac/semantic/QuestSemanticModel.java`
- `src/unluac/semantic/Phase2LucDataExtractionSystem.java`
- `src/unluac/semantic/Phase3DatabaseWriter.java`
- `src/unluac/semantic/Phase4QuestLucExporter.java`
- `src/unluac/semantic/Phase4QuestExportValidator.java`
- `AGENTS.md`

### 5.2 样本 ID
- `2673`
- `804`

### 5.3 JSON 证据 key（`step1_keyword_evidence.json`）
- 顶层：`[ ]`（数组）
- 对象键：`file`, `className`, `evidences`
- evidence 子键：`line`, `method`, `snippet`

