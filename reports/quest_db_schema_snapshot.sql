-- quest_db_schema_snapshot.sql
-- generated_at: 2026-02-13 10:19:18
-- database: ghost_game

-- SHOW TABLES (quest/npc filtered)
npc_dialogue_text
npc_quest_reference
npc_text_edit_map
quest_answer
quest_contents
quest_goal_getitem
quest_goal_killmonster
quest_goal_meetnpc
quest_info
quest_main
quest_requst_item
quest_reward_item
quest_reward_skill

-- ======================================================
-- TABLE: npc_dialogue_text
CREATE TABLE `npc_dialogue_text` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `npc_file` varchar(255) NOT NULL,
  `call_type` varchar(32) NOT NULL,
  `line_number` int(11) NOT NULL,
  `column_number` int(11) NOT NULL,
  `raw_text` longtext NOT NULL,
  `string_literal` longtext NOT NULL,
  `ast_context` longtext,
  `function_name` varchar(128) DEFAULT NULL,
  `associated_quest_id` int(11) DEFAULT NULL,
  `associated_quest_ids_json` json DEFAULT NULL,
  `ast_marker` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_npc_dialogue_text_marker` (`npc_file`,`ast_marker`),
  KEY `idx_npc_dialogue_file` (`npc_file`),
  KEY `idx_npc_dialogue_quest` (`associated_quest_id`),
  KEY `idx_npc_dialogue_call` (`call_type`)
) ENGINE=InnoDB AUTO_INCREMENT=3540 DEFAULT CHARSET=utf8mb4;

-- ======================================================
-- TABLE: npc_quest_reference
CREATE TABLE `npc_quest_reference` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `npc_file` varchar(255) NOT NULL,
  `quest_id` int(11) NOT NULL,
  `reference_count` int(11) NOT NULL DEFAULT '0',
  `goal_access_count` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_npc_quest_reference` (`npc_file`,`quest_id`),
  KEY `idx_npc_ref_quest` (`quest_id`),
  KEY `idx_npc_ref_file` (`npc_file`)
) ENGINE=InnoDB AUTO_INCREMENT=2374 DEFAULT CHARSET=utf8mb4;

-- ======================================================
-- TABLE: npc_text_edit_map
CREATE TABLE `npc_text_edit_map` (
  `textId` bigint(20) NOT NULL AUTO_INCREMENT,
  `npcFile` varchar(255) NOT NULL,
  `line` int(11) NOT NULL,
  `columnNumber` int(11) NOT NULL,
  `callType` varchar(32) NOT NULL,
  `rawText` longtext NOT NULL,
  `modifiedText` longtext,
  `stringLiteral` longtext NOT NULL,
  `astMarker` varchar(255) NOT NULL,
  `functionName` varchar(128) DEFAULT NULL,
  `surroundingAstContext` longtext,
  `associatedQuestId` int(11) DEFAULT NULL,
  `associatedQuestIdsJson` json DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`textId`),
  UNIQUE KEY `uk_npc_text_locator` (`npcFile`,`line`,`columnNumber`,`astMarker`),
  KEY `idx_npc_text_file` (`npcFile`),
  KEY `idx_npc_text_quest` (`associatedQuestId`),
  KEY `idx_npc_text_call` (`callType`)
) ENGINE=InnoDB AUTO_INCREMENT=3540 DEFAULT CHARSET=utf8mb4;

-- ======================================================
-- TABLE: quest_answer
CREATE TABLE `quest_answer` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `quest_id` int(11) NOT NULL,
  `seq_index` int(11) NOT NULL,
  `text` longtext,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_quest_answer` (`quest_id`,`seq_index`),
  KEY `idx_quest_answer_quest` (`quest_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4461 DEFAULT CHARSET=utf8mb4;

