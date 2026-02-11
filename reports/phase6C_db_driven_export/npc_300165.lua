-- DB_DRIVEN_EXPORT
-- source: npc_300165.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_300165"
  local refs = {}
  refs[3744] = {
    name = "[ 兔子的8周年腰带 ]",
    content0 = "你好，我是兔子。",
    reward0_count = 1,
    needLevel = 1,
    bQLoop = 0
  }
  refs[3745] = {
    name = "[ 乌龟的8周年腰带 ]",
    content0 = "你好，我是乌龟。",
    reward0_count = 1,
    needLevel = 1,
    bQLoop = 0
  }
  return refs
end
