# Phase Runtime — game.exe Quest 执行逻辑（非 luc 结构）

> 分析对象：`D:\TitanGames\GhostOnline\Game.exe.i64`
>
> 说明：本次尝试直连 `ida-pro-mcp` 失败（`ConnectionRefused`），已改用同一 IDB 的 IDA 批处理脚本导出反编译与交叉引用，证据文件见文末“证据清单”。

---

## 1) 结论总览（按你的 6 个问题）

1. **`qt[xxxx]` 表何时被读取**  
   在 quest runtime 收包分发后，由 quest 主流程函数调用脚本接口读取。核心路径是 `sub_A10B90` 分发到 `sub_7508C0` / `sub_757740` / `sub_757C30` / `sub_74D850`，这些函数内通过 `sub_9DB000 + sub_9CC2E0/sub_9CC670/sub_9CD700` 执行脚本查询（`chkQState/getContents/getAnswer/getGoal*/getReward*`）。

2. **`contents[]` 如何按顺序展示**  
   `sub_5D23F0` 在任务分支中调用 `getContents` 取数组后，使用内部游标 `dword_3004280` 与 `sub_5D0500(index)` 顺序读取；前进/后退由 UI 状态码 `49001/49399`（前进）与 `49002`（后退）控制。

3. **`ANSWER_YES:` 是否被特殊解析**  
   是。`sub_5D23F0` 对当前 `contents` 行调用 `sub_5D1360(L"ANSWER_YES:", 0)` / `ANSWER_NO:` / `ANSWER_END:` / `ANSWER_IF_NO:` / `ANSWER_QUEST_YES:` / `ANSWER_QUEST_NO:` 进行分支判定，并映射到不同 UI 状态码与发包路径。

4. **`answer[]` 与 `contents[]` 绑定规则**  
   绑定发生在 `sub_5D23F0`：先扫描 `contents` 中带 `ANSWER_` 前缀的行决定可选分支，再调用 `getAnswer` 取 answer 文本并填充对应按钮；`ANSWER_QUEST_YES/NO` 分支直接触发完成/放弃请求路径。

5. **`goal.getItem` 完成检测逻辑位置**  
   在 `sub_62F690` 与 `sub_669DA0`。两者都通过 `getGoalItemKind/getGoalItem/getGoalItemCount` 拉取目标，再与背包/容器计数比对（经 `sub_4E1980` 与物品表遍历）决定是否允许发送完成请求 `sub_A090F0`。

6. **reward 发放在客户端还是服务器**  
   **奖励展示/文案在客户端**（`sub_684D60`、`sub_757C30` 调用 `getReward*` 组 UI 文本）。  
   **奖励生效由服务器回包驱动**（`sub_A10B90` 的 `0x0080` 分支调用 `sub_757740` 写任务状态，再 `sub_758F00` 刷新；`0x027A` 触发 `sub_757C30/sub_74D850` 刷 UI）。客户端不会仅凭本地文本直接完成权威结算。

---

## 2) Quest Runtime 调用链图

```mermaid
flowchart TD
    A[sub_A10B90 收包分发 0xA10B90]
    A -->|case 0x68| B[sub_7508C0 0x7508C0]
    A -->|case 0x80| C[sub_757740 0x757740]
    C --> D[sub_758F00 刷新]
    A -->|case 0x027A| E[sub_757C30 0x757C30]
    A -->|case 0x027A| F[sub_74D850 0x74D850]

    B --> G[sub_9DB000 脚本装载]
    B --> H[sub_9CC2E0("chkQState")]
    H --> I[sub_9CC670 参数压栈]
    I --> J[sub_9CD700 执行调用]

    K[sub_5D23F0 UI/任务总调度 0x5D23F0] -->|case 16014| L[sub_62F690 完成检测/提交]
    K -->|case 16052| M[sub_669DA0 完成检测分支]
    K -->|NPC 对话| N[sub_683880/683980/683A80]

    N --> G
    N --> O[sub_9CC2E0("npcsay") or sub_46B1B0("npcsay")]
    O --> J
    N --> P[sub_A091A0 发送0x007D]

    L --> Q[sub_A090F0 发送0x007C]
    M --> Q
    R[sub_684D60 0x684D60] --> S[sub_A09230 发送0x007E]
```

