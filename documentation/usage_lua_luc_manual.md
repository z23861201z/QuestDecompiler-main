# QuestDecompiler 使用手册（`luc -> lua` / `lua -> luc`）

本文档基于当前项目实现，包含：

- 反编译入口：`src/unluac/Main.java`
- 编码入口：`src/unluac/encode/LucEncoder.java`
- 任务编辑 CLI：`src/unluac/semantic/QuestEditorCli.java`
- 任务编辑 GUI：`src/unluac/editor/QuestEditorMain.java`

---

## 1. 环境准备

- JDK 8+（推荐 JDK 8 或 11）
- 项目根目录：`d:\github\QuestDecompiler-main`

`lua -> luc` 需要 `luac50`（Lua 5.0 编译器），可通过以下任一方式提供：

1. `LucEncoder` 第 4 个参数传入
2. 环境变量 `LUAC50`
3. JVM 参数：`-Dluac50=<path>`

---

## 2. 编译项目

在项目根目录执行：

```bash
javac -encoding UTF-8 -deprecation -Werror -d build -sourcepath src src/unluac/Main.java src/unluac/encode/*.java src/unluac/editor/QuestEditorMain.java src/unluac/semantic/QuestEditorCli.java
```

---

## 3. `luc -> lua`（反编译）

### 3.1 反编译到控制台

```bash
java -cp build unluac.Main D:\TitanGames\GhostOnline\zChina\Script\quest.luc
```

### 3.2 反编译到文件（推荐）

```bash
java '-Dunluac.stringCharset=GBK' -cp build unluac.Main --encoding GBK --out D:\TitanGames\GhostOnline\zChina\Script\quest.lua D:\TitanGames\GhostOnline\zChina\Script\quest.luc
```

说明：

- `--out`：写文件，避免 `>` 重定向乱码
- `-Dunluac.stringCharset=GBK`：按 GBK 解码 luc 字符串
- `--encoding GBK`：按 GBK 写出 lua 文件

### 3.3 批量反编译目录

```bash
java '-Dunluac.stringCharset=GBK' -cp build unluac.Main -d D:\TitanGames\GhostOnline\zChina\Script --encoding GBK
```

---

## 4. `lua -> luc`（编译）

唯一命令入口：`unluac.encode.LucEncoder`

```bash
java -cp build unluac.encode.LucEncoder <input.lua> <output.luc> [sample_for_compare] [luac50_path]
```

### 4.1 从 lua 生成 luc

```bash
java -cp build unluac.encode.LucEncoder D:\work\quest.lua D:\work\quest_gen.luc D:\TitanGames\GhostOnline\zChina\Script\quest.luc D:\TitanGames\lua503\luac50.exe
```

### 4.2 luc 结构重写验证

```bash
java -cp build unluac.encode.LucEncoder D:\TitanGames\GhostOnline\zChina\Script\quest.luc D:\TitanGames\GhostOnline\zChina\Script\quest.repack.luc D:\TitanGames\GhostOnline\zChina\Script\quest.luc
```

---

## 5. QuestEditor CLI 用法

### 5.1 导出 CSV

```bash
java -cp build unluac.semantic.QuestEditorCli export D:\TitanGames\GhostOnline\zChina\Script\quest.luc D:\work\quest_editor.csv
```

### 5.2 导入 CSV 并生成补丁 luc

```bash
java -cp build unluac.semantic.QuestEditorCli import D:\TitanGames\GhostOnline\zChina\Script\quest.luc D:\work\quest_editor.csv D:\work\quest_patched.luc
```

导入时会自动：

- 执行 constant 区补丁
- 输出 mapping 文件（`quest_patched.luc.mapping.csv`）
- 做结构校验（instruction/prototype 不变）
- 若发现 non-constant 区变化直接报错

### 5.3 当前 CSV 列定义（已包含技能奖励）

```text
quest_id,title,description,pre_quest_ids,reward_exp,reward_item_id,reward_item_count,reward_skill_ids,dialog_lines_json,condition_json
```

新增列说明：

- `reward_skill_ids`：技能奖励 ID 数组（如 `[10601,10602]`）
- `condition_json`：可包含 `reward_fame/reward_money/reward_pvppoint` 等数值字段

---

## 6. QuestEditor GUI 用法

启动：

```bash
java -cp build unluac.editor.QuestEditorMain
```

操作流程：

1. 打开 luc
2. 选择任务
3. 编辑字段（含奖励）
4. 点击“应用修改”
5. 点击“保存新 luc”

奖励页支持：

- `reward_exp`
- `reward_fame`
- `reward_money`
- `reward_pvppoint`
- `reward_item_id` / `reward_item_count`
- `reward_skill_ids`
  - 可直接编辑 JSON 数组
  - 也可用“新增技能ID / 删除最后技能ID”按钮

---

## 7. 常见问题

### Q1：PowerShell 下 `-Dunluac.stringCharset=GBK` 报主类错误

请加引号或使用 `--%`，例如：

```bash
java '-Dunluac.stringCharset=GBK' -cp build unluac.Main --encoding GBK --out D:\TitanGames\GhostOnline\zChina\Script\quest.lua D:\TitanGames\GhostOnline\zChina\Script\quest.luc
```

### Q2：保存后没有生成 luc，只生成 csv

GUI/CLI 内部会先生成临时 csv 再应用补丁；最终输出文件由你指定的 `output.luc` 决定。请检查：

- 输出路径是否可写
- 是否触发结构校验错误
- 控制台/弹窗报错详情

### Q3：如何确认只改了 constant 区

使用 `QuestEditorCli import ...`，若出现 non-constant 区变化会直接抛错；mapping 文件可用于逐项核对。

