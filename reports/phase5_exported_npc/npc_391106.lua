-- DB_DRIVEN_EXPORT
-- source: npc_391106.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_391106"
  local refs = {}
  refs[870] = {
    name = "[ 皲裂地狱-暴走的火车轮怪 ]",
    content0 = "这次皲裂好像非常严重！好像有人用巨大的结界在阻挡，但是怪物依旧存在！",
    reward0_count = 1,
    needLevel = 130,
    bQLoop = 0
  }
  refs[1435] = {
    name = "[化境-结界的位置]",
    content0 = "要找到结界的位置？你不说我也已经差人把疯癫的老人抓起来搜查了",
    reward0_count = 1,
    needLevel = 130,
    bQLoop = 0
  }
  return refs
end