---

## 3) Quest 对话状态机图（contents / answer）

```mermaid
flowchart TD
    S0[进入任务对话 sub_5D23F0] --> S1[getContents(questId)]
    S1 --> S2[读取当前行 index=dword_3004280]
    S2 --> S3{检测前缀}

    S3 -->|ANSWER_YES| Y1[生成 YES 选项按钮]
    S3 -->|ANSWER_NO| N1[生成 NO 选项按钮]
    S3 -->|ANSWER_END| E1[结束型分支]
    S3 -->|ANSWER_IF_NO| IFN[条件否定分支]
    S3 -->|普通文本| TXT[显示 NPC 文本]

    TXT --> NX[扫描后续 ANSWER_ 行]
    NX --> GA[getAnswer(questId)]
    GA --> UI[绑定 answer[] 到选项按钮]

    UI --> CH{玩家选择}
    CH -->|YES/QUEST_YES| SENDC[sub_A090F0 发送 0x007C]
    CH -->|NO/QUEST_NO| SENDB[sub_A09070 发送 0x007B]
    CH -->|返回对话| SENDD[sub_A091A0 发送 0x007D]

    SENDC --> REF[sub_757740/0x0080 + sub_757C30/0x027A 刷新]
    SENDB --> REF
    SENDD --> REF
```

---

## 4) 核心函数地址与职责

| 函数 | 地址 | 职责 |
|---|---:|---|
| `sub_A10B90` | `0xA10B90` | 收包分发主函数；将 quest 相关包分派到 runtime 处理函数 |
| `sub_7508C0` | `0x7508C0` | quest 运行时主循环之一；对脚本对象执行 `chkQState` |
| `sub_757740` | `0x757740` | 处理 `0x0080` 任务状态更新；写 questRecord 状态/进度 |
| `sub_757C30` | `0x757C30` | 任务 UI 文本重算；拉取 `getContents/getReward*` |
| `sub_74D850` | `0x74D850` | 任务 UI/对话刷新；可装载 `npc_*.luc` 并执行 `npcsay` |
| `sub_5D23F0` | `0x5D23F0` | 任务 UI 总调度（包含 case `16014/16052` 与对话分支状态机） |
| `sub_62F690` | `0x62F690` | 完成检测主路径：`getGoalItem*` 比对后发送 `0x007C` |
| `sub_669DA0` | `0x669DA0` | 完成检测分支路径：同样触发 `0x007C` |
| `sub_683880` | `0x683880` | `npcsay` 路径（变体1）；按条件触发 `0x007D` |
| `sub_683980` | `0x683980` | `npcsay` 路径（变体2）；`sub_9CC2E0("npcsay")` |
| `sub_683A80` | `0x683A80` | `npcsay` 路径（变体3）；`sub_9CC2E0("npcsay")` |
| `sub_684D60` | `0x684D60` | Done2 流程；发送 `0x007E` 后读取 `getReward*` 生成奖励展示 |
| `sub_9DB000` | `0x9DB000` | 脚本加载/进入点（大量 quest runtime 函数先调用它） |
| `sub_9CC2E0` | `0x9CC2E0` | 设定脚本调用名（如 `chkQState/getContents/getAnswer`） |
| `sub_9CC670` | `0x9CC670` | 压入脚本参数 |
| `sub_9CD700` | `0x9CD700` | 执行脚本调用 |

---

## 5) 对 6 个问题的字节级/调用级证据

### 5.1 `qt[xxxx]` 何时读取

- `sub_A10B90` 在 `case 0x68` 直接调 `sub_7508C0`（`0xA16FF8 -> 0x7508C0`）。
- `sub_7508C0` 内：
  - `0x752FD0` 调 `sub_9DB000` 装载脚本对象。
  - `0x752FF3` 调 `sub_9CC2E0("chkQState",1,0)`。
  - `0x75300A` / `0x753012` 调 `sub_9CC670` / `sub_9CD700` 执行。
- 该链路即 quest 表读取与状态判定入口。

### 5.2 `contents[]` 顺序展示规则

