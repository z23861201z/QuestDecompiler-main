-- DB_DRIVEN_EXPORT
-- source: npc_341014.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_341014"
  local refs = {}
  refs[2909] = {
    name = "[ 想变得更强大的守卫1 ]",
    content0 = "好久不见。有时间聊聊吗？",
    reward0_count = 0,
    needLevel = 191,
    bQLoop = 0
  }
  refs[2913] = {
    name = "[ 想变得更强大的守卫2 ]",
    content0 = "喂，{0xFF99ff99}PLAYERNAME{END}！上次真的太谢谢你了。虽然还不如你，但我也在认真的击退怪物。",
    reward0_count = 0,
    needLevel = 193,
    bQLoop = 0
  }
  refs[3732] = {
    name = "[ 武器不足2 ]",
    content0 = "请留步。",
    reward0_count = 0,
    needLevel = 187,
    bQLoop = 0
  }
  return refs
end
