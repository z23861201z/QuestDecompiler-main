-- DB_DRIVEN_EXPORT
-- source: npc_315002.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_315002"
  local refs = {}
  refs[163] = {
    name = "[ ???? ???? ]",
    content0 = "??? ?? ?? ?? ??? ??? ????. ??? ?? ??? ??? ?? ?? ? ????.",
    reward0_count = 0,
    needLevel = 74,
    bQLoop = 0
  }
  refs[1268] = {
    name = "[ 龙林派师弟的指点 ]",
    content0 = "那个，你不是{0xFF99ff99}PLAYERNAME{END}吗？见到了很有名的侠客，真是我的荣幸啊。",
    reward0_count = 0,
    needLevel = 60,
    bQLoop = 0
  }
  refs[1278] = {
    name = "[ 双重间谍3 ]",
    content0 = "什么？果然…已被皇宫发现。如果你再空手回去的话，他们肯定会追查到底。",
    reward0_count = 0,
    needLevel = 63,
    bQLoop = 0
  }
  refs[1279] = {
    name = "[ 传统的申告式 ]",
    content0 = "如你所见，龙林派是个单一的门派，在中原拥有最大的规模。",
    reward0_count = 5,
    needLevel = 64,
    bQLoop = 0
  }
  refs[1280] = {
    name = "[ 龙林派的自豪感 ]",
    content0 = "那，然后是…（这个师弟比我还强，我要派他做什么呢？）",
    reward0_count = 0,
    needLevel = 64,
    bQLoop = 0
  }
  refs[1295] = {
    name = "[ 连连不断 ]",
    content0 = "你不在的这段时间，清阴关和冥珠城一直流传着有关一位少侠的消息。",
    reward0_count = 0,
    needLevel = 68,
    bQLoop = 0
  }
  refs[1296] = {
    name = "[ 名声 ]",
    content0 = "少侠在这段时间内做了许多了不起的事情。也让沉寂了许久的龙林派名声四起。",
    reward0_count = 0,
    needLevel = 68,
    bQLoop = 0
  }
  refs[1299] = {
    name = "[ 搜索工作 ]",
    content0 = "少侠。最近羊逃之在铁腕山出现了。",
    reward0_count = 1,
    needLevel = 69,
    bQLoop = 0
  }
  refs[1300] = {
    name = "[ 搜索工作2 ]",
    content0 = "多亏少侠，搜索工作可以快速进行，但要击退羊逃之有点儿困难。",
    reward0_count = 0,
    needLevel = 69,
    bQLoop = 0
  }
  refs[1301] = {
    name = "[威胁程度不同]",
    content0 = "大事不好。少侠。",
    reward0_count = 0,
    needLevel = 70,
    bQLoop = 0
  }
  refs[1302] = {
    name = "[ 剩下的担忧 ]",
    content0 = "少侠，龙林银行急着找您呢。",
    reward0_count = 0,
    needLevel = 70,
    bQLoop = 0
  }
  refs[1313] = {
    name = "[ 死战的预感2 ]",
    content0 = "龙林派师弟们正在找少侠呢。",
    reward0_count = 0,
    needLevel = 76,
    bQLoop = 0
  }
  refs[1314] = {
    name = "[ 死战的预感3 ]",
    content0 = "你知道马四掌出现了吗？",
    reward0_count = 1,
    needLevel = 76,
    bQLoop = 0
  }
  refs[1315] = {
    name = "[ 真正的目的 ]",
    content0 = "少侠，师兄找您。",
    reward0_count = 0,
    needLevel = 77,
    bQLoop = 0
  }
  refs[1489] = {
    name = "[ ???-??? ??? ]",
    content0 = "???! ?? 60??? ???? ????. ???? ??? ???? ??? ????.",
    reward0_count = 0,
    needLevel = 60,
    bQLoop = 0
  }
  refs[1490] = {
    name = "[ ???-??? ??? ]",
    content0 = "??! ?? 60??? ???? ???. ???? ??? ???? ??? ???.",
    reward0_count = 0,
    needLevel = 60,
    bQLoop = 0
  }
  refs[1527] = {
    name = "[ 迂回的接近 ]",
    content0 = "你有事求龙林派师兄？少侠为了龙林城立了大功，我也很想帮你的忙，但最近龙林派师兄拒绝外来人的拜访",
    reward0_count = 0,
    needLevel = 1,
    bQLoop = 0
  }
  return refs
end
