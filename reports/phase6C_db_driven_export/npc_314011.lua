-- DB_DRIVEN_EXPORT
-- source: npc_314011.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_314011"
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
  refs[42] = {
    name = "[ 扇-扇魂术 ]",
    content0 = "{0xFFFFFF00}扇魂术，装备扇后可以提升魔攻力的内功武功{END}。要学吗？",
    reward0_count = 0,
    needLevel = 1,
    bQLoop = 0
  }
  refs[43] = {
    name = "[ 杖-杖击术 ]",
    content0 = "{0xFFFFFF00}杖击术，手持杖时魔攻力上升的内功武功{END}。要学吗？",
    reward0_count = 0,
    needLevel = 1,
    bQLoop = 0
  }
  refs[44] = {
    name = "[ 杖-玄冰击 ]",
    content0 = "{0xFFFFFF00}玄冰击，装备杖后可以用冰箭攻击位于前方的敌人的武功{END}。要学吗？",
    reward0_count = 0,
    needLevel = 1,
    bQLoop = 0
  }
  refs[45] = {
    name = "[ 扇-火箭矢 ]",
    content0 = "{0xFFFFFF00}火箭矢，装备扇后可以用火箭矢攻击前方一定距离内的敌人的武功{END}。要学吗？",
    reward0_count = 0,
    needLevel = 1,
    bQLoop = 0
  }
  refs[46] = {
    name = "[ 共同-冰冻大地 ]",
    content0 = "{0xFFFFFF00}冰冻大地，用冰攻击一定距离内多数敌人的武功{END}。要学吗？",
    reward0_count = 0,
    needLevel = 17,
    bQLoop = 0
  }
  refs[47] = {
    name = "[ 共同-蒙蔽蚀眼 ]",
    content0 = "{0xFFFFFF00}蒙蔽蚀眼，在一定时间内阻碍敌人视线的武功{END}。要学吗？",
    reward0_count = 0,
    needLevel = 21,
    bQLoop = 0
  }
  refs[48] = {
    name = "[ 共同-震退 ]",
    content0 = "{0xFFFFFF00}震退，打击敌人并将其推出一定距离以外的武功{END}。要学吗？",
    reward0_count = 0,
    needLevel = 25,
    bQLoop = 0
  }
  refs[49] = {
    name = "[ 共同-瞬移术 ]",
    content0 = "{0xFFFFFF00}瞬移术，可以从当前位置移动到任意位置的武功{END}。要学吗？",
    reward0_count = 0,
    needLevel = 29,
    bQLoop = 0
  }
  refs[50] = {
    name = "[ 共同-防护加持 ]",
    content0 = "{0xFFFFFF00}防护加持，提升整队成员防御力的武功{END}。要学吗？",
    reward0_count = 0,
    needLevel = 33,
    bQLoop = 0
  }
  refs[51] = {
    name = "[ 共同-阴阳幻移 ]",
    content0 = "{0xFFFFFF00}阴阳幻移，消耗自己的鬼力来恢复体力的武功{END}。要学吗？",
    reward0_count = 0,
    needLevel = 37,
    bQLoop = 0
  }
  refs[279] = {
    name = "[注入鬼力（2）]",
    content0 = "那  已经往符咒注入了我的鬼力，拿着这个去见{0xFFFFFF00}道士转职NPC{END}吧。",
    reward0_count = 0,
    needLevel = 80,
    bQLoop = 0
  }
  refs[280] = {
    name = "[注入鬼力（3）]",
    content0 = "那，好了。拿着这个去见{0xFFFFFF00}刺客转职NPC{END}吧。",
    reward0_count = 0,
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
  refs[682] = {
    name = "[ 共同-鬼魔神功 ]",
    content0 = "{0xFFFFFF00}鬼魔神功是道士最高等级的防御武功。受到攻击后消耗一部分鬼力来代替体力消耗的武功{END}。要学吗？",
    reward0_count = 0,
    needLevel = 41,
    bQLoop = 0
  }
  refs[683] = {
    name = "[ 共同-爆裂功 ]",
    content0 = "{0xFFFFFF00}爆裂功是道士最高等级的攻击武功。要学吗？可以给前方敌人强力的爆发性攻击的武功{END}。要学吗？",
    reward0_count = 0,
    needLevel = 44,
    bQLoop = 0
  }
  return refs
end
