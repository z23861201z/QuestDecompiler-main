# QuestDecompiler 资产改动系统指南（安全保守模式）

本文件用于约束后续智能体在本仓库的默认行为。

## 总原则
- 默认目标：保障 Phase1~Phase5 稳定链路，不做激进瘦身。
- 未明确要求时：**不删除、不迁移、不重命名**任何类。
- 遇到不确定类：**默认保留**。
- 仅在用户明确要求时，才允许触碰“验证类/历史类/候选废弃类”。

## 必须保留（核心链路）
以下主执行类默认不得删除或破坏签名：
- `unluac.Main`
- `unluac.semantic.Phase2LucDataExtractionSystem`
- `unluac.semantic.Phase25QuestNpcDependencyMapper`
- `unluac.semantic.Phase3DatabaseWriter`
- `unluac.semantic.Phase4QuestLucExporter`
- `unluac.semantic.Phase5NpcLucExporter`

以下 DB 与导出核心类默认不得删除：
- `unluac.semantic.Phase3DatabaseWriter`
- `unluac.semantic.Phase4QuestLucExporter`
- `unluac.semantic.Phase5NpcLucExporter`
- `unluac.semantic.QuestSemanticJson`

## 默认不改动的稳定基础层
未被明确点名时，避免改动以下基础包（它们是核心依赖闭包的一部分）：
- `unluac.parse.*`
- `unluac.decompile.*`
- `unluac.chunk.Lua50ChunkParser`
- `unluac.chunk.LuaChunk`
- `unluac.semantic.QuestSemanticExtractor`
- `unluac.semantic.QuestSemanticModel`
- `unluac.semantic.QuestGoal`
- `unluac.semantic.QuestDialogTree`
- `unluac.semantic.QuestDialogTreeExtractor`
- `unluac.semantic.DialogNode`
- `unluac.semantic.DialogOption`
- `unluac.semantic.ItemRequirement`
- `unluac.semantic.KillRequirement`

## 疑似无效代码（仅标记，不自动处理）
定义：当前静态依赖图中“无入边引用 + 非入口”。

候选（低置信，仅作提示）：
- `unluac.decompile.Disassembler`
- `unluac.decompile.statement.Declare`
- `unluac.parse.LSourceLines`

处理规则：
- 未收到明确指令时，**不要修改、不要删除**。
- 如用户要求清理，先给影响评估，再执行最小变更。

## 纯验证/阶段性类（默认不进入核心改造）
以下类默认视为“验证用途”，除非用户明确要求，否则不改：
- `unluac.semantic.Phase3DbConsistencyValidator`
- `unluac.semantic.Phase4QuestExportValidator`
- `unluac.semantic.Phase5NpcExportValidator`
- `unluac.semantic.Phase6BForcedHighReferenceMutationValidator`
- `unluac.semantic.Phase6CDbDrivenExportValidator`
- `unluac.semantic.Phase6DbMutationAndImpactValidator`
- `unluac.semantic.Phase7DTextImpactValidator`
- `unluac.semantic.RuntimeConsistencyValidator`
- `unluac.editor.QuestDialogJsonValidator`
- `unluac.editor.QuestEditorValidator`

## 重复/历史实现（默认归为 legacy，不自动处理）
- `unluac.MainBak`（历史备份实现）
- `QuestEditorCli`（入口转发壳，转发到 `unluac.semantic.QuestEditorCli`）

处理规则：
- 默认保留兼容性。
- 只有在用户明确“可以迁移/归档”时，才进行目录调整。

## 对后续智能体的执行要求
- 优先改业务增量代码，不改核心稳定层。
- 若任务涉及核心链路类，必须在回复中说明改动风险与回滚点。
- 不得把“候选无效类”当成“已确认废弃类”。
- 若需要清理，先输出计划与影响范围，再等待用户确认。

## 参考分析文件
- `clean_core_architecture.md`
- `build/asset_slimming_analysis.json`

## Luc ↔ MySQL 双向链路入口（新增）

