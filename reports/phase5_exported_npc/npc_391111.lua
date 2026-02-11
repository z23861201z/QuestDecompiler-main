-- DB_DRIVEN_EXPORT
-- source: npc_391111.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_391111"
  local refs = {}
  refs[3653] = {
    name = "[ 土谷桃园-帮我找回东西 ]",
    content0 = "啊，来得正好.",
    reward0_count = 0,
    needLevel = 120,
    bQLoop = 0
  }
  return refs
end
