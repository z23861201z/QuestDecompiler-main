-- DB_DRIVEN_EXPORT
-- source: npc_391012.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_391012"
  local refs = {}
  refs[802] = {
    name = "[ 怪林地狱-磷火的盛宴 ]",
    content0 = "我的记忆力不是很好，你是不是说过要拯救百姓于水火之中？那么我给你分配一个任务。对你来说不会很难。",
    reward0_count = 1,
    needLevel = 30,
    bQLoop = 0
  }
  return refs
end
