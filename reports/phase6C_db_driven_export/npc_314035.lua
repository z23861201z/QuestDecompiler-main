-- DB_DRIVEN_EXPORT
-- source: npc_314035.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_314035"
  local refs = {}
  refs[2122] = {
    name = "[ 让我睡一觉吧（1） ]",
    content0 = "你好，少侠",
    reward0_count = 0,
    needLevel = 107,
    bQLoop = 0
  }
  refs[2123] = {
    name = "[ 让我睡一觉吧（2） ]",
    content0 = "啊，少侠，你来得正好",
    reward0_count = 0,
    needLevel = 107,
    bQLoop = 0
  }
  refs[2124] = {
    name = "[ 让我睡一觉吧（3） ]",
    content0 = "少侠，一定要帮帮我",
    reward0_count = 1,
    needLevel = 107,
    bQLoop = 0
  }
  refs[2126] = {
    name = "[ 我想赏花 ]",
    content0 = "少侠，你知道冰花么？",
    reward0_count = 0,
    needLevel = 108,
    bQLoop = 0
  }
  refs[2127] = {
    name = "[ 给我冰花 ]",
    content0 = "我有些贪心了",
    reward0_count = 0,
    needLevel = 108,
    bQLoop = 0
  }
  refs[2128] = {
    name = "[ 花坛 ]",
    content0 = "我要用冰花做一个花坛",
    reward0_count = 1,
    needLevel = 108,
    bQLoop = 0
  }
  refs[2135] = {
    name = "[ 南男北女 ]",
    content0 = "少侠，你听说过南男北女么？",
    reward0_count = 1,
    needLevel = 109,
    bQLoop = 0
  }
  return refs
end
