-- DB_DRIVEN_EXPORT
-- source: npc_323007.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_323007"
  local refs = {}
  refs[1481] = {
    name = "[ 外部的帮助 ]",
    content0 = "你是几百年来第一次到来的旅行者，但不能单纯的欢迎你.",
    reward0_count = 0,
    needLevel = 160,
    bQLoop = 0
  }
  refs[1482] = {
    name = "[ 痴迷的酒! ]",
    content0 = "现在疑点有两个。第一个是怪物是怎么得到情报的，第二个是怪物占领小胡同的原因是什么",
    reward0_count = 0,
    needLevel = 160,
    bQLoop = 0
  }
  refs[1484] = {
    name = "[ 收集证据(1) ]",
    content0 = "果然不出所料啊！",
    reward0_count = 0,
    needLevel = 160,
    bQLoop = 0
  }
  refs[1485] = {
    name = "[ 收集证据(2) ]",
    content0 = "嗯，{0xFFFFFF00}狐尾怪{END}？第一次听说啊，确实不是原来就在西部平原地带的怪物",
    reward0_count = 0,
    needLevel = 160,
    bQLoop = 0
  }
  refs[2592] = {
    name = "[ 荒唐的事故 ]",
    content0 = "最近我的同僚们在调查燃烧的废墟过程中，遭受到了些很无语的事故。",
    reward0_count = 0,
    needLevel = 182,
    bQLoop = 0
  }
  refs[2881] = {
    name = "[ 可心的解毒剂1 ]",
    content0 = "你怎么又来了？",
    reward0_count = 0,
    needLevel = 173,
    bQLoop = 0
  }
  refs[2882] = {
    name = "[ 可心的解毒剂2 ]",
    content0 = "来，这是解毒剂。我以最快的速度制作的。",
    reward0_count = 0,
    needLevel = 173,
    bQLoop = 0
  }
  refs[2884] = {
    name = "[ 可心的药1 ]",
    content0 = "制作了魔灵的酸橙汁。你把这个交给{0xFFFFFF00}近卫兵可心{END}，就说这是腹痛药。",
    reward0_count = 0,
    needLevel = 173,
    bQLoop = 0
  }
  refs[2885] = {
    name = "[ 可心的药2 ]",
    content0 = "所以说，不让早退，给了这{0xFFFFFF00}腹痛药{END}是吗？",
    reward0_count = 0,
    needLevel = 173,
    bQLoop = 0
  }
  refs[2886] = {
    name = "[ 可心的报复1 ]",
    content0 = "哎呦，这是谁啊~这不是给安哥拉治疗所有病痛的，非常有~名的{0xFF99ff99}PLAYERNAME{END}吗？",
    reward0_count = 0,
    needLevel = 174,
    bQLoop = 0
  }
  refs[2887] = {
    name = "[ 可心的报复2 ]",
    content0 = "好。这次是50个{0xFFFFFF00}马面人鬼{END}！",
    reward0_count = 0,
    needLevel = 174,
    bQLoop = 0
  }
  return refs
end
