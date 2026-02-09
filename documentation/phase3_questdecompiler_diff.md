# Phase 3 — QuestDecompiler 实现差异对照（基于 Phase 2 真实算法）

## 对比基线

- 真实算法基线：`documentation/phase2_luc_algorithm.md`
- 对比对象源码：`src/unluac/parse/*.java`、`src/unluac/Main.java`
- 真实样本：`D:\game\GhostOnline\Script_cn\quest.luc`

---

## 真实 `.luc` 前 32 字节演示（强制样本）

### 1) 原始前 32 字节

```text
1B 50 01 04 04 04 06 08 09 09 08 B6 09 93 68 E7 F5 7D 41 25 00 00 00 41 46 3D 60 4C 4E 56 5B 5D
```

### 2) 按 Phase 2 真实算法处理后的对应 32 字节

说明：`0x00..0x16` 为头与长度字段，不做解密；`0x17..0x1F` 属于首字符串数据，执行 `dst[i] = (src[i] - (i+1)) & 0xFF`。

```text
1B 50 01 04 04 04 06 08 09 09 08 B6 09 93 68 E7 F5 7D 41 25 00 00 00 40 44 3A 5C 47 48 4F 53 54
```

### 3) 前 32 字节内的逐字节变换过程（`0x17..0x1F`）

