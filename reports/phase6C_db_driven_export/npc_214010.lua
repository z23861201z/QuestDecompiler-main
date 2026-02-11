-- DB_DRIVEN_EXPORT
-- source: npc_214010.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_214010"
  local refs = {}
  refs[1101] = {
    name = "[ 长老的请求 ]",
    content0 = "我们艾里村村民原本出生于大陆，被恶势力迫害来到这里定居。通过村子怪物来锻炼自己，准备回故乡的那一天。",
    reward0_count = 0,
    needLevel = 1,
    bQLoop = 0
  }
  return refs
end
