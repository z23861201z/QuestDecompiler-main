-- DB_DRIVEN_EXPORT
-- source: npc_314009.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_314009"
  local refs = {}
  refs[22] = {
    name = "[ 剑-利刃术 ]",
    content0 = "利刃术，装备剑时，能使攻击力自动上升的内功武功。要学吗？",
    reward0_count = 0,
    needLevel = 1,
    bQLoop = 0
  }
  refs[23] = {
    name = "[ 刀-霸刀术 ]",
    content0 = "{0xFFFFFF00}霸刀术，装备刀时，能使攻击力自动上升的内功技能{END}。要学吗？",
    reward0_count = 0,
    needLevel = 1,
    bQLoop = 0
  }
  refs[24] = {
    name = "[ 剑-剑气穿心 ]",
    content0 = "{0xFFFFFF00}剑气穿心，此武功可以举剑贯穿攻击前方的敌人{END}。要学吗？",
    reward0_count = 0,
    needLevel = 1,
    bQLoop = 0
  }
  refs[25] = {
    name = "[ 刀-裂空斩 ]",
    content0 = "{0xFFFFFF00}裂空斩，提刀会给前方敌人造成额外伤害的武功{END}。要学吗？",
    reward0_count = 0,
    needLevel = 1,
    bQLoop = 0
  }
  refs[26] = {
    name = "[ 剑-开山突击 ]",
    content0 = "{0xFFFFFF00}开山突击，举剑后可以连续两次攻击前方敌人的武功{END}。要学吗？",
    reward0_count = 0,
    needLevel = 18,
    bQLoop = 0
  }
  refs[27] = {
    name = "[ 刀-点穴定身 ]",
    content0 = "{0xFFFFFF00}点穴定身，是提刀攻击时有一定几率使对手定身的武功{END}。要学吗？",
    reward0_count = 0,
    needLevel = 18,
    bQLoop = 0
  }
  refs[28] = {
    name = "[ 共同-狂暴怒气 ]",
    content0 = "狂暴怒气，降低自己的防御力，同时提升攻击力的武功。要学吗？",
    reward0_count = 0,
    needLevel = 23,
    bQLoop = 0
  }
  refs[29] = {
    name = "[ 共同-气力转换 ]",
    content0 = "{0xFFFFFF00}气力转换，使用自己的体力来恢复鬼力的武功{END}。要学吗？",
    reward0_count = 0,
    needLevel = 28,
    bQLoop = 0
  }
  refs[30] = {
    name = "[ 共同-强气护体 ]",
    content0 = "{0xFFFFFF00}强气护体，可以将自己的防御力提升到最高值的武功。要学吗？",
    reward0_count = 0,
    needLevel = 33,
    bQLoop = 0
  }
  refs[31] = {
    name = "[ 共同-强化格挡 ]",
    content0 = "{0xFFFFFF00}强化格挡是在防御时增加格挡数值的武功{END}。要学吗？",
    reward0_count = 0,
    needLevel = 38,
    bQLoop = 0
  }
  refs[678] = {
    name = "[ 剑-梅花幻剑 ]",
    content0 = "{0xFFFFFF00}梅花幻剑，是用剑武士的最高等级武功{END}。要学吗？",
    reward0_count = 0,
    needLevel = 43,
    bQLoop = 0
  }
  refs[679] = {
    name = "[ 刀-破天灭 ]",
    content0 = "破天灭，是用刀武士的最高等级武功。要学吗？",
    reward0_count = 0,
    needLevel = 43,
    bQLoop = 0
  }
  return refs
end
