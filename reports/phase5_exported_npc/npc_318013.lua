-- DB_DRIVEN_EXPORT
-- source: npc_318013.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_318013"
  local refs = {}
  refs[1291] = {
    name = "[ 暴风前夜7 ]",
    content0 = "这是什么意思？这个皇宫武士柳江在哪里？",
    reward0_count = 0,
    needLevel = 67,
    bQLoop = 0
  }
  refs[1292] = {
    name = "[ 暴风前夜8 ]",
    content0 = "我们不仅需要战船。还需要加强韩野码头自身来抵抗敌人们的攻击。",
    reward0_count = 3,
    needLevel = 67,
    bQLoop = 0
  }
  refs[1293] = {
    name = "[ 暴风前夜9 ]",
    content0 = "高一燕好像在找您呢。",
    reward0_count = 0,
    needLevel = 67,
    bQLoop = 0
  }
  refs[1379] = {
    name = "[一定会被需要]",
    content0 = "我研究了黑树妖皮，得到了惊人的事实。",
    reward0_count = 30,
    needLevel = 96,
    bQLoop = 0
  }
  refs[1380] = {
    name = "[预告新时代的材料]",
    content0 = "这就是黑树妖皮？天啊，用这个制造船的话，就可以制造出我梦寐以求的龟船了。",
    reward0_count = 0,
    needLevel = 96,
    bQLoop = 0
  }
  refs[1381] = {
    name = "[回到生死之塔(2)]",
    content0 = "不知道该怎么报答这恩惠啊。但是少侠为什么回来生死之塔？",
    reward0_count = 0,
    needLevel = 96,
    bQLoop = 0
  }
  return refs
end
