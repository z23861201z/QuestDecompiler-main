# Step-4 代码层补全与最小写出修复报告

生成时间：2026-02-12

## 1. 修改范围（严格限定）
- `src/unluac/semantic/QuestSemanticExtractor.java`
- `src/unluac/semantic/Phase2LucDataExtractionSystem.java`
- `src/unluac/semantic/Phase3DatabaseWriter.java`
- `src/unluac/semantic/Phase4QuestLucExporter.java`
- `src/unluac/semantic/Phase4QuestExportValidator.java`

---

## 2. 修改前后对比

### 2.1 `QuestSemanticExtractor`

**修改前**
- 未将 `needItem` 纳入 `QUEST_KEYS/CONDITION_KEYS`。
- 奖励键集合缺少 `mileage`，且 `reward.getItem` 语义未显式纳入统一奖励键集合。
- `requstItem` 会被并入 `goal`（存在条件语义与 goal 语义耦合风险）。

**修改后**
- 增加字段识别：`needItem`（`QuestSemanticExtractor.java:50`, `QuestSemanticExtractor.java:74`, `QuestSemanticExtractor.java:803`）。
- 增加奖励字段识别：`mileage`、`getItem`（`QuestSemanticExtractor.java:64`, `QuestSemanticExtractor.java:65`, `QuestSemanticExtractor.java:1491`）。
- 增加 `reward_mileage` 绑定（`QuestSemanticExtractor.java:991`）。
- 保留 `requstItem` 为条件语义，不再自动并入 `goal`（`QuestSemanticExtractor.java:824` 附近逻辑已去掉并入调用）。

### 2.2 `Phase2LucDataExtractionSystem`

**修改前**
- `QuestRecord` 不承载 `needItem/requstItem`。
- `RewardBlock` 为旧键：`gold/items`，且全量模板写出。

**修改后**
- `QuestRecord` 新增：`needItem`、`requstItem`（`Phase2LucDataExtractionSystem.java:2158`）。
- 新增条件提取：`record.needItem`、`record.requstItem`（`Phase2LucDataExtractionSystem.java:169`, `Phase2LucDataExtractionSystem.java:170`）。
- `fillReward` 改为承载并汇总：`money/exp/fame/pvppoint/mileage/getItem/getSkill`（`Phase2LucDataExtractionSystem.java:416`）。
- `RewardBlock` 改为原始键名与按需写出（`Phase2LucDataExtractionSystem.java:1998`）。
- 新增通用 `toJsonValue(Object)` 用于 `requstItem` 结构化写出（`Phase2LucDataExtractionSystem.java:2113`）。
- `writeQuestReport` 改为按字段存在性输出，避免固定模板全量写出（同文件 `writeQuestReport` 逻辑）。

### 2.3 `Phase3DatabaseWriter`

**修改前**
- `quest_main` 仅含 `reward_exp/reward_gold`，缺失 `money/fame/pvppoint/mileage/needItem` 承载。
- 缺少 `reward.getSkill` 与 `requstItem` 的结构化落库通道。
- 解析 `reward` 只读 `gold/items`。

**修改后**
- `quest_main` 增加承载列：`reward_money/reward_fame/reward_pvppoint/reward_mileage/need_item`（`Phase3DatabaseWriter.java:143`, `Phase3DatabaseWriter.java:150`）。
- 新增表：
  - `quest_reward_skill`（`Phase3DatabaseWriter.java:223`）
  - `quest_requst_item`（`Phase3DatabaseWriter.java:232`）
- 增加兼容补列（幂等）：`ALTER TABLE quest_main ADD COLUMN ...`（`Phase3DatabaseWriter.java:258`）。
- 主表插入扩展为 11 列（`Phase3DatabaseWriter.java:315`）。
- 新增 `rewardSkill`/`requstItem` 入库批处理（`Phase3DatabaseWriter.java:323`, `Phase3DatabaseWriter.java:324`）。
- JSON 解析改为优先原始键名：`money/getItem/getSkill`，兼容旧键 `gold/items`（`Phase3DatabaseWriter.java:523` 起）。
- 新增 `asRequstItemRows` 与原始 JSON 保留（`Phase3DatabaseWriter.java:692`）。

### 2.4 `Phase4QuestLucExporter`

**修改前**
- 从 DB 读取与导出使用旧键：`reward_gold` -> `gold`，`quest_reward_item` -> `items`。
- 固定模板输出 `goal/reward`，空字段与零值也会写出。

**修改后**
- 主查询新增读取：`reward_money/reward_fame/reward_pvppoint/reward_mileage/need_item`（`Phase4QuestLucExporter.java:120`）。
- 新增加载：`quest_reward_skill` 与 `quest_requst_item`（`Phase4QuestLucExporter.java:156`, `Phase4QuestLucExporter.java:157`, `Phase4QuestLucExporter.java:274`, `Phase4QuestLucExporter.java:298`）。
- 导出字段改为 Lua 原始键名：`money/getItem/getSkill`（`Phase4QuestLucExporter.java:421`, `Phase4QuestLucExporter.java:437`, `Phase4QuestLucExporter.java:452`, `Phase4QuestLucExporter.java:455`）。
- 顶层新增条件键按需写出：`needItem`、`requstItem`（`Phase4QuestLucExporter.java:358`, `Phase4QuestLucExporter.java:361`）。
- 新增递归 Lua 值序列化，支持 `requstItem` 结构化回写（`Phase4QuestLucExporter.java:644`）。
- 新增 JSON 反序列化用于 `quest_requst_item.raw_json`（`Phase4QuestLucExporter.java:716`）。
- 输出策略改为“字段非空/非0才写出”，并保持固定字段顺序。

