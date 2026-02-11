-- DB_DRIVEN_EXPORT
-- source: npc_222003.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_222003"
  local refs = {}
  refs[1050] = {
    name = "[ 害了了防具店的请求 ]",
    content0 = "{0xFF99FF99}PLAYERNAME{END}，听说你很有名的，一直以来我都很想制作一件铠甲，你能帮我忙吗？",
    reward0_count = 5,
    needLevel = 156,
    bQLoop = 0
  }
  return refs
end
