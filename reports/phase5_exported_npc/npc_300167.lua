-- DB_DRIVEN_EXPORT
-- source: npc_300167.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_300167"
  local refs = {}
  refs[2845] = {
    name = "[ 艾草和大蒜还有祈祷100天 ]",
    content0 = "所以说，叫黑熊儿的会说话的熊说想变成人是吗？",
    reward0_count = 0,
    needLevel = 1,
    bQLoop = 0
  }
  refs[2846] = {
    name = "[ 额，你也要？ ]",
    content0 = "嗷呜！少侠！",
    reward0_count = 1,
    needLevel = 1,
    bQLoop = 0
  }
  return refs
end
