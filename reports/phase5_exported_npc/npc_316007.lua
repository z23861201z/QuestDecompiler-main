-- DB_DRIVEN_EXPORT
-- source: npc_316007.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_316007"
  local refs = {}
  refs[1549] = {
    name = "[长老装病]",
    content0 = "虽然少侠千方百计地帮助我，但是我可能再也撑不下去了。咳咳。",
    reward0_count = 0,
    needLevel = 102,
    bQLoop = 0
  }
  refs[1550] = {
    name = "[劝解的办法]",
    content0 = "呵呵。老长老装病把您骗了。",
    reward0_count = 3,
    needLevel = 102,
    bQLoop = 0
  }
  refs[1553] = {
    name = "[ 永不放弃! ]",
    content0 = "现在我就实话实说了吧。事实上我们家族就好像古乐村的土地爷，长老职位代代相传。",
    reward0_count = 0,
    needLevel = 103,
    bQLoop = 0
  }
  refs[1554] = {
    name = "[长老候补-寻找候补的方法]",
    content0 = "我担心爷爷给少侠添了太多麻烦。",
    reward0_count = 3,
    needLevel = 103,
    bQLoop = 0
  }
  refs[1555] = {
    name = "[长老候补-古乐村宝芝林篇]",
    content0 = "要帮助我吗？谢谢。我正好需要帮助。",
    reward0_count = 0,
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
  refs[1557] = {
    name = "[长老候补-年老书生]",
    content0 = "担忧吗？肯定就是怪物了。",
    reward0_count = 1,
    needLevel = 104,
    bQLoop = 0
  }
  refs[1558] = {
    name = "[长老候补-年轻书生]",
    content0 = "我很担心年迈母亲的病…",
    reward0_count = 0,
    needLevel = 104,
    bQLoop = 0
  }
  refs[1559] = {
    name = "[长老候补-心情很坏的老媪(1)]",
    content0 = "哎呦…我的腰啊。年纪大了，浑身没一个地方是好的。",
    reward0_count = 0,
    needLevel = 105,
    bQLoop = 0
  }
  refs[1560] = {
    name = "[长老候补-心情很坏的老媪(2)]",
    content0 = "还是不太信，但也没办法。就当相信你，去第一阶梯击退幽灵使者，收集40个幽灵帽子吧。",
    reward0_count = 30,
    needLevel = 105,
    bQLoop = 0
  }
  refs[1561] = {
    name = "[长老候补-候补评价]",
    content0 = "少侠。回来了啊。和长老候补们见面后感觉如何？",
    reward0_count = 0,
    needLevel = 105,
    bQLoop = 0
  }
  return refs
end
