-- DB_DRIVEN_EXPORT
-- source: npc_323012.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_323012"
  local refs = {}
  refs[2183] = {
    name = "[ 贵族的点心 ]",
    content0 = "（嘴里正在吃着什么）啊啊！这真是！",
    reward0_count = 0,
    needLevel = 177,
    bQLoop = 0
  }
  refs[2589] = {
    name = "[ 奇怪的收藏欲望 ]",
    content0 = "嗯…我需要新的收藏品！",
    reward0_count = 0,
    needLevel = 181,
    bQLoop = 0
  }
  refs[2595] = {
    name = "[ 只要对眼睛好 ]",
    content0 = "最近感觉视力在下降，真是苦恼啊……",
    reward0_count = 0,
    needLevel = 183,
    bQLoop = 0
  }
  refs[3646] = {
    name = "[ 这都是我的！ ]",
    content0 = "想吃三头犬尾巴才过来的吗？",
    reward0_count = 0,
    needLevel = 177,
    bQLoop = 0
  }
  return refs
end
