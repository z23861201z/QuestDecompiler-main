-- DB_DRIVEN_EXPORT
-- source: npc_391072.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_391072"
  local refs = {}
  refs[855] = {
    name = "[ 霸主地狱-逃亡者猪大长 ]",
    content0 = "喂，你知道吗？最近白血鬼谷林里出现了黄泉裂缝，鬼舞蛇魔眼找我帮忙。所以我去帮他们封印了。",
    reward0_count = 0,
    needLevel = 20,
    bQLoop = 0
  }
  return refs
end
