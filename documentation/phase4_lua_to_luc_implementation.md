# Phase 4 — lua -> luc 编译器实现（可运行）

## 产出文件

- `src/unluac/encode/LucEncoder.java`
- `src/unluac/encode/HeaderWriter.java`
- `src/unluac/encode/InstructionEncoder.java`
- `src/unluac/encode/StringTableWriter.java`
- `src/unluac/encode/ChecksumWriter.java`
- `src/unluac/encode/BinaryCodec.java`
- 解析保真修复：`src/unluac/parse/LStringType.java`、`src/unluac/parse/LString.java`、`src/unluac/parse/LFunction.java`、`src/unluac/parse/LFunctionType.java`、`src/unluac/parse/BHeader.java`
- 对外入口：`src/unluac/Main.java`（新增 `fileToFunction`）

---

## 写入顺序（已按代码实现）

1. `HeaderWriter` 写 header（magic/version/endian/size/位宽/test number）
2. `StringTableWriter` 写字符串区（source、locals 名称、upvalue 名称、字符串常量）
3. `InstructionEncoder` 写 instruction block（code count + instructions）
4. `ChecksumWriter`（当前实现为无校验字段，写入长度 `0`）

---

## 强制项实现对应

- `ByteArrayOutputStream`：`BinaryCodec.LittleEndianWriter`
- Little Endian 写入：`writeIntLE`、`writeLongLE`
- `writeIntLE` / `writeLongLE`：`src/unluac/encode/BinaryCodec.java`
- test number 写入：`HeaderWriter.writeTestNumber()`
- 字符串 length（包含末尾 `0x00`）：`StringTableWriter.toPlainBytesWithTerminator()` + `writeString()`

---

## 运行命令

### 1) 编译

```bash
javac -encoding UTF-8 -deprecation -Werror -d build -sourcepath src src/unluac/Main.java src/unluac/encode/*.java
```

### 2) lua -> luc（真实可运行）

```bash
java -cp build unluac.encode.LucEncoder test/src/assign.lua test/out_assign_from_lua.luc D:\game\GhostOnline\Script_cn\quest.luc D:\TitanGames\lua503\luac50.exe
```

说明：流程是 `lua -> luac50 bytecode -> LucEncoder game-header/字符串编码`。

### 3) luc -> luc 重打包（用于对比验证）

```bash
java -cp build unluac.encode.LucEncoder D:\game\GhostOnline\Script_cn\quest.luc D:\game\GhostOnline\Script_cn\quest.repack.luc D:\game\GhostOnline\Script_cn\quest.luc
```

---

## quest.luc 前 32 字节强制验证

### 生成结果（`quest.repack.luc`）

```text
generated_first32=1B 50 01 04 04 04 06 08 09 09 08 B6 09 93 68 E7 F5 7D 41 25 00 00 00 41 46 3D 60 4C 4E 56 5B 5D
sample_first32=   1B 50 01 04 04 04 06 08 09 09 08 B6 09 93 68 E7 F5 7D 41 25 00 00 00 41 46 3D 60 4C 4E 56 5B 5D
first32_compare=equal
```

### 逐字节对比结论

- 前 32 字节差异偏移：无
- 标注：一致

---

## `validateLucStructure(byte[] data)`

实现位置：`src/unluac/encode/LucEncoder.java`

检查项：

- header 固定字节（magic/version/endian/size/OP/A/B/C/number size）
- test number（转整后 `31415926`）
- 首字符串 length 合理性（非负、未越界）
- 字符串末尾 `0x00` 终止
- instruction 区域 4 字节对齐

---

## 自检输出（本次实测）

### A. `quest.luc -> quest.repack.luc`

- 生成文件大小：`2000362`
- 原始文件大小：`2000319`
- header 十六进制：`1B 50 01 04 04 04 06 08 09 09 08 B6 09 93 68 E7 F5 7D 41`
- 前 32 字节：一致
- 结构校验：`validation_ok=true`

### B. `assign.lua -> out_assign_from_lua.luc`

- 生成文件大小：`177`
- 样本 `quest.luc` 大小：`2000319`
- 前 32 字节：不一致（输入脚本不同导致 payload 不同）
- 差异偏移示例：`0x13`, `0x18..0x1F`
- 结构校验：`validation_ok=true`

---

## 差异原因说明（当与样本不一致时）

- 对于不同源脚本生成的 `.luc`，header 可一致，payload（source 字符串、常量、debug 信息、指令）必然不同。
- 因此“与 `quest.luc` 前 32 字节完全一致”只在“重打包同一输入”场景成立；对不同 lua 输入不成立。

