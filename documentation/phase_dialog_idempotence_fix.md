# QuestEditor 对话保存幂等修复（结构化模型）

## 问题结论

原保存链路存在非幂等风险：

- 保存时会对全部任务执行回写推导，不区分是否编辑。
- 对话行回写包含“基于旧值再合成”的路径，重复保存可能引入抖动。
- 结果表现为：重复打开/保存后，`dialog_lines_json` 相关常量变更不稳定。

## 本次修复目标

- 不再按字符串拼接 `contents`。
- 对话内容统一来源于结构化模型。
- 保存只处理“脏任务”（被编辑任务），未编辑任务保持原字节不变。
- 同一输入保存 N 次，输出 `.luc` 字节一致（幂等）。

## 新增结构化模型

### `DialogLine`
- 文件：`src/unluac/editor/DialogLine.java`
- 结构：
  - `type`：`TEXT` / `ANSWER`
  - `text`：行文本

### `QuestDialogJsonModel`
- 文件：`src/unluac/editor/QuestDialogJsonModel.java`
- 结构：
  - `lines: List<DialogLine>`

### `QuestEditorModel` 扩展
- 文件：`src/unluac/editor/QuestEditorModel.java`
- 新增：
  - `dialogJsonModel`
  - `dirty`

## 保存链路重写

### 新链路

`GUI编辑 -> QuestStageModel -> QuestDialogJsonModel -> dialog_lines_json -> CSV -> 常量区补丁 -> luc`

### 关键点

1. 仅脏任务参与写回
   - 文件：`src/unluac/editor/QuestEditorService.java`
   - `writeCsv(...)` 中对 `row.dirty == false` 直接跳过。

2. 对话行单向重建，不使用 append/merge
   - `rebuildDialogModelFromStage(...)` 每次 `clear()` 后按当前 stage 全量重建 `lines`。
   - `toDialogLinesJson(...)` 仅按模型序列化为数组。

3. 无变更保存直接拷贝
   - 如果导出 CSV 仅有 header，则直接 `copy(sourceLuc -> outputLuc)`，不触发补丁流程。

4. GUI 应用编辑后显式标记脏
   - 文件：`src/unluac/editor/QuestEditorFrame.java`
   - `applyEditToSelection()` 调用 `service.markDirty(selected)`。

## 幂等性校验代码

### 检查器
- 文件：`src/unluac/editor/QuestEditorIdempotenceCheck.java`
- 执行逻辑：
  1. `source.luc` 保存一次得 `out1`
  2. 读取 `out1` 再保存得 `out2`
  3. 比较 `SHA-256` 与逐字节 diff

### 运行命令

```powershell
java -cp build unluac.editor.QuestEditorIdempotenceCheck D:\TitanGames\GhostOnline\zChina\Script\quest.luc
```

预期输出：
- `byte_equal=true`
- `diff_count=0`

## 单元测试示例

- 文件：`test/src/unluac/editor/QuestEditorIdempotenceTestExample.java`
- 用法：

```powershell
javac -encoding UTF-8 -cp build -d build test/src/unluac/editor/QuestEditorIdempotenceTestExample.java
java -cp build unluac.editor.QuestEditorIdempotenceTestExample D:\TitanGames\GhostOnline\zChina\Script\quest.luc
```

## 结果

- 已通过真实 `quest.luc` 验证：重复保存后输出文件 `SHA-256` 一致，逐字节一致。
- 对话行不再出现重复叠加增长。

