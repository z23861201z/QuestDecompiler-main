-- DB_DRIVEN_EXPORT
-- source: npc_240001.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_240001"
  local refs = {}
  refs[2594] = {
    name = "[ 研究泥土 ]",
    content0 = "我最近正在研究{0xFFFFFF00}[泥娃娃]{END}的泥块。",
    reward0_count = 0,
    needLevel = 183,
    bQLoop = 0
  }
  refs[2596] = {
    name = "[ 研究巨石守护者 ]",
    content0 = "本来觉得我对怪物的研究已经够多了，但是没想到还有好多很厉害的怪物。",
    reward0_count = 0,
    needLevel = 183,
    bQLoop = 0
  }
  return refs
end
