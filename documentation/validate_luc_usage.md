# validateLuc(byte[] data) 使用说明

## 实现位置

- 校验器：`src/unluac/chunk/Lua50StructureValidator.java`
- 入口方法：`validateLuc(byte[] data)`
- 报告对象：`Lua50StructureValidator.ValidationReport`

## 校验项

`validateLuc(byte[] data)` 会把 `data` 与构造校验器时给定的 reference chunk 做结构比对，输出以下结果：

- `header_same`
- `instruction_count_same`
- `constant_count_same`
- `prototype_count_same`
- `debug_count_same`

并输出总量统计：

- `instruction_total`
- `constant_total`
- `prototype_total`
- `debug_lineinfo_total`
- `debug_localvars_total`
- `debug_upvalue_names_total`

## 命令行工具

`src/unluac/chunk/Lua50ValidateTool.java`

```bash
java -Dunluac.stringCharset=GBK -cp build unluac.chunk.Lua50ValidateTool <reference.luc> <target.luc> [report.txt]
```

## 本次实测输出

reference: `quest - 副本.luc`

target: `quest_csv_patch.luc`

```text
structure_consistent=true
header_same=true
instruction_count_same=true
constant_count_same=true
prototype_count_same=true
debug_count_same=true
function_count=34 -> 34
instruction_total=127908 -> 127908
constant_total=24576 -> 24576
prototype_total=33 -> 33
debug_lineinfo_total=127908 -> 127908
debug_localvars_total=38 -> 38
debug_upvalue_names_total=0 -> 0
details=none
```

报告文件：`documentation/validate_luc_structure_report.txt`

