-- DB_DRIVEN_EXPORT
-- source: npc_217001.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_217001"
  local refs = {}
  refs[1159] = {
    name = "[ 送给婆婆的礼物 ]",
    content0 = "嗯~我说？",
    reward0_count = 20,
    needLevel = 24,
    bQLoop = 0
  }
  refs[1162] = {
    name = "[ 对身体有益的补药 ]",
    content0 = "嗯~请过来这边。",
    reward0_count = 0,
    needLevel = 26,
    bQLoop = 0
  }
  return refs
end
