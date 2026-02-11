-- DB_DRIVEN_EXPORT
-- source: npc_391912.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_391912"
  local refs = {}
  refs[804] = {
    name = "[ 巨大鬼怪-炫耀实力 ]",
    content0 = "糟糕。头一次看到那么无知的家伙，连封印结界也吃掉了。嗯？干嘛目不转睛的看着我。你认识我吗？哼。虽然不记得你了，但是你还得给我帮个忙。可以吧？",
    reward0_count = 1,
    needLevel = 60,
    bQLoop = 0
  }
  return refs
end
