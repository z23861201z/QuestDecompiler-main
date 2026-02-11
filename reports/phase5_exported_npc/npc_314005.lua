-- DB_DRIVEN_EXPORT
-- source: npc_314005.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_314005"
  local refs = {}
  refs[1] = {
    name = "[ ??? ??? ] [phaseD]",
    content0 = "phaseD line 1",
    reward0_count = 0,
    needLevel = 33,
    bQLoop = 0
  }
  return refs
end
