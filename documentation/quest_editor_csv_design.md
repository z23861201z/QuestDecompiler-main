# QuestEditor CSV 结构设计（基于 QuestSemanticModel）

## 1. 目标

本设计用于 `QuestSemanticModel` 的**按任务分组**编辑与回写，满足：

1. 不输出 `constant_index`
2. 以 `quest_id` 为唯一分组键（1 行 = 1 个任务）
3. 必含字段：
   - `quest_id`
   - `title`
   - `description`
   - `pre_quest_ids`
   - `reward_exp`
   - `reward_item_id`
   - `reward_item_count`
   - `dialog_lines_json`
   - `condition_json`
4. 修改 CSV 后可 100% 还原回 `QuestSemanticModel`（字段级等价）

---

## 2. CSV 总体规范

- 编码：`UTF-8`
- 分隔符：`,`
- 转义：RFC4180（字段含 `,` / `"` / 换行时必须双引号包裹，内部 `"` 写成 `""`）
- 行结束：`
`
- 主键：`quest_id`（全表唯一）
- 排序建议：`quest_id` 升序

---

## 3. 列定义（含必含列 + 无损列）

> 说明：为保证“100%还原”，在必含列之外增加 2 个无损列。

| 列名 | 必填 | 类型 | 说明 |
|---|---|---|---|
| `quest_id` | 是 | int | 任务ID，`>0`，全表唯一 |
| `title` | 是 | string | 对应 `QuestSemanticModel.title` |
| `description` | 是 | string | 对应 `QuestSemanticModel.description` |
| `pre_quest_ids` | 是 | JSON array<int> | 对应 `preQuestIds`，如 `[]`、`[1001,1002]` |
| `reward_exp` | 是 | int | 奖励经验投影值 |
| `reward_item_id` | 是 | JSON array<int> | 物品奖励ID投影，如 `[]`、`[30001,30002]` |
| `reward_item_count` | 是 | JSON array<int> | 与 `reward_item_id` 一一对应，如 `[2,5]` |
| `dialog_lines_json` | 是 | JSON array<string> | 对应 `dialogLines` |
| `condition_json` | 是 | JSON object | 对应 `conditions` |
| `rewards_json` | 是 | JSON array<object> | **无损列**，完整 `rewards` 列表 |
| `completion_condition_json` | 是 | JSON object | **无损列**，对应 `completionConditions` |
| `schema_version` | 是 | string | 固定 `quest_csv_v1` |

---

## 4. 每列数据格式说明

## 4.1 `quest_id`
- 十进制整数，取值 `> 0`
- 导入校验：不得重复

## 4.2 `title` / `description`
- 普通文本列
- 允许空字符串

## 4.3 `pre_quest_ids`
- 必须是 JSON 数组，元素必须是整数
- 示例：`[]`、`[1001]`、`[1001,1002]`

## 4.4 `reward_exp`
- 十进制整数
- 表示经验奖励投影（用于快速编辑）

## 4.5 `reward_item_id` 与 `reward_item_count`
- 两列均为 JSON 数组
- 长度必须一致，按同索引配对
  - `reward_item_id[i]` 对应 `reward_item_count[i]`

## 4.6 `dialog_lines_json`
- JSON 数组，元素必须是字符串

## 4.7 `condition_json`
- JSON 对象，键为条件字段名，值可为标量/对象/数组

## 4.8 `rewards_json`（无损核心）
- JSON 数组，每项是完整 Reward 对象：
  - `type` (string)
  - `id` (int)
  - `count` (int)
  - `money` (int)
  - `exp` (int)
  - `attrs` (object)

## 4.9 `completion_condition_json`
- JSON 对象，对应 `completionConditions`

## 4.10 `schema_version`
- 固定值：`quest_csv_v1`

---

## 5. 示例数据（3个完整任务）

