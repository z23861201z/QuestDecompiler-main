-- DB_DRIVEN_EXPORT
-- source: npc_323004.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_323004"
  local refs = {}
  refs[2185] = {
    name = "[ 公主的善心 ]",
    content0 = "勇士，勇士",
    reward0_count = 0,
    needLevel = 179,
    bQLoop = 0
  }
  refs[3648] = {
    name = "[ 每日祈祷的公主 ]",
    content0 = "来了啊~",
    reward0_count = 0,
    needLevel = 179,
    bQLoop = 0
  }
  return refs
end
