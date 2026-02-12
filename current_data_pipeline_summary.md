# Current Data Pipeline Summary (Code-Derived)

## Scope
- Source analyzed: `src/**/*.java`
- Build descriptors found: `none`
- DB connection code exists in: unluac.semantic.Phase3DatabaseWriter, unluac.semantic.Phase3DbConsistencyValidator, unluac.semantic.Phase4QuestLucExporter, unluac.semantic.Phase5NpcLucExporter, unluac.semantic.Phase6BForcedHighReferenceMutationValidator, unluac.semantic.Phase6CDbDrivenExportValidator, unluac.semantic.Phase6DbMutationAndImpactValidator, unluac.semantic.Phase7ANpcTextExtractionSystem, unluac.semantic.Phase7BNpcTextModelBuilder, unluac.semantic.Phase7CNpcTextExporter, unluac.semantic.Phase7DTextImpactValidator, unluac.semantic.Phase7NpcLucBinaryExporter

## Primary Quest Flow (`luc -> extracted JSON -> DB -> exported Lua/NPC`)
1. `quest.luc` + NPC Lua directory -> extraction JSON
   - Class: `unluac.semantic.Phase2LucDataExtractionSystem`
   - Code path: `main(...)` -> `run(...)` -> `extractQuestData(...)` / `scanNpcReferences(...)`
   - Quest extraction coverage (current):
     - `reward.exp/gold/items/fame/pvppoint/mileage/skills/extra`
     - `conditions.needLevel/needQuest/requstItem/needItem/deleteItem`
     - `goal.getItem/killMonster/meetNpc/extra`
   - Output artifacts (default):
     - `reports/phase2_quest_data.json`
     - `reports/phase2_npc_reference_index.json`

2. extraction JSON -> quest/npc dependency graph JSON
   - Class: `unluac.semantic.Phase25QuestNpcDependencyMapper`
   - Code path: `main(...)` -> `build(...)`
   - Input defaults:
     - `reports/phase2_quest_data.json`
     - `reports/phase2_npc_reference_index.json`
   - Output default:
     - `reports/phase2_5_quest_npc_dependency_graph.json`

3. quest JSON + dependency graph JSON -> MySQL tables
   - Class: `unluac.semantic.Phase3DatabaseWriter`
   - Code path: `main(...)` -> `write(...)`
   - DB write behavior:
     - `DriverManager.getConnection(...)`
     - `createSchema(...)`
     - `truncateData(...)`
     - `insertQuestData(...)`
     - `insertNpcReferences(...)`
   - Extended DB persistence (current):
     - `quest_main.reward_fame/reward_pvppoint/reward_mileage`
     - `quest_main.reward_extra_json/goal_extra_json/conditions_json`
     - `quest_reward_skill`

4. DB -> quest export text
   - Class: `unluac.semantic.Phase4QuestLucExporter`
   - Code path: `main(...)` -> `export(...)` -> `loadFromDb(...)`
   - Exported reward/condition fields (current):
     - reward: `exp/gold/fame/pvppoint/mileage/items/getSkill`
     - top-level conditions: `needQuest/requstItem/needItem/deleteItem` (and existing fields)
     - goal extra fields from `goal_extra_json`
   - Output default:
     - `reports/phase4_exported_quest.lua`

5. DB + npc reference JSON -> NPC export text
   - Class: `unluac.semantic.Phase5NpcLucExporter`
   - Code path: `main(...)` -> `export(...)`
   - Input default:
     - `reports/phase2_npc_reference_index.json`
   - Output default:
     - directory `reports/phase5_exported_npc`

## NPC Text Edit Flow (DB-driven export)
1. NPC Lua source -> text node extraction + DB upsert
   - Class: `unluac.semantic.Phase7ANpcTextExtractionSystem`
   - Code path: `main(...)` -> `scanAndStore(...)` -> `upsertIntoDatabase(...)`

2. extraction JSON -> edit model table (`npc_text_edit_map`)
   - Class: `unluac.semantic.Phase7BNpcTextModelBuilder`
   - Code path: `main(...)` -> `build(...)` -> `createAndLoadTable(...)`

3. DB edit rows -> exported NPC Lua files
   - Class: `unluac.semantic.Phase7CNpcTextExporter`
   - Code path: `main(...)` -> `export(...)` -> `loadModifiedRows(...)`
   - Output default:
     - directory `reports/phase7C_exported_npc`

4. exported NPC Lua validation
   - Class: `unluac.semantic.Phase7DTextImpactValidator`
   - Code path: `main(...)` -> `validate(...)`

5. DB edit rows + original NPC LUC -> patched NPC LUC
   - Class: `unluac.semantic.Phase7NpcLucBinaryExporter`
   - Code path: `main(...)` -> `loadMutations(...)` -> `Lua50ChunkParser.parse(...)` -> `Lua50ChunkSerializer.serialize(...)`

## Call-chain nature
- The quest/DB/export flow is primarily a **file-contract + DB-contract chain** (JSON filenames, DB tables, and method parameters), not a single in-process Java method call chain between all steps.
- The links above are reconstructed from concrete class methods, `main(...)` argument defaults, and read/write operations in current source code.

## 2026-02-12 Field Completion Record
- Full change log: `documentation/phase2_4_field_completion_change_log.md`
- SQL migration script: `documentation/sql/phase2_4_field_completion_migration.sql`
- SQL rollback script: `documentation/sql/phase2_4_field_completion_rollback.sql`
- Validation reports:
  - `reports/phase3_db_roundtrip_validation.json` (`finalStatus=SAFE`)
  - `reports/phase4_export_validation.json` (`finalStatus=SAFE`)
