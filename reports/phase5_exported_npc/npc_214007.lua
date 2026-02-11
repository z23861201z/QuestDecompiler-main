-- DB_DRIVEN_EXPORT
-- source: npc_214007.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_214007"
  local refs = {}
  refs[932] = {
    name = "{0xFFFFB4B4}[ 交换牌是什么？ ]{END}",
    content0 = "交换牌很小。分为木魂牌、蓝魂牌、银魂牌、金魂牌4种。特别是银魂牌和金魂牌非常珍贵，不容易得到。",
    reward0_count = 0,
    needLevel = 0,
    bQLoop = 0
  }
  refs[933] = {
    name = "{0xFFFFB4B4}[ 强灵牌是什么？ ]{END}",
    content0 = "强灵牌吗？",
    reward0_count = 0,
    needLevel = 0,
    bQLoop = 0
  }
  refs[934] = {
    name = "{0xFFFFB4B4}[ 怎样使用强灵牌？ ]{END}",
    content0 = "强灵牌的使用方法吗？",
    reward0_count = 0,
    needLevel = 0,
    bQLoop = 0
  }
  refs[935] = {
    name = "{0xFFFFB4B4}[ 如何进行强灵牌的合成？ ]{END}",
    content0 = "你知道如何合并封印在强灵牌中的恶鬼们的力量吗？",
    reward0_count = 0,
    needLevel = 0,
    bQLoop = 0
  }
  refs[936] = {
    name = "{0xFFFFB4B4}[ 强灵牌的牌属性是什么？ ]{END}",
    content0 = "你知道强灵牌有属性吗？你仔细看看牌。牌上端的圆形上面应该刻着属性。",
    reward0_count = 0,
    needLevel = 0,
    bQLoop = 0
  }
  return refs
end
