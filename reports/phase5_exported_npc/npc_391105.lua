-- DB_DRIVEN_EXPORT
-- source: npc_391105.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_391105"
  local refs = {}
  refs[869] = {
    name = "[ 愤怒的巨大鬼怪! ]",
    content0 = "PLAYERNAME！大事不妙了。之前出现的巨大鬼怪变得更加残暴，又开始捣乱了",
    reward0_count = 2,
    needLevel = 130,
    bQLoop = 0
  }
  return refs
end