- `sub_5D23F0` 行 `12508` 调 `getContents`。
- 行 `12516/12519/12522` 的 switch 分支使用 `v1714=*(_DWORD*)(v1907+2140)` 作为动作码：
  - `49001/49399`：`++dword_3004280`（前进）
  - `49002`：`--dword_3004280`（后退）
- 行 `12532` 起循环 `sub_5D0500(index)` + `sub_5D1360(L"ANSWER_",0)` 扫描下一可交互行。

### 5.3 `ANSWER_YES:` 是否特殊解析

- `sub_5D23F0` 明确调用：
  - `sub_5D1360(L"ANSWER_YES:",0)`（行 `12782`、`12842`）
  - `sub_5D1360(L"ANSWER_NO:",0)`（行 `12845`）
  - `sub_5D1360(L"ANSWER_END:",0)`（同片段上文）
  - `sub_5D1360(L"ANSWER_IF_NO:",0)`（行 `12543`）
- 匹配后设置不同状态码 `49001/49003/49004/49007`，进入不同 UI/网络路径。

### 5.4 `answer[]` 与 `contents[]` 的绑定规则

- `sub_5D23F0` 行 `12508` 先取 `getContents`；行 `12543` 起扫描 `ANSWER_` 前缀位置。
- 当 `dword_3004280 + answerCount + 1 >= contentsCount` 时，行 `12576` 调 `getAnswer`。
- 随后将 `getAnswer` 返回文本绑定到按钮（`sub_88F390` + 设置项 `[...] [535]` 状态码）。
- `ANSWER_QUEST_YES/NO` 分别触发提交/放弃分支（行 `12916`、`12964`）。

### 5.5 `goal.getItem` 完成检测逻辑

- `sub_62F690`：
  - `getGoalItemKind`（行 `120`）
  - 循环 `getGoalItem` / `getGoalItemCount`（行 `158` / `165`）
  - 汇总物品类型库存后判定；满足则行 `565` 发送 `sub_A090F0`。
  - 若有 `dword_D0B0BC` 先行 `sub_A091A0`（行 `418`）。
- `sub_669DA0`：
  - 同样先拉 `getGoalItemKind/getGoalItem/getGoalItemCount`。
  - 满足条件后 `sub_A090F0`（行 `121` / `141`）。

### 5.6 reward 真实触发点（客户端/服务器）

- 客户端展示：
  - `sub_684D60` 行 `62` 先发 `sub_A09230`（0x007E），随后行 `69/83/97/111/122/132/160` 连续读取 `getRewardMoney/Exp/Fame/Item*/Skill` 拼 UI 文本。
  - `sub_757C30` 也拉取 `getReward*` 并更新任务窗口字段。
- 服务器驱动状态：
  - `sub_A10B90` `case 0x80`：行 `3631` 调 `sub_757740` 写任务状态，再 `sub_758F00`。
  - `sub_A10B90` `case 0x027A`：行 `8688/8689` 调 `sub_757C30/sub_74D850` 刷新界面。
- 结论：**奖励展示由客户端脚本生成，奖励状态生效由服务器状态包（0x0080/0x027A 等）触发。**

---

## 6) 关键词搜索结果（按你的强制项）

### 6.1 `"ANSWER_YES" / "NPC_SAY" / "qt[" / "goal" / "getItem"`

- `ANSWER_YES`：字符串表无独立常量，但在 `sub_5D23F0` 中以宽字面量 `L"ANSWER_YES:"` 调用 `sub_5D1360` 匹配。
- `NPC_SAY`：
  - `sub_536C10` 注册 `"NPC_SAY"` / `"NPC_SAY_MERGE"`。
  - runtime 执行点：`sub_683880/683980/683A80` 调 `npcsay`。
- `qt[`：未在二进制字符串中保留明文字面量；运行时通过脚本 API (`chkQState/getContents/getAnswer/getGoal*`) 间接访问 quest 表。
- `goal/getItem`：
  - `getGoalItemKind/getGoalItem/getGoalItemCount` 大量 xref 至 `sub_62F690/sub_669DA0/sub_757C30`。
  - `getItem` 在 VM/脚本层函数表存在（`sub_9CA030` 等），运行时检测链使用的是 `getGoal*` 系列。

