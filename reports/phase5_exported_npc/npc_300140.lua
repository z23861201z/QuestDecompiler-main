-- DB_DRIVEN_EXPORT
-- source: npc_300140.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_300140"
  local refs = {}
  refs[3705] = {
    name = "[ 杂草横生 ]",
    content0 = "{0xFF99FF99}PLAYERNAME{END}，能帮我个忙吗？",
    reward0_count = 1,
    needLevel = 1,
    bQLoop = 0
  }
  return refs
end