本节用于后续人员快速定位“读取/入库/导出/验证”代码入口。

### 1) `luc -> 应用读取 -> 写入 MySQL`

#### Quest / NPC 结构入库主链路
- 读取与抽取：`src/unluac/semantic/Phase2LucDataExtractionSystem.java`
  - 输入：`quest.luc` + `npc-lua-generated/`
  - 输出：`reports/phase2_quest_data.json`、`reports/phase2_npc_reference_index.json`、`reports/phase2_scan_summary.json`
- 关系图聚合：`src/unluac/semantic/Phase25QuestNpcDependencyMapper.java`
  - 输入：`phase2_quest_data.json` + `phase2_npc_reference_index.json`
  - 输出：`reports/phase2_5_quest_npc_dependency_graph.json`、`reports/phase2_5_dependency_summary.json`
- 入库写入：`src/unluac/semantic/Phase3DatabaseWriter.java`
  - 输入：`phase2_quest_data.json` + `phase2_5_quest_npc_dependency_graph.json`
  - 写入库：`ghost_game`（quest/npc 相关表）

#### NPC 对话文本入库链路（Web 文本编辑依赖）
- 文本抽取入库：`src/unluac/semantic/Phase7ANpcTextExtractionSystem.java`
  - 从 `npc-lua-generated/*.lua` AST 抽取 `NPC_SAY` / `NPC_ASK`
  - 写入表：`npc_dialogue_text`
- 编辑映射建模：`src/unluac/semantic/Phase7BNpcTextModelBuilder.java`
  - 从 phase7A 报告构建 Web 可编辑表
  - 写入表：`npc_text_edit_map`

### 2) `MySQL 修改 -> 保存 DB -> 导出 luc -> 客户端读取`

#### 编辑约束（必须遵守）
- 仅改：`npc_text_edit_map.modifiedText`
- 不改：`rawText`、`stringLiteral`（二者属于基线定位/原始字面量信息）
- 导出器只会处理：`modifiedText IS NOT NULL AND modifiedText <> rawText`

#### 导出与验证代码入口
- DB 文本导出到 Lua：`src/unluac/semantic/Phase7CNpcTextExporter.java`
  - 输入：`npc_text_edit_map`（优先）/`npc_dialogue_text`（兼容）
  - 输出：`reports/phase7C_exported_npc/*.lua`
- DB 文本补丁导出到 Luc（字节码）：`src/unluac/semantic/Phase7NpcLucBinaryExporter.java`
  - 输入：原始 `npc_xxxx.luc` + `npc_text_edit_map` 改动
  - 输出：指定 `npc_xxxx.luc`（可直接给客户端替换）
  - 原理：仅替换字符串常量，使用 `Lua50StructureValidator` 校验结构一致性
- 文本改动影响验证：`src/unluac/semantic/Phase7DTextImpactValidator.java`
  - 验证“是否只改了预期文本节点，且没有结构改动”
  - 输出：`reports/phase7D_text_mutation_validation.json`

#### 常用命令（示例）
- 导出 Lua：
  - `java -cp build unluac.semantic.Phase7CNpcTextExporter "D:/TitanGames/GhostOnline/zChina/Script/npc-lua-generated" "reports/phase7C_exported_npc" "reports/phase7C_export_validation.json"`
- 导出单个 NPC Luc（客户端替换用）：
  - `java "-Dunluac.stringCharset=GBK" -cp build unluac.semantic.Phase7NpcLucBinaryExporter "npc_218008.lua" "D:/TitanGames/GhostOnline/zChina/Script/npc_218008.luc" "reports/npc_218008.luc"`

## 涉及数据库表（功能 + 核心字段）

### Quest 主数据与结构表（Phase3）
- `quest_main`
  - 功能：任务主表（单行任务头信息）
  - 核心字段：`quest_id`(PK), `name`, `need_level`, `bq_loop`, `reward_exp`, `reward_gold`
- `quest_contents`
  - 功能：任务 `contents[]` 顺序文本
  - 核心字段：`quest_id`, `seq_index`, `text`（`quest_id+seq_index` 唯一）
