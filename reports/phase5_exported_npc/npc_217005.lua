-- DB_DRIVEN_EXPORT
-- source: npc_217005.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_217005"
  local refs = {}
  refs[347] = {
    name = "[ ???? ?? ]",
    content0 = "??? ?? ??? ?? ???? ?? ??? ???? ??? ???. ?? ???? ?? ?? ????…",
    reward0_count = 0,
    needLevel = 30,
    bQLoop = 0
  }
  refs[1139] = {
    name = "[ 胡须张的召唤 ]",
    content0 = "{0xFF99ff99}PLAYERNAME{END}？清阴关的胡须张送来一封信说想马上见到您？",
    reward0_count = 1,
    needLevel = 18,
    bQLoop = 0
  }
  refs[1154] = {
    name = "[ 矿工的担心 ]",
    content0 = "从懂事起开始就在强悍巷道做起了矿工，但没见过现在这样怪物泛滥呢。",
    reward0_count = 0,
    needLevel = 23,
    bQLoop = 0
  }
  refs[1156] = {
    name = "[ 清江银行的指点 ]",
    content0 = "疲惫的矿工说的？他本人应该最困难才是啊… 好吧，我给清江村居民转达这一消息。现在开始清江村居民会拜托少侠一些事情的。解决了那些功力马上就能达到{0xFFFFFF00}31级{END}的。",
    reward0_count = 0,
    needLevel = 23,
    bQLoop = 0
  }
  refs[1163] = {
    name = "[ 不足的衣料 ]",
    content0 = "少侠，帮帮我吧。上次为了做衣服帮我收集了衣料，但是衣料不够啊。",
    reward0_count = 20,
    needLevel = 26,
    bQLoop = 0
  }
  return refs
end
