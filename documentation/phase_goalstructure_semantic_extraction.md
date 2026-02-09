# Phase GoalStructure Semantic Extraction

## 0. 范围与结论

本阶段完成内容：

1. 在 `luc -> AST` 语义提取链路中新增 `needLevel / goal.getItem / goal.killMonster / meetcnt / itemid / itemcnt` 提取。
2. 扩展语义模型并输出到 JSON。
3. 扩展 Swing 编辑器，新增任务需求编辑面板（等级、物品需求、杀怪需求）。
4. 对 `meetcnt` 做了指令级与脚本级证据分析。

核心结论：

- `meetcnt` 在 `quest.luc` 中是 **任务需求条目字段**，在当前样本中由 `SETTABLE` 写入表结构。
- 在 `quest.luc` 指令集中，`meetcnt` 的读取次数是 `0`（无 `GETTABLE ... "meetcnt"`）。
- 在已反编译 `npc_*.lua` 的 `chkQState` 逻辑中，状态判断使用的是 `qData[state]` 与 `goal.getItem[].count`，未读取 `meetcnt`。

---

## 1. 代码落地清单

### 1.1 新增模型类

- `src/unluac/semantic/QuestGoal.java`
- `src/unluac/semantic/ItemRequirement.java`
- `src/unluac/semantic/KillRequirement.java`

结构：

- `QuestGoal.needLevel`
- `QuestGoal.items: List<ItemRequirement>`
- `QuestGoal.monsters: List<KillRequirement>`
- `ItemRequirement.meetCount / itemId / itemCount`
- `KillRequirement.monsterId / killCount`

### 1.2 扩展语义主模型

- `src/unluac/semantic/QuestSemanticModel.java`
  - 新增字段：`public QuestGoal goal = new QuestGoal();`

### 1.3 AST 提取器扩展

- `src/unluac/semantic/QuestSemanticExtractor.java`

新增/扩展方法：

- `fillQuestGoalFromValue(...)`
- `fillQuestItemRequirements(...)`
- `fillQuestKillRequirements(...)`
- `collectRequirementTables(...)`
- `hasRequirementLeaf(...)`
- `readIntField(...)`

接入点：

- 读取 `needLevel` 后写入 `model.goal.needLevel`
- 读取 `requstItem` 后写入 `model.goal.items`
- 读取 `goal` 后写入 `model.goal.items` 与 `model.goal.monsters`

### 1.4 JSON 输出扩展

- `src/unluac/semantic/QuestSemanticJson.java`
  - 新增输出块：`"goalSemantic"`
  - 包含：`needLevel / items / monsters`

### 1.5 编辑器模型与服务接线

- `src/unluac/editor/QuestEditorModel.java`
  - 新增字段：`QuestGoal goal`
- `src/unluac/editor/QuestEditorService.java`
  - `loadFromLuc(...)`：将语义层 `goal` 注入编辑层

### 1.6 GUI（Swing）扩展

- `src/unluac/editor/QuestEditorFrame.java`

新增控件：

- `needLevelField`
- `goalItemsArea`（每行 `meetcnt,itemid,itemcnt`）
- `goalMonstersArea`（每行 `monsterId,killCount`）

新增方法：

- `formatItemRequirements(...)`
- `formatKillRequirements(...)`
- `parseItemRequirements(...)`
- `parseKillRequirements(...)`

编辑回写：

- `applyEditToSelection()` 将编辑值写回 `selected.goal`
- `loadSelectionToEditor()` 将 `selected.goal` 装载到 GUI

---

## 2. AST -> GoalStructure 提取规则（固定规则）

### 2.1 Quest 表识别

入口对象必须满足：

1. 表内存在 `id` 字段。
2. 同时命中任务语义键集合之一（`name/contents/needLevel/goal/reward/requstItem/...`）。

实现位置：

- `isQuestSemanticTable(...)`

### 2.2 `needLevel` 提取

规则：

1. 读 `table.fields.get("needLevel")`
2. 若可解析为正整数，写入 `model.goal.needLevel`

实现位置：

- `QuestSemanticExtractor.java` 中 `buildModels(...)` 处理块。

### 2.3 `goal.getItem` 与 `requstItem` 提取

规则：

1. 对 `requstItem` 与 `goal.getItem` 的根值调用 `fillQuestItemRequirements(...)`。
2. 递归遍历子表（数组元素 + 字段子表）：`collectRequirementTables(...)`。
3. 叶子表判定：包含任一键 `itemid/itemcnt/meetcnt/(id+count)`。
4. 字段映射优先级：
   - `itemId`: `itemid` -> `id`
   - `itemCount`: `itemcnt` -> `count`（缺省 `1`）
   - `meetCount`: `meetcnt`（缺省 `0`）
5. 去重键：`(itemId, itemCount, meetCount)`。

### 2.4 `goal.killMonster` 提取

规则：

1. 对 `goal.killMonster` 调用 `fillQuestKillRequirements(...)`。
2. 递归遍历规则与 2.3 一致。
3. 字段映射优先级：
   - `monsterId`: `id` -> `monsterid`
   - `killCount`: `count` -> `killcount`
