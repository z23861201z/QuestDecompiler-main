-- DB_DRIVEN_EXPORT
-- source: npc_241002.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_241002"
  local refs = {}
  refs[3787] = {
    name = "[ 图书馆工程 ]",
    content0 = "你好{0xFF99ff99}PLAYERNAME{END}。能帮帮我吗？",
    reward0_count = 0,
    needLevel = 193,
    bQLoop = 0
  }
  return refs
end
