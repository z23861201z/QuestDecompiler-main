-- DB_DRIVEN_EXPORT
-- source: npc_300170.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_300170"
  local refs = {}
  refs[3751] = {
    name = "[ 找回军用口粮 ]",
    content0 = "必胜！你能帮帮我们吗？",
    reward0_count = 1,
    needLevel = 1,
    bQLoop = 0
  }
  return refs
end
