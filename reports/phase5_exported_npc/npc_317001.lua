-- DB_DRIVEN_EXPORT
-- source: npc_317001.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_317001"
  local refs = {}
  refs[332] = {
    name = "[ ?? ???? ?? ]",
    content0 = "?~ ??? ??? ??? ????…. ??? ?? ??….",
    reward0_count = 0,
    needLevel = 31,
    bQLoop = 0
  }
  refs[334] = {
    name = "[ ??? ??? ?? ]",
    content0 = "{0xFF99FF99}PLAYERNAME{END}? ????. ????? ??? ?? ???.",
    reward0_count = 0,
    needLevel = 33,
    bQLoop = 0
  }
  refs[1137] = {
    name = "[ 往清江村 ]",
    content0 = "少侠来得正好。刚接到消息说现在清江村的强悍巷道出没怪物，清江村村民生活很困难。",
    reward0_count = 0,
    needLevel = 18,
    bQLoop = 0
  }
  refs[1150] = {
    name = "[ 谍报活动2 ]",
    content0 = "嗯，制作精灵的时候最重要的应该是材料对吧？但这材料有时候很难收集到。",
    reward0_count = 20,
    needLevel = 22,
    bQLoop = 0
  }
  refs[1152] = {
    name = "[ 白斩姬的失策 ]",
    content0 = "可能情报出错了。应该是因为邪派的妨碍工作才会发生这种事情的。但也不是一无所获。",
    reward0_count = 1,
    needLevel = 23,
    bQLoop = 0
  }
  refs[1154] = {
    name = "[ 矿工的担心 ]",
    content0 = "从懂事起开始就在强悍巷道做起了矿工，但没见过现在这样怪物泛滥呢。",
    reward0_count = 0,
    needLevel = 23,
    bQLoop = 0
  }
  refs[1167] = {
    name = "[ 矿工的担忧 ]",
    content0 = "还是很担心啊。我进不去巷道期间，怕土拨鼠或其他怪物弄塌了巷道。",
    reward0_count = 0,
    needLevel = 28,
    bQLoop = 0
  }
  refs[1172] = {
    name = "[ 矿工的痛苦 ]",
    content0 = "没想到这么快就把功力提升至31级，清江村居民对你夸不停口啊。你使什么妖术了啊？",
    reward0_count = 0,
    needLevel = 31,
    bQLoop = 0
  }
  refs[1174] = {
    name = "[ 证据 ]",
    content0 = "其实具体的我也不清楚。只是在巷道逃跑的时候向后看了一眼，看到了巨大的怪物。",
    reward0_count = 0,
    needLevel = 32,
    bQLoop = 0
  }
  refs[1176] = {
    name = "[ 回到白斩姬处 ]",
    content0 = "白斩姬捎来一封信让你回去呢。看样子时你击退猪大长分身的瞬间，邪恶的灵魂飞到了芦苇林。所以马上叫你过去想了解情况。",
    reward0_count = 0,
    needLevel = 33,
    bQLoop = 0
  }
  return refs
end
