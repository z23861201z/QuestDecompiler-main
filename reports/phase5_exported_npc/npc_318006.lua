-- DB_DRIVEN_EXPORT
-- source: npc_318006.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_318006"
  local refs = {}
  refs[1287] = {
    name = "[ 暴风前夜3 ]",
    content0 = "既然如此我们也应该准备一下战船。",
    reward0_count = 0,
    needLevel = 67,
    bQLoop = 0
  }
  refs[1288] = {
    name = "[ 暴风前夜4 ]",
    content0 = "什么？包围韩野城码头？造船？哼！太好笑了。让他们自己看着办。",
    reward0_count = 0,
    needLevel = 67,
    bQLoop = 0
  }
  refs[1290] = {
    name = "[ 暴风前夜6 ]",
    content0 = "辛苦了。",
    reward0_count = 0,
    needLevel = 67,
    bQLoop = 0
  }
  refs[1291] = {
    name = "[ 暴风前夜7 ]",
    content0 = "这是什么意思？这个皇宫武士柳江在哪里？",
    reward0_count = 0,
    needLevel = 67,
    bQLoop = 0
  }
  return refs
end
