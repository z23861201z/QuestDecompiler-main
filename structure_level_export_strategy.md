# 结构级生成策略（设计稿，不改数据）

## 目标与边界
- 目标：仅调整 Lua 输出结构，复刻原始构造模式。
- 不变：任务数据本身（字段值、业务语义、DB 内容）。
- 必保留：
  - 匿名 table 表达式
  - `goal/reward` 分段赋值
  - `qt[id], (...)` 多表达式构造

## 目标结构模板
按 quest 粒度输出时，采用“分段 + 终段”模板：

```lua
;({ BASE_qid }).goal = GOAL_qid           -- 如原始存在该段
;({ BASE_qid }).requstItem = REQ_qid      -- 如原始存在该段
;({ BASE_qid }).info = INFO_qid           -- 如原始存在该段
;({ BASE_qid }).npcsay = NPCSAY_qid       -- 如原始存在该段
;({ BASE_qid }).bQLoop = BQ_qid           -- 如原始存在该段
;({ BASE_qid }).needLevel = LV_qid        -- 如原始存在该段

qt[qid], ({ BASE_qid }).reward = { BASE_qid }, REWARD_qid
```

文件头/尾结构保持：
```lua
qt = {}
clickNPCid = 0
-- ... quest blocks ...
function getNPCid() ... end
...
```

## 生成策略（仅设计）
1. 建立“构造签名”而非“数据签名”
- 从原始文件提取每个 qid 的结构签名：
  - 是否有 `;({ ... }).goal =`
  - 是否有 `;({ ... }).requstItem =`
  - 是否有 `;({ ... }).info/.npcsay/.bQLoop/.needLevel =`
  - 最终是否用 `qt[id], (...)` 终段
  - 是否存在重复 qid 块（如原始中重复出现）

2. 结构驱动渲染
- DB 提供值，结构签名决定“如何输出”。
- 同值可按不同结构输出；本策略固定为“原始结构优先”。

3. 分段写入顺序锁定
- 对每个 qid，按原始语句顺序输出片段，最后输出 `qt[id], (...)` 终段。
- 不做“自动内联优化”与“块合并优化”。

4. helper 函数块保留
- 尾部 33 个 getter 函数按原始顺序/命名输出。
- 不折叠、不删除、不改名。

5. 仅结构变换，不改数据
- 所有值来源保持原管道；只改变语句组织方式（statement layout）。

## 构造模式差异矩阵（用于验收）
| 验收项 | 目标值（对齐原始） | 失败表现 |
|---|---|---|
| `^qt\\[...\\],\\s*\\(\\{` | 2605 | 变为 0（扁平化） |
| `^;\\(\\{` | 3801 | 变为 0（分段丢失） |
| `\\}\\)\\.goal\\s*=` | 2471 | 变为 0（goal 内联化） |
| `\\}\\)\\.reward\\s*=` | 2605 | 变为 0（reward 内联化） |
| `^function\\s+` | 33 | 变为 0（prototype 丢失） |

## VM 影响等级评估
| 结构偏差 | 影响等级 | 说明 |
|---|---|---|
| helper 函数块缺失 | Critical | 直接造成 `prototypeCount` 回归 |
| `qt[id], (...)` 改为 `qt[id] = {...}` | High | 改变赋值路径与寄存器生命周期 |
| 匿名分段改为单块内联 | High | 改变 `NEWTABLE/SETTABLE` 规模与语句边界 |
| 重复块被压缩 | Medium | 影响指令密度与 chunk 形态一致性 |

## 是否为崩溃主因（结构视角）
- 是，主因在“函数原型层”（helper 函数块缺失）。
- 同时，分段构造与多表达式构造消失会放大 VM 结构偏离，属于高风险共因，但不是 `prototypeCount` 的直接来源。

## 交付判定标准
- 通过：`prototypeCount/functionCount/maxFunctionNestingDepth` 回到原始量级，且模式计数接近原始。
- 不通过：仍为单块扁平输出（`qt[id]={...}` 主导）或函数块缺失。
