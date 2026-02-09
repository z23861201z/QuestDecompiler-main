# Phase 3.5 — 反向构建可行性验证（lua->luc 前置确认）

## 结论

- 已通过 `@ida-pro-mcp` 复核关键函数：`sub_9D8580`、`sub_9D8610`、`sub_9D85D0`、`sub_9D81D0`、`sub_9D81F0`、`sub_9D80C0`、`sub_9CEDB0`。
- 本阶段要求字段无未确认项。
- 在满足“必须精确写回字段清单”的前提下，可以安全进入 lua->luc 编译阶段。
- 额外强校验仍存在：`OP/A/B/C` 位宽（`6/8/9/9`）与 `bad code` 校验（`sub_9D0B20`）。

---

## 1) game.exe 解析 luc 的强校验点

| 字段 | 校验位置 | 是否必须完全匹配 | 是否存在范围判断 | 是否参与条件跳转 |
|---|---|---|---|---|
| `header magic` | `sub_9D8580`（对 `0xC9EC88` 签名字节比对，值 `0x1B`） | 是 | 否 | 是（不等即 `sub_9D0E00`） |
| `version` | `sub_9D8610`（`cmp edi, 0x50`） | 是（仅 `0x50`） | 是（大于/小于双分支） | 是 |
| `sizeof(int)` | `sub_9D8610 -> sub_9D85D0("int")` | 是（`4`） | 否 | 是 |
| `sizeof(size_t)` | `sub_9D85D0("size_t")` | 是（`4`） | 否 | 是 |
| `instruction size` | `sub_9D85D0("Instruction")` | 是（`4`） | 否 | 是 |
| `number size` | `sub_9D85D0("number")` | 是（`8`） | 否 | 是 |
| `endian flag` | `sub_9D8610`，与 `sub_9D8600()==1` 比较后仅设置 `swap` | 否（非固定等值） | 否 | 是（决定多字节读取字节序） |
| `test number` | `sub_9D81D0` 读 8 字节，再转整比较 `0x01DF5E76` | 是 | 否 | 是 |
| `字符串长度字段` | `sub_9D81B0` 读取，`sub_9D81F0` 使用 | 是（需与载荷一致） | 仅 `len==0` 分支 | 是 |

---

## 2) 字段分类清单

### 必须精确写回字段清单

- `magic=0x1B`
- `version=0x50`
- `sizeof(int)=4`
- `sizeof(size_t)=4`
- `instruction size=4`
- `number size=8`
- `test number`（8字节值需满足转整后 `31415926`）
- 每个字符串 `length`（4字节，含末尾 `0x00` 的总长度）
- `OP/A/B/C = 6/8/9/9`（同属强校验）

### 可容错字段清单

- `endian flag`：可为非 `0x01`，前提是后续多字节字段按该字节序完整写入，且 `test number` 仍通过。

### 可忽略字段清单

- 无。

---

## 3) `quest.luc` 验证（header 逐字节）

样本文件：`D:\game\GhostOnline\Script_cn\quest.luc`

header（`0x00..0x12`）真实值：

```text
1B 50 01 04 04 04 06 08 09 09 08 B6 09 93 68 E7 F5 7D 41
```

| 偏移 | 值 | 含义 | game.exe 是否使用 |
|---|---:|---|---|
| `0x00` | `1B` | magic | 是（`sub_9CEDB0` 二进制分支 + `sub_9D8580` 校验） |
| `0x01` | `50` | version | 是（`sub_9D8610`） |
| `0x02` | `01` | endian flag | 是（设置 `swap`） |
| `0x03` | `04` | sizeof(int) | 是 |
| `0x04` | `04` | sizeof(size_t) | 是 |
| `0x05` | `04` | instruction size | 是 |
| `0x06` | `06` | OP bits | 是 |
| `0x07` | `08` | A bits | 是 |
| `0x08` | `09` | B bits | 是 |
| `0x09` | `09` | C bits | 是 |
| `0x0A` | `08` | number size | 是 |
| `0x0B` | `B6` | test number byte0 | 是 |
| `0x0C` | `09` | test number byte1 | 是 |
| `0x0D` | `93` | test number byte2 | 是 |
| `0x0E` | `68` | test number byte3 | 是 |
| `0x0F` | `E7` | test number byte4 | 是 |
| `0x10` | `F5` | test number byte5 | 是 |
| `0x11` | `7D` | test number byte6 | 是 |
| `0x12` | `41` | test number byte7 | 是 |

首字符串长度字段（非 header，但本阶段要求）：

- `0x13..0x16 = 25 00 00 00`
- 解释值：`37`
- game.exe 使用：是（`sub_9D81B0/sub_9D81F0`）

---

## 4) 自检

- [x] 列出并分析了指定 9 个校验点
- [x] 每项给出“完全匹配/范围判断/条件跳转”
- [x] 输出了“必须精确写回/可容错/可忽略”三类清单
- [x] 使用 `quest.luc` 给出 header 每字节真实值并标注是否使用
- [x] 未确认字段：无

