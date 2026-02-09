# Phase 3 补充：可变长度对话阶段兼容修复

## 背景
- 旧的 Stage 模型默认只有固定 4 段（start/options/progress/completion）。
- 实际 `quest.lua` 中大量任务是**多轮交错对话**：`contents[]` 与 `ANSWER_...` 反复出现，长度不固定。
- 典型样例：`quest_id=1206`，包含多轮 `ANSWER_YES`，并且后续还有 `answer[]`、`info[]`。

## 本次修复目标
- 保留 Stage-Based 编辑方向（不回退递归树）。
- 支持 `dialog_lines_json` 的**全量行编辑**（可变长度）。
- 保存时只走 constant patch，不改指令/原型结构。

## 代码变更

### 1) Stage 模型升级
- 文件：`src/unluac/editor/QuestStageModel.java:10`
- 新增：
  - `dialogStageLines`：完整可编辑对话行列表
  - `dialogStageLineIndices`：每行对应原始 `dialog_lines_json` 索引
- 兼容字段仍保留：`startDialog/options/progressInfo/completionDialog`

### 2) Service 映射升级
- 文件：`src/unluac/editor/QuestEditorService.java:190`
- 核心逻辑：
  - `buildStageModel(...)` 先初始化 `dialogStageLines`，再从中回填 legacy 4 字段。
  - `rebuildDialogLines(...)` 优先按 `dialogStageLineIndices` 回写，避免强行截断为 4 段。
  - `applyDialogStageLinesByIndex(...)` 仅替换目标行，不重排整体结构。

### 3) GUI 升级
- 文件：`src/unluac/editor/QuestEditorFrame.java:185`
- “对话阶段”页新增主编辑框：
  - `dialogStageLinesArea`（每行一个原始槽位；保留 `ANSWER_` 前缀）
- legacy 4 字段继续显示，作为兼容视图。

## 对 `quest_id=1206` 的验证

### 1) 解析验证
- 输入：`D:\TitanGames\GhostOnline\zChina\Script\quest.luc`
- 结果：`quest_id=1206` 提取 `dialogStageLines=20`
- 提取到的 `ANSWER_` 选项数量：`8`

说明：该结果覆盖了你给的多轮样例（多次 `ANSWER_YES` 交错在正文之间），不再被压缩成固定 4 段。

### 2) 写回验证
- 将 `1206` 的中间一行做小幅修改后保存。
- 输出：`out/quest1206_varlen_patch.luc`（验证后已清理测试文件）
- 校验结果：
  - `structure_consistent=true`
  - `nonConstantDiff=0`
  - 指令数/常量数/原型数/debug 计数一致

## 使用说明（编辑器内）
1. 打开 `quest.luc`。
2. 选中任务（如 `1206`）。
3. 在“对话阶段”页优先编辑“可变长度对话阶段”文本框。
4. 每行对应一个原始文本槽位；`ANSWER_...` 前缀不要删。
5. 保存为新 `.luc`；若字符串超槽位会报 `string overflow` 并中止写入。

## 兼容策略说明
- 4 字段模式仍可用，但不再是主存储结构。
- 实际写回以 `dialogStageLines` 为准，4 字段用于展示/快速编辑兼容。
- 对于复杂长任务（如 1206）建议只改“可变长度对话阶段”区域，避免语义折叠。

