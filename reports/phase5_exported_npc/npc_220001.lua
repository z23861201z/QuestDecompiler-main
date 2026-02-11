-- DB_DRIVEN_EXPORT
-- source: npc_220001.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_220001"
  local refs = {}
  refs[1012] = {
    name = "[传递货郎的消息]",
    content0 = "我能再拜托你件事情吗？",
    reward0_count = 0,
    needLevel = 140,
    bQLoop = 0
  }
  refs[1013] = {
    name = "[愧於人的告白]",
    content0 = "让我来告诉你个秘密",
    reward0_count = 0,
    needLevel = 137,
    bQLoop = 0
  }
  refs[1014] = {
    name = "[项链装饰]",
    content0 = "谢谢你上次帮我收集的圆形骨块",
    reward0_count = 0,
    needLevel = 138,
    bQLoop = 0
  }
  refs[1015] = {
    name = "[ 愧於人的请求 ]",
    content0 = "你对飞行怪物{0xFFFFFF00}邪蜂怪{END}有所了解吗？",
    reward0_count = 0,
    needLevel = 142,
    bQLoop = 0
  }
  refs[2461] = {
    name = "[ 蓖林按儡狼 林刮甸2 ]",
    content0 = "唱绰.. 公均..",
    reward0_count = 1,
    needLevel = 141,
    bQLoop = 0
  }
  refs[2463] = {
    name = "[ 撤捞 公挤嚼聪促 ]",
    content0 = "唱.. 唱绰.. 撤捞 滴菲家.",
    reward0_count = 1,
    needLevel = 141,
    bQLoop = 0
  }
  refs[2469] = {
    name = "[ 鲍绢牢狼 夸没 ]",
    content0 = "梆.. 栋抄促绊 甸菌促.",
    reward0_count = 1,
    needLevel = 143,
    bQLoop = 0
  }
  refs[2470] = {
    name = "[ 鲍绢牢狼 捞具扁 ]",
    content0 = "绊缚.. 促. 郴啊.. 吝夸茄 巴阑 舅妨林摆促..",
    reward0_count = 1,
    needLevel = 143,
    bQLoop = 0
  }
  refs[2568] = {
    name = "[ 玄境-寻找龟神的灵魂7 ]",
    content0 = "这是最后一次了。收集{0xFFFFFF00}150个彩色虫符咒{END}和{0xFFFFFF00}150个燃烧的铠甲残片{END}回来吧",
    reward0_count = 0,
    needLevel = 160,
    bQLoop = 0
  }
  refs[2569] = {
    name = "[ 玄境-先发制人 ]",
    content0 = "出..出大事了..",
    reward0_count = 0,
    needLevel = 160,
    bQLoop = 0
  }
  refs[2570] = {
    name = "[ 玄境-鼠偷盗 ]",
    content0 = "谢..谢..击退..了..邪龙..",
    reward0_count = 0,
    needLevel = 160,
    bQLoop = 0
  }
  refs[3676] = {
    name = "[ 对客栈虎视眈眈的怪物：复头龟（每日） ]",
    content0 = "我有个请求...",
    reward0_count = 0,
    needLevel = 145,
    bQLoop = 0
  }
  refs[3677] = {
    name = "[ 对客栈虎视眈眈的怪物：污染怪（每日） ]",
    content0 = "我有个请求...",
    reward0_count = 0,
    needLevel = 146,
    bQLoop = 0
  }
  return refs
end
