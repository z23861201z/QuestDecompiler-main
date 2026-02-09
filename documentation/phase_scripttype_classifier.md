# Phase ScriptType Classifier

## 1) 自动识别 luc 类型

新增文件：`src/unluac/semantic/ScriptTypeDetector.java`

识别规则：

- `NPC_SCRIPT`
  - 同时命中全局函数 `npcsay` 与 `chkQState`
- `QUEST_DEFINITION`
  - 命中 `qt[xxxx] = { ... }` 赋值模式（字节码层为 `SETTABLE` 写入全局表 `qt`，key 为数值，value 为 table）
- 否则 `UNKNOWN`

输出结构：

- `ScriptTypeDetector.DetectionResult`
  - `scriptType`
  - `hasNpcSayFunction`
  - `hasChkQStateFunction`
  - `hasQtAssignment`
  - `globalFunctionNames`

---

## 2) NPC_SCRIPT 语义模型

新增文件：

- `src/unluac/semantic/NpcScriptModel.java`
- `src/unluac/semantic/NpcSemanticExtractor.java`

模型：

```java
class NpcScriptModel {
  int npcId;
  List<DialogBranch> branches;
  List<Integer> relatedQuestIds;
}
```

提取范围（字节码 CALL 语义）：

- `NPC_SAY`
- `ADD_QUEST_BTN`
- `SET_QUEST_STATE`
- `CHECK_ITEM_CNT`

每条 `DialogBranch` 包含：

- `functionPath`
- `pc`
- `action`
- `text`
- `questId`
- `stateValue`
- `itemId`
- `itemCount`

补充：

- `npcId` 通过调用 `setNPCNo(...)` 的参数提取。
- `relatedQuestIds` 来自分支参数聚合去重。

---

## 3) GUI 分支加载实现

修改文件：`src/unluac/editor/QuestEditorFrame.java`

实现点：

- 主区域改为 `CardLayout`
  - `VIEW_QUEST`：原任务编辑器
  - `VIEW_NPC`：NPC 脚本语义面板
- 打开/重载 luc 时先调用：
  - `service.detectScriptType(path)`
- 若为 `NPC_SCRIPT`：
  - 调用 `service.loadNpcScript(path)`
  - 切换到 NPC 面板显示摘要与分支列表
- 若为 `QUEST_DEFINITION`：
  - 走原任务列表与编辑逻辑

NPC 面板字段：

- 摘要区：脚本类型、npcId、relatedQuestIds、函数命中信息
- 分支区：按序输出 `NPC_SAY / ADD_QUEST_BTN / SET_QUEST_STATE / CHECK_ITEM_CNT`

说明：

- 本阶段 `NPC_SCRIPT` 仅支持解析与展示，不接入保存回写。

