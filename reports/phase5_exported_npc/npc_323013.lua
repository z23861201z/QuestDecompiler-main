-- DB_DRIVEN_EXPORT
-- source: npc_323013.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_323013"
  local refs = {}
  refs[2587] = {
    name = "[ 蛇鳞饰品 ]",
    content0 = "最近用蛇鳞制作的饰品在安哥拉很流行。",
    reward0_count = 0,
    needLevel = 180,
    bQLoop = 0
  }
  refs[2591] = {
    name = "[ 制作凉爽的扇子 ]",
    content0 = "你好，我们又见面了。天气很热吧？",
    reward0_count = 0,
    needLevel = 182,
    bQLoop = 0
  }
  return refs
end
