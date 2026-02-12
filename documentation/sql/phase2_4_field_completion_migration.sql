-- Phase2/3/4 字段补全迁移脚本（ghost_game）
-- 执行前请先备份数据库

USE ghost_game;

-- 1) quest_main 增列（幂等写法）
SET @ddl = (
  SELECT IF(
    EXISTS(
      SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS
      WHERE TABLE_SCHEMA = DATABASE()
        AND TABLE_NAME = 'quest_main'
        AND COLUMN_NAME = 'reward_fame'
    ),
    'SELECT 1',
    'ALTER TABLE quest_main ADD COLUMN reward_fame INT NOT NULL DEFAULT 0'
  )
);
PREPARE stmt FROM @ddl; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @ddl = (
  SELECT IF(
    EXISTS(
      SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS
      WHERE TABLE_SCHEMA = DATABASE()
        AND TABLE_NAME = 'quest_main'
        AND COLUMN_NAME = 'reward_pvppoint'
    ),
    'SELECT 1',
    'ALTER TABLE quest_main ADD COLUMN reward_pvppoint INT NOT NULL DEFAULT 0'
  )
);
PREPARE stmt FROM @ddl; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @ddl = (
  SELECT IF(
    EXISTS(
      SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS
      WHERE TABLE_SCHEMA = DATABASE()
        AND TABLE_NAME = 'quest_main'
        AND COLUMN_NAME = 'reward_mileage'
    ),
    'SELECT 1',
    'ALTER TABLE quest_main ADD COLUMN reward_mileage INT NOT NULL DEFAULT 0'
  )
);
PREPARE stmt FROM @ddl; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @ddl = (
  SELECT IF(
    EXISTS(
      SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS
      WHERE TABLE_SCHEMA = DATABASE()
        AND TABLE_NAME = 'quest_main'
        AND COLUMN_NAME = 'reward_extra_json'
    ),
    'SELECT 1',
    'ALTER TABLE quest_main ADD COLUMN reward_extra_json LONGTEXT NULL'
  )
);
PREPARE stmt FROM @ddl; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @ddl = (
  SELECT IF(
    EXISTS(
      SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS
      WHERE TABLE_SCHEMA = DATABASE()
        AND TABLE_NAME = 'quest_main'
        AND COLUMN_NAME = 'goal_extra_json'
    ),
    'SELECT 1',
    'ALTER TABLE quest_main ADD COLUMN goal_extra_json LONGTEXT NULL'
  )
);
PREPARE stmt FROM @ddl; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @ddl = (
  SELECT IF(
    EXISTS(
      SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS
      WHERE TABLE_SCHEMA = DATABASE()
        AND TABLE_NAME = 'quest_main'
        AND COLUMN_NAME = 'conditions_json'
    ),
    'SELECT 1',
    'ALTER TABLE quest_main ADD COLUMN conditions_json LONGTEXT NULL'
  )
);
PREPARE stmt FROM @ddl; EXECUTE stmt; DEALLOCATE PREPARE stmt;

-- 2) 技能奖励表
CREATE TABLE IF NOT EXISTS quest_reward_skill (
  id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  quest_id INT NOT NULL,
  seq_index INT NOT NULL,
  skill_id INT NOT NULL,
  UNIQUE KEY uk_reward_skill (quest_id, seq_index),
  KEY idx_reward_skill_quest (quest_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 3) 迁移后检查
SELECT COUNT(*) AS quest_main_rows FROM quest_main;
SELECT COUNT(*) AS reward_skill_rows FROM quest_reward_skill;
SELECT COUNT(*) AS reward_fame_nonzero FROM quest_main WHERE reward_fame <> 0;
SELECT COUNT(*) AS reward_pvppoint_nonzero FROM quest_main WHERE reward_pvppoint <> 0;
SELECT COUNT(*) AS reward_mileage_nonzero FROM quest_main WHERE reward_mileage <> 0;
SELECT COUNT(*) AS conditions_json_non_empty
FROM quest_main
WHERE conditions_json IS NOT NULL AND conditions_json <> '';
