-- DB_DRIVEN_EXPORT
-- source: npc_391109.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_391109"
  local refs = {}
  refs[878] = {
    name = "[ 安哥拉营地登场 ]",
    content0 = "啊啊！还有一件事！在你调查周边的时候，近卫兵可心传话说发现了怪物密集的营地",
    reward0_count = 1,
    needLevel = 160,
    bQLoop = 0
  }
  return refs
end
