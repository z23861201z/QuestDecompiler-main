-- DB_DRIVEN_EXPORT
-- source: npc_391010.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_391010"
  local refs = {}
  refs[961] = {
    name = "{0xFFFFB4B4}[ 什么是异界门？ ]{END}",
    content0 = "前不久出现了浓眉的承宪道僧，管理世界各地的黄泉的裂缝。因此之前的异界门是消失了，关在此处的武士也可以平安回去了。",
    reward0_count = 0,
    needLevel = 0,
    bQLoop = 0
  }
  refs[1195] = {
    name = "[ 黄泉？ ]",
    content0 = "喂。等一等。",
    reward0_count = 1,
    needLevel = 20,
    bQLoop = 0
  }
  return refs
end