```csv
quest_id,title,description,pre_quest_ids,reward_exp,reward_item_id,reward_item_count,dialog_lines_json,condition_json,rewards_json,completion_condition_json,schema_version
1001,新手试炼,击败3只野狼并回报,[],120,"[30001]","[2]","[""你好，勇士。"",""去击败野狼。"",""做得好。""]","{""needLevel"":2,""needQuest"":[]}","[{""type"":""exp"",""id"":0,""count"":0,""money"":0,""exp"":120,""attrs"":{}},{""type"":""item"",""id"":30001,""count"":2,""money"":0,""exp"":0,""attrs"":{}},{""type"":""currency"",""id"":0,""count"":0,""money"":50,""exp"":0,""attrs"":{""fame"":1}}]","{""goal"":{""killMonster"":[{""id"":10101,""count"":3}]}}",quest_csv_v1
1002,林地补给,收集草药并交付给药师,[1001],200,"[30002,30003]","[1,5]","[""这些草药很重要。"",""请尽快送来。"",""辛苦了。""]","{""needLevel"":4,""needQuest"":[1001]}","[{""type"":""exp"",""id"":0,""count"":0,""money"":0,""exp"":200,""attrs"":{}},{""type"":""item"",""id"":30002,""count"":1,""money"":0,""exp"":0,""attrs"":{}},{""type"":""item"",""id"":30003,""count"":5,""money"":0,""exp"":0,""attrs"":{}},{""type"":""currency"",""id"":0,""count"":0,""money"":80,""exp"":0,""attrs"":{""fame"":2}}]","{""goal"":{""getItem"":[{""id"":40001,""count"":5}]}}",quest_csv_v1
1003,古井调查,与村长对话后前往古井,[1002],350,"[30010]","[1]","[""村里最近不太平。"",""去古井看看。"",""带回你的发现。""]","{""needLevel"":6,""needQuest"":[1002],""region"":""village_west""}","[{""type"":""exp"",""id"":0,""count"":0,""money"":0,""exp"":350,""attrs"":{}},{""type"":""item"",""id"":30010,""count"":1,""money"":0,""exp"":0,""attrs"":{""quality"":""rare""}},{""type"":""currency"",""id"":0,""count"":0,""money"":120,""exp"":0,""attrs"":{""fame"":3}}]","{""goal"":{""meetNpc"":[4214005],""investigate"":true}}",quest_csv_v1
```

---

## 6. QuestSemanticModel -> CSV 导出规则

## 6.1 分组规则
- 遍历 `List<QuestSemanticModel>`
- 每个 `model` 输出 1 行
- `quest_id = model.questId`

## 6.2 字段映射

- `quest_id` = `model.questId`
- `title` = `model.title`
- `description` = `model.description`
- `pre_quest_ids` = JSON(model.preQuestIds)
- `dialog_lines_json` = JSON(model.dialogLines)
- `condition_json` = JSON(model.conditions)
- `completion_condition_json` = JSON(model.completionConditions)
- `rewards_json` = JSON(model.rewards)
- `reward_exp` = `sum(reward.exp)`
- `reward_item_id` = JSON(按 rewards 顺序提取 item 奖励 id 列表)
- `reward_item_count` = JSON(按同顺序提取 item 奖励 count 列表)
- `schema_version` = `quest_csv_v1`

## 6.3 一致性回填
- 导出时同步校验：
  - `len(reward_item_id) == len(reward_item_count)`
  - `reward_exp` 与 `rewards_json` 计算值一致

---

## 7. CSV -> QuestSemanticModel 解析规则

## 7.1 基础解析
- 读取表头并校验全部必需列存在
- `schema_version` 必须是 `quest_csv_v1`
- `quest_id` 唯一

## 7.2 JSON 列解析
- `pre_quest_ids` -> `List<Integer>`
- `dialog_lines_json` -> `List<String>`
- `condition_json` -> `Map<String,Object>`
- `completion_condition_json` -> `Map<String,Object>`
- `rewards_json` -> `List<Reward>`

## 7.3 奖励投影对齐（保证可编辑）

导入时使用以下**确定性对齐规则**：

1. 先以 `rewards_json` 作为基础奖励列表 `baseRewards`
2. 从 `baseRewards` 提取：
   - `baseExp = sum(exp)`
   - `baseItemIds/baseItemCounts`
3. 比较投影列：
   - `reward_exp`
   - `reward_item_id`
   - `reward_item_count`
4. 若投影与基础一致：
   - 直接保留 `baseRewards`（无损）
5. 若不一致：
   - 进入“投影覆盖模式”：
     - 仅更新 `exp` 与 item 奖励（按索引稳定覆盖）
     - 非 item/exp 奖励项（如 money/fame 扩展）原样保留
     - 最终生成新的 `rewards`

这样可支持两种编辑方式：
- 编辑 `rewards_json`（全量编辑）
- 仅编辑 `reward_exp/reward_item_*`（快捷编辑）

---

## 8. 100% 还原保证说明

“100%还原”定义为：导入得到的 `QuestSemanticModel` 与导出前对象在以下维度**字段级完全等价**：

- `questId`
- `title`
- `description`
- `preQuestIds`（顺序一致）
- `dialogLines`（顺序一致）
- `conditions`（深度等价）
- `completionConditions`（深度等价）
- `rewards`（列表顺序 + 每个 Reward 字段与 attrs 深度等价）

达成条件：

1. 使用本设计定义的 `rewards_json` + `completion_condition_json` 无损列
2. 导入时严格执行列校验和 JSON 类型校验
3. 投影列与 `rewards_json` 不一致时，按第7.3节确定性规则进行覆盖，行为可重复

---

## 9. 为什么本方案不需要 constant_index

本 CSV 结构完全基于语义模型字段（任务、对话、条件、奖励）组织，
不包含、也不依赖 `constant_index`，因此满足“语义编辑”需求并与底层常量池位置解耦。

