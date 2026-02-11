-- DB_DRIVEN_EXPORT
-- source: npc_391110.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_391110"
  local refs = {}
  refs[2162] = {
    name = "[ 四天王碑的精气 ]",
    content0 = "我已经跟四天王碑说好了。四天王碑说不知道为什么这附近的妖怪突然聚集到了他身边，如果有人能帮他的话就把自己的精气当成谢礼送出",
    reward0_count = 1,
    needLevel = 110,
    bQLoop = 0
  }
  refs[3623] = {
    name = "[ 第一寺地下-千手妖女的手下们 ]",
    content0 = "听说最近第一寺附近出现了很多千手妖女的手下们…",
    reward0_count = 0,
    needLevel = 110,
    bQLoop = 0
  }
  return refs
end
