-- DB_DRIVEN_EXPORT
-- source: npc_317006.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_317006"
  local refs = {}
  refs[329] = {
    name = "[ 山贼和尚的真心 ]",
    content0 = "??… ??? {0xFF99FF99}PLAYERNAME{END}? ? ????????",
    reward0_count = 0,
    needLevel = 25,
    bQLoop = 0
  }
  refs[1161] = {
    name = "[ 山贼和尚的真心 ]",
    content0 = "啊啊..我的胳膊啊 {0xFF99ff99}PLAYERNAME{END}，能帮帮我吗？",
    reward0_count = 0,
    needLevel = 25,
    bQLoop = 0
  }
  refs[1168] = {
    name = "[ 山贼和尚的秘密 ]",
    content0 = "那个{0xFF99ff99}PLAYERNAME{END}，我有个请求。",
    reward0_count = 20,
    needLevel = 29,
    bQLoop = 0
  }
  return refs
end
