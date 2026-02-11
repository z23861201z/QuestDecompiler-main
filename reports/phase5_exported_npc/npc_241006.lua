-- DB_DRIVEN_EXPORT
-- source: npc_241006.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_241006"
  local refs = {}
  refs[2903] = {
    name = "[ 晶石怪的坏气运 ]",
    content0 = "{0xFFFFCCCC}(自言自语){END}嗯，我看肯定是晶石怪的原因，好担心啊..",
    reward0_count = 0,
    needLevel = 188,
    bQLoop = 0
  }
  return refs
end
