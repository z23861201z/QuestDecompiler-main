-- DB_DRIVEN_EXPORT
-- source: npc_300166.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_300166"
  local refs = {}
  refs[2751] = {
    name = "[ 爱丽丝在找的兔子 ]",
    content0 = "额...你见到兔子了吗？",
    reward0_count = 1,
    needLevel = 1,
    bQLoop = 0
  }
  return refs
end
