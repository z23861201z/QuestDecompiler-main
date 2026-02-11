-- DB_DRIVEN_EXPORT
-- source: npc_314061.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_314061"
  local refs = {}
  refs[1108] = {
    name = "[ 黑暗的力量-鬼魂者 ]",
    content0 = "话说回来。我刚发现你的时候你的样子很奇怪。神智昏迷，身体变成黑色了。咳…",
    reward0_count = 0,
    needLevel = 6,
    bQLoop = 0
  }
  refs[1109] = {
    name = "[ 小甜甜的花冠 ]",
    content0 = "知道吗？我们村来客人了！听大人们说那人失去记忆了…失忆真是太神奇了！\n…咦？你是谁？",
    reward0_count = 0,
    needLevel = 7,
    bQLoop = 0
  }
  return refs
end
