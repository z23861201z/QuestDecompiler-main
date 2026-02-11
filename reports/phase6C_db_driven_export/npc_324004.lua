-- DB_DRIVEN_EXPORT
-- source: npc_324004.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_324004"
  local refs = {}
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
  refs[1528] = {
    name = "[ 修拉-弄皱的命令书 ]",
    content0 = "（皱巴巴的命令书。其他长老紧急召唤我的师傅牟永健）",
    reward0_count = 0,
    needLevel = 1,
    bQLoop = 0
  }
  refs[1529] = {
    name = "[ 罗-弄皱的命令书 ]",
    content0 = "（皱巴巴的命令书。其他长老紧急召唤我的父亲牟永健。",
    reward0_count = 0,
    needLevel = 1,
    bQLoop = 0
  }
  refs[1911] = {
    name = "[ 兰德-他人的痕迹 ]",
    content0 = "兰德！你怎么了？",
    reward0_count = 0,
    needLevel = 60,
    bQLoop = 0
  }
  refs[1917] = {
    name = "[ 力魔-他人的痕迹 ]",
    content0 = "力魔！你怎么了？",
    reward0_count = 0,
    needLevel = 60,
    bQLoop = 0
  }
  return refs
end
