-- DB_DRIVEN_EXPORT
-- source: npc_218001.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_218001"
  local refs = {}
  refs[1288] = {
    name = "[ 暴风前夜4 ]",
    content0 = "什么？包围韩野城码头？造船？哼！太好笑了。让他们自己看着办。",
    reward0_count = 0,
    needLevel = 67,
    bQLoop = 0
  }
  refs[1289] = {
    name = "[ 暴风前夜5 ]",
    content0 = "原来有这种事情。我也一直担心冬混汤一族和我们部族年轻人之间的矛盾。",
    reward0_count = 0,
    needLevel = 67,
    bQLoop = 0
  }
  return refs
end
