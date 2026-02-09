# Phase B — JSON 对话编辑模型（含 YES/NO 与末段分支）

## 目标

将任务对话编辑从“多文本框 + 字符串拼接”改为“结构化 JSON”，并明确区分 `ANSWER_YES` 与 `ANSWER_NO`。

本实现满足：

- `ANSWER` 不是普通 `TEXT`
- JSON 中支持 `branch` 字段标识语义分支
- AST 读写保持前缀可逆映射

---

## 1) JSON 结构定义

文件：`src/unluac/editor/QuestDialogJsonModel.java`

```json
{
  "start": [
    { "type": "TEXT", "text": "大家都说钓鱼很无聊..." },
    { "type": "ANSWER", "branch": "YES", "text": "我还不知道钓鱼的方法呢。" },
    { "type": "ANSWER", "branch": "NO", "text": "我不想钓鱼。" },
    { "type": "TEXT", "branch": "LAST_ANSWER_1", "text": "钓1只鲫鱼还不简单。我去去就来。" },
    { "type": "TEXT", "branch": "LAST_ANSWER_2", "text": "我去采矿了。" },
    { "type": "TEXT", "branch": "LAST_INFO", "text": "在钓鱼场钓1只鲫鱼给清野江钓具店送去吧。" }
  ]
}
```

`DialogLine` 字段定义在 `src/unluac/editor/DialogLine.java`：

- `type`：`TEXT` 或 `ANSWER`
- `branch`：可选语义标记
  - `ANSWER`：必须是 `YES` 或 `NO`
  - `TEXT`：可使用 `LAST_ANSWER_1` / `LAST_ANSWER_2` / ... / `LAST_INFO`
- `text`：显示文本

---

## 2) JSON 校验器

文件：`src/unluac/editor/QuestDialogJsonValidator.java`

入口：

- `QuestDialogJsonValidator.parseAndValidate(String jsonText)`
- `QuestDialogJsonValidator.toJson(QuestDialogJsonModel model)`

强校验规则：

1. 根对象必须包含 `start/progress/complete` 三个数组。
2. 每个数组元素必须是对象，且必须包含 `type/text`。
3. `type` 仅允许 `TEXT` 或 `ANSWER`。
4. `start` 中 `ANSWER` 必须有 `branch`，且只能是 `YES`/`NO`。
5. `progress` 与 `complete` 不允许 `ANSWER`。
6. `TEXT` 若声明 `branch`，仅允许 `LAST_ANSWER_N` 或 `LAST_INFO`。

---

## 3) Swing JSON 编辑器代码

文件：`src/unluac/editor/QuestEditorFrame.java`

关键点：

- “对话阶段”页签使用单一 JSON 编辑框 `dialogJsonArea`
- 任务切换时加载：
  - `dialogJsonArea.setText(QuestDialogJsonValidator.toJson(dialogModel))`
- 点击“应用到当前任务”时：
  - `QuestDialogJsonModel dialogModel = QuestDialogJsonValidator.parseAndValidate(dialogJsonArea.getText());`
  - `service.applyDialogJsonModel(selected, dialogModel);`

---

## 4) AST 解析与生成代码（完整路径）

文件：`src/unluac/editor/QuestEditorService.java`

### 4.1 AST 行解析为 JSON 行

方法：`toDialogLine(String raw, int answerOrdinal)`

- 普通行：
  - `type = TEXT`
  - `text = raw`
- 答案行（前缀 `ANSWER_`）：
  - `type = ANSWER`
  - `branch = extractAnswerBranch(...)`
  - `text = parseAnswerOptionText(...)`（去除 `ANSWER_XXX:` 前缀）

分支识别方法：`extractAnswerBranch(String line, int fallbackOrdinal)`

- `ANSWER_YES:...` -> `branch = YES`
- `ANSWER_NO:...` -> `branch = NO`
- 其他 `ANSWER_` token：按序号回退（第一个 YES，其余 NO）

### 4.2 JSON 行生成 AST 行

方法：`toAstLine(DialogLine dialogLine)`

- `type = TEXT`：直接输出 `text`
- `type = ANSWER`：
  - `branch = YES` -> 输出 `ANSWER_YES:<text>`
  - `branch = NO` -> 输出 `ANSWER_NO:<text>`
- `type = TEXT`：
  - `branch = LAST_ANSWER_N` 或 `LAST_INFO` 仍输出纯文本（不加 `ANSWER_` 前缀）

### 4.3 JSON 顺序映射到 AST

方法：`dialogModelToLines(QuestDialogJsonModel model)`

严格顺序：

1. `start[]`
2. `progress[]`
3. `complete[]`

不自动补全，不自动复制旧行。

---

## 5) 单元测试（YES/NO 分支）

文件：`test/src/unluac/editor/QuestDialogAnswerBranchTest.java`

覆盖项：

1. `ANSWER` 缺失 `branch` 会被拒绝
2. `ANSWER_YES/ANSWER_NO` 可正确解析为 `branch=YES/NO`
3. `branch=YES/NO` 可正确生成 `ANSWER_YES/ANSWER_NO` 前缀
4. `applyDialogJsonModel` 后 `dialogLinesJson` 行顺序和内容正确
5. `LAST_ANSWER_N/LAST_INFO` 可校验、可写回纯文本

运行：

```powershell
javac -encoding UTF-8 -d build -cp build -sourcepath src test/src/unluac/editor/QuestDialogAnswerBranchTest.java
java -cp build unluac.editor.QuestDialogAnswerBranchTest
```

---

## 6) 启动编辑器与使用

编译：

```powershell
javac -encoding UTF-8 -d build -sourcepath src src/unluac/editor/QuestEditorMain.java
```

启动 GUI：

```powershell
java -cp build unluac.editor.QuestEditorMain
```

在 GUI 中操作：

1. 打开 `.luc`
2. 在“对话阶段”页签编辑 JSON
3. 点击“应用到当前任务”
4. 保存输出新的 `.luc`
