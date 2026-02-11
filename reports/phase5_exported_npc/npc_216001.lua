-- DB_DRIVEN_EXPORT
-- source: npc_216001.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_216001"
  local refs = {}
  refs[293] = {
    name = "[ ?? ?? ]",
    content0 = "???... ???? ?? ????? ????",
    reward0_count = 50,
    needLevel = 87,
    bQLoop = 0
  }
  refs[484] = {
    name = "[ ??? ?? ?? ]",
    content0 = "?? ?????? ??? ?? ????? ????? ????? ??? ?? ?? ???, PLAYERNAME ?? ????? ??? ??? ? ?? ??? ?? ????.",
    reward0_count = 0,
    needLevel = 99,
    bQLoop = 0
  }
  refs[553] = {
    name = "[ ??? ??.. ]",
    content0 = "PLAYERNAME? ?????.. ??",
    reward0_count = 0,
    needLevel = 77,
    bQLoop = 0
  }
  refs[1543] = {
    name = "[面临重建…]",
    content0 = "重建村子要做的事情像小山一样多，再加上最近我的身体状态不是很好，很是苦恼。",
    reward0_count = 0,
    needLevel = 99,
    bQLoop = 0
  }
  refs[1544] = {
    name = "[特殊药材]",
    content0 = "为长老治病的这段时间，我又找到了一种治疗方法。",
    reward0_count = 30,
    needLevel = 99,
    bQLoop = 0
  }
  refs[1550] = {
    name = "[劝解的办法]",
    content0 = "呵呵。老长老装病把您骗了。",
    reward0_count = 3,
    needLevel = 102,
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
  refs[1555] = {
    name = "[长老候补-古乐村宝芝林篇]",
    content0 = "要帮助我吗？谢谢。我正好需要帮助。",
    reward0_count = 0,
    needLevel = 103,
    bQLoop = 0
  }
  return refs
end
