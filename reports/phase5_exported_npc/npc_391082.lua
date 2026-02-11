-- DB_DRIVEN_EXPORT
-- source: npc_391082.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_391082"
  local refs = {}
  refs[856] = {
    name = "[ 杀气地狱-邪恶恶魂天鬼 ]",
    content0 = "你认识鬼谷村的带花女吗？精神稍微有点异常。据说她总在村子里吵嚷着看到黄泉的裂缝。",
    reward0_count = 0,
    needLevel = 29,
    bQLoop = 0
  }
  return refs
end
