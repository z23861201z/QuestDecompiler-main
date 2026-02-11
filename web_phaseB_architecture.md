# Web Phase-B：服务封装层架构说明

## 1. 包结构设计

本次改造只新增 `src/unluac/web/`，不改动任何核心解析与原有 Phase 主类。

- `src/unluac/web/request`
  - 各 Phase 的请求对象（替代 `main(String[] args)` 参数）
  - 统一继承 `BasePhaseRequest`，支持 `workingDirectory`

- `src/unluac/web/result`
  - 统一返回结构：`PhaseResult<T>`
  - 状态枚举：`PhaseStatus`
  - 错误对象：`PhaseError`

- `src/unluac/web/support`
  - 路径解析与默认目录处理：`PhasePathUtil`
  - 异常转统一错误：`PhaseExceptionUtil`
  - 产物自检（JSON 存在/非空/finalStatus=SAFE）：`PhaseSelfCheckUtil`
  - 执行报告写出：`ExecutionReportWriter`

- `src/unluac/web/service`
  - 每个 Phase 对应一个 Web 可调用 Service
  - `XxxService.execute(XxxRequest)` 内部仅调用现有 Phase 的 `run/build/write/export/validate/main`
  - `WebPhaseBExecutionRunner` 用于 Phase-B 自检执行与报告落盘

## 2. 统一返回结构：`PhaseResult<T>`

字段如下（满足约束要求）：

- `phaseName`
- `status`
- `startedAt`
- `finishedAt`
- `elapsedMs`
- `workingDirectory`
- `artifacts`（JSON/文件产物路径）
- `error`

此外保留：

- `payload`（原 Phase 返回对象，可选）

## 3. Service 与原 Phase 的映射

- `Phase2Service` -> `Phase2LucDataExtractionSystem.run(...)`
- `Phase25Service` -> `Phase25QuestNpcDependencyMapper.build(...)`
- `Phase3WriteService` / `Phase3Service` -> `Phase3DatabaseWriter.write(...)`
- `Phase3ConsistencyService` -> `Phase3DbConsistencyValidator.validate(...)`
- `Phase4ExportService` / `Phase4Service` -> `Phase4QuestLucExporter.export(...)`
- `Phase4ValidateService` -> `Phase4QuestExportValidator.validate(...)`
- `Phase5ExportService` -> `Phase5NpcLucExporter.export(...)`
- `Phase5ValidateService` -> `Phase5NpcExportValidator.validate(...)`
- `Phase6MutationImpactService` -> `Phase6DbMutationAndImpactValidator.run(...)`
- `Phase6BService` -> `Phase6BForcedHighReferenceMutationValidator.run(...)`
- `Phase6CService` -> `Phase6CDbDrivenExportValidator.run(...)`
- `Phase7AService` -> `Phase7ANpcTextExtractionSystem.scanAndStore(...)`
- `Phase7BService` -> `Phase7BNpcTextModelBuilder.build(...)`
- `Phase7CService` -> `Phase7CNpcTextExporter.export(...)`
- `Phase7DService` -> `Phase7DTextImpactValidator.validate(...)`
- `Phase7NpcLucBinaryService` -> `Phase7NpcLucBinaryExporter.main(args)`

## 4. 自检机制

每个 Service 在执行后都进行产物自检：

1. JSON 文件必须存在
2. JSON 文件大小必须大于 0
3. 若 JSON 包含 `finalStatus` 字段，必须为 `SAFE`
4. 失败时统一捕获异常并封装为 `PhaseError`

## 5. 执行报告输出

通过 `ExecutionReportWriter` 自动生成：

- `reports/web_phaseB_execution_report_{timestamp}.json`

报告内容包含：

- 执行阶段
- 产物路径
- 成功/失败状态
- 异常信息
- 时间线（startedAt/finishedAt/elapsedMs）

## 6. Phase2Facade 示例（等价 Service 用法）

以下是 Web 层调用示例：

```java
Phase2Service service = new Phase2Service();
Phase2Request req = new Phase2Request();
req.workingDirectory = Paths.get(".");
req.questLuc = Paths.get("new.luc");
req.npcDir = Paths.get("npc-lua-autofixed");

PhaseResult<Phase2LucDataExtractionSystem.Phase2Result> result = service.execute(req);
if(result.status != PhaseStatus.SUCCESS) {
  throw new RuntimeException(result.error == null ? "Phase2 failed" : result.error.message);
}
```

说明：

- 该调用方式已将 CLI 参数改造成可注入 Request
- 可由控制器/调度器直接调用
- 不触碰原有 Phase2 主逻辑

