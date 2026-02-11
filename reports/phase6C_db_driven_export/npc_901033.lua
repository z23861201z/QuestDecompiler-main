-- DB_DRIVEN_EXPORT
-- source: npc_901033.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_901033"
  local refs = {}
  refs[107] = {
    name = "[ 龙林山隐藏的地区 ]",
    content0 = "呵呵呵呵呵呵…啊！恩恩…什么事啊？",
    reward0_count = 0,
    needLevel = 54,
    bQLoop = 0
  }
  refs[109] = {
    name = "[ 丢失的仙女衣 ]",
    content0 = "别害怕…今天我不会让你去太远的。还记得上次见过的{0xFFFFFF00}樵夫{END}吗？你去他那里把{0xFFFFFF00}仙女衣{END}拿来吧。",
    reward0_count = 0,
    needLevel = 55,
    bQLoop = 0
  }
  refs[1245] = {
    name = "[ 中断的线索 ]",
    content0 = "错了。听说东泼肉师兄离开村子往龙林山方向出发后就谁都不知道他的行踪。",
    reward0_count = 0,
    needLevel = 53,
    bQLoop = 0
  }
  refs[1246] = {
    name = "[ 营救受伤的鹿 ]",
    content0 = "东泼肉的行踪吗？这个。因为我答应过东泼肉要替他保密的。",
    reward0_count = 20,
    needLevel = 54,
    bQLoop = 0
  }
  return refs
end
