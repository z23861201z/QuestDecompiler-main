-- DB_DRIVEN_EXPORT
-- source: npc_300155.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_300155"
  local refs = {}
  refs[3711] = {
    name = "[ 苦恼的圣诞老人 ]",
    content0 = "年轻人，你能帮我个忙吗？",
    reward0_count = 1,
    needLevel = 1,
    bQLoop = 0
  }
  return refs
end
