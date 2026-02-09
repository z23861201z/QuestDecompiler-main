# QuestSemanticModel -> AST 常量修改映射器设计与实现

## 1. 实现目标

当前实现提供一条可落地链路：

1. `quest.luc` 解析为 AST
2. `QuestSemanticExtractor` 产出语义模型 + 字段绑定信息
3. `QuestSemanticCsvTool` 导出/导入语义 CSV
4. `QuestSemanticPatchApplier` 将 CSV 编辑结果映射到 AST 常量并写回 `luc`

并满足约束：

- 不修改 instruction
- 不修改 prototype 结构
- 只修改 constant 区

---

## 2. 字段 -> constant_index 映射构建算法

实现位置：
- `src/unluac/semantic/QuestSemanticExtractor.java`
- `src/unluac/semantic/QuestSemanticPatchApplier.java`

### 2.1 提取阶段记录绑定

`QuestSemanticExtractor` 在构建 `QuestSemanticModel` 时，把每个语义字段对应的常量来源记录为 `FieldBinding`：

- `questId`
- `fieldKey`（如 `title` / `description` / `reward_exp`）
- `sourceFunctionPath`
- `constantIndex`
- `sourcePc`
- 值类型与原值（string/number）

关键逻辑：

1. `title`
   - 来源：`table.fields["name"]`
   - 记录其 `constantIndex`

2. `description`
   - 来源：`table.fields["contents"]` 的数组第1项
   - 记录该字符串常量 `constantIndex`

3. `pre_quest_ids`
   - 来源：`needQuest` 数值常量
   - 记录 `constantIndex`

4. `condition_json.needLevel`
   - 来源：`needLevel` 数值常量
   - 记录 `constantIndex`

5. `reward_exp / reward_item_id / reward_item_count`
   - 深度遍历 `reward` 子树，定位 `exp/itemid/count/itemcnt`
   - 记录对应 `constantIndex`

### 2.2 应用阶段构建可补丁映射

`QuestSemanticPatchApplier.buildFieldConstantBindings(...)`：

1. 遍历 `ExtractionResult.fieldBindings`
2. 用 `sourceFunctionPath` 找到 AST function
3. 用 `constantIndex` 定位 function.constants[index]
4. 构建 `PatchBinding`（携带 constant 引用）

输出结果是“字段到具体常量槽位”的直接映射，可直接用于写补丁。

---

## 3. 如何从 AST 中定位 constant

定位键为二元组：

- `function_path`
- `constant_index`

定位步骤：

1. `findFunction(root, function_path)` 递归匹配 `LuaChunk.Function.path`
2. `function.constants.get(constant_index)` 取得 `LuaChunk.Constant`
3. 根据常量类型写入：
   - string: `constant.stringValue.dataOffset`
   - number: `constant.valueOffset`

这是字节级精确定位，不依赖猜测。

---

## 4. 长度不超限验证

字符串采用“固定槽位补丁”，限制规则：

1. 目标槽位最大可写字节：
   - `maxBytes = constant.stringValue.lengthField - 1`
   - 预留末尾 `0x00`

2. 新文本字节长度：
   - `newBytes = replacement.getBytes(charset).length`

3. 校验：
   - `newBytes <= maxBytes` 才允许写入
   - 否则 `reject_overflow` 并报错终止

实现位置：
- `QuestSemanticPatchApplier.maxWritableStringBytes(...)`
- `QuestSemanticPatchApplier.decidePatchAction(...)`
- `QuestSemanticPatchApplier.applyActionInConstantArea(...)`

---

## 5. 字符串变长处理策略

当前实现策略是“**不改变结构**”优先：

1. 允许变短
   - 清空原内容区（0填充）
   - 写入新内容
   - 保持原 `lengthField` 不变

2. 允许等长
   - 原地覆盖

