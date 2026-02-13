-- quest_table_comment_update.sql
-- generated_at: 2026-02-13 10:22:04
USE ghost_game;

ALTER TABLE npc_quest_reference COMMENT='NPC与Quest依赖映射表；来源Phase3DatabaseWriter；参与Phase5导出范围判定';
ALTER TABLE quest_answer COMMENT='Quest answer顺序表；来源Phase3DatabaseWriter；参与Phase4导出读取';
ALTER TABLE quest_contents COMMENT='Quest contents顺序表；来源Phase3DatabaseWriter；参与Phase4导出读取';
ALTER TABLE quest_goal_getitem COMMENT='Quest goal.getItem结构表；来源Phase3DatabaseWriter；参与Phase4导出读取';
ALTER TABLE quest_goal_killmonster COMMENT='Quest goal.killMonster结构表；来源Phase3DatabaseWriter；参与Phase4导出读取';
ALTER TABLE quest_goal_meetnpc COMMENT='Quest goal.meetNpc结构表；来源Phase3DatabaseWriter；参与Phase4导出读取';
ALTER TABLE quest_info COMMENT='Quest info顺序表；来源Phase3DatabaseWriter；参与Phase4导出读取';
ALTER TABLE quest_main COMMENT='Quest主表；来源Phase3DatabaseWriter；参与Phase4导出读取';
ALTER TABLE quest_requst_item COMMENT='Quest requstItem原始结构表；来源Phase3DatabaseWriter；参与Phase4导出读取';
ALTER TABLE quest_reward_item COMMENT='Quest reward.getItem结构表；来源Phase3DatabaseWriter；参与Phase4导出读取';
ALTER TABLE quest_reward_skill COMMENT='Quest reward.getSkill结构表；来源Phase3DatabaseWriter；参与Phase4导出读取';
