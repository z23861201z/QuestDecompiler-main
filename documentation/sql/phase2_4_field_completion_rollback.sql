-- Phase2/3/4 字段补全回滚脚本（ghost_game）
-- 仅在确认需要回退时执行

USE ghost_game;

DROP TABLE IF EXISTS quest_reward_skill;

SET @ddl = (
  SELECT IF(
    EXISTS(
      SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS
      WHERE TABLE_SCHEMA = DATABASE()
        AND TABLE_NAME = 'quest_main'
        AND COLUMN_NAME = 'conditions_json'
    ),
    'ALTER TABLE quest_main DROP COLUMN conditions_json',
    'SELECT 1'
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
    'ALTER TABLE quest_main DROP COLUMN goal_extra_json',
    'SELECT 1'
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
    'ALTER TABLE quest_main DROP COLUMN reward_extra_json',
    'SELECT 1'
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
    'ALTER TABLE quest_main DROP COLUMN reward_mileage',
    'SELECT 1'
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
    'ALTER TABLE quest_main DROP COLUMN reward_pvppoint',
    'SELECT 1'
  )
);
PREPARE stmt FROM @ddl; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @ddl = (
  SELECT IF(
    EXISTS(
      SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS
      WHERE TABLE_SCHEMA = DATABASE()
        AND TABLE_NAME = 'quest_main'
        AND COLUMN_NAME = 'reward_fame'
    ),
    'ALTER TABLE quest_main DROP COLUMN reward_fame',
    'SELECT 1'
  )
);
PREPARE stmt FROM @ddl; EXECUTE stmt; DEALLOCATE PREPARE stmt;
