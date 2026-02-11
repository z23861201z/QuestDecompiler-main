-- DB_DRIVEN_EXPORT
-- source: npc_240003.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_240003"
  local refs = {}
  refs[2182] = {
    name = "[ 不灭的火炉之谜 ]",
    content0 = "那个~从那儿经过的那位",
    reward0_count = 0,
    needLevel = 176,
    bQLoop = 0
  }
  refs[3645] = {
    name = "[ 火炉似熔炉 ]",
    content0 = "呀！~{0xFF99ff99}PLAYERNAME{END}，今天也过来了啊",
    reward0_count = 0,
    needLevel = 176,
    bQLoop = 0
  }
  refs[3698] = {
    name = "[ 再次利用三叉戟 ]",
    content0 = "你知道{0xFFFFFF00}[黑色阿拉克涅]{END}手里的三叉戟是很好的武器材料这件事吗？",
    reward0_count = 0,
    needLevel = 180,
    bQLoop = 0
  }
  return refs
end
