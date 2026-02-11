-- DB_DRIVEN_EXPORT
-- source: npc_300133.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_300133"
  local refs = {}
  refs[894] = {
    name = "[ 7周年赛跑！ ]",
    content0 = "?? 7??? ???? ??? 7??????? ??????.",
    reward0_count = 1,
    needLevel = 1,
    bQLoop = 0
  }
  return refs
end
