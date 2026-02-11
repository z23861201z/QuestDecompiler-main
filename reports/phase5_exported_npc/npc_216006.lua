-- DB_DRIVEN_EXPORT
-- source: npc_216006.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_216006"
  local refs = {}
  refs[2125] = {
    name = "[ 禽流感？ ]",
    content0 = "来得正好，我有事情要拜托你",
    reward0_count = 0,
    needLevel = 107,
    bQLoop = 0
  }
  refs[2129] = {
    name = "[ 慰灵节 ]",
    content0 = "知道雪魔女么？",
    reward0_count = 1,
    needLevel = 108,
    bQLoop = 0
  }
  return refs
end
