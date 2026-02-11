-- DB_DRIVEN_EXPORT
-- source: npc_300175.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_300175"
  local refs = {}
  refs[3769] = {
    name = "[ 国家语言 ]",
    content0 = "国家的语言都被后代说的不成样子了...",
    reward0_count = 1,
    needLevel = 1,
    bQLoop = 0
  }
  return refs
end
