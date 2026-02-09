# luc -> AST -> CSV -> patch -> luc 完整使用手册

本手册对应当前项目实现，目标是：

- 从 `.luc` 导出常量到 `CSV`
- 在 `CSV` 修改常量
- 回写生成新 `.luc`
- 保证：
  - 不改变结构
  - 不改变 instruction
  - 只改 constant 区

---

## 1. 相关类

- AST 模型：`src/unluac/chunk/LuaChunk.java`
- 解析器：`src/unluac/chunk/Lua50ChunkParser.java`
- AST 常量补丁器：`src/unluac/chunk/Lua50AstPatcher.java`
- CSV 工具：`src/unluac/chunk/Lua50ConstantCsvTool.java`
- 结构校验器：`src/unluac/chunk/Lua50StructureValidator.java`
- 校验命令工具：`src/unluac/chunk/Lua50ValidateTool.java`

---

## 2. 编译

在仓库根目录执行：

```bash
javac -encoding UTF-8 -deprecation -Werror -d build -sourcepath src src/unluac/chunk/LuaChunk.java src/unluac/chunk/Lua50ChunkParser.java src/unluac/chunk/Lua50AstPatcher.java src/unluac/chunk/Lua50ConstantCsvTool.java src/unluac/chunk/Lua50StructureValidator.java src/unluac/chunk/Lua50ValidateTool.java
```

---

## 3. 第一步：luc -> AST -> CSV

```bash
java '-Dunluac.stringCharset=GBK' -cp build unluac.chunk.Lua50ConstantCsvTool export "D:\TitanGames\GhostOnline\zChina\Script\quest - 副本.luc" "D:\TitanGames\GhostOnline\zChina\Script\quest_constants_hex.csv"
```

导出后会得到：

- `function_path`
- `constant_index`
- `constant_value`

CSV 头固定：

```text
function_path,constant_index,constant_value
```

---

## 4. 第二步：修改 CSV

### 4.1 `constant_value` 支持格式

- 字符串（推荐）：`strhex:<HEX>`
- 字符串（可用）：`str:<text>`
- 数值：`numraw:<HEX>` 或 `num:<decimal>`
- 布尔：`bool:true|false`
- nil：`nil`

### 4.2 强烈建议使用 `strhex`

原因：

- 避免编辑器编码差异
- 避免中文/代码页引起长度不确定

### 4.3 字符串长度规则（关键）

回写是“定点字节补丁”，不是重建 chunk。

- 新字符串字节长度不能超过该常量原长度
- 小于原长度会自动补零
- 超长会报错：`replacement too long for fixed-size patch`

### 4.4 示例

把 `root,1` 改成 10 字节 `ABCD123456`：

```text
root,1,strhex:41424344313233343536
```

---

## 5. 第三步：CSV -> patch -> luc

```bash
java '-Dunluac.stringCharset=GBK' -cp build unluac.chunk.Lua50ConstantCsvTool import "D:\TitanGames\GhostOnline\zChina\Script\quest - 副本.luc" "D:\TitanGames\GhostOnline\zChina\Script\quest_constants_hex_patch.csv" "D:\TitanGames\GhostOnline\zChina\Script\quest_csv_patch.luc"
```

工具会输出：

- `diff_count`
- `constant_area_diff_count`
- `non_constant_area_diff_count`
- `only_constant_area_changed`
- `instruction_unchanged`
- `debug_unchanged`
- `structure_unchanged`

当出现非预期结构变化时会直接失败。

---

## 6. 第四步：结构一致性验证（强烈建议）

```bash
java '-Dunluac.stringCharset=GBK' -cp build unluac.chunk.Lua50ValidateTool "D:\TitanGames\GhostOnline\zChina\Script\quest - 副本.luc" "D:\TitanGames\GhostOnline\zChina\Script\quest_csv_patch.luc" "d:\github\QuestDecompiler-main\documentation\validate_luc_structure_report.txt"
```

验证项：

- header 一致
- instruction count 一致
- constant count 一致
- prototype 数量一致
- debug 数量一致

---

## 7. 本地实测结果（本项目当前实现）

一次 `root,1` 单常量修改结果：

```text
applied_rows=1
diff_count=10
constant_area_diff_count=10
non_constant_area_diff_count=0
only_constant_area_changed=true
instruction_unchanged=true
debug_unchanged=true
structure_unchanged=true
```

结构校验结果：

```text
structure_consistent=true
header_same=true
instruction_count_same=true
constant_count_same=true
prototype_count_same=true
debug_count_same=true
details=none
```

---

## 8. 常见问题

### Q1：PowerShell 下 `-D...` 参数报主类错误

请写成：

```bash
java '-Dunluac.stringCharset=GBK' -cp build ...
```

不要直接裸写 `-Dunluac.stringCharset=GBK`。

### Q2：导入时报 `replacement too long`

说明你的新字符串字节长度超过原常量容量。

处理方式：

- 改短字符串
- 或改用等长 `strhex`

### Q3：为什么我改了很多行但 `applied_rows` 很少？

导入逻辑会跳过“值未变化”的行，仅对发生变更的常量执行补丁。

---

## 9. 最简命令清单

```bash
# 1) 导出
java '-Dunluac.stringCharset=GBK' -cp build unluac.chunk.Lua50ConstantCsvTool export <in.luc> <out.csv>

# 2) 编辑 out.csv

# 3) 导入
java '-Dunluac.stringCharset=GBK' -cp build unluac.chunk.Lua50ConstantCsvTool import <in.luc> <patched.csv> <out.luc>

# 4) 校验
java '-Dunluac.stringCharset=GBK' -cp build unluac.chunk.Lua50ValidateTool <in.luc> <out.luc> <report.txt>
```

