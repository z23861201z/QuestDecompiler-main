-- DB_DRIVEN_EXPORT
-- source: npc_222005.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_222005"
  local refs = {}
  refs[2799] = {
    name = "[ 吕林城老婆婆的条件 ]",
    content0 = "{0xFFFFFF00}清丽公主{END}还没有放弃吗？",
    reward0_count = 0,
    needLevel = 169,
    bQLoop = 0
  }
  refs[2806] = {
    name = "[ 吕林城银行的认可(1) ]",
    content0 = "你就是想要探查{0xFFFFFF00}獐子潭洞穴{END}的人吗？",
    reward0_count = 0,
    needLevel = 169,
    bQLoop = 0
  }
  refs[2807] = {
    name = "[ 吕林城银行的认可(2) ]",
    content0 = "这种实力能探查{0xFFFFFF00}獐子潭洞穴{END}吗？",
    reward0_count = 0,
    needLevel = 169,
    bQLoop = 0
  }
  refs[2808] = {
    name = "[ 吕林城银行的认可(3) ]",
    content0 = "没想到你实力这么出众。真的很厉害。",
    reward0_count = 1,
    needLevel = 169,
    bQLoop = 0
  }
  return refs
end
