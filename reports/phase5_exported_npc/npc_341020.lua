-- DB_DRIVEN_EXPORT
-- source: npc_341020.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_341020"
  local refs = {}
  refs[2724] = {
    name = "[ 莎罗拉的秀发 ]",
    content0 = "我好羡慕那边那位的一头秀发啊。",
    reward0_count = 0,
    needLevel = 187,
    bQLoop = 0
  }
  return refs
end
