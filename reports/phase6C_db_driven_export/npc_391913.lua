-- DB_DRIVEN_EXPORT
-- source: npc_391913.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_391913"
  local refs = {}
  refs[805] = {
    name = "[ 巨大鬼怪-守护冥珠 ]",
    content0 = "你来得正好。巨大鬼怪此时正在冥珠城外围捣乱。大侠你作为冥珠城的主人，一定要去阻止它。",
    reward0_count = 0,
    needLevel = 60,
    bQLoop = 0
  }
  return refs
end
