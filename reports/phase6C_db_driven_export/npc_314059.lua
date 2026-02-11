-- DB_DRIVEN_EXPORT
-- source: npc_314059.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_314059"
  local refs = {}
  refs[1105] = {
    name = "[ 小甜甜妈妈的请求1 ]",
    content0 = "说了这么多话，好累啊。我要休息了。嗯…你也不要闲着，干点什么怎么样？",
    reward0_count = 0,
    needLevel = 4,
    bQLoop = 0
  }
  refs[1106] = {
    name = "[ 小甜甜妈妈的请求2 ]",
    content0 = "是训练所长广柱将昏迷中的你背到长老那里，你见过他了吗？",
    reward0_count = 20,
    needLevel = 4,
    bQLoop = 0
  }
  refs[1107] = {
    name = "[ 变强（魂） ]",
    content0 = "你还在那里吗？该不是你想变得像我这样强吧？看来你是想知道我强大的秘密啊。吼吼。",
    reward0_count = 1,
    needLevel = 5,
    bQLoop = 0
  }
  refs[1108] = {
    name = "[ 黑暗的力量-鬼魂者 ]",
    content0 = "话说回来。我刚发现你的时候你的样子很奇怪。神智昏迷，身体变成黑色了。咳…",
    reward0_count = 0,
    needLevel = 6,
    bQLoop = 0
  }
  refs[1110] = {
    name = "[ 修栅栏 ]",
    content0 = "哎呦，怎么这么晚？从刚才开始小菜头就跑到村子来闹了。",
    reward0_count = 0,
    needLevel = 8,
    bQLoop = 0
  }
  refs[1111] = {
    name = "[ 广柱的健康状态 ]",
    content0 = "咳，咳咳！这么快就来了？托我的福你现在变得又聪明又敏捷呢。",
    reward0_count = 0,
    needLevel = 9,
    bQLoop = 0
  }
  refs[1201] = {
    name = "[ 广柱的事情 ]",
    content0 = "训练所长广柱的身体不知如何了…话说回来训练所长广柱好像在找{0xFF99ff99}PLAYERNAME{END}。在他跌到之前快点去看看吧。",
    reward0_count = 1,
    needLevel = 9,
    bQLoop = 0
  }
  refs[1202] = {
    name = "[ 长老的想法 ]",
    content0 = "长老好像在找你…好像知道找回你记忆的方法了。咳咳。咳咳。",
    reward0_count = 1,
    needLevel = 1,
    bQLoop = 0
  }
  refs[1466] = {
    name = "[ 青出于蓝啊 ]",
    content0 = "好久不见。看到你成长的样子，我无比高兴啊。作为我的弟子，能成长成这样，真是青出于蓝啊",
    reward0_count = 1,
    needLevel = 170,
    bQLoop = 0
  }
  return refs
end
