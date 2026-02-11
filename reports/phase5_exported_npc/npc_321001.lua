-- DB_DRIVEN_EXPORT
-- source: npc_321001.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_321001"
  local refs = {}
  refs[3657] = {
    name = "[ 守护南丰馆2 ]",
    content0 = "南丰馆还是在受到亡者的山谷的怪物们的威胁",
    reward0_count = 1,
    needLevel = 146,
    bQLoop = 0
  }
  return refs
end
