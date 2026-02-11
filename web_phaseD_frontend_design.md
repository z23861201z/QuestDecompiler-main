# Web Phase-D：前端管理界面 + 流程编排设计

## 1. 目标与边界

本阶段实现最小可用管理后台，覆盖：

1. Quest 列表查看
2. Quest 文本编辑
3. NPC 文本编辑
4. 保存到 DB
5. 一键导出 luc

严格遵守：

- 前端仅通过 REST API 访问数据
- 不直接访问数据库
- 不直接操作文件
- 不改核心 Phase 逻辑

## 2. 架构

### 后端（Spring Boot）

- 保留 Phase-C 控制层（`/api/phase*`）
- 新增管理控制层：`/api/admin/*`
- 新增编排服务：`PhaseDOrchestrationService`
  - 调用现有 `Phase4Service`、`Phase5ExportService`
  - 生成 Phase-D 导出报告

### 前端（Vue3 + Vite）

- 单页管理后台（最小实现）
- 通过 `frontend/src/api.js` 调用 `/api/admin/*`
- 页面模块：Dashboard / Quest 管理 / NPC 文本管理 / 导出中心

## 3. API 设计（Phase-D 新增）

### Dashboard

- `GET /api/admin/dashboard`
  - 返回：quest 数量、npc 数量、最近导出报告、时间线

### Quest 管理

- `GET /api/admin/quests?keyword=&limit=`
- `GET /api/admin/quests/{questId}`
- `POST /api/admin/quests/{questId}/save`
  - 请求体：
    - `name`
    - `contents[]`
    - `answer[]`
    - `info[]`

### NPC 文本管理

- `GET /api/admin/npc-texts?questId=&npcFile=&keyword=&limit=`
- `POST /api/admin/npc-texts/{textId}/save`
  - 请求体：
    - `modifiedText`

说明：只更新 `npc_text_edit_map.modifiedText`，不改 `rawText`、`stringLiteral`。

### 导出中心

- `POST /api/admin/export/run`
  - 执行：Quest/NPC 导出编排
  - 返回：`PhaseDExportReport`

## 4. 自检机制

每次导出运行会生成：

- `reports/web_phaseD_export_report_{timestamp}.json`

报告字段：

- `finalStatus`
- `elapsedMs`
- `questExportFileCount`
- `npcExportFileCount`
- `dbChanged`
- `exportTimestampChanged`
- `artifacts`

校验规则：

1. DB 数据是否变化（本次通过一次 NPC 文本修改后验证）
2. 导出文件时间戳是否变化（Quest 导出 + NPC 导出目录）
3. 最终状态 `SAFE` 才视为通过

## 5. 前端结构

- `frontend/src/App.vue`
  - Dashboard 区域
  - Quest 列表与详情编辑
  - NPC 文本表格与单行保存
  - 导出中心与报告展示
- `frontend/src/api.js`
  - 封装所有 `/api/admin/*` 调用
- `frontend/src/style.css`
  - 最小样式

## 6. 验证流程（已落地）

1. 读取 Quest 列表与详情
2. 修改 Quest 文本并保存
3. 修改 NPC 文本并保存
4. 点击导出（调用 `/api/admin/export/run`）
5. 检查：
   - DB 数据变化
   - 导出文件时间戳变化
   - 导出报告 `finalStatus=SAFE`

## 7. 关键文件

- 后端控制层：`src/unluac/web/controller/AdminController.java`
- 后端服务层：
  - `src/unluac/web/service/AdminQuestService.java`
  - `src/unluac/web/service/AdminNpcTextService.java`
  - `src/unluac/web/service/PhaseDOrchestrationService.java`
- 报告模型：`src/unluac/web/result/PhaseDExportReport.java`
- 前端入口：`frontend/src/App.vue`

