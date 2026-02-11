-- DB_DRIVEN_EXPORT
-- source: npc_315010.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_315010"
  local refs = {}
  refs[111] = {
    name = "[ ??? ?? ?? ]",
    content0 = "? ? ? ?????. ??! ???.???? ??? ????...???? ??!",
    reward0_count = 0,
    needLevel = 56,
    bQLoop = 0
  }
  refs[1246] = {
    name = "[ 营救受伤的鹿 ]",
    content0 = "东泼肉的行踪吗？这个。因为我答应过东泼肉要替他保密的。",
    reward0_count = 20,
    needLevel = 54,
    bQLoop = 0
  }
  refs[1247] = {
    name = "[ 鹿的指点 ]",
    content0 = "东泼肉的行踪吗？很遗憾，我也不是很清楚。但是…。",
    reward0_count = 0,
    needLevel = 55,
    bQLoop = 0
  }
  return refs
end
