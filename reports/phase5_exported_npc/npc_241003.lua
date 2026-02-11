-- DB_DRIVEN_EXPORT
-- source: npc_241003.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_241003"
  local refs = {}
  refs[2721] = {
    name = "[ 修理裁缝剪刀 ]",
    content0 = "啊~少侠？你现在有时间吗？",
    reward0_count = 0,
    needLevel = 186,
    bQLoop = 0
  }
  refs[3785] = {
    name = "[ 新的材料 ]",
    content0 = "啊！少侠？你现在有时间吗？",
    reward0_count = 0,
    needLevel = 191,
    bQLoop = 0
  }
  return refs
end
