-- DB_DRIVEN_EXPORT
-- source: npc_218007.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_218007"
  local refs = {}
  refs[576] = {
    name = "[ ????? ]",
    content0 = "?????? ? ?? ?? ???? ",
    reward0_count = 1,
    needLevel = 12,
    bQLoop = 0
  }
  return refs
end
