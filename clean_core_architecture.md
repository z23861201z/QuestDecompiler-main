# 代码资产瘦身计划（安全保守模式）

## 分析基线
- 分析范围：`src/**/*.java`（共 201 个 Java 类）。
- 依赖图来源：仅基于 Java 真实引用关系（`import`、同包类名引用、全限定名引用、主入口类调用关系）。
- 保守原则：**不确定即保留**，本报告只给建议，不执行删除。
- 强制约束已执行：未把 Phase1~Phase5 主执行类、DB 写入类、导出类放入删除建议。

---

## 1. 核心保留类清单

### 1.1 Phase1~Phase5 主执行链路（必须保留）
- `unluac.Main`（Phase1 入口）
- `unluac.semantic.Phase2LucDataExtractionSystem`（Phase2）
- `unluac.semantic.Phase25QuestNpcDependencyMapper`（Phase2.5）
- `unluac.semantic.Phase3DatabaseWriter`（Phase3 DB 落库）
- `unluac.semantic.Phase4QuestLucExporter`（Phase4 quest 导出）
- `unluac.semantic.Phase5NpcLucExporter`（Phase5 npc 导出）

### 1.2 DB 写入与导出相关（必须保留）
- `unluac.semantic.Phase3DatabaseWriter`
- `unluac.semantic.Phase4QuestLucExporter`
- `unluac.semantic.Phase5NpcLucExporter`
- `unluac.semantic.QuestSemanticJson`（Phase2.5/3/5 读写 JSON 契约核心）

### 1.3 核心依赖闭包（建议整体保留）
以下类被主链路直接或间接引用，属于“最小可运行内核”依赖集合（共 116 类）：
- 解析与反编译基础：`unluac.parse.*`、`unluac.decompile.*`、`unluac.chunk.Lua50ChunkParser`、`unluac.chunk.LuaChunk`
- 语义抽取核心：`unluac.semantic.QuestSemanticExtractor`、`unluac.semantic.QuestSemanticModel`、`unluac.semantic.QuestGoal`
- 对话/目标结构：`unluac.semantic.QuestDialogTree`、`unluac.semantic.QuestDialogTreeExtractor`、`unluac.semantic.DialogNode`、`unluac.semantic.DialogOption`
- 任务目标结构：`unluac.semantic.ItemRequirement`、`unluac.semantic.KillRequirement`

> 说明：完整 116 类清单见 `build/asset_slimming_analysis.json` 中 `keep_core_sorted`。

---

## 2. 建议删除候选类（仅候选，不执行）

以下类满足：
- 不在 Phase1~5 核心依赖闭包中；
- 无任何入边引用（`referenced_by = []`）；
- 非主入口类。

候选列表：
- `unluac.decompile.Disassembler`
- `unluac.decompile.statement.Declare`
- `unluac.parse.LSourceLines`

风险提示：
- 这些仅为**低置信候选**，仍建议先“移动到 archive 并观察”，而不是直接删除。
- 若后续 Web 改造需要调试/诊断能力，`Disassembler` 可能仍有价值。

---

## 3. 建议移动到 archive/ 目录的类（不删除）

### 3.1 纯验证/阶段检查类（非 Phase1~5 核心运行必需）
- `unluac.semantic.Phase6BForcedHighReferenceMutationValidator`
- `unluac.semantic.Phase6CDbDrivenExportValidator`
- `unluac.semantic.Phase6DbMutationAndImpactValidator`
- `unluac.semantic.Phase7DTextImpactValidator`
- `unluac.semantic.RuntimeConsistencyValidator`
- `unluac.editor.QuestDialogJsonValidator`
- `unluac.editor.QuestEditorValidator`

建议归档路径示例：
- `archive/validation/semantic/...`
- `archive/validation/editor/...`

### 3.2 重复功能类（建议归档而非删除）
- `unluac.MainBak`
  - 理由：与 `unluac.Main` 功能重叠，且包含硬编码路径，属于明显历史/备份实现。
- `QuestEditorCli`
  - 理由：仅转发到 `unluac.semantic.QuestEditorCli.main(args)`，属于兼容壳层入口。

建议归档路径示例：
- `archive/legacy/unluac/MainBak.java`
- `archive/compat/QuestEditorCli.java`

> 保守规则：若外部脚本仍依赖这些入口名，则先保留并标注 `@deprecated`，不要立刻迁移。

---

## 4. 当前最小可运行核心路径说明

当前可支撑 Web 改造的最小稳定主链路（按数据契约串联，而非单进程硬调用）：

1. Phase2 数据抽取
- `unluac.semantic.Phase2LucDataExtractionSystem`
- 输入：`quest.luc` + npc Lua 目录
- 输出：`phase2_quest_data.json`、`phase2_npc_reference_index.json`

2. Phase2.5 关联映射
- `unluac.semantic.Phase25QuestNpcDependencyMapper`
- 输入：Phase2 两个 JSON
- 输出：`phase2_5_quest_npc_dependency_graph.json`

3. Phase3 DB 落库
- `unluac.semantic.Phase3DatabaseWriter`
- 输入：Phase2 任务 JSON + Phase2.5 依赖图 JSON
- 输出：MySQL 表数据（`quest_main`、`quest_contents`、`npc_quest_reference` 等）

4. Phase4 quest 导出
- `unluac.semantic.Phase4QuestLucExporter`
- 输入：MySQL
- 输出：quest 导出 Lua 文本

5. Phase5 npc 导出
- `unluac.semantic.Phase5NpcLucExporter`
- 输入：MySQL + Phase2 NPC 索引 JSON
- 输出：npc 导出目录

结论：
- 对 Web 化来说，建议把“Phase2 -> Phase2.5 -> Phase3 -> Phase4/5”固化为服务编排主线。
- `unluac.parse.*` + `unluac.decompile.*` + `unluac.semantic` 核心子集应作为**稳定内核层**，其余验证/历史类进入软归档池。
