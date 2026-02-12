# QuestSemanticExtractor 设计文档（LuaChunk AST -> QuestSemanticModel）

## 1. 目标与边界

本设计实现一个新的语义层：`QuestSemanticExtractor`。

输入：
- `LuaChunk` AST（来自 `Lua50ChunkParser`）

输出：
- `List<QuestSemanticModel>`
- 规则命中追踪（`RuleHit`）

本设计满足以下约束：
- 不通过 `constant_index` 硬编码识别字段。
- 通过以下信息做字段识别：
  - 函数路径（`function.path`）
  - 常量在函数中的使用位置（`pc` + `offset`）
  - 指令引用关系（寄存器流 + RK 解析）
  - 表构造结构（`NEWTABLE50` + `SETTABLE` + `SETLIST50/SETLISTO`）
  - 参数传递关系（`CALL` 采集）

对应代码：
- `src/unluac/semantic/QuestSemanticExtractor.java`
- `src/unluac/semantic/QuestSemanticExtractTool.java`

---

## 2. 中间模型

### 2.1 业务模型

`src/unluac/semantic/QuestSemanticModel.java`:

```java
class QuestSemanticModel {
  int questId;
  String title;
  String description;
  List<Integer> preQuestIds;
  List<Reward> rewards;
  List<String> dialogLines;
  Map<String, Object> conditions;
  Map<String, Object> completionConditions;
}
```

### 2.2 提取器内部模型

`QuestSemanticExtractor` 内部使用：
- `FunctionFrame`: 函数级寄存器快照 + 指令解码器。
- `Value`: 运行态值（`NIL/BOOLEAN/NUMBER/STRING/TABLE/GLOBAL/CLOSURE/UNKNOWN`）。
- `TableState`: 表构造状态（`fields` + `array`），带创建位置信息。
- `CallEvent`: 调用事件（函数路径、PC、偏移、callee、args）。
- `RuleHit`: 规则命中证据（规则ID + 函数路径 + PC + 偏移 + 详情）。

---

## 3. 指令层语义恢复

### 3.1 解码基础

使用：
- `Lua50InstructionCodec`（内部用 `Code50 + OpcodeMap(0x50)`）

每条指令解码后拿到：
- `op, A, B, C, Bx, sBx`

### 3.2 RK 常量判定（Lua 5.0）

关键规则：
- Lua 5.0 的 RK 常量基准为 `250`。
- `raw >= 250` 时为常量：`constantIndex = raw - 250`。
- 否则为寄存器索引。

实现位置：
- `QuestSemanticExtractor.FunctionFrame` 中 `rkBase = 250`（`header.version == 0x50`）
- `resolveRK(...)`

### 3.3 寄存器和表恢复规则

按指令驱动状态机：

1) `LOADK A Bx`
- `R[A] = 常量[Bx]`
- 记录常量来源位置（`function.path`, `pc`, `constantIndex`）

2) `MOVE A B`
- `R[A] = R[B]`

3) `GETGLOBAL A Bx`
- 常量字符串作为全局名
- `R[A] = Global(name)` 或已知 `globalValues[name]`

4) `SETGLOBAL A Bx`
- `globalValues[name] = R[A]`

5) `NEWTABLE50 A ...`
- 创建 `TableState`
- `R[A] = TableRef`
- 写入规则命中 `R-TABLE-NEW`

6) `SETTABLE A B C`
- `table = R[A]`
- `key = RK(B)`
- `value = RK(C)`
- 若 key 为字符串：写入 `table.fields[key] = value`
- 若 key 为数字整数：写入 `table.array[index] = value`
- 写入规则命中 `R-FIELD-WRITE`

7) `SETLIST50/SETLISTO A ...`
- 还原数组批量写入，生成顺序索引项
- 写入规则命中 `R-ARRAY-WRITE`

8) `GETTABLE A B C`
- `R[A] = table[RK(C)]`（若可解析）
- 记录 relation：`GETTABLE(tableId,key)`

9) `CALL A B C`
- 采集调用边 `CallEvent`
- 记录 callee 与参数值流
- 写入规则命中 `R-CALL-EDGE`

10) `CLOSURE A Bx`
- `R[A] = Closure(path)`

---

## 4. 字段识别规则（无 constant_index 硬编码）

以下规则使用“表结构 + 指令位置 + 值流关系”识别字段。

### 4.1 Quest 表判定

规则：
- 表必须有 `id` 数字字段。
- 同时命中至少一个 quest 语义键：
  - `name/contents/answer/info/npcsay/needLevel/needQuest/goal/reward/requstItem`

命中后建立/合并 `QuestSemanticModel`（按 `questId` 聚合）。

规则ID：`R-QUEST-ID`

### 4.2 questId

来源：
- `table.fields["id"]` 的数值

约束：
- `id > 0`

### 4.3 标题（title）

来源：
- `table.fields["name"]` 字符串

规则ID：`R-TITLE`

### 4.4 描述（description）

来源：
- `table.fields["contents"]` 的首个字符串叶子

