# QuestDecompiler-main

Quest/NPC 数据链路工具（CLI + Web 管理后台）。

当前已支持：

- Phase-C：REST API 控制层
- Phase-D：前端管理界面（Quest/NPC 编辑 + 一键导出）

## 1. 环境要求

建议环境（当前仓库已验证）：

- JDK：`1.8`（推荐 `JDK 8`）
- Maven：`3.9+`
- Node.js：`18+`（当前验证为 `v20.19.5`）
- npm：`8+`（当前验证为 `10.8.2`）
- MySQL：`8.x`（库名 `ghost_game`）

> 说明：项目编译目标为 Java 8（`pom.xml` 中 `source/target=1.8`）。

## 2. 关键配置位置

### 后端端口

- `src/application.properties`
  - `server.port=8080`

### 前端代理到后端

- `frontend/vite.config.js`
  - 代理 `/api` -> `http://127.0.0.1:8080`

### 数据库连接默认值（当前实现）

- `src/unluac/web/controller/WebPhaseController.java`
- `src/unluac/web/controller/AdminController.java`

默认 JDBC：

- `jdbc:mysql://127.0.0.1:3306/ghost_game?useUnicode=true&characterEncoding=utf8&serverTimezone=UTC&useSSL=false&allowPublicKeyRetrieval=true`
- 用户名：`root`
- 密码：`root`

如果你的数据库账号不同，请修改上述控制器中的默认值。

## 3. 启动后端（Spring Boot）

推荐使用打包后的可执行 JAR 启动（更接近生产）：

```bash
mvn -DskipTests package
java -jar target/questdecompiler-web-1.0.0-SNAPSHOT.jar
```

可选指定端口：

```bash
java -jar target/questdecompiler-web-1.0.0-SNAPSHOT.jar --server.port=18080
```

开发调试也可用 Maven 启动：

```bash
mvn spring-boot:run
```

在仓库根目录执行（开发模式）：

```bash
mvn -DskipTests compile
mvn spring-boot:run
```

启动后默认地址：

- `http://127.0.0.1:8080`

## 4. 启动前端（Vue3）

在仓库根目录执行：

```bash
cd frontend
npm install
npm run dev
```

启动后默认地址：

- `http://127.0.0.1:5173`

## 5. 常用接口（Phase-D）

管理后台接口：

- `GET /api/admin/dashboard`
- `GET /api/admin/quests`
- `GET /api/admin/quests/{questId}`
- `POST /api/admin/quests/{questId}/save`
- `GET /api/admin/npc-texts`
- `POST /api/admin/npc-texts/{textId}/save`
- `POST /api/admin/export/run`

Phase-C 执行接口：

- `POST /api/phase2/run`
- `POST /api/phase3/run`
- `POST /api/phase4/exportQuest`
- `POST /api/phase5/exportNpc`
- `POST /api/pipeline/full`

## 6. 产物与日志位置

### API 调用日志

- `logs/web_api_execution_{timestamp}.log`

### Phase-C API 报告

- `reports/web_phaseC_api_report_{timestamp}.json`

### Phase-D 导出报告

- `reports/web_phaseD_export_report_{timestamp}.json`

### 导出文件

- Quest 导出：`reports/phase4_exported_quest.lua`
- NPC 导出目录：`reports/phase5_exported_npc/`

## 7. 旧 CLI 启动方式（保留）

```bash
java -cp build unluac.editor.QuestEditorMain
```