- `quest_answer`
  - 功能：任务 `answer[]` 顺序文本
  - 核心字段：`quest_id`, `seq_index`, `text`
- `quest_info`
  - 功能：任务 `info[]` 顺序文本
  - 核心字段：`quest_id`, `seq_index`, `text`
- `quest_goal_getitem`
  - 功能：目标 `goal.getItem[]`
  - 核心字段：`quest_id`, `seq_index`, `item_id`, `item_count`
- `quest_goal_killmonster`
  - 功能：目标 `goal.killMonster[]`
  - 核心字段：`quest_id`, `seq_index`, `monster_id`, `monster_count`
- `quest_goal_meetnpc`
  - 功能：目标 `goal.meetNpc[]`
  - 核心字段：`quest_id`, `seq_index`, `npc_id`
- `quest_reward_item`
  - 功能：奖励 `reward.items[]`
  - 核心字段：`quest_id`, `seq_index`, `item_id`, `item_count`
- `npc_quest_reference`
  - 功能：NPC ↔ Quest 引用关系索引
  - 核心字段：`npc_file`, `quest_id`, `reference_count`, `goal_access_count`

### NPC 对话文本表（Phase7）
- `npc_dialogue_text`（抽取层）
  - 功能：从原始 NPC Lua AST 抽取的文本基线快照（Phase7A）
  - 核心字段：`id`(PK), `npc_file`, `call_type`, `line_number`, `column_number`, `raw_text`, `string_literal`, `ast_marker`
  - 说明：该表主要用于“原始定位与审计”，不作为首选编辑入口
- `npc_text_edit_map`（编辑层）
  - 功能：Web 编辑映射表（Phase7B/7C/7D 主要使用）
  - 核心字段：`textId`(PK), `npcFile`, `line`, `columnNumber`, `callType`, `rawText`, `modifiedText`, `stringLiteral`, `astMarker`
  - 说明：实际改文案时只改 `modifiedText`；`rawText/stringLiteral` 保留基线与定位

### 字段使用约定（必须遵守）
- 编辑时：仅写 `npc_text_edit_map.modifiedText`
- 不改：`rawText`、`stringLiteral`
- 导出生效条件：`modifiedText IS NOT NULL AND modifiedText <> rawText`
- 定位优先级：`astMarker` > `npcFile + line + column(+callType)`

## 2026-02-12 Quest 字段补全（Phase2/3/4 + Extractor）

本节用于记录“在现有 `ghost_game` 表结构上做补全，不重建库”的实现入口。

### 1) 代码入口
- Extractor：`src/unluac/semantic/QuestSemanticExtractor.java`
  - 新增条件字段识别：`needItem`、`deleteItem`
- Phase2 抽取：`src/unluac/semantic/Phase2LucDataExtractionSystem.java`
  - 输出补全：`conditions`、`reward.fame/pvppoint/mileage/skills/extra`、`goal.extra`
- Phase3 入库：`src/unluac/semantic/Phase3DatabaseWriter.java`
  - `quest_main` 增量补列 + `quest_reward_skill` 写入
- Phase3 回读校验：`src/unluac/semantic/Phase3DbConsistencyValidator.java`
- Phase4 导出：`src/unluac/semantic/Phase4QuestLucExporter.java`
- Phase4 导出校验：`src/unluac/semantic/Phase4QuestExportValidator.java`

### 2) 数据库补全点（ghost_game）
- `quest_main` 新增字段：
  - `reward_fame`
  - `reward_pvppoint`
  - `reward_mileage`
  - `reward_extra_json`
  - `goal_extra_json`
  - `conditions_json`
- 新增表：
  - `quest_reward_skill(quest_id, seq_index, skill_id)`

### 3) 变更留档文档
- 变更总记录：`documentation/phase2_4_field_completion_change_log.md`
- 迁移 SQL：`documentation/sql/phase2_4_field_completion_migration.sql`
- 回滚 SQL：`documentation/sql/phase2_4_field_completion_rollback.sql`
