-- DB_DRIVEN_EXPORT
-- source: npc_314010.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_314010"
  local refs = {}
  refs[16] = {
    name = "[ 武士转职 ]",
    content0 = "??? ?? ????",
    reward0_count = 1,
    needLevel = 1,
    bQLoop = 0
  }
  refs[19] = {
    name = "[ 刺客转职 ]",
    content0 = "??? ?? ?????",
    reward0_count = 1,
    needLevel = 1,
    bQLoop = 0
  }
  refs[21] = {
    name = "[ 道士转职 ]",
    content0 = "??? ?? ?????",
    reward0_count = 1,
    needLevel = 1,
    bQLoop = 0
  }
  refs[32] = {
    name = "[ 手套-鬼手术 ]",
    content0 = "{0xFFFFFF00}鬼手术，装备暗器时可以自动提升射程和攻击力的内功武功{END}。要学吗？",
    reward0_count = 0,
    needLevel = 1,
    bQLoop = 0
  }
  refs[33] = {
    name = "[ 爪-利爪术 ]",
    content0 = "{0xFFFFFF00}利爪术，装备爪后攻击力自动上升的内功武功{END}。要学吗？",
    reward0_count = 0,
    needLevel = 1,
    bQLoop = 0
  }
  refs[34] = {
    name = "[ 手套-索命贯击 ]",
    content0 = "索命贯击，装备暗器后能给前方敌人贯穿攻击的武功{END}。要学吗？",
    reward0_count = 0,
    needLevel = 1,
    bQLoop = 0
  }
  refs[35] = {
    name = "[ 爪-崩击爪 ]",
    content0 = "{0xFFFFFF00}崩击爪，装备爪后能加倍给敌人攻击的武功{END}。要学吗？",
    reward0_count = 0,
    needLevel = 1,
    bQLoop = 0
  }
  refs[36] = {
    name = "[ 手套-双镖飞击 ]",
    content0 = "{0xFFFFFF00}双镖飞击，装备暗器后可以发射2个暗器的武功{END}。要学吗？",
    reward0_count = 0,
    needLevel = 18,
    bQLoop = 0
  }
  refs[37] = {
    name = "[ 爪-疾刺爪 ]",
    content0 = "{0xFFFFFF00}疾刺爪，装备爪武器后可以快速接近并攻击的武功{END}。要学吗？",
    reward0_count = 0,
    needLevel = 18,
    bQLoop = 0
  }
  refs[38] = {
    name = "[ 共同-喂毒术 ]",
    content0 = "{0xFFFFFF00}喂毒术，给自己的武器上擦毒后进行攻击的武功{END}。要学吗？",
    reward0_count = 0,
    needLevel = 23,
    bQLoop = 0
  }
  refs[39] = {
    name = "[ 共同-解毒术 ]",
    content0 = "{0xFFFFFF00}解毒术，中毒时可以解毒的武功{END}。要学吗？",
    reward0_count = 0,
    needLevel = 28,
    bQLoop = 0
  }
  refs[41] = {
    name = "[ 共同-闪击技 ]",
    content0 = "{0xFFFFFF00}闪击技，可以提升回避对手攻击几率的武功{END}。要学吗？",
    reward0_count = 0,
    needLevel = 38,
    bQLoop = 0
  }
  refs[138] = {
    name = "[ 太和老君的第12个弟子 ]",
    content0 = "??? ???? ??? ?? ??????",
    reward0_count = 0,
    needLevel = 15,
    bQLoop = 0
  }
  refs[280] = {
    name = "[注入鬼力（3）]",
    content0 = "那，好了。拿着这个去见{0xFFFFFF00}刺客转职NPC{END}吧。",
    reward0_count = 0,
    needLevel = 80,
    bQLoop = 0
  }
  refs[281] = {
    name = "[注入鬼力（4）]",
    content0 = "那 ，拿着吧。对了！一定要注意了~去击退血玉髓的时候一定要跟可以帮助自己的人组队进入！那去见见{0xFFFFFF00}偷笔怪盗{END}吧。",
    reward0_count = 1,
    needLevel = 80,
    bQLoop = 0
  }
  refs[351] = {
    name = "[ 力士转职 ]",
    content0 = "??? ?? ??!?",
    reward0_count = 1,
    needLevel = 1,
    bQLoop = 0
  }
  refs[612] = {
    name = "[ 射手转职 ]",
    content0 = "??? ?? ??????",
    reward0_count = 1,
    needLevel = 1,
    bQLoop = 0
  }
  refs[680] = {
    name = "[ 爪-风云雷格 ]",
    content0 = "{0xFFFFFF00}风云雷格，是用爪刺客的最高等级武功{END}。可以瞬间移到对手后方进行攻击。要学吗？",
    reward0_count = 0,
    needLevel = 43,
    bQLoop = 0
  }
  refs[681] = {
    name = "[ 手套-风云投雷 ]",
    content0 = "{0xFFFFFF00}风云投雷，是用暗器刺客的最高等级武功{END}。可以瞬间移到对手后方并投掷暗器。要学吗？",
    reward0_count = 0,
    needLevel = 43,
    bQLoop = 0
  }
  return refs
end
