-- DB_DRIVEN_EXPORT
-- source: npc_323003.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_323003"
  local refs = {}
  refs[2599] = {
    name = "[ 人气满分真英招皮 ]",
    content0 = "要想再提高我的地位，必须得提高我在王室里的人气。",
    reward0_count = 0,
    needLevel = 184,
    bQLoop = 0
  }
  return refs
end
