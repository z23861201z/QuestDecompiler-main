-- DB_DRIVEN_EXPORT
-- source: npc_213009.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_213009"
  local refs = {}
  refs[676] = {
    name = "[ 开启新的黄泉（2） ]",
    content0 = "邪派那些家伙不但不会告诉你，还会拿你逗乐子，不过我们正派就算再累也会秉持正义。因此清阴胡须张才让你来找我的吧。",
    reward0_count = 0,
    needLevel = 20,
    bQLoop = 0
  }
  refs[802] = {
    name = "[ 怪林地狱-磷火的盛宴 ]",
    content0 = "我的记忆力不是很好，你是不是说过要拯救百姓于水火之中？那么我给你分配一个任务。对你来说不会很难。",
    reward0_count = 1,
    needLevel = 30,
    bQLoop = 0
  }
  refs[805] = {
    name = "[ 巨大鬼怪-守护冥珠 ]",
    content0 = "你来得正好。巨大鬼怪此时正在冥珠城外围捣乱。大侠你作为冥珠城的主人，一定要去阻止它。",
    reward0_count = 0,
    needLevel = 60,
    bQLoop = 0
  }
  return refs
end
