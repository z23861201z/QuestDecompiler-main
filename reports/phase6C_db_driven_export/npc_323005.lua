-- DB_DRIVEN_EXPORT
-- source: npc_323005.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_323005"
  local refs = {}
  refs[1480] = {
    name = "[ 旅行许可(3) ]",
    content0 = "进到安哥拉王宫内部，能最先见到的人就是亲卫队长罗新！",
    reward0_count = 0,
    needLevel = 160,
    bQLoop = 0
  }
  refs[1481] = {
    name = "[ 外部的帮助 ]",
    content0 = "你是几百年来第一次到来的旅行者，但不能单纯的欢迎你.",
    reward0_count = 0,
    needLevel = 160,
    bQLoop = 0
  }
  refs[2186] = {
    name = "[ 亲卫队的剑 ]",
    content0 = "听说你最近在帮助公主？",
    reward0_count = 1,
    needLevel = 180,
    bQLoop = 0
  }
  refs[2586] = {
    name = "[ 危险的阿拉克涅 ]",
    content0 = "你有时间的话，能帮我个忙吗？",
    reward0_count = 0,
    needLevel = 180,
    bQLoop = 0
  }
  refs[2882] = {
    name = "[ 可心的解毒剂2 ]",
    content0 = "来，这是解毒剂。我以最快的速度制作的。",
    reward0_count = 0,
    needLevel = 173,
    bQLoop = 0
  }
  refs[2883] = {
    name = "[ 可心装病 ]",
    content0 = "我听着外面很乱，能告诉我出了什么事情吗？",
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
  refs[2890] = {
    name = "[ 降落伞的记忆3 ]",
    content0 = "这样，我受到了两次{0xFFFFFF00}春水糖{END}的帮助。可能是担心受伤的我，{0xFFFFFF00}春水糖{END}一直陪着我侦查。",
    reward0_count = 0,
    needLevel = 174,
    bQLoop = 0
  }
  refs[2891] = {
    name = "[ 安哥拉的名人 ]",
    content0 = "哦，刚好我也在找你呢。{0xFF99ff99}PLAYERNAME{END}!!",
    reward0_count = 0,
    needLevel = 174,
    bQLoop = 0
  }
  refs[3649] = {
    name = "[ 亲卫队的剑（每日） ]",
    content0 = "1个火龙的龙角只能制作一个武器",
    reward0_count = 1,
    needLevel = 180,
    bQLoop = 0
  }
  refs[3701] = {
    name = "[ 泥泞的大地 ]",
    content0 = "最近我的部下们在燃烧的废墟探险，但是有一个问题。",
    reward0_count = 0,
    needLevel = 183,
    bQLoop = 0
  }
  return refs
end
