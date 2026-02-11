-- DB_DRIVEN_EXPORT
-- source: npc_317003.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_317003"
  local refs = {}
  refs[333] = {
    name = "[ 祈祷的意义 ]",
    content0 = "年轻人，可拜托一件事吗？",
    reward0_count = 0,
    needLevel = 30,
    bQLoop = 0
  }
  refs[1137] = {
    name = "[ 往清江村 ][FORCE_TEST][FORCE_TEST]",
    content0 = "少侠来得正好。刚接到消息说现在清江村的强悍巷道出没怪物，清江村村民生活很困难。[FORCE_TEST][FORCE_TEST]",
    reward0_count = 4,
    needLevel = 18,
    bQLoop = 0
  }
  refs[1170] = {
    name = "[ 祈祷的意义 ]",
    content0 = "年轻人，我可以拜托你件事情吗？",
    reward0_count = 0,
    needLevel = 30,
    bQLoop = 0
  }
  return refs
end
