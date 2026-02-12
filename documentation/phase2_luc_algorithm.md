# Phase 2 — luc 解密算法还原（字节级）

## 1. 主链与入口

- 入口链：`sub_9DB000 -> sub_9DAD80 -> sub_9CEDB0 -> sub_9D1BD0`
- `sub_9DAD80`：`fopen("r")`，必要时切 `fopen("rb")`，reader 回调为 `sub_9DACF0`
- `sub_9DACF0`：`fread(buf,1,0x200,fp)` 按块读入
- `sub_9CEDB0`：首字节判断 `cmp eax, 1Bh`，`v5==27` 走二进制路径（`sub_9D8770`）

---

## 2. Header 结构

`sub_9D8610` 的读取顺序与校验：

| 偏移 | 长度 | 字段 | 处理 |
|---|---:|---|---|
| `0x00` | 1 | magic | `sub_9D8580` 校验，签名字节固定 `0x1B` |
| `0x01` | 1 | version | 必须 `0x50`（Lua 5.0） |
| `0x02` | 1 | endian_flag | 与 `sub_9D8600()` 返回值比较（返回常量 `1`） |
| `0x03` | 1 | sizeof(int) | 必须 `4` |
| `0x04` | 1 | sizeof(size_t) | 必须 `4` |
| `0x05` | 1 | sizeof(Instruction) | 必须 `4` |
| `0x06` | 1 | size(OP) | 必须 `6` |
| `0x07` | 1 | size(A) | 必须 `8` |
| `0x08` | 1 | size(B) | 必须 `9` |
| `0x09` | 1 | size(C) | 必须 `9` |
| `0x0A` | 1 | sizeof(number) | 必须 `8` |
| `0x0B` | 8 | test number | 读 double，转 int 后必须等于 `0x01DF5E76` (`31415926`) |

样本头（`quest.luc/chat.luc/npc_200001.luc` 一致）：

```text
1b 50 01 04 04 04 06 08 09 09 08 b6 09 93 68 e7 f5 7d 41
```

---

## 3. 解密算法

### 3.1 key 来源

- 无外部 key
- 无种子值
- 仅使用循环下标 `i` 与常量 `0xFF`
- `dword_3019E10` 仅在 `sub_9D81F0` 内作为循环计数

### 3.2 每字节处理方式

- 普通字节读取：`sub_9D8060`，原样读
- 多字节数值读取（int/size/number/instruction）：
  - `swap=0`：原序 memcpy（`sub_9D80A0/sub_9DA290`）
  - `swap=1`：按字节逆序填充（`sub_9D80C0/sub_9D80F0`）
- 字符串解密（`sub_9D81F0`）：
  1. 读长度 `n`（4 字节）
  2. 读 `n` 字节原始串（含结尾 `\0`）
  3. 对 `i=0..n-2` 执行：
     - `dst[i] = (src[i] + 0xFF - i) & 0xFF`
     - 等价：`dst[i] = (src[i] - (i+1)) & 0xFF`
  4. 最后一字节 `dst[n-1]` 保持原值（通常 `0x00`）

### 3.3 循环加解密

- 有，仅在字符串路径存在循环变换（`sub_9D81F0`）

### 3.4 压缩

- 无
- 主链仅见 `fopen/getc/ungetc/fread` 与内存拷贝；无 `inflate/deflate/RtlDecompress*` 调用

### 3.5 校验位

- 无 CRC/校验位字段
- 存在格式校验与代码合法性校验：
  - header 校验（magic/version/endianness/size/number format）
  - `sub_9D0B20 -> sub_9D07A0` 做字节码结构合法性检查

### 3.6 异或 / 轮转 / 查表

- 解密阶段：无 XOR/ROL/查表
- `sub_9D73C0` 中存在 XOR 哈希，用于字符串驻留（intern），不属于解密

---

## 4. 算法伪代码

