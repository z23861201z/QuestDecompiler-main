-- DB_DRIVEN_EXPORT
-- source: npc_322008.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_322008"
  local refs = {}
  refs[1053] = {
    name = "[???? ?? ??[1]]",
    content0 = "? ?? ???. ??? ??? ? ?? ?? ?? ???.",
    reward0_count = 0,
    needLevel = 155,
    bQLoop = 0
  }
  refs[1063] = {
    name = "[ 得到黑虎的认可[2] ]",
    content0 = "喂，小朋友，这里不是你能来的地方！",
    reward0_count = 0,
    needLevel = 155,
    bQLoop = 0
  }
  return refs
end
