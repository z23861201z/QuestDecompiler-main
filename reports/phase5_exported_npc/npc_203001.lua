-- DB_DRIVEN_EXPORT
-- source: npc_203001.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_203001"
  local refs = {}
  refs[1190] = {
    name = "[ 什么是采矿？ ]",
    content0 = "你也是来采矿的吗？那能接受我一个请求吗？",
    reward0_count = 99,
    needLevel = 35,
    bQLoop = 0
  }
  refs[1191] = {
    name = "[ 什么是矿物冶炼？ ]",
    content0 = "你知道提炼矿物的方法吗？",
    reward0_count = 1,
    needLevel = 35,
    bQLoop = 0
  }
  refs[1192] = {
    name = "[ 什么是装备强化？ ]",
    content0 = "有没有强化装备的意向？",
    reward0_count = 0,
    needLevel = 35,
    bQLoop = 0
  }
  refs[1193] = {
    name = "[ 什么是饰品强化？ ]",
    content0 = "有没有强化首饰的想法？",
    reward0_count = 0,
    needLevel = 35,
    bQLoop = 0
  }
  return refs
end
