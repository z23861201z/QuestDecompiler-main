-- DB_DRIVEN_EXPORT
-- source: npc_322009.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_322009"
  local refs = {}
  refs[1054] = {
    name = "[???? ??]",
    content0 = "?????. {0xFF99FF99}PLAYERNAME{END}?, ?? ????????. ???? ????.",
    reward0_count = 0,
    needLevel = 157,
    bQLoop = 0
  }
  refs[2327] = {
    name = "[ 失踪的旅行家 ]",
    content0 = "你好！我有事要拜托你",
    reward0_count = 0,
    needLevel = 160,
    bQLoop = 0
  }
  refs[2328] = {
    name = "[ 发现旅行家 ]",
    content0 = "帮，帮帮我吧",
    reward0_count = 0,
    needLevel = 160,
    bQLoop = 0
  }
  refs[2330] = {
    name = "[ 解毒药和粮食 ]",
    content0 = "稍等，稍等",
    reward0_count = 0,
    needLevel = 160,
    bQLoop = 0
  }
  refs[2331] = {
    name = "[ 旅行家的见闻 ]",
    content0 = "这，这是哪里啊？",
    reward0_count = 0,
    needLevel = 160,
    bQLoop = 0
  }
  refs[2332] = {
    name = "[ 寻找新路 ]",
    content0 = "简单的说明一下情况吧",
    reward0_count = 0,
    needLevel = 160,
    bQLoop = 0
  }
  refs[2562] = {
    name = "[ 玄境-寻找龟神的灵魂1 ]",
    content0 = "巨木神生气了。巨木神很好奇为什么会这么晚",
    reward0_count = 0,
    needLevel = 160,
    bQLoop = 0
  }
  refs[2563] = {
    name = "[ 玄境-寻找龟神的灵魂2 ]",
    content0 = "哦，恩人！好久不见了~",
    reward0_count = 0,
    needLevel = 160,
    bQLoop = 0
  }
  refs[2791] = {
    name = "[ 来历不明的石板(5) ]",
    content0 = "但是我完全看不懂啊。中原的人看懂了吗？",
    reward0_count = 0,
    needLevel = 168,
    bQLoop = 0
  }
  refs[2792] = {
    name = "[ 来历不明的石板(6) ]",
    content0 = "是獐子潭的文字啊！这个怎么发现的？",
    reward0_count = 0,
    needLevel = 168,
    bQLoop = 0
  }
  return refs
end
