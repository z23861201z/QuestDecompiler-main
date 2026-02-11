-- DB_DRIVEN_EXPORT
-- source: npc_341005.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_341005"
  local refs = {}
  refs[3731] = {
    name = "[ 击退怪物委托 ]",
    content0 = "(观察周边后小声说)过来一下。",
    reward0_count = 0,
    needLevel = 187,
    bQLoop = 0
  }
  return refs
end
