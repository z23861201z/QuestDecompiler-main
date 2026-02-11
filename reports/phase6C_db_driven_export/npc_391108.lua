-- DB_DRIVEN_EXPORT
-- source: npc_391108.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_391108"
  local refs = {}
  refs[877] = {
    name = "[ 安哥拉暗黑路登场 ]",
    content0 = "你要去安哥拉暗黑路？那，那可不行！很危险的！也不知道近卫兵亚夫会什么时候来呢！",
    reward0_count = 1,
    needLevel = 160,
    bQLoop = 0
  }
  return refs
end
