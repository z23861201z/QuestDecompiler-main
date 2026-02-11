-- DB_DRIVEN_EXPORT
-- source: npc_301002.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_301002"
  local refs = {}
  refs[1078] = {
    name = "[ 分发新春娃娃2 ]",
    content0 = "幸亏有你帮忙，现在兔娃娃制作的很顺利。我给你的娃娃都收好了吗？",
    reward0_count = 1,
    needLevel = 41,
    bQLoop = 0
  }
  return refs
end
