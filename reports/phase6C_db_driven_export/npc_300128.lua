-- DB_DRIVEN_EXPORT
-- source: npc_300128.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_300128"
  local refs = {}
  refs[2012] = {
    name = "[ 讨厌的恶作剧! ]",
    content0 = "欢迎光临！请好好享受我们村准备的万圣节宴会吧！",
    reward0_count = 1,
    needLevel = 1,
    bQLoop = 0
  }
  refs[2013] = {
    name = "[ 制止恶作剧的方法! ]",
    content0 = "我说...出大事了...",
    reward0_count = 1,
    needLevel = 1,
    bQLoop = 0
  }
  refs[2014] = {
    name = "[ 欢度万圣节! ]",
    content0 = "托您的福，万圣节宴会举办的很成功呢！",
    reward0_count = 1,
    needLevel = 1,
    bQLoop = 0
  }
  return refs
end
