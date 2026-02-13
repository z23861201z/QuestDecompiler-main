# Step-3：数据库最小侵入补全设计（不改代码）

## 0. 边界与原则
- 不删除任何现有字段。
- 不重命名任何现有字段。
- 不改变现有表用途。
- 仅给出 **新增列 / 新增表 / JSON承载字段** 设计。
- 本文不包含代码修改。

---

## 1. 现状证据（源码）

### 1.1 现有 DB 写入/读取锚点
- `quest_main` 仅有 `reward_exp`、`reward_gold`：`Phase3DatabaseWriter.java:142-149`
- 条件表：`quest_goal_getitem`、`quest_goal_killmonster`：`Phase3DatabaseWriter.java:178-196`
- 奖励物品表：`quest_reward_item`：`Phase3DatabaseWriter.java:207-215`
- Phase3 落库使用：
  - `row.rewardExp = reward.get("exp")`：`Phase3DatabaseWriter.java:434`
  - `row.rewardGold = reward.get("gold")`：`Phase3DatabaseWriter.java:435`
  - `reward.get("items") -> quest_reward_item`：`Phase3DatabaseWriter.java:436-437`

### 1.2 Phase4 兼容锚点（新增不会破坏的依据）
- Exporter 固定读取：`reward_exp`,`reward_gold`：`Phase4QuestLucExporter.java:120-121,134-135`
- Exporter 固定读取表：`quest_goal_getitem`,`quest_goal_killmonster`,`quest_reward_item`：`Phase4QuestLucExporter.java:144-147`
- Exporter 固定导出键：`reward.exp`,`reward.gold`,`reward.items`：`Phase4QuestLucExporter.java:292-297`
- Validator 固定校验键：`reward.exp`,`reward.gold`,`reward.items`：`Phase4QuestExportValidator.java:96-97,106,295-298`

### 1.3 语义来源锚点（Extractor）
- 条件键包含：`requstItem`,`goal`,`killMonster`,`getItem`；不含`needItem`：`QuestSemanticExtractor.java:69-74`
- 奖励键包含：`money`,`exp`,`fame`,`pvppoint`,`getSkill`；不含`mileage`：`QuestSemanticExtractor.java:59-67`
- `requstItem` 被识别并并入条件：`QuestSemanticExtractor.java:799-803`
- `reward.money/exp/fame/pvppoint/getSkill` 识别入模：`QuestSemanticExtractor.java:915-966,1424-1468`
- 奖励 `getItem` 仅作为已知键/额外字段处理：`QuestSemanticExtractor.java:1041-1051,1473`

---

## 2. 字段级补全设计（逐字段）

> 说明格式：  
> **现状承载** / **原结构问题** / **最小侵入补全** / **为何不破坏 Phase4**

| 字段 | 现状承载 | 原结构问题 | 最小侵入补全 | 为何不破坏 Phase4 |
|---|---|---|---|---|
| `goal.getItem` | 已有 `quest_goal_getitem`（`Phase3DatabaseWriter.java:178-186,425-427`） | 无结构缺口 | 不改现表，不新增必需字段 | Phase4 已固定读取该表（`Phase4QuestLucExporter.java:144`） |
| `goal.killMonster` | 已有 `quest_goal_killmonster`（`Phase3DatabaseWriter.java:188-196,428-429`） | 无结构缺口 | 不改现表，不新增必需字段 | Phase4 已固定读取该表（`Phase4QuestLucExporter.java:145`） |
| `requstItem` | Extractor识别，但 Phase2/3/4 无独立承载 | 当前仅被并入 goal 路径，缺少原字段独立落库位点（`QuestSemanticExtractor.java:799-803`） | 新增表 `quest_requst_item`（结构化+`raw_json`） | 新表不会影响 Phase4 现有固定查询（`Phase4QuestLucExporter.java:120-121,144-147`） |
| `needItem` | 当前无识别与无落库 | 字段无承载列 | 在 `quest_main` 新增 `need_item` 列 | Phase4 只读固定列 `reward_exp/reward_gold`，新增列被忽略（`Phase4QuestLucExporter.java:120-121,134-135`） |
| `reward.getItem` | 现有值落在 `quest_reward_item`，但链路键名为 `items`（`Phase3DatabaseWriter.java:436-437`） | 原始键名 `getItem` 未显式保留 | 保留 `quest_reward_item`；新增 `quest_main.reward_getitem_json` 用于保留原字段形态 | Phase4 不读取新增 JSON 列，现逻辑不变（`Phase4QuestLucExporter.java:120-121,147`） |
| `reward.getSkill` | Extractor 入模 `skillIds`，DB 无对应表（`QuestSemanticExtractor.java:963-966,1464-1468`） | 技能奖励无法落库 | 新增表 `quest_reward_skill` | 新表不参与现有 Phase4 查询，不破坏现流程 |
| `reward.money` | 现链路写入 `reward_gold`（`Phase3DatabaseWriter.java:147-149,435`） | 原字段名 `money` 不可逆，键名漂移 | 在 `quest_main` 新增 `reward_money`（保留 `reward_gold` 不删） | Phase4 继续读 `reward_gold`，新增列不影响当前导出（`Phase4QuestLucExporter.java:120-121,134-135`） |
| `reward.exp` | 已有 `reward_exp`（`Phase3DatabaseWriter.java:147,434`） | 无结构缺口 | 不改现字段 | 与现 Phase4 完全一致（`Phase4QuestLucExporter.java:120-121,134,293`） |
| `reward.fame` | Extractor 识别，DB 无列（`QuestSemanticExtractor.java:61,927-937,1434-1441`） | 奖励声望无法落库 | `quest_main` 新增 `reward_fame` 列 | 新增列不被现 Phase4 读取，不影响现行为 |
| `reward.pvppoint` | Extractor 识别，DB 无列（`QuestSemanticExtractor.java:62,951-960,1444-1451`） | 奖励PVP点无法落库 | `quest_main` 新增 `reward_pvppoint` 列 | 新增列不被现 Phase4 读取，不影响现行为 |
| `reward.mileage` | Extractor奖励键集合未覆盖（`QuestSemanticExtractor.java:59-67`）且 DB 无列 | 里程奖励无法落库 | `quest_main` 新增 `reward_mileage` 列；并在 `quest_main` 增加 `reward_extra_json` 兜底承载 | 新增列/JSON不改变现有 Phase4 固定查询 |

