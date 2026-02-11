-- DB_DRIVEN_EXPORT
-- source: npc_314001.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_314001"
  local refs = {}
  refs[1121] = {
    name = "[ 名声(1) ]",
    content0 = "失去了记忆？可惜我也是第一次见到少侠。但是想推荐一个能找到认识少侠的人的方法。只要少侠出了名，不是自然就会有认识少侠的人出现了吗？",
    reward0_count = 1,
    needLevel = 14,
    bQLoop = 0
  }
  refs[1130] = {
    name = "[ 押镖准备 ]",
    content0 = "现在不像以前，怪物数量增多了不少，押镖的路上很不安全。所以需要更彻底的准备。",
    reward0_count = 0,
    needLevel = 16,
    bQLoop = 0
  }
  refs[1145] = {
    name = "[ 不明身份的袭击者 ]",
    content0 = "最近去往冥珠城的押镖之路每次都被不知名的敌人袭击。在这样下去，连清阴关的生活必需品也不够。",
    reward0_count = 20,
    needLevel = 21,
    bQLoop = 0
  }
  refs[1183] = {
    name = "[ 艰难的人们 ]",
    content0 = "听说{0xFF99ff99}PLAYERNAME{END}为了清阴关做了件大事。但现在还是有很艰难的人们啊。",
    reward0_count = 1,
    needLevel = 36,
    bQLoop = 0
  }
  return refs
end
