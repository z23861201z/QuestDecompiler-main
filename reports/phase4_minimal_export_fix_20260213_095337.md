# Phase4 Minimal Export Fix Report (20260213_095337)

## 修改点列表

### src/unluac/semantic/Phase4QuestLucExporter.java
- main(String[] args)：新增可选 referenceQuestLua 参数（第5参）并输出 profile/suppression 统计。
- export(...)：新增重载 export(..., Path referenceQuestLua)，引入“原始字段画像”加载并按画像导出。
- appendQuest(...)：改为按 quest 画像字段顺序写出，禁止固定模板全量写出。
- renderTopField(...)：按字段名精确写出；reward.getItem 强制键名保持 getItem。
- renderGoal(...) / renderReward(...)：改为受画像子字段顺序驱动。
- recordSuppressedTopFields(...) / recordSuppressedGoalFields(...) / recordSuppressedRewardFields(...)：记录“DB有值但原始无字段”的抑制行为。
- resolveReferenceQuestLua(...)：自动发现 reports/structure_audit_*/questbak_decompiled.lua。
- loadReferenceFieldProfiles(...)：新增对 questbak_decompiled.lua（qt[id], ({...}).goal/.reward 形式）的字段画像聚合。
- scanTableFields(...) / skipLuaValue(...) 等：新增轻量语法扫描，避免全量 AST/对象构建导致内存膨胀。
- QuestFieldProfile：新增 top/goal/reward 字段集合 + 顺序承载。
- ExportResult：新增 profileQuestCount / profileMissingQuestCount / suppressedFieldCount / suppressedFieldExamples / referenceQuestLua。

### src/unluac/semantic/Phase4QuestExportValidator.java
- validate(...)：新增字段存在性一致性校验（top/goal/reward）与语义分区校验。
- compareFieldPresence(...)：新增“缺失/多余字段”比对。
- fromMapToQuestValue(...)：新增导出侧字段存在性采集与 goal/reward 分区违规检测。
- loadQuestValuesFromLuc(...)：新增原始侧字段存在性采集（top/goal/reward）。
- ValidationResult.addMismatch(...)：新增 sourcePartition 字段并自动推断分区。

## 被抑制导出的字段示例
- questId=2, field=needItem
- questId=2, field=reward.exp
- questId=2, field=reward.fame
- questId=2, field=reward.pvppoint
- questId=2, field=reward.mileage
- questId=3, field=needItem
- questId=3, field=reward.pvppoint
- questId=4, field=needItem
- questId=5, field=reward.pvppoint
- questId=7, field=reward.fame

> 当前导出实测：suppressedFieldCount=13156

## 与 STEP5 的结构差异摘要

来源：reports/luc_structure_compare_STEP5.md

- 文件大小：2,474,477 -> 2,283,359（-7.72%）
- 常量池数量：23,583 -> 23,580（-0.01%）
- NEWTABLE50：29,344 -> 20,353（-30.64%）
- SETTABLE：48,280 -> 33,386（-30.85%）
- prototype_total：0 -> 0（无变化）
- 指令数量：127,434 -> 103,548（-18.74%）

## 本次编译与验证结果
- 编译：通过。
- 导出：通过（画像 quest 数 2604，导出 quest 数 2602，画像缺失 quest 数 1）。
- 校验：mismatchCount=17550（输出于 reports/phase4_export_validation.json）。

## 备注
- 本次仅改动 Phase4 导出/校验两文件，未改 Phase2/Phase3/Extractor/DB 结构。
