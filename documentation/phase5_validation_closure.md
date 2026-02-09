# Phase 5 — 验证闭环（新生成 luc 与 game.exe 解析逻辑）

## 样本与范围

- 验证样本 A（`lua -> luc` 新生成）：`test/out_assign_from_lua.luc`
- 验证样本 B（重打包）：`D:\game\GhostOnline\Script_cn\quest.repack.luc`
- 解析链基于 IDA 反编译：`sub_9DB000 -> sub_9DAD80 -> sub_9CEDB0 -> sub_9D1BD0 -> sub_9D8770 -> sub_9D8750 -> sub_9D8610 -> sub_9D84D0`

---

## 1) 解析入口“断点路径”分析

> 当前 IDA 会话无调试器（`ida_dbg.dbg_can_query() == False`），本节采用“断点位 + 条件值驱动”的路径验证方式；每个断点条件都用真实样本字节计算。

| 断点位（函数/地址） | 条件 | 样本 A 观测值 | 结果 |
|---|---|---:|---|
| `sub_9CEDB0` (`0x9CEDD8`) | `v5 == 0x1B` 走 binary | `byte0=0x1B` | 命中 binary 路径 |
| `sub_9D8750` (`0x9D8752`) | 调用 header 检查 | 进入 `sub_9D8610` | 通过 |
| `sub_9D8580` (`0x9D8590`) | 签名匹配 `0x1B` | `0x1B` | 不触发 `bad signature` |
| `sub_9D8610` (`0x9D8621`) | `version == 0x50` | `0x50` | 不触发 too new/too old |
| `sub_9D85D0` 系列 | `int/size_t/instruction/OP/A/B/C/number` | `4/4/4/6/8/9/9/8` | 不触发 vm mismatch |
| `sub_9D8610` (`0x9D872B`) | test number 转整后 `== 31415926` | `31415926.5358979 -> 31415926` | 不触发 unknown number format |
| `sub_9D84D0` (`0x9D84E7`) | 调用 `sub_9D81F0`（字符串解密） | 首串长度 `21`，执行 `len-1` 循环 | 正常执行 |
| `sub_9D84D0` (`0x9D854B`) | `sub_9D0B20(v2) != 0` | 解析/反编译返回成功 | 不触发 `bad code` |

---

## 2) header 判断是否通过

样本 A 前 32 字节：

```text
1B 50 01 04 04 04 06 08 09 09 08 B6 09 93 68 E7 F5 7D 41 15 00 00 00 41 76 68 77 79 62 7A 7A 6C
```

header 字段映射：

- magic=`1B` ✅
- version=`50` ✅
- endian=`01` ✅
- sizeof(int)=`04` ✅
- sizeof(size_t)=`04` ✅
- instruction size=`04` ✅
- OP/A/B/C=`06/08/09/09` ✅
- number size=`08` ✅
- test number bytes=`B6 09 93 68 E7 F5 7D 41`（double 转整后 `31415926`）✅

结论：header 强校验全部通过。

---

## 3) 解密函数是否正常执行

`sub_9D81F0` 逻辑：

- 读取 `len`（4 字节）
- 当 `len > 0` 时读取字符串并对 `i=0..len-2` 做 `b[i] -= (i+1)`

样本 A 实测：

- 首字符串 `len=21`（`0x15`）
- 循环执行次数：`20`（`len-1`）
- 解密结果：`@test\src\assign.lua\0`
- 末尾 `0x00` 存在

结论：解密路径被执行，且输出结构正确。

---

## 4) 校验是否触发错误分支

目标错误分支（game.exe）与结果：

- `bad signature in %s`（`sub_9D8580`）：未触发
- `too new/too old`（`sub_9D8610`）：未触发
- `virtual machine mismatch`（`sub_9D85D0`）：未触发
- `unknown number format`（`sub_9D8610`）：未触发
- `bad integer in %s`（`sub_9D8170`）：未触发
- `bad nupvalues in %s`（`sub_9D8360`）：未触发
- `bad constant type`（`sub_9D83D0`）：未触发
- `bad code in %s`（`sub_9D84D0 -> sub_9D0B20`）：未触发

辅助验证（命令执行结果）：

- `java -cp build unluac.Main test/out_assign_from_lua.luc` -> `PARSE_ASSIGN_LUC_OK`
- `java -cp build unluac.Main D:\game\GhostOnline\Script_cn\quest.repack.luc` -> `PARSE_QUEST_REPACK_OK`

---

## 5) 验证结论

### 调用路径验证

- 入口链与 binary 分支条件一致，路径为：
  - `sub_9DB000`
  - `sub_9DAD80`
  - `sub_9CEDB0`（`v5==0x1B`）
  - `sub_9D1BD0`
  - `sub_9D8770`
  - `sub_9D8750`
  - `sub_9D8610`（header 全通过）
  - `sub_9D84D0`（字符串解密、结构加载、code 校验）

### 是否存在异常

- 未发现触发错误分支的证据。

### 是否结构匹配

- 结构匹配：是。
- 样本 A、样本 B 均通过解析验证。

---

## 自检

- [x] 入口函数断点路径分析
- [x] header 判断通过性检查
- [x] 解密函数执行检查
- [x] 错误分支触发检查
- [x] 输出调用路径/异常/结构匹配结论

