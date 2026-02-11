-- DB_DRIVEN_EXPORT
-- source: npc_200003.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_200003"
  local refs = {}
  refs[2035] = {
    name = "[ 军士 - 参观市集 ]",
    content0 = "看着你迅速成长，让我想起了小时候的自己(暂时陷入回忆中)..那时候真好啊！",
    reward0_count = 0,
    needLevel = 23,
    bQLoop = 0
  }
  refs[2036] = {
    name = "[ 军士 - 技能: 碎云斩 ]",
    content0 = "(巡视日记里有几个要确认的事项)",
    reward0_count = 0,
    needLevel = 23,
    bQLoop = 0
  }
  return refs
end
