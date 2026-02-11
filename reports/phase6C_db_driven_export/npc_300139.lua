-- DB_DRIVEN_EXPORT
-- source: npc_300139.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_300139"
  local refs = {}
  refs[3706] = {
    name = "[ 准备食材 ]",
    content0 = "（跟大目仔爸爸对视。）",
    reward0_count = 1,
    needLevel = 1,
    bQLoop = 0
  }
  return refs
end
