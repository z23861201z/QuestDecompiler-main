-- DB_DRIVEN_EXPORT
-- source: npc_210001.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_210001"
  local refs = {}
  refs[918] = {
    name = "{0xFFFFB4B4}[ 什么是商店？ ]{END}",
    content0 = "一般分为卖符咒类的哞读册NPC、卖药水类的宝芝林NPC和卖装备类的武器店NPC",
    reward0_count = 0,
    needLevel = 0,
    bQLoop = 0
  }
  refs[919] = {
    name = "{0xFFFFB4B4}[ 出售物品 ]{END}",
    content0 = "点击“商店”键打开商店后，将想卖的物品从行囊内拖入商店即可出售。",
    reward0_count = 0,
    needLevel = 0,
    bQLoop = 0
  }
  refs[920] = {
    name = "{0xFFFFB4B4}[ 购买物品 ]{END}",
    content0 = "点击“商店”键打开商店后，双击或使用下端购买键都可以购买想要购买的物品。",
    reward0_count = 0,
    needLevel = 0,
    bQLoop = 0
  }
  return refs
end
