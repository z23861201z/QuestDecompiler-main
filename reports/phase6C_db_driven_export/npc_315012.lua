-- DB_DRIVEN_EXPORT
-- source: npc_315012.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_315012"
  local refs = {}
  refs[107] = {
    name = "[ 龙林山隐藏的地区 ]",
    content0 = "呵呵呵呵呵呵…啊！恩恩…什么事啊？",
    reward0_count = 0,
    needLevel = 54,
    bQLoop = 0
  }
  refs[109] = {
    name = "[ 丢失的仙女衣 ]",
    content0 = "别害怕…今天我不会让你去太远的。还记得上次见过的{0xFFFFFF00}樵夫{END}吗？你去他那里把{0xFFFFFF00}仙女衣{END}拿来吧。",
    reward0_count = 0,
    needLevel = 55,
    bQLoop = 0
  }
  refs[1247] = {
    name = "[ 鹿的指点 ]",
    content0 = "东泼肉的行踪吗？很遗憾，我也不是很清楚。但是…。",
    reward0_count = 0,
    needLevel = 55,
    bQLoop = 0
  }
  refs[1248] = {
    name = "[ 土地公的法力 ]",
    content0 = "你有什么事情打扰我重要的时刻…，不是，应该是我深思的时间？",
    reward0_count = 0,
    needLevel = 56,
    bQLoop = 0
  }
  refs[1249] = {
    name = "[ 土地公的法力2 ]",
    content0 = "看看啊…。好像东泼肉之前说过要去哪儿的…。为了让自己变得更强大要去哪里来着？",
    reward0_count = 0,
    needLevel = 57,
    bQLoop = 0
  }
  refs[1250] = {
    name = "[ 不容易的事 ]",
    content0 = "龙林派师兄可以说是现武林最具名望的人物之一。就是想见一面也很难。",
    reward0_count = 1,
    needLevel = 57,
    bQLoop = 0
  }
  return refs
end
