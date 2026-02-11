-- DB_DRIVEN_EXPORT
-- source: npc_391103.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_391103"
  local refs = {}
  refs[1325] = {
    name = "[龙林城的守护者]",
    content0 = "出大事了！龙林派被以皇宫武士陈调为首的皇宫兵力包围了！",
    reward0_count = 1,
    needLevel = 80,
    bQLoop = 0
  }
  return refs
end
