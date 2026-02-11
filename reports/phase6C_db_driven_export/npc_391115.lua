-- DB_DRIVEN_EXPORT
-- source: npc_391115.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_391115"
  local refs = {}
  refs[2651] = {
    name = "[ 王命：讨伐古龙 ]",
    content0 = "卧病在床的国王陛下亲自下达了王命。",
    reward0_count = 1,
    needLevel = 160,
    bQLoop = 0
  }
  refs[3721] = {
    name = "[ 王命：讨伐古龙(每日) ]",
    content0 = "我需要你的帮助。",
    reward0_count = 5,
    needLevel = 1,
    bQLoop = 0
  }
  return refs
end
