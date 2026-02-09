# QuestDecompiler 项目结构拆解

## 1. 项目总体定位

`QuestDecompiler-main` 是一个围绕 `luc <-> lua`、`luc AST 语义提取`、`Quest/NPC 编辑与补丁` 的 Java 工具集。项目目前同时包含：

- 反编译：`luc -> lua`
- 编译/重编码：`lua -> luc`
- AST 解析、结构校验、字节级 patch
- QuestEditor GUI 与 CLI
- Quest/NPC 语义扫描与字段覆盖报告

---

## 2. 根目录结构（高层）

- `src/`：核心源码目录（主要关注 `src/unluac`）
- `test/`：测试与样例脚本
- `documentation/`：阶段文档、使用手册、扫描报告
- `build/`：编译输出目录
- `out/`：运行产物/临时输出目录

备注：`src/.venv`、`src/build` 不是核心 Java 业务代码目录，阅读源码时可优先忽略。

---

## 3. 核心源码分层（`src/unluac`）

### 3.1 顶层入口类

- `src/unluac/Main.java`：主反编译入口（`luc -> lua`）
- `src/unluac/editor/QuestEditorMain.java`：QuestEditor Swing GUI 入口
- `src/unluac/semantic/QuestEditorCli.java`：QuestEditor 命令行入口（CSV 导入导出、回写）
- `src/unluac/semantic/QuestFieldCoverageScanner.java`：Quest/NPC 全量扫描入口

### 3.2 `chunk`（Lua 5.0 chunk 二进制层）

- 代表文件：
  - `src/unluac/chunk/LuaChunk.java`
  - `src/unluac/chunk/Lua50ChunkParser.java`
  - `src/unluac/chunk/Lua50ChunkSerializer.java`
  - `src/unluac/chunk/Lua50StructureValidator.java`
- 职责：
  - luc 的字节级读取、对象化
  - AST/chunk 序列化写回
  - 结构一致性校验（header/instruction/prototype/debug）

### 3.3 `parse`（底层 Lua 对象类型系统）

- 代表文件：`src/unluac/parse/LFunction.java`、`src/unluac/parse/LString.java` 等
- 职责：
  - 对 Lua chunk 各类型对象（number/string/local/upvalue 等）做底层解析建模

### 3.4 `decompile`（反编译逻辑）

- 代表文件：`src/unluac/decompile/*`
- 职责：
  - 指令流 -> 表达式/语句结构 -> Lua 文本输出

### 3.5 `encode`（编译/重编码）

- 代表文件：
  - `src/unluac/encode/LucEncoder.java`
  - `src/unluac/encode/HeaderWriter.java`
  - `src/unluac/encode/InstructionEncoder.java`
  - `src/unluac/encode/StringTableWriter.java`
  - `src/unluac/encode/ChecksumWriter.java`
- 职责：
  - 生成可被目标游戏读取的 luc
  - header/string/instruction/checksum 写入流程控制

### 3.6 `semantic`（语义抽取与补丁链路）

- 代表文件：
  - `src/unluac/semantic/QuestSemanticExtractor.java`
  - `src/unluac/semantic/QuestSemanticCsvTool.java`
  - `src/unluac/semantic/QuestSemanticPatchApplier.java`
  - `src/unluac/semantic/NpcSemanticExtractor.java`
  - `src/unluac/semantic/ScriptTypeDetector.java`
  - `src/unluac/semantic/QuestFieldCoverageScanner.java`
- 职责：
  - Quest 语义模型抽取（字段、goal、reward、dialog）
  - NPC 脚本行为语义抽取（`NPC_SAY` / `SET_QUEST_STATE` / `ADD_QUEST_BTN` / `CHECK_ITEM_CNT`）
  - CSV 导入导出、常量区 patch
  - 字段覆盖率与缺失分析报告

### 3.7 `editor`（GUI 编辑层）

- 代表文件：
  - `src/unluac/editor/QuestEditorFrame.java`
  - `src/unluac/editor/QuestEditorService.java`
  - `src/unluac/editor/QuestEditorModel.java`
  - `src/unluac/editor/QuestReward.java`
  - `src/unluac/editor/QuestRewardDiffDetector.java`
- 职责：
  - GUI 交互与编辑状态管理
  - 数据加载/保存流程编排
  - reward 差异检测与保存结果展示

---

## 4. 主要业务流程拆解

### 4.1 反编译流程（`luc -> lua`）

1. `Main` 读取 luc
2. `chunk/parse` 将二进制解析为内部结构
3. `decompile` 生成 Lua 源码
4. 输出到控制台或文件

### 4.2 编译流程（`lua -> luc`）

1. `LucEncoder` 组织编译输入
2. `HeaderWriter` / `StringTableWriter` / `InstructionEncoder` 写入各区块
3. `ChecksumWriter`（若启用）写入校验
4. 输出 luc，并可做结构校验

### 4.3 QuestEditor 回写流程（GUI/CLI 共用主链）

1. `QuestSemanticExtractor` 从 luc 提取语义
2. 语义 <-> CSV/GUI 模型转换
3. `QuestSemanticPatchApplier` 定位常量并 patch
4. `Lua50StructureValidator` 做一致性校验
5. 输出 patched luc + mapping 报告

### 4.4 Quest/NPC 扫描流程

1. `QuestFieldCoverageScanner` 扫描单文件或目录
2. `ScriptTypeDetector` 区分 Quest/NPC 脚本
3. Quest 走 `scanFieldCoverage`；NPC 走 `NpcSemanticExtractor`
4. 生成字段集合、方法覆盖率、缺失分析 `Markdown` 报告

---

## 5. 目录统计（当前源码粗略统计）

- `src/unluac/chunk`：9 文件
- `src/unluac/decompile`：71 文件
- `src/unluac/editor`：13 文件
- `src/unluac/encode`：6 文件
- `src/unluac/parse`：26 文件
- `src/unluac/semantic`：24 文件
- `src/unluac/util`：1 文件

（统计用于结构理解，不作为精确版本约束）

---

## 6. 测试结构

重点测试位于：`test/src/unluac`

- `test/src/unluac/editor/QuestDialogAnswerBranchTest.java`
- `test/src/unluac/editor/QuestRewardSkillModelTest.java`
- `test/src/unluac/editor/QuestRewardDiffDetectorTest.java`
- `test/src/unluac/semantic/NpcSemanticExtractorSmoke.java`
- `test/src/unluac/semantic/ScriptTypeDetectorSmoke.java`

这些测试覆盖了分支解析、reward 映射、差异检测、NPC 语义抽取与脚本类型识别。

---

## 7. 启动与常用命令（当前可用）

### 7.1 编译

```bash
javac -encoding UTF-8 -d build -sourcepath src src/unluac/editor/QuestEditorMain.java src/unluac/semantic/QuestEditorCli.java src/unluac/semantic/QuestFieldCoverageScanner.java
```

### 7.2 启动 GUI

```bash
java -cp build unluac.editor.QuestEditorMain
```

### 7.3 CLI（CSV 导出/导入）

```bash
java -cp build unluac.semantic.QuestEditorCli export <quest.luc> <quest_editor.csv>
java -cp build unluac.semantic.QuestEditorCli import <quest.luc> <quest_editor.csv> <quest_patched.luc>
```

### 7.4 全量扫描（Quest + NPC）

```bash
java -cp build unluac.semantic.QuestFieldCoverageScanner <script_dir_or_luc> documentation/quest_field_scan_report.md
```

