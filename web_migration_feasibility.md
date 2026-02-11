# Web化可行性扫描（Phase2~7）

更新时间：2026-02-11
扫描范围：`src/`（仅现有代码，不做推测）

---

## 1. 当前 `src` 结构概览

已扫描到的主包结构：

- `src/unluac/`
  - `chunk/`：Lua 5.0 字节码解析、序列化、结构校验
  - `decompile/`：反编译核心
  - `parse/`：底层解析结构
  - `semantic/`：Phase2~7 业务流程、语义提取、导出、验证
  - `editor/`：Swing 编辑器入口与服务
  - `util/`、`test/`：工具与测试
- `src/META-INF/`

结论：
- 现有工程已经具备“批处理 pipeline + DB + 导出 +校验”的 Web 后端可复用基础。
- Web 化重点不在重写引擎，而在**封装调用链**与**任务编排**。

---

## 2. Phase2~7 入口类确认（实际存在）

以下均为已存在且带 `main` 的入口类：

### Phase2 / 2.5

- `src/unluac/semantic/Phase2LucDataExtractionSystem.java`
  - 入口：`main`
  - 作用：扫描 `quest.luc` + `npc-lua-generated`，生成 phase2 报告
- `src/unluac/semantic/Phase25QuestNpcDependencyMapper.java`
  - 入口：`main`
  - 作用：基于 phase2 两份 JSON 构建 Quest↔NPC 依赖图与汇总

### Phase3

- `src/unluac/semantic/Phase3DatabaseWriter.java`
  - 入口：`main`
  - 作用：建表 + 清表 + 将 phase2/2.5 数据写入 MySQL
- `src/unluac/semantic/Phase3DbConsistencyValidator.java`
  - 入口：`main`
  - 作用：DB roundtrip 一致性校验

### Phase4

- `src/unluac/semantic/Phase4QuestLucExporter.java`
  - 入口：`main`
  - 作用：DB -> quest.lua 导出
- `src/unluac/semantic/Phase4QuestExportValidator.java`
  - 入口：`main`
  - 作用：导出与原始 quest 对比校验

### Phase5

- `src/unluac/semantic/Phase5NpcLucExporter.java`
  - 入口：`main`
  - 作用：DB -> 全量 NPC lua 导出
- `src/unluac/semantic/Phase5NpcExportValidator.java`
  - 入口：`main`
  - 作用：导出 NPC 与原始目录校验

### Phase6

- `src/unluac/semantic/Phase6DbMutationAndImpactValidator.java`
  - 入口：`main`
  - 作用：DB 变更影响验证
- `src/unluac/semantic/Phase6BForcedHighReferenceMutationValidator.java`
  - 入口：`main`
  - 作用：高引用 Quest 强制传播验证
- `src/unluac/semantic/Phase6CDbDrivenExportValidator.java`
  - 入口：`main`
  - 作用：验证 NPC 导出是否真正 DB 驱动

### Phase7

- `src/unluac/semantic/Phase7ANpcTextExtractionSystem.java`
  - 入口：`main`
  - 作用：抽取 NPC_SAY/NPC_ASK 文本并入库
- `src/unluac/semantic/Phase7BNpcTextModelBuilder.java`
  - 入口：`main`
  - 作用：构建 Web 编辑映射表与说明文档
- `src/unluac/semantic/Phase7CNpcTextExporter.java`
  - 入口：`main`
  - 作用：读取 `modifiedText` 精确替换导出 NPC lua
- `src/unluac/semantic/Phase7DTextImpactValidator.java`
  - 入口：`main`
  - 作用：校验文本变更是否仅影响预期节点/文件
- `src/unluac/semantic/Phase7NpcLucBinaryExporter.java`
  - 入口：`main`
  - 作用：将 DB 文本修改打进单个 `npc_xxxx.luc`（字节码级）

---

## 3. 核心引擎类（不可改）

以下是 Web 化适配时应视为“稳定内核”的类/包（建议只封装调用，不改实现）：

### 字节码与反编译基础层