---

## 3. DDL 变更清单（Forward SQL）

```sql
-- Step-3 Forward Patch (MySQL 5.7)
-- 原则：不删、不改名、不改用途；只追加。

-- 1) quest_main：补齐奖励/条件缺口字段
ALTER TABLE quest_main
  ADD COLUMN reward_money INT NULL,
  ADD COLUMN reward_fame INT NULL,
  ADD COLUMN reward_pvppoint INT NULL,
  ADD COLUMN reward_mileage INT NULL,
  ADD COLUMN need_item INT NULL,
  ADD COLUMN reward_getitem_json JSON NULL,
  ADD COLUMN reward_extra_json JSON NULL;

-- 2) requstItem 独立承载（结构化 + 原始JSON）
CREATE TABLE IF NOT EXISTS quest_requst_item (
  id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  quest_id INT NOT NULL,
  seq_index INT NOT NULL,
  item_id INT NULL,
  item_count INT NULL,
  meet_count INT NOT NULL DEFAULT 0,
  raw_json JSON NULL,
  UNIQUE KEY uk_quest_requst_item (quest_id, seq_index),
  KEY idx_quest_requst_item_quest (quest_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 3) reward.getSkill 独立承载
CREATE TABLE IF NOT EXISTS quest_reward_skill (
  id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  quest_id INT NOT NULL,
  seq_index INT NOT NULL,
  skill_id INT NOT NULL,
  UNIQUE KEY uk_quest_reward_skill (quest_id, seq_index),
  KEY idx_quest_reward_skill_quest (quest_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
```

---

## 4. 回滚脚本（Rollback SQL）

```sql
-- Step-3 Rollback
-- 仅回滚 Step-3 新增对象；不触碰旧对象。

DROP TABLE IF EXISTS quest_reward_skill;
DROP TABLE IF EXISTS quest_requst_item;

ALTER TABLE quest_main
  DROP COLUMN reward_extra_json,
  DROP COLUMN reward_getitem_json,
  DROP COLUMN need_item,
  DROP COLUMN reward_mileage,
  DROP COLUMN reward_pvppoint,
  DROP COLUMN reward_fame,
  DROP COLUMN reward_money;
```

---

## 5. 两个强制问题的明确回答

### 5.1 `getItem` 是否拆分为两张表？
**是，继续拆分为两张表，不合并：**
- 条件侧：`quest_goal_getitem`（现有，不变）
- 奖励侧：`quest_reward_item`（现有，不变）

依据：当前代码已按两条语义路径分流  
- 条件路径：`goal.get("getItem")` -> `goalGetItem`（`Phase3DatabaseWriter.java:424-427,678`）  
- 奖励路径：`reward.get("items")` -> `rewardItems`（`Phase3DatabaseWriter.java:433-437,681`）

### 5.2 `money` 是否恢复为 `money` 而非 `gold`？
**是，新增 `quest_main.reward_money` 承载原始语义键名；`reward_gold` 保留兼容，不删除。**

依据：当前链路存在 `money -> gold` 漂移  
- Phase2：`record.reward.gold += reward.money`（`Phase2LucDataExtractionSystem.java:337`）  
- Phase3：读取 `reward.get("gold")`（`Phase3DatabaseWriter.java:435`）  
- Phase4：导出 `reward.gold`（`Phase4QuestLucExporter.java:294`）  

---

## 6. 为什么这些新增不会破坏 Phase4（逐点）

1. **不删除现字段**：`reward_exp/reward_gold` 保留，Phase4 仍按现语句读取（`Phase4QuestLucExporter.java:120-121,134-135`）。  
2. **不改现表用途**：`quest_goal_getitem/quest_goal_killmonster/quest_reward_item` 不变（`Phase4QuestLucExporter.java:144-147`）。  
3. **新增对象“旁路承载”**：新增列/新表未被现 Exporter/Validator 的固定字段集使用（`Phase4QuestExportValidator.java:96-107,295-298`）。  
4. **因此 Step-3 仅做承载补全，不改变现 Phase4 行为面。**