-- ======================================================
-- TABLE: quest_contents
CREATE TABLE `quest_contents` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `quest_id` int(11) NOT NULL,
  `seq_index` int(11) NOT NULL,
  `text` longtext,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_quest_contents` (`quest_id`,`seq_index`),
  KEY `idx_quest_contents_quest` (`quest_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14982 DEFAULT CHARSET=utf8mb4;

-- ======================================================
-- TABLE: quest_goal_getitem
CREATE TABLE `quest_goal_getitem` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `quest_id` int(11) NOT NULL,
  `seq_index` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `item_count` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_goal_getitem` (`quest_id`,`seq_index`),
  KEY `idx_goal_getitem_quest` (`quest_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1610 DEFAULT CHARSET=utf8mb4;

-- ======================================================
-- TABLE: quest_goal_killmonster
CREATE TABLE `quest_goal_killmonster` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `quest_id` int(11) NOT NULL,
  `seq_index` int(11) NOT NULL,
  `monster_id` int(11) NOT NULL,
  `monster_count` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_goal_killmonster` (`quest_id`,`seq_index`),
  KEY `idx_goal_killmonster_quest` (`quest_id`)
) ENGINE=InnoDB AUTO_INCREMENT=639 DEFAULT CHARSET=utf8mb4;

-- ======================================================
-- TABLE: quest_goal_meetnpc
CREATE TABLE `quest_goal_meetnpc` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `quest_id` int(11) NOT NULL,
  `seq_index` int(11) NOT NULL,
  `npc_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_goal_meetnpc` (`quest_id`,`seq_index`),
  KEY `idx_goal_meetnpc_quest` (`quest_id`)
) ENGINE=InnoDB AUTO_INCREMENT=396 DEFAULT CHARSET=utf8mb4;

-- ======================================================
-- TABLE: quest_info
CREATE TABLE `quest_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `quest_id` int(11) NOT NULL,
  `seq_index` int(11) NOT NULL,
  `text` longtext,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_quest_info` (`quest_id`,`seq_index`),
  KEY `idx_quest_info_quest` (`quest_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2606 DEFAULT CHARSET=utf8mb4;

-- ======================================================
-- TABLE: quest_main
CREATE TABLE `quest_main` (
  `quest_id` int(11) NOT NULL,
  `name` text,
  `need_level` int(11) NOT NULL DEFAULT '0',
  `bq_loop` int(11) NOT NULL DEFAULT '0',
  `reward_exp` int(11) NOT NULL DEFAULT '0',
  `reward_gold` int(11) NOT NULL DEFAULT '0',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `reward_money` int(11) NOT NULL DEFAULT '0',
  `reward_fame` int(11) NOT NULL DEFAULT '0',
  `reward_pvppoint` int(11) NOT NULL DEFAULT '0',
  `reward_mileage` int(11) NOT NULL DEFAULT '0',
  `need_item` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`quest_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ======================================================
-- TABLE: quest_requst_item
CREATE TABLE `quest_requst_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `quest_id` int(11) NOT NULL,
  `seq_index` int(11) NOT NULL,
  `item_id` int(11) DEFAULT NULL,
  `item_count` int(11) DEFAULT NULL,
  `raw_json` longtext,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_requst_item` (`quest_id`,`seq_index`),
  KEY `idx_requst_item_quest` (`quest_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ======================================================
-- TABLE: quest_reward_item
CREATE TABLE `quest_reward_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `quest_id` int(11) NOT NULL,
  `seq_index` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `item_count` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_reward_item` (`quest_id`,`seq_index`),
  KEY `idx_reward_item_quest` (`quest_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1078 DEFAULT CHARSET=utf8mb4;

-- ======================================================
-- TABLE: quest_reward_skill
CREATE TABLE `quest_reward_skill` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `quest_id` int(11) NOT NULL,
  `seq_index` int(11) NOT NULL,
  `skill_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_reward_skill` (`quest_id`,`seq_index`),
  KEY `idx_reward_skill_quest` (`quest_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

