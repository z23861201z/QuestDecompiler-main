-- DB_DRIVEN_EXPORT
-- source: npc_391101.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_391101"
  local refs = {}
  refs[1208] = {
    name = "[ 为了清阴关！ ]",
    content0 = "推你的福现在可以再次进行贸易了。但是…。",
    reward0_count = 1,
    needLevel = 35,
    bQLoop = 0
  }
  return refs
end
