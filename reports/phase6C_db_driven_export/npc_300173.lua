-- DB_DRIVEN_EXPORT
-- source: npc_300173.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_300173"
  local refs = {}
  refs[3756] = {
    name = "[ 我需要黑兔毛 ]",
    content0 = "你好，你见到过黑兔子吗？",
    reward0_count = 1,
    needLevel = 1,
    bQLoop = 0
  }
  return refs
end
