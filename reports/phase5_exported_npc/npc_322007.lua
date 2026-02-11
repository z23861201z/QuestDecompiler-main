-- DB_DRIVEN_EXPORT
-- source: npc_322007.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_322007"
  local refs = {}
  refs[1052] = {
    name = "[??? ??[1]]",
    content0 = "{0xFF99FF99}PLAYERNAME{END}?, ?????. ?? ????????. ? ?? ?? ?? ?? ??? ????? ???????",
    reward0_count = 0,
    needLevel = 151,
    bQLoop = 0
  }
  refs[1062] = {
    name = "[[新同伴[2]]",
    content0 = "{0xFF99FF99}PLAYERNAME{END}，你好！我是格斗家韩柏，你是为了什么事情来到这里的啊？是第一次来巨木重林吗？",
    reward0_count = 0,
    needLevel = 151,
    bQLoop = 0
  }
  return refs
end
