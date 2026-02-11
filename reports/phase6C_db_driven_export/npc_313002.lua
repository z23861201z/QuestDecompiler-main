-- DB_DRIVEN_EXPORT
-- source: npc_313002.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_313002"
  local refs = {}
  refs[76] = {
    name = "[ ??? ????? ]",
    content0 = "{0xFF99FF99}PLAYERNAME{END}?, ?????. ?? ?? ??? ??????",
    reward0_count = 0,
    needLevel = 42,
    bQLoop = 0
  }
  refs[95] = {
    name = "[ ???? ??? ]",
    content0 = "???.. ???.. ??",
    reward0_count = 0,
    needLevel = 45,
    bQLoop = 0
  }
  refs[106] = {
    name = "[ ??? ???? ]",
    content0 = "?? {0xFF99FF99}PLAYERNAME{END}? ???? ????? ??? ?? ??? ?? ???. ??..",
    reward0_count = 0,
    needLevel = 53,
    bQLoop = 0
  }
  refs[198] = {
    name = "[ 新鲜的材料 ]",
    content0 = "爸爸说食材总是要用新鲜的…但是放在仓库里的材料很难保持新鲜啊。",
    reward0_count = 0,
    needLevel = 49,
    bQLoop = 0
  }
  refs[200] = {
    name = "[ ??? ?? ]",
    content0 = "???? ??????. ?? ???? ??? ??? ?????. {0xFF99FF99}PLAYERNAME{END}? ??? ??? ? ???? ???? ????.",
    reward0_count = 1,
    needLevel = 58,
    bQLoop = 0
  }
  refs[1212] = {
    name = "[ 冥珠城的力士 ]",
    content0 = "啊，是道名寺说了那事…。你听到的部分是对的。原来冥珠城是以连接中部和东部的交通要塞发展，积累了很多财富。",
    reward0_count = 1,
    needLevel = 1,
    bQLoop = 0
  }
  refs[1213] = {
    name = "[ 正邪间的纠葛3 ]",
    content0 = "我想获得冥珠城居民的信任才是优先级的。否则就因为深印在居民脑海里的对武林人士的不满就很难扭转局势。",
    reward0_count = 0,
    needLevel = 1,
    bQLoop = 0
  }
  refs[1214] = {
    name = "[ 祖传调料的秘密 ]",
    content0 = "最近怪物开始泛滥之后，食材怎么也收集不到。这样下去食堂早晚得关门大吉。这种情况下武林人士还分成派系互相争斗…",
    reward0_count = 1,
    needLevel = 41,
    bQLoop = 0
  }
  refs[1215] = {
    name = "[ 商人们的苦衷 ]",
    content0 = "食材找到了，现在继续营业不是问题，但还是担心啊。",
    reward0_count = 0,
    needLevel = 41,
    bQLoop = 0
  }
  refs[1264] = {
    name = "[ 正邪间的纠葛3 ]",
    content0 = "我想获得冥珠城居民的信任才是优先级的。否则就因为深印在居民脑海里的对武林人士的不满就很难扭转局势。",
    reward0_count = 0,
    needLevel = 1,
    bQLoop = 0
  }
  refs[1396] = {
    name = "[ ??? ? ?? ]",
    content0 = "???! ??? ????.",
    reward0_count = 0,
    needLevel = 1,
    bQLoop = 0
  }
  refs[1397] = {
    name = "[ ?? ? ????? ]",
    content0 = "???? ? ??? ?? ??????? ??? ???? ????.",
    reward0_count = 0,
    needLevel = 1,
    bQLoop = 0
  }
  refs[1415] = {
    name = "[ ?????? ?? ]",
    content0 = "???, ???! ? ? ??????.",
    reward0_count = 1,
    needLevel = 1,
    bQLoop = 0
  }
  return refs
end
