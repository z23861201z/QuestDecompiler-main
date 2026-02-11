# Phase7B NPC Text Model Summary

- GeneratedAt: 2026-02-11T18:27:13.685+08:00
- SourceReport: `reports/phase7A_npc_text_extraction.json`
- TableName: `npc_text_edit_map`
- SourceTextNodeCount: 3539
- InsertedRowCount: 3539

## Table DDL

```sql
CREATE TABLE IF NOT EXISTS npc_text_edit_map (textId BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,npcFile VARCHAR(255) NOT NULL,line INT NOT NULL,columnNumber INT NOT NULL,callType VARCHAR(32) NOT NULL,rawText LONGTEXT NOT NULL,modifiedText LONGTEXT NULL,stringLiteral LONGTEXT NOT NULL,astMarker VARCHAR(255) NOT NULL,functionName VARCHAR(128) NULL,surroundingAstContext LONGTEXT NULL,associatedQuestId INT NULL,associatedQuestIdsJson JSON NULL,created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,UNIQUE KEY uk_npc_text_locator (npcFile, line, columnNumber, astMarker),KEY idx_npc_text_file (npcFile),KEY idx_npc_text_quest (associatedQuestId),KEY idx_npc_text_call (callType)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci
```

## Field Definition

| Field | Type | Description |
|---|---|---|
| `textId` | BIGINT PK | Unique text id for Web editing row |
| `npcFile` | VARCHAR(255) | Source NPC file name, e.g. `npc_218008.lua` |
| `line` | INT | Original line number (1-based) |
| `columnNumber` | INT | Original column number (1-based) |
| `callType` | VARCHAR(32) | Editable call type scope: `NPC_SAY` / `NPC_ASK` |
| `rawText` | LONGTEXT | Original extracted text |
| `modifiedText` | LONGTEXT | User edited text, nullable |
| `stringLiteral` | LONGTEXT | Original Lua string literal with quote/escape |
| `astMarker` | VARCHAR(255) | AST location marker for exact locate |
| `functionName` | VARCHAR(128) | Function containing the text node |
| `surroundingAstContext` | LONGTEXT | AST context for safe localization |
| `associatedQuestId` | INT | Primary related quest id, nullable |
| `associatedQuestIdsJson` | JSON | Related quest id array |
| `created_at` / `updated_at` | TIMESTAMP | Audit fields |

## textId Locate to Source

1. Query one row by textId:
   `SELECT npcFile, line, columnNumber, astMarker, callType, rawText, modifiedText FROM npc_text_edit_map WHERE textId=?;`
2. Open `npcFile` and locate by `line + columnNumber + astMarker`.
3. Replace only text literal: `effectiveText = COALESCE(modifiedText, rawText)`.
4. Do not modify AST structure, function structure, call name, or argument count.

## Locate + Replace Rule

- Reversible: `rawText` and `stringLiteral` are always preserved.
- Editable only: `modifiedText`.
- No refactor logic: only text replacement, no AST rewrite.
- Unique locator: `UNIQUE(npcFile, line, columnNumber, astMarker)`.

## Quest Association

- Use `associatedQuestId` and `associatedQuestIdsJson` for quest linkage if present.
- Quest side change can query impacted NPC text rows by quest id.
