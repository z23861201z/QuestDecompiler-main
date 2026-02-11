-- DB_DRIVEN_EXPORT
-- source: npc_324001.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_324001"
  local refs = {}
  refs[1507] = {
    name = "[ 修拉-征讨异教徒 ]",
    content0 = "睡午觉了？",
    reward0_count = 15,
    needLevel = 1,
    bQLoop = 0
  }
  refs[1508] = {
    name = "[ 罗-征讨异教徒 ]",
    content0 = "睡午觉了？",
    reward0_count = 15,
    needLevel = 1,
    bQLoop = 0
  }
  refs[1509] = {
    name = "[ 修拉-魔教的正义 ]",
    content0 = "看你的神色不太对，发生什么事情了？",
    reward0_count = 15,
    needLevel = 1,
    bQLoop = 0
  }
  refs[1510] = {
    name = "[ 罗-魔教的正义 ]",
    content0 = "看你的神色不太对，发生什么事情了？",
    reward0_count = 15,
    needLevel = 1,
    bQLoop = 0
  }
  refs[1511] = {
    name = "[ 修拉-异教徒的宝物 ]",
    content0 = "事实上我们来这里的目的除了讨伐异教徒以外，还要得到他们的宝物-深潭水晶。",
    reward0_count = 15,
    needLevel = 1,
    bQLoop = 0
  }
  refs[1512] = {
    name = "[ 罗-异教徒的宝物 ]",
    content0 = "事实上我们来这里的目的除了讨伐异教徒以外，还要得到他们的宝物-深潭水晶。",
    reward0_count = 15,
    needLevel = 1,
    bQLoop = 0
  }
  refs[2609] = {
    name = "[ 魔布加-神殿探索 ]",
    content0 = "到沉默神殿了。今天非常谢谢你跟我一起来。",
    reward0_count = 15,
    needLevel = 60,
    bQLoop = 0
  }
  refs[2610] = {
    name = "[ 魔布加-往更深处探索 ]",
    content0 = "得去更深处看看才行啊~",
    reward0_count = 15,
    needLevel = 60,
    bQLoop = 0
  }
  refs[2611] = {
    name = "[ 魔布加-深处的深渊 ]",
    content0 = "听说教主在找你。你去更深处调查后就回去吧。",
    reward0_count = 15,
    needLevel = 60,
    bQLoop = 0
  }
  refs[2615] = {
    name = "[ 耶单-神殿探索 ]",
    content0 = "到沉默神殿了。今天非常谢谢你跟我一起来。",
    reward0_count = 15,
    needLevel = 60,
    bQLoop = 0
  }
  refs[2616] = {
    name = "[ 耶单-往更深处探索 ]",
    content0 = "得去更深处看看才行啊~",
    reward0_count = 15,
    needLevel = 60,
    bQLoop = 0
  }
  refs[2617] = {
    name = "[ 耶单-深处的深渊 ]",
    content0 = "听说教主在找你。你去更深处调查后就回去吧。",
    reward0_count = 15,
    needLevel = 60,
    bQLoop = 0
  }
  return refs
end
