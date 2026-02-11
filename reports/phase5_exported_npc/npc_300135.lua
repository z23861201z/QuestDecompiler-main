-- DB_DRIVEN_EXPORT
-- source: npc_300135.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_300135"
  local refs = {}
  refs[2177] = {
    name = "[ 燃烧的手镯[3阶段] ]",
    content0 = "要制作燃烧的手镯[3阶段]么？知道需要什么材料么？",
    reward0_count = 1,
    needLevel = 1,
    bQLoop = 0
  }
  refs[2178] = {
    name = "[ 燃烧的戒指[3阶段] ]",
    content0 = "要制作燃烧的戒指[3阶段]么？知道需要什么材料么？",
    reward0_count = 1,
    needLevel = 1,
    bQLoop = 0
  }
  refs[2179] = {
    name = "[ 燃烧的项链[3阶段] ]",
    content0 = "要制作燃烧的项链[3阶段]么？知道需要什么材料么？",
    reward0_count = 1,
    needLevel = 1,
    bQLoop = 0
  }
  refs[2180] = {
    name = "[ 燃烧的耳环[3阶段] ]",
    content0 = "要制作燃烧的耳环[3阶段]么？知道需要什么材料么？",
    reward0_count = 1,
    needLevel = 1,
    bQLoop = 0
  }
  refs[3643] = {
    name = "[ 燃烧的结晶 ]",
    content0 = "听说你最近在寻找燃烧的结晶？",
    reward0_count = 1,
    needLevel = 1,
    bQLoop = 0
  }
  return refs
end