规则ID：`R-DESCRIPTION`

### 4.5 前置任务（preQuestIds）

来源：
- `table.fields["needQuest"]`
- 递归提取所有整数叶子，去重后写入 `preQuestIds`

规则ID：`R-PREQUEST`

### 4.6 奖励（rewards）

来源1：
- `table.fields["reward"]` 子树递归扫描

来源2：
- 当前 `table` 本身直接包含奖励键（`money/exp/fame/itemid/itemcnt/count/id`）

映射规则：
- `itemid + count/itemcnt` -> `type=item`
- `money` -> `money`
- `exp` -> `exp`
- 其余字段落入 `attrs`

规则ID：`R-REWARD`

### 4.7 对话文本（dialogLines）

来源：
- `contents/answer/info/npcsay` 四个字段的字符串叶子
- 去空串、去重

规则ID：`R-DIALOG`

### 4.8 条件字段（conditions）

来源：
- `needLevel`
- `needQuest`
- `requstItem`
- 语义调用参数（见 4.10）

规则ID：`R-CONDITION`、`R-CALL-CONDITION`

### 4.9 完成条件（completionConditions）

来源：
- `goal`

规则ID：`R-COMPLETION`

### 4.10 参数传递关系（CALL）

调用识别：
- callee 全局名包含 `quest/npc/dialog`
- 或参数中包含可识别 `questId` 的表

记录方式：
- `conditions["call:<name>@<function_path>:<pc>"] = [args...]`

规则ID：`R-CALL-CONDITION`

---

## 5. AST 节点定位方式（证据链）

每条语义可回溯到三层定位：

1) 函数路径
- 由解析器生成（如 `root`, `root/0`, `root/1/2`）

2) 指令位置
- `pc`（函数内指令索引）
- `offset`（chunk 字节偏移）

3) 值来源
- `Value.sourcePc`
- 常量来源 `constantIndex`（仅做来源标记，不用于硬编码字段识别）

导出证据文件：
- `out/quest_semantic_rule_hits.csv`
- 列：`rule_id,function_path,pc,offset,detail`

---

## 6. JSON 输出示例

由 `QuestSemanticExtractTool` 生成（`out/quest_semantic.json`）：

```json
[
  {
    "questId": 2,
    "title": "[ ????? ?? ]",
    "description": "?? ??? ????? ??? ?? ??? ????. ???? ???? ??? ?? ???? ?????.",
    "preQuestIds": [],
    "rewards": [
      {
        "type": "currency",
        "id": 0,
        "count": 0,
        "money": 200,
        "exp": 0,
        "attrs": {}
      }
    ],
    "dialogLines": [
      "?? ??? ????? ??? ?? ??? ????. ???? ???? ??? ?? ???? ?????.",
      "???? ??? ????."
    ],
    "conditions": {
      "needLevel": 2
    },
    "completionConditions": {
      "goal": {
        "getItem": [
          {
            "id": 8910031,
            "count": 3
          }
        ]
      }
    }
  }
]
```

---

## 7. CLI 使用

命令：

```bash
java -cp build unluac.semantic.QuestSemanticExtractTool <input.luc> <output.json> [rule_hits.csv]
```

示例：

```bash
java -cp build unluac.semantic.QuestSemanticExtractTool D:\TitanGames\GhostOnline\zChina\Script\quest.luc out\quest_semantic.json out\quest_semantic_rule_hits.csv
```

---

## 8. 规则命中清单

固定规则ID：
- `R-TABLE-NEW`
- `R-FIELD-WRITE`
- `R-ARRAY-WRITE`
- `R-CALL-EDGE`
- `R-QUEST-ID`
- `R-TITLE`
- `R-DESCRIPTION`
- `R-PREQUEST`
- `R-REWARD`
- `R-DIALOG`
- `R-CONDITION`
- `R-COMPLETION`
- `R-CALL-CONDITION`

---

## 9. 自检结论

已完成：
- 基于指令关系恢复表结构与参数关系。
- 输出 `QuestSemanticModel` 与规则证据。
- 可复现生成 JSON 与命中 CSV。

验证结果（quest 样本）：
- `quest_count=2604`
- `rule_hit_count=292488`

生成文件：
- `out/quest_semantic.json`
- `out/quest_semantic_rule_hits.csv`

---

## 10. 2026-02-12 字段补全更新（Extractor）

本次补全仅扩展语义识别覆盖面，不改变既有提取主流程。

- 新增 Quest 条件字段识别：
  - `needItem`
  - `deleteItem`
- 更新点：
  - 关键词集合补充：`QUEST_KEYS`、`CONDITION_KEYS`
  - 建模写入补充：`model.conditions`
- 影响范围：
  - Phase2 输出 `conditions` 可完整保留 `needQuest/requstItem/needItem/deleteItem`
  - Phase3 入库与 Phase4 导出可恢复上述条件结构
- 关联变更总记录：
  - `documentation/phase2_4_field_completion_change_log.md`
