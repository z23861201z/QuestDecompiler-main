-- DB_DRIVEN_EXPORT
-- source: npc_341008.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_341008"
  local refs = {}
  refs[2912] = {
    name = "[ 乐器的报复 ]",
    content0 = "{0xFFFFCCCC}(雅琪在伤心的哭泣。){END}呜呜呜..",
    reward0_count = 0,
    needLevel = 193,
    bQLoop = 0
  }
  return refs
end
