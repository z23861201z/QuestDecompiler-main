-- DB_DRIVEN_EXPORT
-- source: npc_314012.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_314012"
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
  refs[351] = {
    name = "[ 力士转职 ]",
    content0 = "??? ?? ??!?",
    reward0_count = 1,
    needLevel = 1,
    bQLoop = 0
  }
  refs[352] = {
    name = "[ 斧-狂烈符 ]",
    content0 = "{0xFFFFFF00}狂烈符，装备斧时可以使攻击力自动上升的内功武功{END}。要学吗？",
    reward0_count = 0,
    needLevel = 1,
    bQLoop = 0
  }
  refs[353] = {
    name = "[ 轮-强轮 ]",
    content0 = "{0xFFFFFF00}强轮，装备轮时可以使攻击力自动上升的内功武功{END}。要学吗？",
    reward0_count = 0,
    needLevel = 1,
    bQLoop = 0
  }
  refs[354] = {
    name = "[ 斧-太斧出击 ]",
    content0 = "{0xFFFFFF00}太斧出击，连带斧子的重量一起，强力攻击的武功{END}。要学吗？",
    reward0_count = 0,
    needLevel = 1,
    bQLoop = 0
  }
  refs[355] = {
    name = "[ 轮-横轮抛 ]",
    content0 = "{0xFFFFFF00}横轮抛，利用肌肉的爆发力，以极快的速度瞬间连挥3次的武功{END}。要学吗？",
    reward0_count = 0,
    needLevel = 1,
    bQLoop = 0
  }
  refs[356] = {
    name = "[ 斧-斧头斩 ]",
    content0 = "{0xFFFFFF00}斧头斩，利用斧头的侧面，像挥舞锤头一样攻击的武功{END}。要学吗？",
    reward0_count = 0,
    needLevel = 18,
    bQLoop = 0
  }
  refs[357] = {
    name = "[ 轮-天轮仙器 ]",
    content0 = "{0xFFFFFF00}天轮仙器，使用强力挥舞天轮，给对手伤害的武功{END}。要学吗？",
    reward0_count = 0,
    needLevel = 18,
    bQLoop = 0
  }
  refs[358] = {
    name = "[ 共同-碧波雷 ]",
    content0 = "{0xFFFFFF00}碧波雷，用强气包围身体，受到攻击时可以将一定比例的伤害吸收为鬼力的武功{END}。要学吗？",
    reward0_count = 0,
    needLevel = 23,
    bQLoop = 0
  }
  refs[359] = {
    name = "[ 共同-真功护体 ]",
    content0 = "{0xFFFFFF00}真功护体，原地变成一个柱子，拥有铁壁般的防御力的武功{END}。不过无法使用其他武功。要学吗？",
    reward0_count = 0,
    needLevel = 28,
    bQLoop = 0
  }
  refs[360] = {
    name = "[ 共同-无限真气 ]",
    content0 = "{0xFFFFFF00}无限真气，接受月亮的气息，慢慢治疗外伤的恢复武功{END}。要学吗？",
    reward0_count = 0,
    needLevel = 33,
    bQLoop = 0
  }
  refs[361] = {
    name = "[ 共同-猛龙胜出 ]",
    content0 = "{0xFFFFFF00}猛龙胜出，劲力被呼唤出一次后就会像老虎一样勇猛起来的武功{END}。缺点是容易疲倦…要学吗？",
    reward0_count = 0,
    needLevel = 38,
    bQLoop = 0
  }
  refs[362] = {
    name = "[ 太和老君的第12个弟子 ]",
    content0 = "? ???? ??? ?? ??? ?????",
    reward0_count = 0,
    needLevel = 15,
    bQLoop = 0
  }
  refs[612] = {
    name = "[ 射手转职 ]",
    content0 = "??? ?? ??????",
    reward0_count = 1,
    needLevel = 1,
    bQLoop = 0
  }
  refs[684] = {
    name = "[ 斧-灭绝拳 ]",
    content0 = "{0xFFFFFF00}灭绝拳是用斧力士的最高等级武功。瞬间跳起然后向地面砍去的武功{END}。要学吗？",
    reward0_count = 0,
    needLevel = 43,
    bQLoop = 0
  }
  refs[685] = {
    name = "[ 轮-分光无痕 ]",
    content0 = "{0xFFFFFF00}分光无痕是用轮力士的最高等级武功{END}。高度旋转轮，只要对手擦过，便会受致命伤的武功。要学吗？",
    reward0_count = 0,
    needLevel = 43,
    bQLoop = 0
  }
  refs[1418] = {
    name = "[ 6?? ?? ??! ]",
    content0 = "?? 6??? ???? ???? ??? ??? ???? ??. ?? ??? ?? ? ?? ????.",
    reward0_count = 1,
    needLevel = 1,
    bQLoop = 0
  }
  return refs
end