```c
Proto* load_luc(State* L, FILE* fp, const char* chunkname) {
    ZIO z = make_zio(reader=sub_9DACF0, data=&fp, name=chunkname);
    int c = z.getc();
    bool is_binary = (c == 0x1B);
    return parser(L, &z, is_binary);
}

Proto* parser(State* L, ZIO* z, bool is_binary) {
    if (is_binary) return undump(L, z);   // sub_9D8770 -> sub_9D8750
    else          return parse_text(L, z); // sub_9D6D90
}

Proto* undump(State* L, ZIO* z) {
    check_header(z);               // sub_9D8610
    return load_function(z, NULL); // sub_9D84D0
}

void check_header(ZIO* z) {
    assert(read_byte(z) == 0x1B);
    assert(read_byte(z) == 0x50);
    int file_endian = read_byte(z);
    z->swap = (file_endian != 1);

    assert(read_byte(z) == 4); // int
    assert(read_byte(z) == 4); // size_t
    assert(read_byte(z) == 4); // Instruction
    assert(read_byte(z) == 6); // OP
    assert(read_byte(z) == 8); // A
    assert(read_byte(z) == 9); // B
    assert(read_byte(z) == 9); // C
    assert(read_byte(z) == 8); // number

    double test = read_number(z, z->swap);
    assert((int)test == 31415926); // 0x01DF5E76
}

String* read_string_dec(ZIO* z) {
    int n = read_int32(z, z->swap);
    if (n == 0) return NULL;

    uint8_t* buf = read_n_bytes(z, n); // raw from file
    for (int i = 0; i < n - 1; i++) {
        buf[i] = (buf[i] - (i + 1)) & 0xFF;
    }
    // buf[n-1] 保持原值（通常 0）
    return intern_string(buf, n - 1);
}
```

---

## 5. 样本字节验证

### 样本 A：`quest.luc` 首字符串（偏移 `0x17`）

- raw：

```text
41 46 3D 60 4C 4E 56 5B ... 8E 98 85 00
```

- dec：

```text
40 44 3A 5C 47 48 4F 53 ... 2E 6C 75 61 00
```

- 解码文本：

```text
@D:\GHOST_China\Lua\Lua_Cn\quest.lua
```

前 8 字节逐字节：

- `41 -> 40` (`-1`)
- `46 -> 44` (`-2`)
- `3D -> 3A` (`-3`)
- `60 -> 5C` (`-4`)
- `4C -> 47` (`-5`)
- `4E -> 48` (`-6`)
- `56 -> 4F` (`-7`)
- `5B -> 53` (`-8`)

### 样本 B：`quest.luc` 字符串常量（偏移 `0x4EF51`）

- raw：`64 6E 6C 67 70 54 57 4B 72 6E 00`
- dec：`63 6C 69 63 6B 4E 50 43 69 64 00`
- 文本：`clickNPCid`

---

## 6. 字节流程图

```mermaid
flowchart TD
A[FILE bytes] --> B[sub_9DACF0 fread 0x200块]
B --> C[sub_9D8060 逐字节读取]
C --> D{字段类型}
D -->|header/int/size/num| E[sub_9D80C0 / sub_9D80F0]
E --> E1{swap?}
E1 -->|0| E2[原序写入]
E1 -->|1| E3[逆序写入]
D -->|string| F[sub_9D81F0]
F --> F1[读len(4字节)]
F1 --> F2[读n字节原串]
F2 --> F3[for i=0..n-2: b[i]-=(i+1)]
F3 --> F4[sub_9D73C0 intern]
E2 --> G[Proto字段填充]
E3 --> G
F4 --> G
G --> H[sub_9D0B20 / sub_9D07A0 结构校验]
```

---

## 7. 内存结构草图

```text
LoadCtx (sub_9D8770 传给 sub_9D8750/sub_9D8610)
+0x00  L
+0x04  ZIO/read state
+0x08  source ptr
+0x0C  swap flag (endianness mismatch)
+0x10  chunk name

Proto (sub_9D22D0 分配 0x48)
+0x08  constants ptr           +0x28  constants count
+0x0C  lineinfo ptr            +0x2C  lineinfo count
+0x10  subproto ptr            +0x34  subproto count
+0x14  code ptr                +0x30  code count
+0x18  locvar ptr              +0x38  locvar count
+0x1C  upvalue-name ptr        +0x24  upvalue-name count
+0x20  source string
+0x3C  lineDefined
+0x44  nups
+0x45  numparams
+0x46  is_vararg
+0x47  maxstacksize
```

---

## 8. 自检清单

- [x] header结构
- [x] key来源
- [x] 循环加解密判断
- [x] 压缩判断
- [x] 校验位判断
- [x] 算法伪代码
- [x] 每字节处理方式
- [x] 种子值判断
- [x] 异或/轮转/查表判断
- [x] 样本luc字节变换验证
- [x] 字节流程图
- [x] 内存结构草图

