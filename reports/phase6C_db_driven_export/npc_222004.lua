-- DB_DRIVEN_EXPORT
-- source: npc_222004.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_222004"
  local refs = {}
  refs[1051] = {
    name = "[ 蟹钳的用法 ]",
    content0 = "制作武器的时候是我最幸福的时刻。只要有了材料就可以完成最强的武器了",
    reward0_count = 1,
    needLevel = 158,
    bQLoop = 0
  }
  refs[1057] = {
    name = "[ 吕林城制造武器 ]",
    content0 = "喂~喂~等会儿~",
    reward0_count = 5,
    needLevel = 159,
    bQLoop = 0
  }
  refs[2665] = {
    name = "[ 急需的药材3-1 ]",
    content0 = "现在需要最后的药材。但是那个药材我这儿没有。",
    reward0_count = 0,
    needLevel = 161,
    bQLoop = 0
  }
  refs[2666] = {
    name = "[ 急需的药材3-2 ]",
    content0 = "没有事就回去吧。",
    reward0_count = 0,
    needLevel = 161,
    bQLoop = 0
  }
  refs[2667] = {
    name = "[ 急需的药材3-3 ]",
    content0 = "挺厉害啊，这么快就击退了太极蜈蚣…",
    reward0_count = 0,
    needLevel = 161,
    bQLoop = 0
  }
  refs[2675] = {
    name = "[ 为父亲报仇：太极蜈蚣1 ]",
    content0 = "武器不错啊。",
    reward0_count = 0,
    needLevel = 161,
    bQLoop = 0
  }
  refs[2676] = {
    name = "[ 为父亲报仇：太极蜈蚣2 ]",
    content0 = "能在拜托你一次吗？",
    reward0_count = 0,
    needLevel = 162,
    bQLoop = 0
  }
  return refs
end
