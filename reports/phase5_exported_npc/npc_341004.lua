-- DB_DRIVEN_EXPORT
-- source: npc_341004.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_341004"
  local refs = {}
  refs[2718] = {
    name = "[ 宝石项链的报复 ]",
    content0 = "那边路过的那人，走近一点看看。",
    reward0_count = 0,
    needLevel = 187,
    bQLoop = 0
  }
  refs[2723] = {
    name = "[ 要插在扇子上的羽毛 ]",
    content0 = "那个，路过的那位，到我跟前来一下。",
    reward0_count = 0,
    needLevel = 187,
    bQLoop = 0
  }
  refs[2905] = {
    name = "[ 击退恶心的晶石怪 ]",
    content0 = "那个，那边正路过的那个人，能过来一下吗？",
    reward0_count = 0,
    needLevel = 189,
    bQLoop = 0
  }
  return refs
end
