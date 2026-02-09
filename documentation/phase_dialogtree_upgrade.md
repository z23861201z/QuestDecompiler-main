# Phase DialogTree Upgrade

## 1. 新语义结构

本次升级新增以下数据结构，已落地到 `src/unluac/semantic`：

```java
class DialogNode {
  String text;
  List<DialogOption> options;
  List<DialogNode> next;
}

class DialogOption {
  String optionText;
  int nextNodeIndex;
}

class QuestDialogTree {
  List<DialogNode> nodes;
}
```

`QuestSemanticModel` 已扩展：

```java
class QuestSemanticModel {
  ...
  QuestDialogTree dialogTree;
}
```

对应代码文件：

- `src/unluac/semantic/DialogNode.java`
- `src/unluac/semantic/DialogOption.java`
- `src/unluac/semantic/QuestDialogTree.java`
- `src/unluac/semantic/QuestSemanticModel.java`

---

## 2. AST → DialogTree 构建算法（已实现）

实现入口：`src/unluac/semantic/QuestDialogTreeExtractor.java`

### 2.1 指令级数据流追踪

提取器逐函数遍历 `LuaChunk.Function.code[]`，对以下 opcode 做运行时寄存器模拟：

- `LOADK / MOVE / GETGLOBAL / GETTABLE / SELF`
- `NEWTABLE50 / SETTABLE / SETLIST50 / SETLISTO`
- `CALL / RETURN / TEST50 / TESTSET`
- `EQ / LT / LE / TEST / TESTSET / TEST50 + 后续 JMP`

寄存器值类型：

- `STRING`
- `NUMBER`
- `GLOBAL`
- `TABLE`
- `UNKNOWN`

`TABLE` 类型支持字段和数组写入，允许从参数里反向提取 `questId`（优先 `table.fields["id"]`）。

### 2.2 基本块和分支图构建

提取器基于 `pc` 构建 CFG：

1. 识别条件跳转头：`{EQ,LT,LE,TEST,TESTSET,TEST50}` 后接 `JMP`
2. 建立 `ConditionalEdge`：
   - `fallthroughPc = condPc + 2`
   - `targetPc = condPc + 2 + jmp.sBx`
3. 以 leader 切分 `BasicBlock`
4. 计算每个 block 的 `successorBlockIds`

### 2.3 语义事件识别规则

调用事件由 `CALL` 指令解析得到：

- `callName`: 由被调寄存器解析（支持 `global.func`）
- `callBaseName`: 取最后段并转大写
- `args`: 参数寄存器值列表
- `questIds`: 从参数中提取（数字参数 + table.id）

函数语义分类：

- **NPC说话节点**：
  - `NPC_SAY`
  - `NPCSAY`
  - `SAY`
  - `DIALOG_SAY`
  - `CHAT_SAY`
- **选项节点**：
  - `ANSWER_YES`
  - `ANSWER_NO`
  - `ANSWER*`
  - `*OPTION*`
- **状态终止点**：
  - `SET_QUEST_STATE`
  - `SETQUESTSTATE`
  - 同时包含 `QUEST_STATE` 和 `SET`

### 2.4 树构建规则

对每个 questId 单独遍历 CFG：

1. 从入口 block 开始 DFS。
2. block 内按顺序处理动作：
   - 命中说话调用：创建/推进 `DialogNode.text`
   - 命中选项调用：追加 `DialogOption`
   - 命中 `SET_QUEST_STATE` 或 `RETURN`：分支终止
3. `successor` 处理：
   - 单后继：连线到线性 next 节点
   - 双后继及以上：建立分叉 next 节点；若已有 option，优先把 option 绑定到分叉目标
4. 构建完成后对 node 做 DFS 重排，输出稳定 `nodes[]` 和 `option.nextNodeIndex`。

该流程不使用常量索引硬编码，不使用全局字符串扫描，直接依据：

- 调用顺序
- 条件跳转
- return/状态设置终止点
- 参数传递中的 questId 绑定

---

## 3. Java 完整实现类

### 3.1 语义模型类

- `src/unluac/semantic/DialogNode.java`
- `src/unluac/semantic/DialogOption.java`
- `src/unluac/semantic/QuestDialogTree.java`
- `src/unluac/semantic/QuestSemanticModel.java`

### 3.2 核心提取器

- `src/unluac/semantic/QuestDialogTreeExtractor.java`
  - `extractTrees(...)`
  - `analyzeFunctionFlow(...)`
  - `buildBasicBlocks(...)`
  - `traverseFlow(...)`

### 3.3 现有语义提取主链集成

- `src/unluac/semantic/QuestSemanticExtractor.java`
  - `extract(...)` 中调用 `QuestDialogTreeExtractor`
  - 将结果写回每个 `QuestSemanticModel.dialogTree`

### 3.4 JSON 输出集成

- `src/unluac/semantic/QuestSemanticJson.java`
  - 新增 `appendDialogTree(...)`
  - `toJson(...)` 输出 `dialogTree`
- `src/unluac/semantic/QuestSemanticExtractTool.java`
  - 改为直接调用 `QuestSemanticJson.toJson(...)`

---

## 4. GUI 升级（Swing JTree，已实现）

实现文件：`src/unluac/editor/QuestEditorFrame.java`

### 4.1 布局结构

- 左侧：任务列表 `JTable`
- 右侧上半：标题/描述/奖励字段
- 右侧下半：对话树编辑区
  - `JTree` 显示节点、选项、连接
  - 节点文本编辑框
  - 选项文本 + nextNodeIndex 编辑框

### 4.2 交互功能

已支持：

1. **添加节点**（`add_node`）
2. **添加选项**（`add_option`）
3. **删除分支**（`delete_branch`）
   - 删除 option
   - 删除 node（含重排 `nextNodeIndex`）
   - 删除 link
4. **修改选中节点/选项**（`apply_node_edit`）

### 4.3 数据绑定

- `QuestEditorModel` 新增 `dialogTree`
- `QuestEditorService.loadFromLuc(...)` 直接走语义提取，不再用临时 CSV 中转
- 任务切换时同步刷新 JTree

---

## 5. 示例 JSON

示例结构（节选）：

```json
{
  "questId": 1001,
  "title": "示例任务",
  "description": "初始描述",
  "dialogTree": {
    "nodes": [
      {
        "index": 0,
        "text": "欢迎来到任务流程。",
        "options": [
          {"optionText": "接受", "nextNodeIndex": 1},
          {"optionText": "拒绝", "nextNodeIndex": 2}
        ]
      },
      {
        "index": 1,
        "text": "很好，去收集物品。",
        "options": []
      },
      {
        "index": 2,
        "text": "那你再考虑一下。",
        "options": []
      }
    ]
  }
}
```

---

## 6. 变更清单

- 新增：
  - `src/unluac/semantic/DialogNode.java`
  - `src/unluac/semantic/DialogOption.java`
  - `src/unluac/semantic/QuestDialogTree.java`
  - `src/unluac/semantic/QuestDialogTreeExtractor.java`
- 修改：
  - `src/unluac/semantic/QuestSemanticModel.java`
  - `src/unluac/semantic/QuestSemanticExtractor.java`
  - `src/unluac/semantic/QuestSemanticJson.java`
  - `src/unluac/semantic/QuestSemanticExtractTool.java`
  - `src/unluac/semantic/QuestSemanticCsvTool.java`
  - `src/unluac/editor/QuestEditorModel.java`
  - `src/unluac/editor/QuestEditorService.java`
  - `src/unluac/editor/QuestEditorFrame.java`

