-- DB_DRIVEN_EXPORT
-- source: npc_901019.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_901019"
  local refs = {}
  refs[1091] = {
    name = "[ 花花公子的情人节 ]",
    content0 = "少侠，为了收集糖果忙得不可开交啊，暂时帮我个忙吧！",
    reward0_count = 0,
    needLevel = 1,
    bQLoop = 0
  }
  refs[1580] = {
    name = "[ 准备开学了！ ]",
    content0 = "少侠，你能帮我个忙吗？",
    reward0_count = 0,
    needLevel = 1,
    bQLoop = 0
  }
  return refs
end
