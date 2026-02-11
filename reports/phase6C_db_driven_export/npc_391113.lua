-- DB_DRIVEN_EXPORT
-- source: npc_391113.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_391113"
  local refs = {}
  refs[2337] = {
    name = "[ 你还没有准备好3 ]",
    content0 = "巨木神该说的都说了。快回去吧，等你准备好了我再见你",
    reward0_count = 0,
    needLevel = 160,
    bQLoop = 0
  }
  refs[2338] = {
    name = "[ 你还没有准备好4 ]",
    content0 = "巨木神很吃惊",
    reward0_count = 0,
    needLevel = 160,
    bQLoop = 0
  }
  refs[2574] = {
    name = "[ 玄境-那年那时 ]",
    content0 = "巨木神在回忆。你是龟神介绍到此地的",
    reward0_count = 0,
    needLevel = 160,
    bQLoop = 0
  }
  refs[3663] = {
    name = "[ 与巨木神的修炼 ]",
    content0 = "巨木神对你的力量赞叹不止！",
    reward0_count = 1,
    needLevel = 160,
    bQLoop = 0
  }
  return refs
end
