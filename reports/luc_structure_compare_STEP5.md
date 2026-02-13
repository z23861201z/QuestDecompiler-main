# Step-5 字节码结构一致性验证报告

## 输入文件
- 修复前 luc：`reports/step5_artifacts/quest_pre_fix.luc`
- 修复后 luc：`reports/step5_artifacts/quest_post_fix.luc`

## 对比结果

| 指标 | 修复前 | 修复后 | 差值 | 变化率 |
|---|---:|---:|---:|---:|
| 文件大小(bytes) | 2,474,477 | 2,283,359 | -191,118 | -7.72% |
| 常量池数量(constant_total) | 23,583 | 23,580 | -3 | -0.01% |
| NEWTABLE50 数量 | 29,344 | 20,353 | -8,991 | -30.64% |
| SETTABLE 数量 | 48,280 | 33,386 | -14,894 | -30.85% |
| prototype_total | 0 | 0 | 0 | 0.00% |
| 指令数量(instruction_total) | 127,434 | 103,548 | -23,886 | -18.74% |

## 阈值判定
- 规则1：`prototype_total` 差异 > 1 判定结构破坏
  - 实际：`|0 - 0| = 0`，未触发
- 规则2：指令数量增加 > 5% 判定结构破坏
  - 实际：`(103548 - 127434) / 127434 = -18.74%`，未触发

## 结论
- 判定：**未触发结构破坏阈值**
- 回滚结论：**无需回滚**

## 执行记录（核心命令）
1. 修复前导出（使用 `HEAD` 版本 `Phase4QuestLucExporter`）
2. 修复后导出（使用当前 `Phase4QuestLucExporter`）
3. `lua -> luc` 编码：`unluac.encode.LucEncoder`
4. 结构统计：`reports/step5_artifacts/LucStructureStatsTool.java`（临时分析工具）
