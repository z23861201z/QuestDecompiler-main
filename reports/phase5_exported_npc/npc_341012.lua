-- DB_DRIVEN_EXPORT
-- source: npc_341012.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_341012"
  local refs = {}
  refs[2715] = {
    name = "[ 击退锯齿飞鱼 ]",
    content0 = "嗯，我有事要麻烦你一下。",
    reward0_count = 0,
    needLevel = 186,
    bQLoop = 0
  }
  return refs
end
