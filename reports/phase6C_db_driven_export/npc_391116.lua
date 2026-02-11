-- DB_DRIVEN_EXPORT
-- source: npc_391116.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_391116"
  local refs = {}
  refs[3741] = {
    name = "[ 白鬼地狱-鬼觜客栈的危机 ]",
    content0 = "出大事了，大侠！",
    reward0_count = 1,
    needLevel = 140,
    bQLoop = 0
  }
  return refs
end