- `src/unluac/Main.java`
- `src/unluac/chunk/Lua50ChunkParser.java`
- `src/unluac/chunk/LuaChunk.java`
- `src/unluac/chunk/Lua50ChunkSerializer.java`
- `src/unluac/chunk/Lua50StructureValidator.java`
- `src/unluac/decompile/*`
- `src/unluac/parse/*`

### 语义核心层

- `src/unluac/semantic/QuestSemanticExtractor.java`
- `src/unluac/semantic/NpcSemanticExtractor.java`
- `src/unluac/semantic/ScriptTypeDetector.java`
- `src/unluac/semantic/QuestSemanticJson.java`
- `src/unluac/semantic/QuestSemanticModel.java`
- `src/unluac/semantic/QuestGoal.java`
- `src/unluac/semantic/QuestDialogTree.java`
- `src/unluac/semantic/QuestDialogTreeExtractor.java`
- `src/unluac/semantic/DialogNode.java`
- `src/unluac/semantic/DialogOption.java`
- `src/unluac/semantic/ItemRequirement.java`
- `src/unluac/semantic/KillRequirement.java`

### 已成链路的阶段核心（AGENTS 约束中已标记）

- `src/unluac/semantic/Phase2LucDataExtractionSystem.java`
- `src/unluac/semantic/Phase25QuestNpcDependencyMapper.java`
- `src/unluac/semantic/Phase3DatabaseWriter.java`
- `src/unluac/semantic/Phase4QuestLucExporter.java`
- `src/unluac/semantic/Phase5NpcLucExporter.java`

---

## 4. Web 封装建议层结构（不新增 Controller，仅架构建议）

目标：保留现有 Phase 引擎，增加“可调用、可编排、可回滚”的服务层。

### 建议分层

1) `web.application`（编排层）
- 职责：组织一次完整业务流程（入库、导出、校验）
- 方式：调用下述 facade，不直接碰底层 parser/chunk

2) `web.facade`（引擎封装层）
- `Phase2Facade` -> 包装 `Phase2LucDataExtractionSystem`
- `Phase25Facade` -> 包装 `Phase25QuestNpcDependencyMapper`
- `Phase3Facade` -> 包装 `Phase3DatabaseWriter` / `Phase3DbConsistencyValidator`
- `Phase4Facade` -> 包装 `Phase4QuestLucExporter` / `Phase4QuestExportValidator`
- `Phase5Facade` -> 包装 `Phase5NpcLucExporter` / `Phase5NpcExportValidator`
- `NpcTextFacade` -> 包装 `Phase7A/B/C/D` + `Phase7NpcLucBinaryExporter`

3) `web.domain.service`（业务规则层）
- 职责：
  - 约束可编辑字段（仅 `modifiedText`）
  - 变更前后校验策略（是否影响非预期文件）
  - 任务状态流转（PENDING/RUNNING/SUCCESS/FAILED）

4) `web.infrastructure`（基础设施层）
- `JdbcProvider`：统一连接池/事务边界
- `ReportStorage`：统一报告落盘与路径管理
- `ProcessLock`：防止并发导出互相覆盖

### 适配原则

- 不改核心算法类，优先“组合调用 + 参数标准化”。
- 保留现有 JSON 报告格式，Web 层直接消费。
- 将 CLI `main` 能力下沉为可重入方法（多数类已具备对应实例方法）。
- 将 I/O 路径和 DB 配置统一收敛到配置层，避免硬编码散落。

---

## 5. 可行性结论

### 结论

- **可行**：当前代码已具备完整 Phase2~7 执行链路，且有稳定入口类。
- **低风险迁移策略**：保持引擎不动，新增 Web 编排与 facade 层。
- **关键前提**：对 `chunk/parse/decompile` 与 `Quest/Npc semantic` 核心类采取“只读封装”。

### 建议优先顺序（Web 落地）

1. 先封装 Phase7 文本编辑链（最直接业务价值）
2. 再封装 Phase3/4/5 的任务化执行
3. 最后封装 Phase6 验证链做发布前质量门禁

