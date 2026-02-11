-- DB_DRIVEN_EXPORT
-- source: npc_323001.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_323001"
  local refs = {}
  refs[2600] = {
    name = "[ 连续不断的雷电 ]",
    content0 = "最近我们王国因为{0xFFFFFF00}[雷神]{END}的雷电遭受了很大伤害。",
    reward0_count = 0,
    needLevel = 185,
    bQLoop = 0
  }
  return refs
end
