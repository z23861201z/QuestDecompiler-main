-- DB_DRIVEN_EXPORT
-- source: npc_317005.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_317005"
  local refs = {}
  refs[1137] = {
    name = "[ 往清江村 ]",
    content0 = "少侠来得正好。刚接到消息说现在清江村的强悍巷道出没怪物，清江村村民生活很困难。",
    reward0_count = 0,
    needLevel = 18,
    bQLoop = 0
  }
  refs[1158] = {
    name = "[ 头疼的蓝舌跳跳鬼 ]",
    content0 = "喂，你，说你呢。看哪儿呢？那儿就你一个人啊！",
    reward0_count = 20,
    needLevel = 24,
    bQLoop = 0
  }
  refs[1169] = {
    name = "[ 雕刻师的苦恼 ]",
    content0 = "我有个请求..强悍巷道里的石头是石雕的最高级材料~",
    reward0_count = 0,
    needLevel = 29,
    bQLoop = 0
  }
  return refs
end
