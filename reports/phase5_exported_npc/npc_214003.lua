-- DB_DRIVEN_EXPORT
-- source: npc_214003.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_214003"
  local refs = {}
  refs[1115] = {
    name = "[ 派报员的小聪明 ]",
    content0 = "刚好我有要给商人转达的简讯，一边送简讯一边见到人，没准能遇到少侠记得的人或记得少侠的人，不是吗？",
    reward0_count = 1,
    needLevel = 1,
    bQLoop = 0
  }
  refs[1117] = {
    name = "[ 害了了防具店的关怀 ]",
    content0 = "你说我认不认识少侠？很遗憾，我不认识。\n我因为是别的地方的人，只是需要武功出色的人而已。",
    reward0_count = 0,
    needLevel = 11,
    bQLoop = 0
  }
  return refs
end
