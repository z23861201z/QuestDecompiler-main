-- DB_DRIVEN_EXPORT
-- source: npc_341011.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_341011"
  local refs = {}
  refs[2908] = {
    name = "[ 夜盲症 ]",
    content0 = "亲，亲卫队莎易！执勤中，无异常！",
    reward0_count = 0,
    needLevel = 191,
    bQLoop = 0
  }
  return refs
end
