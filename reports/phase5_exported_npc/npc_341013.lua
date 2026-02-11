-- DB_DRIVEN_EXPORT
-- source: npc_341013.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_341013"
  local refs = {}
  refs[3730] = {
    name = "[ 武器不足1 ]",
    content0 = "初次见面，虽然有点失礼，但我有个事想请教一下。",
    reward0_count = 0,
    needLevel = 186,
    bQLoop = 0
  }
  return refs
end
