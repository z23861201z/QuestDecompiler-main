# Phase 1 — `luc` 解析入口定位报告（`Game.exe`）

> 说明：你点名了 `@ida-pro-mcp`，但本次会话里 IDA MCP 插件未连接（`ConnectionRefused`）。我改用 `idat.exe` 对现有 `Game.exe.i64` 做离线脚本分析，结论如下。

## 1) 搜索结果（按要求）

- `.luc` 字符串命中：
  - `0x00C866D8` → `quest.luc`（wide）
  - `0x00C9E628` → `chat.luc`（wide）
  - `0x00C9E5FC` → `./%s/npc_%s.luc`（ascii）
- `quest` 相关命中：
  - `sub_536C10` 内大量 `QUEST` 指令/注册字符串，且包含 `quest.luc` 装载路径。
- 文件读取 API（导入表）：
  - `CreateFileA @ 0xC632B8`
  - `CreateFileW @ 0xC63304`
  - `ReadFile @ 0xC63344`
  - `fopen @ 0xC6352C`
  - `fread @ 0xC634A4`
  - `fseek @ 0xC63484`
  - `ftell @ 0xC63760`
  - `_read @ 0xC6345C`
- 关键结论：`luc` 主链使用的是 `fopen/fread` 路径，不是 `CreateFileA/ReadFile`。

## 2) 调用路径图（文件读取 → luc识别 → 解析）

```mermaid
flowchart LR
A[sub_536C10 (0x536C10)\n构造 quest.luc 路径] --> B[sub_9DB000 (0x9DB000)]
A2[sub_9BEBB0/9BEFE0/9BF470/9BF960\n构造 chat.luc/npc_%s.luc] --> B

B --> C[sub_9DAD80 (0x9DAD80)\n文件打开入口]
C -->|fopen(\"r\") / 条件切换 fopen(\"rb\")| D[(FILE*)]
C -->|push callback sub_9DACF0| E[sub_9CEDB0 (0x9CEDB0)]

E --> F[sub_9DA260 初始化读取上下文]
E --> G[sub_9DA230 预读首字节]
G --> H{byte == 0x1B ?}
H -->|yes| I[binary/luc 标志=1]
H -->|no| J[text/lua 标志=0]
I --> K[sub_9D1BD0 (0x9D1BD0)\n解析入口]
J --> K

sub_9DACF0 -->|fread| D
```

## 3) 关键函数地址与职责

- `sub_536C10 @ 0x00536C10`
  - 任务系统初始化/注册逻辑内，拼出 `quest.luc` 路径并调用 `sub_9DB000`。
  - 证据：`0x53BE12 push off_C866D8`（`quest.luc`）→ `0x53BE99 call sub_9DB000`。
- `sub_9BEBB0 @ 0x009BEBB0`（同类：`sub_9BEFE0/9BF470/9BF960`）
  - 构造 `chat.luc`、`%s/npc_%s.luc` 并调用 `sub_9DB000`。
- `sub_9DB000 @ 0x009DB000`
  - `luc` 文件加载总入口包装；直接转到 `sub_9DAD80`。
- `sub_9DAD80 @ 0x009DAD80`
  - 文件打开与解析调度：
    - `fopen("r")`，必要时切 `fopen("rb")`
    - 传入 reader 回调 `sub_9DACF0`
    - 调用 `sub_9CEDB0` 执行解析
- `sub_9DACF0 @ 0x009DACF0`
  - reader 回调，核心读取是 `fread(...)`。
- `sub_9CEDB0 @ 0x009CEDB0`
  - **luc 识别入口（关键）**：
    - 读取首字节后 `cmp eax, 1Bh`
    - `setz` 得到 binary 标志，传给 `sub_9D1BD0`
- `sub_9D1BD0 @ 0x009D1BD0`
  - 解析执行入口（`sub_9CEDB0` 识别后最终进入）。

## 4) 特征头判断 & 解密结论

- 特征头判断：**存在**
  - 位置：`0x009CEDDF`，指令 `cmp eax, 1Bh`（Lua 字节码典型首字节）。
- 文件读取后传递目标：
  - `sub_9DAD80 -> sub_9CEDB0 -> sub_9D1BD0`。
- 解密调用：**未发现独立解密调用**
  - 在该链路中未见 `CryptDecrypt/Bcrypt/...` 导入或明显解密函数跳转；
  - 更像“读取 + 首字节识别 + 直接解析”。

## 5) 自检（按你的硬性要求）

- [x] 搜索了 `.luc`
- [x] 搜索了 `quest`
- [x] 搜索了文件读取 API（`fopen/CreateFileA/ReadFile/...`）
- [x] 给出调用链（读取 → 识别 → 解析）
- [x] 给出关键函数地址与职责
- [x] 判断了特征头与是否存在解密调用
- [x] 含调用路径图（Mermaid）

可复核证据文件（本机）：
- `D:\TitanGames\ida-mcp\.ida-mcp\phase1_key_funcs.asm.txt:5388`
- `D:\TitanGames\ida-mcp\.ida-mcp\phase1_lua_core.asm.txt:2`
- `D:\TitanGames\ida-mcp\.ida-mcp\xrefs_9db000.log:24`