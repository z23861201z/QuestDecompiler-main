-- DB_DRIVEN_EXPORT
-- source: npc_324002.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_324002"
  local refs = {}
  refs[1513] = {
    name = "[ 修拉-驱逐背叛者 ]",
    content0 = "（牟永健不会说话。）",
    reward0_count = 0,
    needLevel = 1,
    bQLoop = 0
  }
  refs[1514] = {
    name = "[ 罗-驱逐背叛者 ]",
    content0 = "（牟永健不会说话。）",
    reward0_count = 0,
    needLevel = 1,
    bQLoop = 0
  }
  refs[1515] = {
    name = "[ 修拉-牟永健的遗言 ]",
    content0 = "听，听我说…当我第一眼看到被波浪带到这里的你，就感受到你体内惊人的潜在力。",
    reward0_count = 0,
    needLevel = 1,
    bQLoop = 0
  }
  refs[1516] = {
    name = "[ 罗-牟永健的遗言 ]",
    content0 = "听，听我说…当我第一眼看到被波浪带到这里的你，就感受到你体内惊人的潜在力。",
    reward0_count = 0,
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
  return refs
end
