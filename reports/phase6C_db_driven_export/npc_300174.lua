-- DB_DRIVEN_EXPORT
-- source: npc_300174.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_300174"
  local refs = {}
  refs[2844] = {
    name = "[ 想变成人类的黑熊儿 ]",
    content0 = "呜呜呜...",
    reward0_count = 0,
    needLevel = 1,
    bQLoop = 0
  }
  refs[2845] = {
    name = "[ 艾草和大蒜还有祈祷100天 ]",
    content0 = "所以说，叫黑熊儿的会说话的熊说想变成人是吗？",
    reward0_count = 0,
    needLevel = 1,
    bQLoop = 0
  }
  refs[3768] = {
    name = "[ 艾草和大蒜 ]",
    content0 = "想要变成人类就要吃艾草和大蒜，有点难度啊。",
    reward0_count = 1,
    needLevel = 1,
    bQLoop = 0
  }
  return refs
end