### 2.5 `Phase4QuestExportValidator`

**修改前**
- 仅校验 `reward.exp/reward.gold/reward.items`，未覆盖 `needItem/requstItem/fame/pvppoint/mileage/getSkill`。

**修改后**
- 新增校验字段：
  - 条件：`needItem`、`requstItem`（`Phase4QuestExportValidator.java:95`, `Phase4QuestExportValidator.java:97`）
  - 奖励：`reward.money/fame/pvppoint/mileage/getItem/getSkill`（`Phase4QuestExportValidator.java:98`~`Phase4QuestExportValidator.java:112`）
- Luc 侧提取新增：`needItem/requstItem` 与奖励扩展字段汇总（`Phase4QuestExportValidator.java:167`, `Phase4QuestExportValidator.java:168`）。
- Phase4 lua 解析新增旧键兼容读取（`money|gold`, `getItem|items`）并归一到原始语义（`Phase4QuestExportValidator.java:331`, `Phase4QuestExportValidator.java:336`）。
- 新增复杂对象深比较用于 `requstItem`（`Phase4QuestExportValidator.java:469`）。

---

## 3. 每个字段补全逻辑

| 字段 | Extractor | Phase2 JSON | Phase3 落库 | Phase4 导出 | Validator |
|---|---|---|---|---|---|
| `goal.getItem` | 原有识别保留 | 保留顺序输出 | `quest_goal_getitem` | `goal.getItem` | 已校验 |
| `goal.killMonster` | 原有识别保留 | 保留顺序输出 | `quest_goal_killmonster` | `goal.killMonster` | 已校验 |
| `reward.getItem` | 纳入奖励键识别 | 输出 `reward.getItem` | `quest_reward_item` | 输出 `reward.getItem` | 已校验 |
| `reward.getSkill` | 原有识别保留 | 输出 `reward.getSkill` | 新增 `quest_reward_skill` | 输出 `reward.getSkill` | 已校验 |
| `reward.money` | 原有字段保留 | 输出 `reward.money` | `quest_main.reward_money`（兼容回填 `reward_gold`） | 输出 `reward.money` | 已校验 |
| `reward.exp` | 原有字段保留 | 输出 `reward.exp` | `quest_main.reward_exp` | 输出 `reward.exp` | 已校验 |
| `reward.fame` | 原有字段保留 | 输出 `reward.fame` | `quest_main.reward_fame` | 输出 `reward.fame` | 已校验 |
| `reward.pvppoint` | 原有字段保留 | 输出 `reward.pvppoint` | `quest_main.reward_pvppoint` | 输出 `reward.pvppoint` | 已校验 |
| `reward.mileage` | 新增识别绑定 | 输出 `reward.mileage` | `quest_main.reward_mileage` | 输出 `reward.mileage` | 已校验 |
| `needItem` | 新增条件识别 | 输出顶层 `needItem` | `quest_main.need_item` | 输出顶层 `needItem` | 已校验 |
| `requstItem` | 保持条件语义，不并入 goal | 输出顶层 `requstItem`（结构化） | 新增 `quest_requst_item`（含 `raw_json`） | 输出顶层 `requstItem`（结构化） | 已校验 |

---

## 4. 不影响已有功能的证明

1. **旧键兼容读取仍保留**
   - Phase3 读取 reward 时支持 `money|gold`、`getItem|items` 双通道。
   - Phase4 Validator 对导出解析同样兼容旧键。

2. **旧列/旧表不删除**
   - `quest_main.reward_gold` 保留且继续写入（由 `money` 回填），避免历史流程断裂。
   - 仅新增列与新表，不删除任何旧结构。

3. **DB 迁移为最小侵入**
   - 使用 `CREATE TABLE IF NOT EXISTS` + 幂等 `ALTER TABLE ... ADD COLUMN`。
   - 旧库可增量补齐，不要求重建。

4. **写出策略满足最小化**
   - `Phase4QuestLucExporter` 仅输出非空/非0字段，避免模板化全量写出导致结构膨胀。

5. **编译验证通过**
   - 命令：
     - `javac -encoding UTF-8 -d build -cp build -sourcepath src src/unluac/semantic/QuestSemanticExtractor.java src/unluac/semantic/Phase2LucDataExtractionSystem.java src/unluac/semantic/Phase3DatabaseWriter.java src/unluac/semantic/Phase4QuestLucExporter.java src/unluac/semantic/Phase4QuestExportValidator.java`
   - 结果：`0`（编译成功）。

---

## 5. 风险与回滚点（核心链路）

- 涉及核心链路类：`QuestSemanticExtractor`、`Phase2LucDataExtractionSystem`、`Phase3DatabaseWriter`、`Phase4QuestLucExporter`、`Phase4QuestExportValidator`。
- 回滚点：以本次提交前版本为基线，若需回滚可按文件粒度回退上述 5 个类；数据库侧仅新增列/表，回滚可通过不读取新增列表实现逻辑回退。