### 6.2 文件读取 API（`fopen/CreateFileA/ReadFile/fread`）

- 在本次 quest runtime 关键函数链中，未看到直接 `CreateFileA/ReadFile/fopen` 调用。
- 全局导入 xref 统计：
  - `CreateFileA`: 0 xref
  - `ReadFile`: 0 xref
  - `fopen`: 0 xref
  - `_wfopen`: 0 xref
  - `fread`: 1 xref（`sub_C131E0`，不在 quest runtime 主链）
- quest runtime 中 `.luc` 装载统一走 `sub_9DB000`（例如 `sub_74D850` 装载 `npc_300117.luc`）。

---

## 7) reward / 对话 / 完成检测的调用路径（简版）

### 7.1 对话执行链

`sub_A10B90` → `sub_5D23F0`(UI case) → `sub_683880|sub_683980|sub_683A80` → `sub_9DB000` → `npcsay` (`sub_9CC2E0/sub_9CC670/sub_9CD700`) → 可选 `sub_A091A0(0x007D)`

### 7.2 完成检测链

`sub_A10B90`/UI事件 → `sub_5D23F0(case 16014|16052)` → `sub_62F690|sub_669DA0` → `getGoalItem*` 校验 → `sub_A090F0(0x007C)`

### 7.3 奖励显示链

`sub_684D60`（含 `sub_A09230(0x007E)`）→ `getReward*` → UI 文本构造；

状态确认：`sub_A10B90 case 0x80 -> sub_757740`，`case 0x027A -> sub_757C30/sub_74D850`。

---

## 8) 自检（按你本阶段要求）

- [x] 使用了 `ida-pro-mcp` 尝试连接（失败，已记录错误），并完成同 IDB 的离线 IDA 反编译取证。  
- [x] 搜索了 `ANSWER_YES / NPC_SAY / qt[ / goal / getItem`。  
- [x] 给出 quest runtime 主函数、对话状态机函数、完成检测函数。  
- [x] 输出了调用链图与状态机图。  
- [x] 给出 `contents/answer` 绑定规则。  
- [x] 给出 reward 触发点（客户端展示 vs 服务器状态驱动）。  
- [x] 每个关键结论附函数地址与调用路径。

---

## 9) 证据清单

- `D:\TitanGames\ida-mcp\.ida-mcp\runtime_decomp\00A10B90_sub_A10B90.c.txt`
- `D:\TitanGames\ida-mcp\.ida-mcp\runtime_decomp\007508C0_sub_7508C0.c.txt`
- `D:\TitanGames\ida-mcp\.ida-mcp\runtime_decomp\005D23F0_sub_5D23F0.c.txt`
- `D:\TitanGames\ida-mcp\.ida-mcp\runtime_decomp\0062F690_sub_62F690.c.txt`
- `D:\TitanGames\ida-mcp\.ida-mcp\runtime_decomp\00669DA0_sub_669DA0.c.txt`
- `D:\TitanGames\ida-mcp\.ida-mcp\runtime_decomp\00684D60_sub_684D60.c.txt`
- `D:\TitanGames\ida-mcp\.ida-mcp\runtime_decomp\00683880_sub_683880.c.txt`
- `D:\TitanGames\ida-mcp\.ida-mcp\runtime_decomp\00683980_sub_683980.c.txt`
- `D:\TitanGames\ida-mcp\.ida-mcp\runtime_decomp\00683A80_sub_683A80.c.txt`
- `D:\TitanGames\ida-mcp\.ida-mcp\runtime_decomp\00757C30_sub_757C30.c.txt`
- `D:\TitanGames\ida-mcp\.ida-mcp\runtime_decomp\0074D850_sub_74D850.c.txt`
- `D:\TitanGames\ida-mcp\.ida-mcp\phase_runtime_quest_scan2.json`
- `D:\TitanGames\ida-mcp\.ida-mcp\phase_runtime_quest_scan2.md`
- `D:\TitanGames\ida-mcp\.ida-mcp\xrefs_9db000.log`
- `D:\TitanGames\ida-mcp\.ida-mcp\phase1_key_funcs.asm.txt`

