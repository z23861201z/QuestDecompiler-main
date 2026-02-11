-- DB_DRIVEN_EXPORT
-- source: npc_901026.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_901026"
  local refs = {}
  refs[106] = {
    name = "[ ??? ???? ]",
    content0 = "?? {0xFF99FF99}PLAYERNAME{END}? ???? ????? ??? ?? ??? ?? ???. ??..",
    reward0_count = 0,
    needLevel = 53,
    bQLoop = 0
  }
  return refs
end
