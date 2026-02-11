-- DB_DRIVEN_EXPORT
-- source: npc_322005.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_322005"
  local refs = {}
  refs[1060] = {
    name = "[ 双胞胎妹妹的祝福 ]",
    content0 = "等一下，你等会儿，你是准备以现在这样的状态去击退怪物吗？",
    reward0_count = 0,
    needLevel = 150,
    bQLoop = 0
  }
  refs[1061] = {
    name = "[ 双胞胎妹妹的关怀 ]",
    content0 = "等一下，你等会儿，你是准备以现在这样的状态去击退怪物吗？",
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
  refs[2713] = {
    name = "[ 照亮黑暗2 ]",
    content0 = "我有事要拜托你，你现在有时间吗？",
    reward0_count = 0,
    needLevel = 164,
    bQLoop = 0
  }
  return refs
end
