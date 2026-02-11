-- DB_DRIVEN_EXPORT
-- source: npc_316008.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_316008"
  local refs = {}
  refs[292] = {
    name = "[ ? ? ]",
    content0 = "??...",
    reward0_count = 0,
    needLevel = 83,
    bQLoop = 0
  }
  return refs
end
