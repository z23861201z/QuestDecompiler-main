# Quest/NPC 字段扫描结果对应的 MySQL 设计

基于 `documentation/quest_field_scan_report.md` 的字段扫描结果，设计 Quest/NPC 可编辑语义库表。

约束与原则：

- 不使用外键，仅做逻辑关联
- 支持一对多关系
- 支持多种奖励/目标类型
- 保留未来扩展字段（JSON）
- 所有主表包含 `version` / `created_at` / `updated_at` / `script_source`

---

## ER 逻辑结构（无外键）

- `quest (1) -> (N) quest_goal`
- `quest (1) -> (N) quest_reward`
- `quest_reward (1) -> (N) quest_reward_item`
- `quest_reward (1) -> (N) quest_reward_skill`
- `quest (1) -> (N) quest_dialogue`（树结构通过 `node_uid` / `parent_node_uid`）
- `npc (1) -> (N) npc_dialogue`（树结构通过 `node_uid` / `parent_node_uid`）
- `npc (1) -> (N) npc_action`
- `npc_action.quest_id` 与 `quest.quest_id` 逻辑关联

---

## 完整 SQL（MySQL 8.0+）

```sql
-- =========================
-- Quest/NPC Script DB Schema
-- MySQL 8.0+
-- =========================

CREATE DATABASE IF NOT EXISTS quest_editor
  DEFAULT CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE quest_editor;

-- 1) Quest 主表
CREATE TABLE IF NOT EXISTS quest (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  quest_id INT NOT NULL COMMENT '业务任务ID（qt[xxxx]）',
  quest_name VARCHAR(255) NULL,
  bq_loop TINYINT NULL,
  need_level INT NULL,

  contents_json JSON NULL COMMENT 'contents[]',
  answer_json JSON NULL COMMENT 'answer[]',
  info_json JSON NULL COMMENT 'info[]',
  npcsay_json JSON NULL COMMENT 'npcsay[]',

  need_quest_json JSON NULL COMMENT 'needQuest（可能为标量或数组）',
  requst_item_json JSON NULL COMMENT '原字段 requstItem',
  need_item_json JSON NULL COMMENT 'needItem',
  delete_item_json JSON NULL COMMENT 'deleteItem',

  extra_fields_json JSON NULL COMMENT '未来扩展字段',
  version INT NOT NULL DEFAULT 1,
  script_source VARCHAR(512) NOT NULL COMMENT '来源脚本路径，如 quest.luc',

  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

  PRIMARY KEY (id),
  UNIQUE KEY uk_quest_questid_version (quest_id, version),
  KEY idx_quest_name (quest_name),
  KEY idx_quest_need_level (need_level),
  KEY idx_quest_script_source (script_source)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- 2) QuestGoal 表（支持多种目标类型）
CREATE TABLE IF NOT EXISTS quest_goal (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  quest_id INT NOT NULL COMMENT '逻辑关联 quest.quest_id',

  goal_set VARCHAR(32) NOT NULL COMMENT 'goal|requstItem|needItem|deleteItem|needQuest|custom',
  goal_type VARCHAR(64) NOT NULL COMMENT 'GET_ITEM|KILL_MONSTER|MEET_NPC|NEED_ITEM|NEED_QUEST|TIMEOUT|EXP|FAME|CUSTOM',
  source_key VARCHAR(64) NULL COMMENT '原始字段名，如 getItem/getitem/meetNpc/meetNPC',

  target_id BIGINT NULL COMMENT 'item_id/monster_id/npc_id/quest_id',
  target_count INT NULL,
  meet_count INT NULL,
  timeout_sec INT NULL,
  exp_required INT NULL,
  fame_required INT NULL,
  need_level INT NULL,

  step_order INT NOT NULL DEFAULT 0,
  condition_expr VARCHAR(512) NULL,
  extra_fields_json JSON NULL,

  version INT NOT NULL DEFAULT 1,
  script_source VARCHAR(512) NOT NULL,

  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

  PRIMARY KEY (id),
  KEY idx_qgoal_quest_version (quest_id, version),
  KEY idx_qgoal_set (goal_set),
  KEY idx_qgoal_type (goal_type),
  KEY idx_qgoal_source_key (source_key),
  KEY idx_qgoal_target_id (target_id),
  KEY idx_qgoal_script_source (script_source)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- 3) QuestReward 表（支持多种奖励类型）
CREATE TABLE IF NOT EXISTS quest_reward (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  quest_id INT NOT NULL COMMENT '逻辑关联 quest.quest_id',

  reward_stage VARCHAR(32) NOT NULL DEFAULT 'complete' COMMENT 'complete|stage_x|custom',
  reward_type VARCHAR(32) NOT NULL DEFAULT 'MIXED' COMMENT 'MIXED|CURRENCY|ITEM|SKILL|CUSTOM',

  exp INT NULL DEFAULT 0,
  fame INT NULL DEFAULT 0,
  money BIGINT NULL DEFAULT 0,
  pvppoint INT NULL DEFAULT 0,
  mileage INT NULL DEFAULT 0,

  extra_fields_json JSON NULL,
  version INT NOT NULL DEFAULT 1,
  script_source VARCHAR(512) NOT NULL,

  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

  PRIMARY KEY (id),
  KEY idx_qreward_quest_version (quest_id, version),
  KEY idx_qreward_stage (reward_stage),
  KEY idx_qreward_type (reward_type),
  KEY idx_qreward_script_source (script_source)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- 4) QuestRewardItem 表
CREATE TABLE IF NOT EXISTS quest_reward_item (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  quest_id INT NOT NULL COMMENT '逻辑关联 quest.quest_id',
  reward_id BIGINT UNSIGNED NOT NULL COMMENT '逻辑关联 quest_reward.id',

  item_id INT NOT NULL,
  item_count INT NOT NULL DEFAULT 1,
  item_type VARCHAR(32) NULL COMMENT 'normal|bind|optional|custom',

  step_order INT NOT NULL DEFAULT 0,
  extra_fields_json JSON NULL,

  version INT NOT NULL DEFAULT 1,
  script_source VARCHAR(512) NOT NULL,

  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

  PRIMARY KEY (id),
  KEY idx_qr_item_quest_version (quest_id, version),
  KEY idx_qr_item_reward_id (reward_id),
  KEY idx_qr_item_item_id (item_id),
  KEY idx_qr_item_script_source (script_source)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- 5) QuestRewardSkill 表
CREATE TABLE IF NOT EXISTS quest_reward_skill (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  quest_id INT NOT NULL COMMENT '逻辑关联 quest.quest_id',
  reward_id BIGINT UNSIGNED NOT NULL COMMENT '逻辑关联 quest_reward.id',

  skill_id INT NOT NULL,
  skill_level INT NULL,
  step_order INT NOT NULL DEFAULT 0,

  extra_fields_json JSON NULL,
  version INT NOT NULL DEFAULT 1,
  script_source VARCHAR(512) NOT NULL,

  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

  PRIMARY KEY (id),
  KEY idx_qr_skill_quest_version (quest_id, version),
  KEY idx_qr_skill_reward_id (reward_id),
  KEY idx_qr_skill_skill_id (skill_id),
  KEY idx_qr_skill_script_source (script_source)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- 6) QuestDialogue 表（多分支树）
CREATE TABLE IF NOT EXISTS quest_dialogue (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  quest_id INT NOT NULL COMMENT '逻辑关联 quest.quest_id',

  dialogue_tree_id VARCHAR(64) NOT NULL DEFAULT 'default' COMMENT '同一任务可多棵树',
  node_uid VARCHAR(64) NOT NULL COMMENT '节点唯一标识（在 quest_id+tree+version 下唯一）',
  parent_node_uid VARCHAR(64) NULL COMMENT '父节点UID（逻辑关联）',

  branch_label VARCHAR(64) NULL COMMENT 'YES|NO|IF_NO|LAST_ANSWER_1|LAST_INFO|...',
  line_type VARCHAR(32) NOT NULL COMMENT 'TEXT|ANSWER|PROGRESS_INFO|COMPLETE_INFO|NPC_SAY|SYSTEM',
  source_block VARCHAR(32) NULL COMMENT 'contents|answer|info|npcsay|derived',

  line_text TEXT NULL,
  step_order INT NOT NULL DEFAULT 0,
  depth INT NOT NULL DEFAULT 0,
  is_terminal TINYINT(1) NOT NULL DEFAULT 0,

  next_node_uids_json JSON NULL COMMENT '子节点UID列表',
  extra_fields_json JSON NULL,

  version INT NOT NULL DEFAULT 1,
  script_source VARCHAR(512) NOT NULL,

  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

  PRIMARY KEY (id),
  UNIQUE KEY uk_qdialogue_node (quest_id, dialogue_tree_id, node_uid, version),
  KEY idx_qdialogue_parent (quest_id, dialogue_tree_id, parent_node_uid, version, step_order),
  KEY idx_qdialogue_branch (quest_id, branch_label, version),
  KEY idx_qdialogue_source_block (source_block),
  KEY idx_qdialogue_script_source (script_source),
  FULLTEXT KEY ft_qdialogue_text (line_text)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- 7) Npc 表
CREATE TABLE IF NOT EXISTS npc (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  npc_id INT NOT NULL COMMENT '业务NPC ID',
  npc_name VARCHAR(255) NULL,
  script_type VARCHAR(32) NOT NULL DEFAULT 'NPC_SCRIPT',

  function_names_json JSON NULL COMMENT '检测到的全局函数名',
  related_quest_ids_json JSON NULL COMMENT '关联任务ID列表',
  extra_fields_json JSON NULL,

  version INT NOT NULL DEFAULT 1,
  script_source VARCHAR(512) NOT NULL COMMENT '来源脚本路径，如 npc_xxxx.luc',

  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

  PRIMARY KEY (id),
  UNIQUE KEY uk_npc_npcid_version (npc_id, version),
  KEY idx_npc_name (npc_name),
  KEY idx_npc_script_source (script_source)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- 8) NpcDialogue 表
CREATE TABLE IF NOT EXISTS npc_dialogue (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  npc_id INT NOT NULL COMMENT '逻辑关联 npc.npc_id',

  dialogue_tree_id VARCHAR(64) NOT NULL DEFAULT 'default',
  node_uid VARCHAR(64) NOT NULL,
  parent_node_uid VARCHAR(64) NULL,

  branch_label VARCHAR(64) NULL COMMENT 'YES|NO|IF_NO|DEFAULT|...',
  line_type VARCHAR(32) NOT NULL COMMENT 'NPC_SAY|NPC_QSAY|TEXT|OPTION|SYSTEM',
  line_text TEXT NULL,

  step_order INT NOT NULL DEFAULT 0,
  depth INT NOT NULL DEFAULT 0,
  is_terminal TINYINT(1) NOT NULL DEFAULT 0,

  quest_id_hint INT NULL COMMENT '该对白可能关联的任务ID',
  next_node_uids_json JSON NULL,
  extra_fields_json JSON NULL,

  version INT NOT NULL DEFAULT 1,
  script_source VARCHAR(512) NOT NULL,

  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

  PRIMARY KEY (id),
  UNIQUE KEY uk_npc_dialogue_node (npc_id, dialogue_tree_id, node_uid, version),
  KEY idx_npc_dialogue_parent (npc_id, dialogue_tree_id, parent_node_uid, version, step_order),
  KEY idx_npc_dialogue_quest_hint (quest_id_hint, version),
  KEY idx_npc_dialogue_script_source (script_source),
  FULLTEXT KEY ft_npc_dialogue_text (line_text)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- 9) NpcAction 表
CREATE TABLE IF NOT EXISTS npc_action (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  npc_id INT NOT NULL COMMENT '逻辑关联 npc.npc_id',

  function_path VARCHAR(255) NULL COMMENT '函数路径（反编译路径）',
  pc INT NULL COMMENT '指令偏移',
  action_name VARCHAR(128) NOT NULL COMMENT '如 NPC_SAY/SET_QUEST_STATE/未知方法',
  action_category VARCHAR(64) NOT NULL DEFAULT 'UNKNOWN' COMMENT 'DIALOG|QUEST_STATE|ITEM_CHECK|WARP|SHOP|UNKNOWN',

  quest_id INT NULL,
  state_value INT NULL,
  item_id INT NULL,
  item_count INT NULL,

  arg1 VARCHAR(255) NULL,
  arg2 VARCHAR(255) NULL,
  arg3 VARCHAR(255) NULL,
  arg4 VARCHAR(255) NULL,
  arg5 VARCHAR(255) NULL,
  args_json JSON NULL,

  resolved_flag TINYINT(1) NOT NULL DEFAULT 1 COMMENT '是否被语义识别',
  extra_fields_json JSON NULL,

  version INT NOT NULL DEFAULT 1,
  script_source VARCHAR(512) NOT NULL,

  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

  PRIMARY KEY (id),
  KEY idx_npcaction_npc_version (npc_id, version),
  KEY idx_npcaction_action_name (action_name),
  KEY idx_npcaction_category (action_category),
  KEY idx_npcaction_quest (quest_id, version),
  KEY idx_npcaction_item (item_id),
  KEY idx_npcaction_resolved (resolved_flag),
  KEY idx_npcaction_script_source (script_source)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
```

---

## 索引设计说明

- 版本化主查询：`quest_id + version`、`npc_id + version`
- 对话树遍历：`parent_node_uid + step_order` 复合索引
- 行为分析：`npc_action.action_name`、`quest_id`、`resolved_flag`
- 文本检索：`quest_dialogue.line_text`、`npc_dialogue.line_text` 的 FULLTEXT
- 溯源追踪：所有表保留 `script_source` 并建索引