| 偏移 | 原始字节 | 变换 | 结果字节 | ASCII |
|---|---:|---|---:|---|
| `0x17` | `41` | `41 - 1` | `40` | `@` |
| `0x18` | `46` | `46 - 2` | `44` | `D` |
| `0x19` | `3D` | `3D - 3` | `3A` | `:` |
| `0x1A` | `60` | `60 - 4` | `5C` | `\` |
| `0x1B` | `4C` | `4C - 5` | `47` | `G` |
| `0x1C` | `4E` | `4E - 6` | `48` | `H` |
| `0x1D` | `56` | `56 - 7` | `4F` | `O` |
| `0x1E` | `5B` | `5B - 8` | `53` | `S` |
| `0x1F` | `5D` | `5D - 9` | `54` | `T` |

---

## 差异对照表

### A. 项目中实现正确部分

| 对照项 | 真实算法（Phase 2） | 项目现状（源码证据） | 结论 |
|---|---|---|---|
| `.luc` 特征识别（`0x1B 0x50`） | 头部前两字节为 `1B 50`（Lua 5.0 变体） | `BHeader` 先读两字节，命中后置 `Encoded=true`，签名切到单字节 `0x1B`：`src/unluac/parse/BHeader.java:45`、`src/unluac/parse/BHeader.java:47`、`src/unluac/parse/BHeader.java:49` | 一致 |
| Lua50 头部主解析顺序 | 读取 endianness/int/size_t/instruction/op位宽/number/test number | `LHeaderType50.parse_main` 顺序解析并做 test number 判定：`src/unluac/parse/LHeaderType.java:160` 至 `src/unluac/parse/LHeaderType.java:177` | 一致 |
| 字符串循环减法解密 | `for i=0..n-2: b[i]-=(i+1)`，末尾 `\0` 不变 | `LStringType50` 中 `test[i2] = buffer.get() - i`，且 `i` 从 1 递增；末尾迭代 `i==endl` 时置 0：`src/unluac/parse/LStringType.java:37`、`src/unluac/parse/LStringType.java:42`、`src/unluac/parse/LStringType.java:43` | 一致 |
| 无压缩路径 | 真实链路无压缩调用 | 项目仅做字节解析与结构读取，未见解压调用入口（解析路径集中在 `parse` 包） | 一致 |

### B. 缺失步骤

| 对照项 | 真实算法（Phase 2） | 项目现状（源码证据） | 结论 |
|---|---|---|---|
| 二进制/文本分支 | 先看首字节 `0x1B`，再分 binary/text 路径 | `Main.file_to_function` 直接构造 `BHeader`，没有 text 分支入口：`src/unluac/Main.java:97`、`src/unluac/Main.java:103` | 缺失 |
| `fopen("r")`→`fopen("rb")` 退避与 reader 回调分块读取 | 真实链路使用 `fopen/fread`，并有模式切换与回调读取 | 项目一次性 `RandomAccessFile + FileChannel` 全量读入：`src/unluac/Main.java:98`、`src/unluac/Main.java:101`、`src/unluac/Main.java:102` | 缺失 |
| 解析后专门结构合法性校验阶段 | 真实链路有 `sub_9D0B20 -> sub_9D07A0` 校验步骤 | 解析层未见对应独立“加载后校验函数”调用；仅在反编译阶段抛非法指令异常：`src/unluac/decompile/Decompiler.java:403` | 缺失 |

### C. 结构错误点

| 对照项 | 真实算法（Phase 2） | 项目现状（源码证据） | 结论 |
|---|---|---|---|
| 非 `Encoded` 字符串路径返回值 | 非加密路径应原样读取字符串字节 | `if(!Encoded)` 分支只写 `StringBuilder`，但最终返回 `new String(test, GBK)`；`test` 在该分支未填充：`src/unluac/parse/LStringType.java:47`、`src/unluac/parse/LStringType.java:48`、`src/unluac/parse/LStringType.java:54` | 错误 |
| `Encoded` 分支中 builder 逻辑 | 真实算法每字节只做一次减法 | 代码对 `b.append` 使用 `test[i2] - i`，形成二次减法表达；且该 builder 最终不用于返回：`src/unluac/parse/LStringType.java:44`、`src/unluac/parse/LStringType.java:54` | 错误 |
| 全局签名状态 | 每次解析应独立判定头部 | `signature` 是静态变量，命中 `1B50` 后被改成单字节签名，影响后续实例：`src/unluac/parse/BHeader.java:12`、`src/unluac/parse/BHeader.java:48` | 错误 |

### D. 未覆盖字段

| 字段/约束 | 真实算法（Phase 2） | 项目现状（源码证据） | 结论 |
|---|---|---|---|
| `sizeof(int)` 固定为 `4` | 强制等于 `4` | 仅读取并实例化 `BIntegerType`，未强制值：`src/unluac/parse/LHeaderType.java:84`、`src/unluac/parse/LHeaderType.java:90` | 未覆盖 |
| `sizeof(size_t)` 固定为 `4` | 强制等于 `4` | 仅读取并实例化 `BSizeTType`，未强制值：`src/unluac/parse/LHeaderType.java:93`、`src/unluac/parse/LHeaderType.java:99` | 未覆盖 |
| `size(OP/A/B/C)=6/8/9/9` | 强制固定值 | 仅读取并传入 `Code50`，未做固定值判等：`src/unluac/parse/LHeaderType.java:132` 至 `src/unluac/parse/LHeaderType.java:141` | 未覆盖 |
| `sizeof(number)=8` | 强制等于 `8` | 仅读取到 `s.lNumberSize`，后续允许 4/8 两种：`src/unluac/parse/LHeaderType.java:113`、`src/unluac/parse/LHeaderType.java:118`、`src/unluac/parse/LNumberType.java:22` | 未覆盖 |
| endian flag 与运行时比较 | 真实实现以运行时端序比较决定 `swap` | 项目接受 `0/1` 并直接设 ByteOrder，无“必须等于本机值”的约束：`src/unluac/parse/LHeaderType.java:68` 至 `src/unluac/parse/LHeaderType.java:75` | 未覆盖 |

### E. 可能导致不可逆的设计问题

| 问题点 | 证据（源码位置） | 不可逆影响 |
|---|---|---|
| 解密字节直接按固定 `GBK` 转 `String` | `src/unluac/parse/LStringType.java:54` | 当字节序列非 `GBK` 可逆映射时，字节信息丢失，无法从字符串精确还原原字节 |
| `LString` 无条件截掉末字节 | `src/unluac/parse/LString.java:11` | 若输入末尾并非合法 `\0` 终止，末字节数据被永久丢弃 |
| 反编译输出固定 `GB2312` | `src/unluac/Main.java:115` | 输出文件无法保真承载超出 `GB2312` 的字符，文本信息不可逆 |

---

## 自检

- [x] 给出“项目中实现正确部分”
- [x] 给出“缺失步骤”
- [x] 给出“结构错误点”
- [x] 给出“未覆盖字段”
- [x] 给出“可能导致不可逆的设计问题”
- [x] 使用真实 `.luc`（`quest.luc`）前 32 字节演示
- [x] 演示包含原始字节 / 解密后字节 / 逐字节变换过程
- [x] 输出为 Markdown 文档

