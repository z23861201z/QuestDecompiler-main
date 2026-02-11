-- DB_DRIVEN_EXPORT
-- source: npc_316006.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_316006"
  local refs = {}
  refs[284] = {
    name = "[ ?????(1) ]",
    content0 = "?? ?? ? ???? ?? {0xFFFFFF00}???? ??{END}? ?? ????",
    reward0_count = 0,
    needLevel = 90,
    bQLoop = 0
  }
  refs[286] = {
    name = "[ ???? ??(1) ]",
    content0 = "???… ?????…?",
    reward0_count = 0,
    needLevel = 90,
    bQLoop = 0
  }
  refs[287] = {
    name = "[ ???? ??(2) ]",
    content0 = "?? ??? ????? ???. ??? 2?? ??? ?? ??... ??.. ",
    reward0_count = 0,
    needLevel = 90,
    bQLoop = 0
  }
  refs[288] = {
    name = "[ ???? ??(3) ]",
    content0 = "???...? ?? ??? ?? ??? ???. ?? ?? ?? ??? ????",
    reward0_count = 1,
    needLevel = 90,
    bQLoop = 0
  }
  refs[290] = {
    name = "[ ? ?(2) ]",
    content0 = "? ? ??! ?? ??? {0xFFFFFF00}??????{END}?? ????.",
    reward0_count = 0,
    needLevel = 90,
    bQLoop = 0
  }
  refs[483] = {
    name = "[ ???? ?? ]",
    content0 = "??..? ?? ?? ???? ?? ?? ??? 2??? ??? ??????… ???? ??? ???.. ,..",
    reward0_count = 1,
    needLevel = 98,
    bQLoop = 0
  }
  refs[1092] = {
    name = "[ 教训花花公子 ]",
    content0 = "就算是为了我的孩子，也不能放任花花公子的行为而不管，大侠，你得去趟古乐村",
    reward0_count = 1,
    needLevel = 1,
    bQLoop = 0
  }
  refs[1554] = {
    name = "[长老候补-寻找候补的方法]",
    content0 = "我担心爷爷给少侠添了太多麻烦。",
    reward0_count = 3,
    needLevel = 103,
    bQLoop = 0
  }
  refs[1559] = {
    name = "[长老候补-心情很坏的老媪(1)]",
    content0 = "哎呦…我的腰啊。年纪大了，浑身没一个地方是好的。",
    reward0_count = 0,
    needLevel = 105,
    bQLoop = 0
  }
  refs[1560] = {
    name = "[长老候补-心情很坏的老媪(2)]",
    content0 = "还是不太信，但也没办法。就当相信你，去第一阶梯击退幽灵使者，收集40个幽灵帽子吧。",
    reward0_count = 30,
    needLevel = 105,
    bQLoop = 0
  }
  refs[1581] = {
    name = "[ 老媪的礼物 ]",
    content0 = "我们都已经有了礼物，但是不能忘记老人家呀。大侠，得麻烦你替我去趟古乐村",
    reward0_count = 1,
    needLevel = 1,
    bQLoop = 0
  }
  return refs
end
