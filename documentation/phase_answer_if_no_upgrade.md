# Phase Answer Branch Upgrade（支持 `ANSWER_IF_NO`）

## 1) 新枚举定义

文件：`src/unluac/editor/DialogLine.java`

新增常量：

- `DialogLine.BRANCH_IF_NO = "IF_NO"`

`ANSWER` 分支集合现在为：

- `YES`
- `NO`
- `IF_NO`

---

## 2) 解析代码（AST -> JSON）

文件：`src/unluac/editor/QuestEditorService.java`

关键方法：`extractAnswerBranch(String line, int fallbackOrdinal)`

解析规则：

- `ANSWER_YES:xxx` -> `branch = YES`
- `ANSWER_NO:xxx` -> `branch = NO`
- `ANSWER_IF_NO:xxx` -> `branch = IF_NO`

对应代码位置：`src/unluac/editor/QuestEditorService.java:546`

---

## 3) 生成代码（JSON -> AST）

文件：`src/unluac/editor/QuestEditorService.java`

关键方法：`toAstLine(DialogLine dialogLine)`

生成规则：

- `type=ANSWER, branch=YES` -> `ANSWER_YES:<text>`
- `type=ANSWER, branch=NO` -> `ANSWER_NO:<text>`
- `type=ANSWER, branch=IF_NO` -> `ANSWER_IF_NO:<text>`

对应代码位置：`src/unluac/editor/QuestEditorService.java:531`

---

## 4) JSON 校验器

文件：`src/unluac/editor/QuestDialogJsonValidator.java`

`ANSWER` 分支校验更新为允许：

- `YES`
- `NO`
- `IF_NO`

对应代码位置：`src/unluac/editor/QuestDialogJsonValidator.java:118`

JSON 示例：

```json
{
  "start": [
    { "type": "ANSWER", "branch": "YES", "text": "接受" },
    { "type": "ANSWER", "branch": "NO", "text": "拒绝" },
    { "type": "ANSWER", "branch": "IF_NO", "text": "若不满足条件则拒绝" }
  ],
  "progress": [],
  "complete": []
}
```

---

## 5) GUI 修改代码

文件：`src/unluac/editor/QuestEditorFrame.java`

新增控件：

- `JComboBox<String> answerBranchCombo`
  - 选项：`YES` / `NO` / `IF_NO`
  - 默认：`YES`
- `JTextField answerTextField`
- 按钮：`追加到 start`

新增方法：

- `buildAnswerQuickAppendPanel()`
- `appendAnswerLineToDialogJson()`

行为：

- 通过下拉框选择 branch，输入文本后一键追加到 `start[]`
- 仍走 JSON 校验器，非法结构直接报错

对应代码位置：

- `src/unluac/editor/QuestEditorFrame.java:65`
- `src/unluac/editor/QuestEditorFrame.java:207`
- `src/unluac/editor/QuestEditorFrame.java:438`

---

## 6) 单元测试

文件：`test/src/unluac/editor/QuestDialogAnswerBranchTest.java`

新增覆盖：

1. JSON 校验接受 `IF_NO`
2. 解析 `ANSWER_IF_NO:` -> `branch=IF_NO`
3. 生成 `branch=IF_NO` -> `ANSWER_IF_NO:`
4. roundtrip 后分支不丢失

运行：

```powershell
javac -encoding UTF-8 -d build -cp build -sourcepath src test/src/unluac/editor/QuestDialogAnswerBranchTest.java
java -cp build unluac.editor.QuestDialogAnswerBranchTest
```

