# Phase 3 — Stage-Based 编辑模型重构文档

## 1. 目标与结论

本阶段已完成以下重构：

- 放弃旧的递归对话树编辑 UI（`JTree` 方向）。
- 改为 Stage-Based 编辑模型（阶段式编辑）。
- 界面改为：左侧任务列表 + 右侧 4 个 Tab。
- 保存链路继续走 `luc -> semantic -> csv -> constant patch -> luc`。
- 支持对 `dialog_lines_json[i]` 的常量绑定与补丁写回。

结论：当前实现可用于阶段式编辑，并能保持结构校验通过（`structure_consistent=true`）。

---

## 2. 新模型定义

### 2.1 `QuestStageModel`

文件：`src/unluac/editor/QuestStageModel.java`

```java
public class QuestStageModel {
  public String startDialog = "";
  public int startDialogLineIndex = -1;

  public final List<String> options = new ArrayList<String>();
  public final List<Integer> optionLineIndices = new ArrayList<Integer>();

  public String progressInfo = "";
  public int progressInfoLineIndex = -1;

  public String completionDialog = "";
  public int completionDialogLineIndex = -1;

  public QuestGoal goal = new QuestGoal();
  public QuestReward reward = new QuestReward();
}
```

说明：

- 你要求的核心字段已全部实现：
  - `startDialog`
  - `options`
  - `progressInfo`
  - `completionDialog`
  - `goal`
  - `reward`
- 新增 `*LineIndex` 用于**精准回写原对话行槽位**，避免误改其它常量。

### 2.2 `QuestReward`

文件：`src/unluac/editor/QuestReward.java`

```java
public class QuestReward {
  public int exp;
  public final List<Integer> itemIds = new ArrayList<Integer>();
  public final List<Integer> itemCounts = new ArrayList<Integer>();
}
```

### 2.3 `QuestEditorModel` 扩展

文件：`src/unluac/editor/QuestEditorModel.java`

新增字段：

- `QuestStageModel stage`
- `Map<String, Object> conditionMap`
- `Map<String, String> dialogBindingValues`

---

## 3. Stage 映射规则

文件：`src/unluac/editor/QuestEditorService.java`

### 3.1 读取映射（`buildStageModel`）

输入：`row.dialogLines`（由 semantic 提取）

规则：

1. 第一条非 `ANSWER_` 行 -> `stage.startDialog`。
2. 所有 `ANSWER_...` 行去掉前缀后 -> `stage.options[]`。
3. 第二条非 `ANSWER_` 行 -> `stage.progressInfo`（若存在）。
4. 最后一条非 `ANSWER_` 行 -> `stage.completionDialog`（若存在）。
5. 同时记录每个字段在 `dialogLines` 中的原始索引（`*LineIndex`）。

### 3.2 保存回写（`applyStageBackToLegacyFields`）

回写目标仍是旧 CSV 字段，保持补丁主链不变：

- `description`
- `dialog_lines_json`
- `reward_exp`
- `reward_item_id`
- `reward_item_count`
- `condition_json`

关键策略：

- 优先按 `*LineIndex` 回写到原行位。
- `options` 只替换答案文本，不重排行结构。
- `ANSWER_` 前缀保持原样（包含 `:`、`：`、或历史无分隔格式兼容）。
- 默认不做“扩容插入”，减少字符串长度溢出风险。

### 3.3 安全加载（`loadForEditor` + `sanitizeStageForSafeSave`）

为了避免“打开即保存”时误触发对话字段长度变化：

- 使用 `loadForEditor()` 给 GUI 数据做一次 Stage 字段归一化。
- 保证 Stage 默认值与原始 `dialogLines` 一致，减少无意 diff。

---

## 4. UI 改造（非递归树）

文件：`src/unluac/editor/QuestEditorFrame.java`

### 4.1 布局

- 左侧：任务表（quest 列表）
- 右侧：`JTabbedPane`
  - `基础信息`
  - `对话阶段`
  - `任务目标`
  - `奖励`

### 4.2 对话阶段编辑区

- `startDialog`：接任务对话
- `options`：每行一个选项
- `progressInfo`：进行中提示
- `completionDialog`：完成提示

### 4.3 任务目标编辑区

- `needLevel`
- `goal.items`：每行 `meetcnt,itemid,itemcnt`
- `goal.monsters`：每行 `monsterId,killCount`

### 4.4 奖励编辑区

- `reward_exp`
- `reward_item_id`（JSON int 数组）
- `reward_item_count`（JSON int 数组）

---

## 5. 常量绑定与补丁链路增强

### 5.1 Semantic 提取绑定

文件：`src/unluac/semantic/QuestSemanticExtractor.java`

新增能力：

- 为每条对话行生成 `FieldBinding`：
  - `dialog_lines_json[0]`
  - `dialog_lines_json[1]`
  - ...

实现点：

- `extractStringLeafValues(...)`
- 构建 `FieldBinding.stringBinding(..., "dialog_lines_json[i]", ...)`

### 5.2 PatchApplier 识别对话行

文件：`src/unluac/semantic/QuestSemanticPatchApplier.java`

新增：

- `decidePatchAction(...)` 支持 `dialog_lines_json[i]`
- `parseDialogIndex(...)` 解析下标

结果：

- 对话字段可直接映射到具体 string 常量槽位并补丁。

---

## 6. 保存与结构一致性保证

保存路径：

1. GUI 应用编辑值到 `QuestEditorModel`。
2. Service 生成临时 CSV。
3. 调用 `QuestSemanticPatchApplier.apply(...)`。
4. 产出 patched `.luc`。
5. 调用 `Lua50StructureValidator` 校验。

若出现：

- `string overflow` -> 报错并中止写入。
- `nonConstantDiff > 0` -> 视为结构异常并报错。

---

## 7. 编译与运行

### 7.1 编译

```powershell
javac -encoding UTF-8 -d build -sourcepath src \
  src/unluac/editor/QuestEditorMain.java \
  src/unluac/editor/QuestEditorFrame.java \
  src/unluac/editor/QuestEditorService.java \
  src/unluac/editor/QuestEditorModel.java \
  src/unluac/editor/QuestStageModel.java \
  src/unluac/editor/QuestReward.java \
  src/unluac/semantic/QuestSemanticExtractor.java \
  src/unluac/semantic/QuestSemanticPatchApplier.java
```

### 7.2 运行编辑器

```powershell
java -cp build unluac.editor.QuestEditorMain
```

---

## 8. 已完成自检

本阶段已执行：

- 编译校验：通过。
- `quest.luc` 真实链路保存测试：
  - 结果 `structure_consistent=true`
  - 成功生成 patched `.luc`

说明：

- 仍保留字符串长度上限约束（固定槽位补丁）。
- 该约束是当前补丁机制本身决定，不是 Stage 模型额外引入的问题。

---

## 9. 关键文件清单

- `src/unluac/editor/QuestEditorFrame.java`
- `src/unluac/editor/QuestEditorService.java`
- `src/unluac/editor/QuestEditorModel.java`
- `src/unluac/editor/QuestStageModel.java`
- `src/unluac/editor/QuestReward.java`
- `src/unluac/semantic/QuestSemanticExtractor.java`
- `src/unluac/semantic/QuestSemanticPatchApplier.java`

