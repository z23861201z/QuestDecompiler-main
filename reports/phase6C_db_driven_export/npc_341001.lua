-- DB_DRIVEN_EXPORT
-- source: npc_341001.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_341001"
  local refs = {}
  refs[2911] = {
    name = "[ 击退粗暴的晶石喙龟 ]",
    content0 = "哦，{0xFF99ff99}PLAYERNAME{END}，你能帮我个忙吗？",
    reward0_count = 0,
    needLevel = 192,
    bQLoop = 0
  }
  refs[3729] = {
    name = "[ 每日讨伐队:翅鳍 ]",
    content0 = "这个怎么办才好！",
    reward0_count = 0,
    needLevel = 186,
    bQLoop = 0
  }
  refs[3783] = {
    name = "[ 击退晶石怪 ]",
    content0 = "{0xFF99ff99}PLAYERNAME{END}，你能帮我个忙吗？",
    reward0_count = 0,
    needLevel = 189,
    bQLoop = 0
  }
  return refs
end
