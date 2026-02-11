-- DB_DRIVEN_EXPORT
-- source: npc_300129.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_300129"
  local refs = {}
  refs[2954] = {
    name = "[ 新年问候 ]",
    content0 = "又是新的一年了。",
    reward0_count = 1,
    needLevel = 1,
    bQLoop = 0
  }
  return refs
end