4. 去重键：`(monsterId, killCount)`。

---

## 3. `meetcnt` 语义与引用路径（证据链）

## 3.1 指令级引用统计

证据文件：`out/meetcnt_rw_stats.txt`

关键结论行：

- `SUMMARY path=root meetcntIndex=33 write=1513 read=0`

含义：

1. `meetcnt` 常量索引是 `33`。
2. `quest.luc` 主函数中，对 `meetcnt` 的引用全部是 `SETTABLE` 写表。
3. 没有出现 `GETTABLE ... "meetcnt"` 读取。

### 3.2 数据样本证据（静态字段，不是运行时累加）

证据 A（多阶段条目）：`out/quest_decompiled.lua`

- `4158-4163`: `requstItem` 中 `meetcnt = 0, itemcnt = 4`
- `4185-4205`: `deleteItem` 中同一物品出现 `meetcnt = 1/2/3/4`

证据 B（单条批量条目）：`out/quest_decompiled.lua`

- `39497-39502`: `deleteItem` 中 `meetcnt = 0, itemcnt = 50`

解释：

1. `meetcnt` 不是固定等于 `itemcnt`。
2. 同一任务可出现 `meetcnt` 序列（1..N）和 `itemcnt=1` 的拆分记录。
3. 同时存在 `meetcnt=0` 且 `itemcnt` 很大的记录。

### 3.3 Quest API 层证据（无 meetcnt getter）

证据文件：`out/quest_decompiled.lua`

- `200354-200374` 提供 `getGoalItemKind/getGoalItem/getGoalItemCount`
- 同区域没有 `getMeetCnt` / `getReqMeetCnt` 之类访问函数。

### 3.4 `chkQState` 路径证据（无 meetcnt 分支）

证据文件：`out/artifacts/QuestDecompiler_main_jar/npc_323009.lua`

- `101-170`: `chkQState(id)` 逻辑分支
- `115-116`, `136-137`, `147-148`: 使用 `CHECK_ITEM_CNT(qt[id].goal.getItem[n].id) >= ...count`
- 全函数无 `meetcnt` 访问。

额外全局检索结果：

- 对 `out/artifacts/QuestDecompiler_main_jar` 下 `npc_*.lua` 扫描 `meetcnt`，匹配数 `0`。

### 3.5 字段用途判定（本仓库证据范围）

1. **字段用途**：`meetcnt` 是 quest 数据表中的需求条目标记字段。
2. **客户端运行时写入**：未发现。当前证据只有加载期构造表的写入。
3. **客户端运行时校验**：未发现。`chkQState` 使用 `qData.state` 与 `goal.getItem[].count`。
4. **服务器校验**：本仓库未包含服务器进程源码/可执行体；在当前可见证据内没有 `meetcnt` 校验路径。

---

## 4. GUI 需求面板行为定义

### 4.1 输入格式

1. `needLevelField`：整数。
2. `goalItemsArea`：每行 `meetcnt,itemid,itemcnt`。
3. `goalMonstersArea`：每行 `monsterId,killCount`。

### 4.2 解析规则

1. 空行忽略。
2. 物品行必须 3 列，杀怪行必须 2 列。
3. 每列严格按整数解析，失败即抛出错误。

### 4.3 回写规则

1. `selected.goal` 为空则初始化。
2. 每次应用前清空旧列表，再按当前文本重新构建。
3. 不修改 instruction/prototype/debug 结构，仅更新语义层对象。

---

## 5. 运行与自检

### 5.1 编译

命令：

```bash
javac -encoding UTF-8 -deprecation -Werror -d build -sourcepath src src/unluac/editor/*.java src/unluac/semantic/*.java src/unluac/*.java src/QuestEditorCli.java
```

结果：成功。

### 5.2 语义提取验证

命令：

```bash
java -cp build unluac.semantic.QuestSemanticExtractTool D:\TitanGames\GhostOnline\zChina\Script\quest.luc out\quest_semantic_goal_v2.json out\quest_semantic_goal_v2_hits.csv
```

结果：

- `quest_count=2602`
- `rule_hit_count=137655`
- `goalSemantic` 已输出（含 `needLevel/items/monsters`）。

### 5.3 导出导入烟雾验证

命令：

```bash
java -cp build QuestEditorCli export D:\TitanGames\GhostOnline\zChina\Script\quest.luc out\phase_goal_smoke.csv
java -cp build QuestEditorCli import D:\TitanGames\GhostOnline\zChina\Script\quest.luc out\phase_goal_smoke.csv out\phase_goal_smoke_patched.luc
```

结果：

- `structure_consistent=true`
- `diff_non_constant_area=0`

---

## 6. 阶段自检结论

1. GoalStructure 语义字段已进入 AST 提取、JSON 输出、GUI 编辑三条链路。
2. `meetcnt` 的引用路径已给出指令级证据与脚本级证据。
3. `chkQState` 路径已给出具体函数文件与行段。
4. 编译与链路烟雾验证均通过。

