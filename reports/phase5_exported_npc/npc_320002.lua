-- DB_DRIVEN_EXPORT
-- source: npc_320002.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_320002"
  local refs = {}
  refs[3668] = {
    name = "[ 请保护我和我的船吧：龟壳童（每日） ]",
    content0 = "少侠，不知道什么时候怪物就会攻过来，和我一起守住船只吧",
    reward0_count = 0,
    needLevel = 136,
    bQLoop = 0
  }
  refs[3669] = {
    name = "[ 请保护我和我的船吧：蛇头怪（每日） ]",
    content0 = "少侠，不知道什么时候怪物就会攻过来，和我一起守住船只吧",
    reward0_count = 0,
    needLevel = 137,
    bQLoop = 0
  }
  refs[3670] = {
    name = "[ 请保护我和我的船吧：食人鱼（每日） ]",
    content0 = "少侠，不知道什么时候怪物就会攻过来，和我一起守住船只吧",
    reward0_count = 0,
    needLevel = 139,
    bQLoop = 0
  }
  refs[3671] = {
    name = "[ 请保护我和我的船吧：凶面魔女（每日） ]",
    content0 = "少侠，不知道什么时候怪物就会攻过来，和我一起守住船只吧",
    reward0_count = 0,
    needLevel = 140,
    bQLoop = 0
  }
  refs[3672] = {
    name = "[ 请保护我和我的船吧：吸血怪（每日） ]",
    content0 = "少侠，不知道什么时候怪物就会攻过来，和我一起守住船只吧",
    reward0_count = 0,
    needLevel = 141,
    bQLoop = 0
  }
  return refs
end
