-- DB_DRIVEN_EXPORT
-- source: npc_341007.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_341007"
  local refs = {}
  refs[2914] = {
    name = "[ 燃烧的艺术魂 ]",
    content0 = "那边路过的那位，你就是有名的{0xFF99ff99}PLAYERNAME{END}吗？",
    reward0_count = 0,
    needLevel = 193,
    bQLoop = 0
  }
  return refs
end
