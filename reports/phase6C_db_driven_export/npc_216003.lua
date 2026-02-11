-- DB_DRIVEN_EXPORT
-- source: npc_216003.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_216003"
  local refs = {}
  refs[295] = {
    name = "[ ???? ???? ]",
    content0 = "??? ??…  ?? ????. ",
    reward0_count = 0,
    needLevel = 93,
    bQLoop = 0
  }
  refs[482] = {
    name = "[ ???? ???? ]",
    content0 = "??? ??? ????? ?? ??? ??? ?????. ????? ?????? ???? ?? ??? ??? ??????.",
    reward0_count = 0,
    needLevel = 97,
    bQLoop = 0
  }
  refs[1554] = {
    name = "[长老候补-寻找候补的方法]",
    content0 = "我担心爷爷给少侠添了太多麻烦。",
    reward0_count = 3,
    needLevel = 103,
    bQLoop = 0
  }
  refs[1556] = {
    name = "[长老候补-古乐村服装店篇]",
    content0 = "最近的问题？无非就是缺少抗寒的好布料啊。",
    reward0_count = 0,
    needLevel = 103,
    bQLoop = 0
  }
  return refs
end
