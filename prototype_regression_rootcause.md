# Prototype 还原风险与根因分析

## 输入证据
- `reports/quest_backup_decompiled_decode_gbk_out_utf8.lua`
- `reports/quest_after_gbk_reexport_decode_gbk_out_utf8.lua`
- `luc_binary_compare.json`

`luc_binary_compare.json` 关键指标：
- `prototypeCount`: 33 -> 0（-33）
- `functionCount`: 34 -> 1（-33）
- `maxFunctionNestingDepth`: 1 -> 0

## 直接来源判定（prototypeCount 差异）
原始 Lua 文件包含 33 个顶层函数定义，重导出文件为 0 个。
- 原始函数段：`reports/quest_backup_decompiled_decode_gbk_out_utf8.lua:200148`
- 原始函数末尾：`reports/quest_backup_decompiled_decode_gbk_out_utf8.lua:200368`
- 重导出文件中 `^function` 计数：0

因此，`prototypeCount` 的直接来源是：**33 个函数原型整体缺失**。

## 问题逐项回答
1. prototypeCount 差异的直接来源是什么？
- 直接来源是函数定义块缺失（33 个函数体不再生成子原型）。

2. 是否由于匿名 table 表达式消失？
- 不是 prototype 差异的直接来源。
- 匿名 table 形态变化会影响 `instruction/newtable/settable`，但不会单独产生/删除函数原型。

3. 是否由于 chunk 扁平化？
- 是，证据是 `functionCount 34->1` 与 `maxFunctionNestingDepth 1->0`。
- 结果表现为仅保留主 chunk，子函数原型被清空。

4. 是否由于函数作用域合并？
- 从结果看是“函数层被消除到仅主 chunk”。
- 在字节码统计上等价于函数作用域层级被移除（不再存在子函数原型）。

## 根因矩阵（结构视角）
| 结构变化 | 证据 | 对 prototypeCount 的作用 | 影响等级 |
|---|---|---|---|
| 33 个 helper 函数缺失 | 原始 33 个 `function`；重导出 0 个 | 直接导致 -33 | Critical |
| 匿名 table 分段写法消失 | `}).field=` 原始 6406，重导出 0 | 非直接（影响指令与表操作数量） | Medium |
| `qt[id], (...)` 多表达式消失 | 原始 2605，重导出 0 | 非直接（影响赋值路径） | Medium |

## 是否为崩溃主因
- 在“prototype 回归”这个故障维度上：**是主因**。
- 即：`prototypeCount` 的回归主因不是字段值，也不是文本内容，而是函数原型块被去除。
- 匿名 table / 分段构造变化是次级结构偏差，不是 `prototypeCount` 直接来源。
