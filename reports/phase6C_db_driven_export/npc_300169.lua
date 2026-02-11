-- DB_DRIVEN_EXPORT
-- source: npc_300169.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_300169"
  local refs = {}
  refs[3747] = {
    name = "[ 要重新制作巧克力 ]",
    content0 = "喂，喂...",
    reward0_count = 1,
    needLevel = 1,
    bQLoop = 0
  }
  return refs
end
