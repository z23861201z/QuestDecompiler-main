-- DB_DRIVEN_EXPORT
-- source: npc_314014.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_314014"
  local refs = {}
  refs[3712] = {
    name = "[ 为了增加神通 ]",
    content0 = "马上又是新年了。能帮我一起做件好事吗？",
    reward0_count = 1,
    needLevel = 1,
    bQLoop = 0
  }
  return refs
end
