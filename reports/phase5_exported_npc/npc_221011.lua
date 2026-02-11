-- DB_DRIVEN_EXPORT
-- source: npc_221011.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_221011"
  local refs = {}
  refs[3658] = {
    name = "[ 守护南丰馆3 ]",
    content0 = "只要亡者的山谷的那些怪物存在，南丰馆就一直处于危险之中",
    reward0_count = 1,
    needLevel = 146,
    bQLoop = 0
  }
  return refs
end
