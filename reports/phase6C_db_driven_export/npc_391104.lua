-- DB_DRIVEN_EXPORT
-- source: npc_391104.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_391104"
  local refs = {}
  refs[1347] = {
    name = "[ 修行之路 ]",
    content0 = "拿来了叛徒南呱湃的信？我为什么要收那个？拿回去吧！",
    reward0_count = 0,
    needLevel = 80,
    bQLoop = 0
  }
  refs[1390] = {
    name = "[去往生死地狱]",
    content0 = "黄泉结界僧们应该打开了通往生死地狱的通道。但，跟之前不同，这次需要中级灯火。中级灯火可以在汉谟拉比商人处购买。",
    reward0_count = 1,
    needLevel = 99,
    bQLoop = 0
  }
  return refs
end
