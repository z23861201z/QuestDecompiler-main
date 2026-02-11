-- DB_DRIVEN_EXPORT
-- source: npc_316004.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_316004"
  local refs = {}
  refs[480] = {
    name = "[ ????!(1) ]",
    content0 = "? ?? ? ???? ??? ???? ?? ??? ?????. ????? ?? ???? ??? ?????? ? ??? ?????.",
    reward0_count = 0,
    needLevel = 96,
    bQLoop = 0
  }
  refs[481] = {
    name = "[ ????!(2) ]",
    content0 = "? ?? ??, ???? ? ?? ?? ?? ?? ?? ?? ???.",
    reward0_count = 0,
    needLevel = 96,
    bQLoop = 0
  }
  refs[1545] = {
    name = "[对身体好的东西!]",
    content0 = "多亏少侠帮忙，我已经收到古乐村宝芝林的药了。",
    reward0_count = 0,
    needLevel = 101,
    bQLoop = 0
  }
  refs[1546] = {
    name = "[灵验的蘑菇]",
    content0 = "您是说治疗母亲病症的方法吗？",
    reward0_count = 30,
    needLevel = 101,
    bQLoop = 0
  }
  refs[1547] = {
    name = "[中和的汤药(1)]",
    content0 = "现在全都结束了，回到老长老那儿把。",
    reward0_count = 0,
    needLevel = 101,
    bQLoop = 0
  }
  refs[1551] = {
    name = "[假药效应(1)]",
    content0 = "你问这是什么药么？吼吼吼。不知少侠是否听说过假药效应一词？",
    reward0_count = 0,
    needLevel = 102,
    bQLoop = 0
  }
  refs[1554] = {
    name = "[长老候补-寻找候补的方法]",
    content0 = "我担心爷爷给少侠添了太多麻烦。",
    reward0_count = 3,
    needLevel = 103,
    bQLoop = 0
  }
  refs[1558] = {
    name = "[长老候补-年轻书生]",
    content0 = "我很担心年迈母亲的病…",
    reward0_count = 0,
    needLevel = 104,
    bQLoop = 0
  }
  return refs
end
