# Phase E — QuestEditor.exe（离线 GUI）

## 1. 项目结构

新增 Swing GUI 结构如下：

```text
src/
  QuestEditorCli.java                               # CLI 无包名入口（已存在）
  unluac/
    editor/
      QuestEditorMain.java                          # GUI 入口
      QuestEditorFrame.java                         # 主窗口（任务列表 + 编辑面板）
      QuestEditorService.java                       # GUI 与语义/补丁服务桥接
      QuestEditorModel.java                         # GUI 行模型
      QuestEditorValidator.java                     # 编辑输入校验
      QuestEditorSaveResult.java                    # 保存结果摘要
    semantic/
      QuestEditorCli.java                           # CLI（export/import + diff + validator）
      QuestSemanticCsvTool.java                     # 语义CSV导入导出
      QuestSemanticPatchApplier.java                # 仅常量区补丁应用
      QuestSemanticExtractor.java                   # 语义提取 + 字段绑定
      QuestSemanticJson.java                        # JSON序列化/解析
```

---

## 2. GUI 功能对照

已实现（Swing，本地离线）：

1. 打开 luc
   - 按钮：`打开 luc`
   - 入口：`QuestEditorFrame.openLuc()`

2. 显示任务列表
   - 左侧 `JTable`
   - 列：`quest_id/title/description/reward_exp/reward_item_id/reward_item_count`

3. 编辑标题
   - 字段：`titleField`
   - 应用：`applyEditToSelection()`

4. 编辑描述
   - 字段：`descArea`
   - 应用：`applyEditToSelection()`

5. 编辑奖励
   - 字段：
     - `reward_exp`
     - `reward_item_id`（JSON数组）
     - `reward_item_count`（JSON数组）
   - 校验：`QuestEditorValidator`

6. 保存生成新 luc
   - 按钮：`保存新 luc`
   - 入口：`QuestEditorFrame.savePatchedLuc()`
   - 流程：
     - 当前表格数据 -> 语义 CSV
     - `QuestSemanticPatchApplier` 应用补丁
     - 自动结构验证 + diff 统计

---

## 3. 关键类代码位置

- GUI 入口：`src/unluac/editor/QuestEditorMain.java`
- GUI 主窗体：`src/unluac/editor/QuestEditorFrame.java`
- GUI 业务服务：`src/unluac/editor/QuestEditorService.java`
- 补丁/验证核心：`src/unluac/semantic/QuestSemanticPatchApplier.java`
- 结构验证：`src/unluac/semantic/QuestEditorCli.java`（内部使用 `Lua50StructureValidator`）

---

## 4. 构建命令

在项目根目录执行：

```bash
javac -encoding UTF-8 -deprecation -Werror -d build -sourcepath src src/unluac/editor/*.java src/unluac/semantic/*.java src/unluac/*.java src/QuestEditorCli.java
```

运行 GUI：

```bash
java -cp build unluac.editor.QuestEditorMain
```

CLI 仍可用：

```bash
java -cp build QuestEditorCli export D:\path\quest.luc D:\path\quest_editor.csv
java -cp build QuestEditorCli import D:\path\quest.luc D:\path\quest_editor.csv D:\path\quest_patched.luc
```

---

## 5. 打包成 exe（离线）

## 5.1 先打 jar

创建 manifest（示例 `manifest_questeditor.mf`）：

```text
Main-Class: unluac.editor.QuestEditorMain
```

打包：

```bash
jar -cfm bin/QuestEditor.jar manifest_questeditor.mf -C build .
```

## 5.2 用 jpackage 生成 exe（推荐）

要求：
- JDK 17+（含 `jpackage`）

命令示例：

```bash
jpackage \
  --type exe \
  --name QuestEditor \
  --input bin \
  --main-jar QuestEditor.jar \
  --main-class unluac.editor.QuestEditorMain \
  --win-console \
  --dest dist
```

生成：
- `dist/QuestEditor.exe`

## 5.3 备用方案（Launch4j）

若使用 JDK8/11 无 `jpackage`：
- 先打 `QuestEditor.jar`
- 用 Launch4j 将 jar 包装为 exe
- 入口主类仍是 `unluac.editor.QuestEditorMain`

---

## 6. 离线可运行说明

- 技术栈：Swing（纯 Java 桌面）
- 不依赖 Web/浏览器/远程服务
- 所有处理均本地文件读写

