# luc -> AST -> CSV / CSV -> luc（仅常量区修改）

## 目标

- `luc -> AST -> CSV`
- `CSV -> 更新 AST 常量 -> 写回 luc`
- 保证：
  - 不改变结构
  - 不改变 `instruction`
  - 仅修改 constant 区域字节

## 相关实现

- AST 模型：`src/unluac/chunk/LuaChunk.java`
- 解析器：`src/unluac/chunk/Lua50ChunkParser.java`
- 定点补丁器：`src/unluac/chunk/Lua50AstPatcher.java`
- CSV 工具：`src/unluac/chunk/Lua50ConstantCsvTool.java`

## 编译

```bash
javac -encoding UTF-8 -deprecation -Werror -d build -sourcepath src src/unluac/chunk/LuaChunk.java src/unluac/chunk/Lua50ChunkParser.java src/unluac/chunk/Lua50AstPatcher.java src/unluac/chunk/Lua50ConstantCsvTool.java
```

## 1) luc -> AST -> CSV

```bash
java -Dunluac.stringCharset=GBK -cp build unluac.chunk.Lua50ConstantCsvTool export "D:\TitanGames\GhostOnline\zChina\Script\quest - 副本.luc" "D:\TitanGames\GhostOnline\zChina\Script\quest_constants_hex.csv"
```

CSV 头：

```text
function_path,constant_index,constant_value
```

`constant_value` 格式：

- 字符串：`strhex:<HEX>`（导出默认）
- 数值：`numraw:<HEX>` 或 `num:<decimal>`
- 布尔：`bool:true|false`
- nil：`nil`

## 2) 修改 CSV

示例：把 `root,1` 的字符串改为 10 字节 `ABCD123456`

```text
root,1,strhex:41424344313233343536
```

## 3) CSV -> 写回 luc

```bash
java -Dunluac.stringCharset=GBK -cp build unluac.chunk.Lua50ConstantCsvTool import "D:\TitanGames\GhostOnline\zChina\Script\quest - 副本.luc" "D:\TitanGames\GhostOnline\zChina\Script\quest_constants_hex_patch.csv" "D:\TitanGames\GhostOnline\zChina\Script\quest_csv_patch.luc"
```

## 实测输出（本次）

```text
mode=import
orig_size=2231503
patched_size=2231503
applied_rows=1
diff_count=10
constant_area_diff_count=10
non_constant_area_diff_count=0
only_constant_area_changed=true
instruction_unchanged=true
debug_unchanged=true
structure_unchanged=true
```

## 结论

- 已实现 `luc -> AST -> CSV -> patch -> luc`
- 回写时只修改常量区字节
- `instruction/debug/结构` 保持不变

