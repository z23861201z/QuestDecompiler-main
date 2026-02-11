-- DB_DRIVEN_EXPORT
-- source: npc_317007.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_317007"
  local refs = {}
  refs[330] = {
    name = "[ 愉快的舞蹈的秘密 ]",
    content0 = "啦啦啦 愉快的跳舞~",
    reward0_count = 0,
    needLevel = 27,
    bQLoop = 0
  }
  refs[1139] = {
    name = "[ 胡须张的召唤 ]",
    content0 = "{0xFF99ff99}PLAYERNAME{END}？清阴关的胡须张送来一封信说想马上见到您？",
    reward0_count = 1,
    needLevel = 18,
    bQLoop = 0
  }
  refs[1140] = {
    name = "[ 胡须张的召唤（2） ]",
    content0 = "快使用{0xFFFFFF00}清阴符{END}去找清阴镖局的{0xFFFFFF00}胡须张{END}吧。",
    reward0_count = 1,
    needLevel = 18,
    bQLoop = 0
  }
  refs[1164] = {
    name = "[ 愉快的舞蹈的秘密 ]",
    content0 = "啦啦啦 愉快的跳舞~",
    reward0_count = 0,
    needLevel = 27,
    bQLoop = 0
  }
  refs[1171] = {
    name = "[ 居民们的不安 ]",
    content0 = "托{0xFF99ff99}PLAYERNAME{END}的福最近怪物少了很多。但现在强悍巷道还有很多怪物吧？",
    reward0_count = 30,
    needLevel = 30,
    bQLoop = 0
  }
  return refs
end
