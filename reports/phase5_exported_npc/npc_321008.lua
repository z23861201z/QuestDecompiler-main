-- DB_DRIVEN_EXPORT
-- source: npc_321008.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_321008"
  local refs = {}
  refs[1465] = {
    name = "[化境-觉醒！化境的境界（3）]",
    content0 = "你的意思是说你想要掩盖你是太和老君分身的事实吗？",
    reward0_count = 0,
    needLevel = 130,
    bQLoop = 0
  }
  return refs
end
