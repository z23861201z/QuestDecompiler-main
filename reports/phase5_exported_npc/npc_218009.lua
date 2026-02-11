-- DB_DRIVEN_EXPORT
-- source: npc_218009.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_218009"
  local refs = {}
  refs[921] = {
    name = "{0xFFFFB4B4}[ 什么是装备属性？ ]{END}",
    content0 = "所谓装备属性，是指在一般武器或衣服上附加属性。",
    reward0_count = 0,
    needLevel = 0,
    bQLoop = 0
  }
  refs[922] = {
    name = "{0xFFFFB4B4}[ 什么是强化属性？ ]{END}",
    content0 = "所谓强化属性，是指强化已经装备属性了的武器和衣服的等级。",
    reward0_count = 0,
    needLevel = 0,
    bQLoop = 0
  }
  refs[923] = {
    name = "{0xFFFFB4B4}[ 装备属性后的武器的效果 ]{END}",
    content0 = "火属性武器会用火焰包围对手，水属性武器会冰冻对手。",
    reward0_count = 0,
    needLevel = 0,
    bQLoop = 0
  }
  refs[924] = {
    name = "{0xFFFFB4B4}[ 装备属性后的防具的效果 ]{END}",
    content0 = "火属性防具可以让自己变身狂暴，水属性防具的效果是治愈自己。",
    reward0_count = 0,
    needLevel = 0,
    bQLoop = 0
  }
  return refs
end
