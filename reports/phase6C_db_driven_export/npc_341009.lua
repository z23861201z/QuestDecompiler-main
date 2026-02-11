-- DB_DRIVEN_EXPORT
-- source: npc_341009.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_341009"
  local refs = {}
  refs[2716] = {
    name = "[ 地龙守卫的攻击 ]",
    content0 = "不许动！你看着面生啊，是从哪儿来的？",
    reward0_count = 0,
    needLevel = 186,
    bQLoop = 0
  }
  refs[2907] = {
    name = "[ 大瀑布巡查活动 ]",
    content0 = "{0xFF99ff99}PLAYERNAME{END}，你能听我说一会儿我的事情吗?",
    reward0_count = 0,
    needLevel = 190,
    bQLoop = 0
  }
  return refs
end
