-- DB_DRIVEN_EXPORT
-- source: npc_314002.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_314002"
  local refs = {}
  refs[1129] = {
    name = "[ 酒鬼的担忧 ]",
    content0 = "我真的没打盹！真的看到了。没有眼鼻口的光光的鸡蛋一样的脸！分明是看到了，说都不相信我！",
    reward0_count = 20,
    needLevel = 16,
    bQLoop = 0
  }
  refs[1144] = {
    name = "[ 酒鬼的担忧（2） ]",
    content0 = "说谁是胆小鬼啊！嗯… 嗯… 呵！少侠，我没打，打盹。",
    reward0_count = 0,
    needLevel = 20,
    bQLoop = 0
  }
  return refs
end
