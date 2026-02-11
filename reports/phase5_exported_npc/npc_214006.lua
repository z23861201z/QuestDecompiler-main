-- DB_DRIVEN_EXPORT
-- source: npc_214006.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_214006"
  local refs = {}
  refs[953] = {
    name = "{0xFFFFB4B4}[ 什么是精灵？ ]{END}",
    content0 = "精灵跟随着主人，辅助主人的能力。随着灵物的成长，主人的能力也变强。",
    reward0_count = 0,
    needLevel = 0,
    bQLoop = 0
  }
  refs[1146] = {
    name = "[ 正派的请求 ]",
    content0 = "怎么这么久啊？总之来了就好。有件事要拜托你。这是正派的正式邀请，不会拒绝吧？",
    reward0_count = 0,
    needLevel = 21,
    bQLoop = 0
  }
  refs[1148] = {
    name = "[ 谍报活动 ]",
    content0 = "有情报说{0xFFFFFF00}无名湖的精灵匠人{END}对这次的袭击有所了解。我们调查怪老子的眼珠的时候，你去他那边把情报弄到手吧。",
    reward0_count = 0,
    needLevel = 21,
    bQLoop = 0
  }
  refs[1150] = {
    name = "[ 谍报活动2 ]",
    content0 = "嗯，制作精灵的时候最重要的应该是材料对吧？但这材料有时候很难收集到。",
    reward0_count = 20,
    needLevel = 22,
    bQLoop = 0
  }
  refs[1183] = {
    name = "[ 艰难的人们 ]",
    content0 = "听说{0xFF99ff99}PLAYERNAME{END}为了清阴关做了件大事。但现在还是有很艰难的人们啊。",
    reward0_count = 1,
    needLevel = 36,
    bQLoop = 0
  }
  refs[1184] = {
    name = "[ 黄金劣犬的牙 ]",
    content0 = "年轻人，每次都帮忙真是太谢谢了。反正都帮了这么多了，可不可以再帮我一次啊？",
    reward0_count = 20,
    needLevel = 36,
    bQLoop = 0
  }
  refs[1187] = {
    name = "[ 不足的材料 ]",
    content0 = "喂。过来一下！",
    reward0_count = 0,
    needLevel = 38,
    bQLoop = 0
  }
  return refs
end