3. 禁止变长扩容（超上限）
   - 因为扩容会导致：
     - 常量区位移
     - 后续字节偏移变化
     - instruction/prototype/debug 潜在级联变化
   - 与“只能改 constant 区 + 不改结构”冲突

所以超限时直接拒绝，提示最大字节数。

---

## 6. 类结构（可直接实现/已实现）

## 6.1 `QuestSemanticExtractor.java`

文件：`src/unluac/semantic/QuestSemanticExtractor.java`

新增/关键结构：

- `ExtractionResult`
  - `List<QuestSemanticModel> quests`
  - `List<RuleHit> ruleHits`
  - `List<FieldBinding> fieldBindings`

- `FieldBinding`
  - `questId`
  - `fieldKey`
  - `ownerFunctionPath`
  - `constantIndex`
  - `sourcePc`
  - `sourceFunctionPath`
  - `valueType`（string/number）
  - `stringValue / numberValue`

关键点：
- 在语义提取过程中同步写入字段绑定，不额外二次分析。

## 6.2 `QuestSemanticCsvTool.java`

文件：`src/unluac/semantic/QuestSemanticCsvTool.java`

CLI：

- 导出：
  - `java -cp build unluac.semantic.QuestSemanticCsvTool export <input.luc> <output.csv>`
- 导入：
  - `java -cp build unluac.semantic.QuestSemanticCsvTool import <input.csv> <output.json>`

结构：

- `CSV_HEADER`
- `CsvQuestRow`
  - 与你指定列完全对应：
    - `quest_id`
    - `title`
    - `description`
    - `pre_quest_ids`
    - `reward_exp`
    - `reward_item_id`
    - `reward_item_count`
    - `dialog_lines_json`
    - `condition_json`

说明：
- 该工具只负责语义 CSV 的导入导出和校验。

## 6.3 `QuestSemanticPatchApplier.java`

文件：`src/unluac/semantic/QuestSemanticPatchApplier.java`

CLI：

- `java -cp build unluac.semantic.QuestSemanticPatchApplier <input.luc> <edited.csv> <output.luc> <mapping.csv>`

关键结构：

- `PatchBinding`
  - 字段与常量槽位绑定
- `PatchAction`
  - 具体补丁动作
  - 包含 `maxBytes/newBytes/lengthOk/action`
- `PatchValueType`
  - `STRING` / `NUMBER`

关键流程：

1. 解析 luc -> AST
2. 提取语义 + `FieldBinding`
3. 读取 CSV
4. 构建 `PatchBinding` 列表
5. 生成 `PatchAction`
6. 仅对常量区写补丁
7. 验证 instruction/prototype 不变
8. 输出映射报告 `mapping.csv`

---

## 7. 只改 constant 区的校验

应用后执行双重校验：

1. `verifyNoInstructionOrPrototypeChanges(before, after)`
   - 校验每个函数：
     - `code.size` 不变
     - 每条 instruction value 不变
     - `prototypes.size` 不变

2. `Lua50StructureValidator`
   - 校验整体结构一致

---

## 8. 支持文件

新增 JSON 辅助：
- `src/unluac/semantic/QuestSemanticJson.java`

用途：
- 语义模型 JSON 序列化
- CSV JSON 列解析（轻量 parser）

---

## 9. 运行示例

1. 导出 CSV

```bash
java -cp build unluac.semantic.QuestSemanticCsvTool export D:\TitanGames\GhostOnline\zChina\Script\quest.luc out\quest_semantic_editor.csv
```

2. 编辑 CSV 后应用补丁

```bash
java -cp build unluac.semantic.QuestSemanticPatchApplier D:\TitanGames\GhostOnline\zChina\Script\quest.luc out\quest_semantic_editor_small.csv out\quest_semantic_patched.luc out\quest_semantic_mapping.csv
```

3. 结果

- 输出 patched 文件
- 输出映射报告：
  - `quest_id,field_key,function_path,constant_index,...,length_ok,action`

