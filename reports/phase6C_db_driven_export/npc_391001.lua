-- DB_DRIVEN_EXPORT
-- source: npc_391001.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_391001"
  local refs = {}
  refs[1195] = {
    name = "[ 黄泉？ ]",
    content0 = "喂。等一等。",
    reward0_count = 1,
    needLevel = 20,
    bQLoop = 0
  }
  refs[1502] = {
    name = "[ ??? ?? ]",
    content0 = "?? ???…????? ?? ?? ??? ??. ??? ??? ?? ?? ??? ?? ?? ?? ?? ??? ?? ???",
    reward0_count = 1,
    needLevel = 1,
    bQLoop = 0
  }
  refs[3629] = {
    name = "[ 供米三百石 ]",
    content0 = "我打算供奉佛祖，好让大目仔村一直和平下去。你愿意帮助我么？",
    reward0_count = 1,
    needLevel = 1,
    bQLoop = 0
  }
  return refs
end
