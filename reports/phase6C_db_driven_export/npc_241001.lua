-- DB_DRIVEN_EXPORT
-- source: npc_241001.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_241001"
  local refs = {}
  refs[3736] = {
    name = "[ 研究材料 ]",
    content0 = "下层居民中流浪者很多，所以生病的患者也很多。特别是高热和营养不良引发的症状居多。",
    reward0_count = 2,
    needLevel = 187,
    bQLoop = 0
  }
  return refs
end
