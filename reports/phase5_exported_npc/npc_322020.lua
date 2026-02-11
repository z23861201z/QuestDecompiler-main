-- DB_DRIVEN_EXPORT
-- source: npc_322020.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_322020"
  local refs = {}
  refs[2817] = {
    name = "[ 春水糖留下的 ]",
    content0 = "我收集了纸条，发现{0xFFFFFF00}春水糖{END}分明在此处逗留了很久。",
    reward0_count = 0,
    needLevel = 170,
    bQLoop = 0
  }
  refs[2818] = {
    name = "[ 最后的獐子潭人 ]",
    content0 = "别..过..",
    reward0_count = 0,
    needLevel = 170,
    bQLoop = 0
  }
  return refs
end
