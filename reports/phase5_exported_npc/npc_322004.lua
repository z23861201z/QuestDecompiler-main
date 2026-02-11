-- DB_DRIVEN_EXPORT
-- source: npc_322004.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_322004"
  local refs = {}
  refs[1058] = {
    name = "[ 双胞胎姐姐的祝福 ]",
    content0 = "想要击退怪物，就要时刻处于备战状态！",
    reward0_count = 0,
    needLevel = 150,
    bQLoop = 0
  }
  refs[1059] = {
    name = "[ 双胞胎姐姐的关怀 ]",
    content0 = "想要击退怪物，就要时刻处于备战状态！",
    reward0_count = 0,
    needLevel = 150,
    bQLoop = 0
  }
  refs[2712] = {
    name = "[ 照亮黑暗1 ]",
    content0 = "你好，少侠。我有个请求。",
    reward0_count = 0,
    needLevel = 164,
    bQLoop = 0
  }
  return refs
end
