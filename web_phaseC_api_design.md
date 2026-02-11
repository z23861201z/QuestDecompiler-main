# Web Phase-C：REST API 控制层设计

## 1. API 列表

- `POST /api/phase2/run`
- `POST /api/phase3/run`
- `POST /api/phase4/exportQuest`
- `POST /api/phase5/exportNpc`
- `POST /api/pipeline/full`

## 2. 请求参数说明

所有接口都支持 `workingDirectory`（可选，默认 `.`）。

### `POST /api/phase2/run`

请求体（`Phase2Request`）：

- `workingDirectory`: 工作目录
- `questLuc`: quest 输入 luc（默认 `new.luc`）
- `npcDir`: NPC lua 目录（默认 `npc-lua-autofixed`）
- `questOut`: 可选，自定义 quest JSON 输出路径
- `npcOut`: 可选，自定义 npc 索引 JSON 输出路径
- `summaryOut`: 可选，自定义 phase2 summary 输出路径

### `POST /api/phase3/run`

请求体（`Phase3Request`）：

- `workingDirectory`
- `phase2QuestJson`: 可选，默认 `reports/phase2_quest_data.json`
- `phase25GraphJson`: 可选，默认 `reports/phase2_5_quest_npc_dependency_graph.json`
- `summaryOutput`: 可选，默认 `reports/phase3_db_insert_summary.json`
- `jdbcUrl`: 默认 `jdbc:mysql://127.0.0.1:3306/ghost_game?...`
- `user`: 默认 `root`
- `password`: 默认 `root`

说明：该接口内部会先执行一次 `Phase2.5` 以保证依赖图存在。

### `POST /api/phase4/exportQuest`

请求体（`Phase4Request`）：

- `workingDirectory`
- `output`: 可选，默认 `reports/phase4_exported_quest.lua`
- `jdbcUrl` / `user` / `password`

### `POST /api/phase5/exportNpc`

请求体（`Phase5ExportRequest`）：

- `workingDirectory`
- `phase2NpcIndex`: 可选，默认 `reports/phase2_npc_reference_index.json`
- `outputDir`: 可选，默认 `reports/phase5_exported_npc`
- `summaryOutput`: 可选，默认 `reports/phase5_export_summary.json`
- `jdbcUrl` / `user` / `password`

### `POST /api/pipeline/full`

请求体（`PipelineFullRequest`）：

- `workingDirectory`
- `questLuc`（默认 `new.luc`）
- `npcDir`（默认 `npc-lua-autofixed`）
- `jdbcUrl` / `user` / `password`
- `phase4QuestOutput`（默认 `reports/phase4_exported_quest.lua`）
- `phase5OutputDir`（默认 `reports/phase5_exported_npc`）
- `phase5SummaryOutput`（默认 `reports/phase5_export_summary.json`）

执行顺序：`Phase2 -> Phase2.5 -> Phase3 -> Phase4 -> Phase5`

## 3. 统一响应结构

单阶段接口返回：

```json
{
  "phaseName": "",
  "status": "",
  "elapsedMs": 0,
  "artifacts": {},
  "error": null
}
```

`/api/pipeline/full` 返回同结构的数组（每个阶段一条）。

## 4. 自检与报告机制

每次 API 调用均执行：

1. 写日志：`logs/web_api_execution_{timestamp}.log`
2. 写报告：`reports/web_phaseC_api_report_{timestamp}.json`
3. 自动校验：
   - `status` 必须为 `SUCCESS`
   - Phase4 后验证 `phase4ExportLua` 文件存在
   - Phase5 后验证 `phase5OutputDir` 目录存在且包含 `.lua` 文件

## 5. 约束落实

- 未修改数据库结构
- 未修改 `unluac.chunk / parse / decompile` 核心
- 未改动既有 Phase 主类逻辑
- 未改动既有 JSON 报告格式
- 本次仅新增 Spring Boot 启动、Controller 及 API 支持文件

