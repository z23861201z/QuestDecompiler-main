-- DB_DRIVEN_EXPORT
-- source: npc_314008.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_314008"
  local refs = {}
  refs[1114] = {
    name = "[ 找回记忆的方法 ]",
    content0 = "针灸术好像对你没什么作用，那么就只能让你施展一下你的能力了。",
    reward0_count = 0,
    needLevel = 1,
    bQLoop = 0
  }
  refs[1115] = {
    name = "[ 派报员的小聪明 ]",
    content0 = "刚好我有要给商人转达的简讯，一边送简讯一边见到人，没准能遇到少侠记得的人或记得少侠的人，不是吗？",
    reward0_count = 1,
    needLevel = 1,
    bQLoop = 0
  }
  refs[1137] = {
    name = "[ 往清江村 ]",
    content0 = "少侠来得正好。刚接到消息说现在清江村的强悍巷道出没怪物，清江村村民生活很困难。",
    reward0_count = 0,
    needLevel = 18,
    bQLoop = 0
  }
  refs[1142] = {
    name = "[ 带来幸运的饰品 ]",
    content0 = "少侠找回点记忆了吗？",
    reward0_count = 1,
    needLevel = 19,
    bQLoop = 0
  }
  return refs
end
