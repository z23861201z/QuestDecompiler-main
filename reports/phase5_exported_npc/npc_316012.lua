-- DB_DRIVEN_EXPORT
-- source: npc_316012.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_316012"
  local refs = {}
  refs[494] = {
    name = "[ 决战！千手妖女(2) ]",
    content0 = "现在要开始了吧…一定要注意安全…咳咳",
    reward0_count = 1,
    needLevel = 110,
    bQLoop = 0
  }
  refs[3631] = {
    name = "[ 千手妖女的复活 ]",
    content0 = "太乙仙女来信了",
    reward0_count = 1,
    needLevel = 110,
    bQLoop = 0
  }
  return refs
end
