-- DB_DRIVEN_EXPORT
-- source: npc_317002.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_317002"
  local refs = {}
  refs[346] = {
    name = "[ 碍事的怪物 ]",
    content0 = "??? ??? ??? ????… ?…",
    reward0_count = 1,
    needLevel = 27,
    bQLoop = 0
  }
  refs[1137] = {
    name = "[ 往清江村 ][FORCE_TEST][FORCE_TEST]",
    content0 = "少侠来得正好。刚接到消息说现在清江村的强悍巷道出没怪物，清江村村民生活很困难。[FORCE_TEST][FORCE_TEST]",
    reward0_count = 4,
    needLevel = 18,
    bQLoop = 0
  }
  refs[1153] = {
    name = "[ 乌骨鸡的性急 ]",
    content0 = "嗯，去见路边摊了？",
    reward0_count = 1,
    needLevel = 23,
    bQLoop = 0
  }
  refs[1155] = {
    name = "[ 厨师的疑心 ]",
    content0 = "您是之前见过的？是乌骨鸡让你来的？（语气变了）哼，就你一个人能干什么事啊？我也是邪派的武人呢。我们邪派的武人平时就这样隐藏着身份。",
    reward0_count = 1,
    needLevel = 23,
    bQLoop = 0
  }
  refs[1157] = {
    name = "[ 农夫的希望 ]",
    content0 = "有什么事吗？",
    reward0_count = 0,
    needLevel = 23,
    bQLoop = 0
  }
  refs[1165] = {
    name = "[ 碍事的怪物 ]",
    content0 = "我要怎么教训一下这些混蛋怪物呢…",
    reward0_count = 1,
    needLevel = 27,
    bQLoop = 0
  }
  return refs
end
