-- DB_DRIVEN_EXPORT
-- source: npc_341002.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_341002"
  local refs = {}
  refs[2717] = {
    name = "[ 请守护空中庭院吧 ]",
    content0 = "你就是穿过西部边境地带而来的人吗？",
    reward0_count = 0,
    needLevel = 187,
    bQLoop = 0
  }
  refs[2915] = {
    name = "[ 空中庭院防御准备 ]",
    content0 = "你好，我是空中庭院的领主夏德。能跟我聊会儿吗？",
    reward0_count = 0,
    needLevel = 193,
    bQLoop = 0
  }
  refs[3734] = {
    name = "[ 讨伐委托：讨伐地龙 ]",
    content0 = "西部边境地带的地龙相当危险。是跟普通的妖怪不同，繁殖力非常强大的危险的存在。",
    reward0_count = 2,
    needLevel = 186,
    bQLoop = 0
  }
  return refs
end
