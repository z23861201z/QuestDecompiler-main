-- DB_DRIVEN_EXPORT
-- source: npc_314004.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_314004"
  local refs = {}
  refs[1131] = {
    name = "[ 老父的白内障 ]",
    content0 = "真是的…怎么办才好…啊！原来是{0xFF99ff99}PLAYERNAME{END}啊。请帮帮我吧。",
    reward0_count = 1,
    needLevel = 17,
    bQLoop = 0
  }
  return refs
end
