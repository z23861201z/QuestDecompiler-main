-- DB_DRIVEN_EXPORT
-- source: npc_203006.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_203006"
  local refs = {}
  refs[1198] = {
    name = "[ 清野江钓具店的秘诀 ]",
    content0 = "大家都说钓鱼很666，其实钓鱼\n很有趣。怎么样？想知道开心钓鱼的\n方法吗？\u0000",
    reward0_count = 99,
    needLevel = 1,
    bQLoop = 0
  }
  return refs
end
