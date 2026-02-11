-- DB_DRIVEN_EXPORT
-- source: npc_214004.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_214004"
  local refs = {}
  refs[901] = {
    name = "{0xFFFFB4B4}[ 什么是装备修理？ ]{END}",
    content0 = "{0xFFFFFF00}修理方法{END}很简单。首先带着{0xFFFFFF00}缺损的道具{END}以及{0xFFFFFF00}和装备等级相符的加工石{END}",
    reward0_count = 0,
    needLevel = 0,
    bQLoop = 0
  }
  refs[902] = {
    name = "{0xFFFFB4B4}[ 如何知道装备等级？ ]{END}",
    content0 = "根据功力的不同{0xFFFFFF00}装备的等级{END}也不同，参照下表可知。",
    reward0_count = 0,
    needLevel = 0,
    bQLoop = 0
  }
  refs[903] = {
    name = "{0xFFFFB4B4}[ 装备修理成功时？ ]{END}",
    content0 = "成功完成修理后会像{0xFFFFFF00}鬼魂合成{END}一样，能力值得到提升。能力值最大提升到{0xFFFFFF00}封印符咒{END}的能力值。相应的剩余{0xFFFFFF00}合成次数会减少1次{END}。",
    reward0_count = 0,
    needLevel = 0,
    bQLoop = 0
  }
  refs[1085] = {
    name = "[ 清阴关的人气帅哥 ]",
    content0 = "呼~好热！大冬天的还汗流浃背啊！",
    reward0_count = 1,
    needLevel = 1,
    bQLoop = 0
  }
  refs[1093] = {
    name = "[ 清阴关人气帅哥的糖果 ]",
    content0 = "欢迎光临！嗯？那手势是什么意思？是要什么东西吗？",
    reward0_count = 1,
    needLevel = 1,
    bQLoop = 0
  }
  refs[1115] = {
    name = "[ 派报员的小聪明 ]",
    content0 = "刚好我有要给商人转达的简讯，一边送简讯一边见到人，没准能遇到少侠记得的人或记得少侠的人，不是吗？",
    reward0_count = 1,
    needLevel = 1,
    bQLoop = 0
  }
  refs[1118] = {
    name = "[ 金系系武器店的服务 ]",
    content0 = "年轻的朋友，过来一下。",
    reward0_count = 20,
    needLevel = 13,
    bQLoop = 0
  }
  refs[1136] = {
    name = "[ 正邪间的纠葛 ]",
    content0 = "啊！过来这边吧。上次真是谢谢了。忙得不可开交连声谢谢都来不及说呢。",
    reward0_count = 0,
    needLevel = 18,
    bQLoop = 0
  }
  return refs
end
