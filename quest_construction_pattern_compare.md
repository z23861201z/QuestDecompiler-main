# Quest Lua 构造模式对比（仅结构，不比较字段值）

## 分析范围
- 原始：`reports/quest_backup_decompiled_decode_gbk_out_utf8.lua`
- 重导出：`reports/quest_after_gbk_reexport_decode_gbk_out_utf8.lua`
- 佐证：`luc_binary_compare.json`（仅用于 VM 指标交叉验证）

## 构造模式差异矩阵
| 模式项 | 原始 quest.lua | 重导出 quest.lua | 证据 | 影响等级 |
|---|---|---|---|---|
| 匿名 table 表达式 `({ ... }).goal = ...` | 大量存在 | 不存在 | 原始 `}).goal =` 2471 次；重导出 0 次 | High |
| 匿名 table 表达式 `({ ... }).reward = ...` | 通过 `qt[id], (...)` 组合出现 | 不存在 | 原始 `}).reward =` 2605 次；重导出 0 次 | High |
| `qt[id], (...)` 多表达式构造 | 大量存在 | 不存在 | 原始 `^qt\\[...\\],\\s*\\(\\{` 2605 次；重导出 0 次 | High |
| 分段 table 构造（同一 quest 分多语句拼装） | 强存在 | 基本不存在（单块内联） | 原始 `}).field=` 总计 6406 次；重导出 0 次 | High |
| 分步赋值（先构造片段，再落到 `qt[id]`） | 强存在 | 弱/无 | 原始以 `;({` 起始语句 3801 次；重导出 0 次 | Medium-High |
| 重复块结构（同一 quest 基础字段反复展开） | 强存在 | 明显收敛 | 原始 `^  id =` 9011 次 vs 重导出 2604 次 | Medium |
| runtime 副作用表达式（临时对象字段赋值） | 存在 | 基本不存在 | 原始 `;({ ... }).field = ...` 大量出现；重导出无此形态 | High |

## 原始 quest.lua 的构造模式抽象模型
```lua
qt = {}
clickNPCid = 0

-- 对同一 quest 的“片段写入”落在匿名 table 表达式
;({ BASE_qid }).goal = GOAL_qid
;({ BASE_qid }).requstItem = REQ_qid
;({ BASE_qid }).info = INFO_qid
;({ BASE_qid }).npcsay = NPCSAY_qid
;({ BASE_qid }).bQLoop = BQ_qid
;({ BASE_qid }).needLevel = LV_qid

-- 最终采用多变量赋值
qt[qid], ({ BASE_qid }).reward = { BASE_qid }, REWARD_qid

-- 文件尾存在 33 个访问函数
function getid(qid) ... end
...
```

典型位置：
- 匿名/分段起点：`reports/quest_backup_decompiled_decode_gbk_out_utf8.lua:3`
- `qt[id], (...)`：`reports/quest_backup_decompiled_decode_gbk_out_utf8.lua:25`
- helper 函数段起点：`reports/quest_backup_decompiled_decode_gbk_out_utf8.lua:200148`

## 当前导出 lua 的构造模式抽象模型
```lua
qt[qid] = {
  BASE_qid,
  goal = GOAL_qid,
  reward = REWARD_qid
}
-- 连续单块输出，文件尾无 helper function 定义
```

典型位置：
- 单块构造起点：`reports/quest_after_gbk_reexport_decode_gbk_out_utf8.lua:1`

## VM 指令层面可能影响（结构视角）
- 匿名 table 表达式与多表达式赋值消失后，`NEWTABLE/SETTABLE` 会减少，因为临时表与临时字段写入路径被折叠。
- 同一 quest 的“多段写入”改成“单块内联”后，语句边界和寄存器生命周期变短，整体 `instructionCount` 下降。
- 由 `qt[id], (...)` 改为 `qt[id] = {...}` 后，左值/右值并行赋值路径消失，相关寄存器搬运与中间对象构造减少。
- 与上面模式变化一致，`luc_binary_compare.json` 中：
  - `instructionCount` -13534
  - `newtableCount` -3473
  - `settableCount` -2974

## 为恢复 prototype 结构必须保持的构造
只看 prototype（函数原型）恢复，必须保持：
- 文件尾 33 个 `function ... end` 块（数量、顺序、名称一致）。
- 顶层 chunk 中函数定义语句存在（不可省略成纯数据块）。

若目标是同时逼近原始运行结构（不仅 prototype）还应保持：
- `qt[id], (...)` 多表达式构造形态。
- `;({ ... }).goal = ...` / `;({ ... }).reward = ...` 这类匿名 table 分段写入。
- 语句顺序（先分段，再最终 `qt[id], (...)`）与分块颗粒度。

## 影响等级评估与“是否为崩溃主因”
- 构造模式变化本身：`High`（对 VM 结构差异影响大）。
- 但“构造模式变化”不是本次 `prototypeCount` 下降的直接主因。
- 在当前证据下，`prototype` 维度的主因是函数原型块缺失（详见 `prototype_regression_rootcause.md`）。
