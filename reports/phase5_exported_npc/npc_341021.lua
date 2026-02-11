-- DB_DRIVEN_EXPORT
-- source: npc_341021.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_341021"
  local refs = {}
  refs[2722] = {
    name = "[ 需要新的梳子 ]",
    content0 = "这！这头发真是~怎么能这么管理头发呢？",
    reward0_count = 0,
    needLevel = 187,
    bQLoop = 0
  }
  refs[2724] = {
    name = "[ 莎罗拉的秀发 ]",
    content0 = "我好羡慕那边那位的一头秀发啊。",
    reward0_count = 0,
    needLevel = 187,
    bQLoop = 0
  }
  refs[3735] = {
    name = "[ 乌黑亮丽的秀发的秘密 ]",
    content0 = "最近来询问我秀发秘密的人增多了。",
    reward0_count = 2,
    needLevel = 187,
    bQLoop = 0
  }
  refs[3786] = {
    name = "[ 磨刀石替代品-喙 ]",
    content0 = "天啊！这可怎么办才好？",
    reward0_count = 0,
    needLevel = 192,
    bQLoop = 0
  }
  return refs
end
