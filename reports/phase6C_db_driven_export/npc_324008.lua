-- DB_DRIVEN_EXPORT
-- source: npc_324008.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_324008"
  local refs = {}
  refs[2610] = {
    name = "[ 魔布加-往更深处探索 ]",
    content0 = "得去更深处看看才行啊~",
    reward0_count = 15,
    needLevel = 60,
    bQLoop = 0
  }
  refs[2616] = {
    name = "[ 耶单-往更深处探索 ]",
    content0 = "得去更深处看看才行啊~",
    reward0_count = 15,
    needLevel = 60,
    bQLoop = 0
  }
  return refs
end
