-- DB_DRIVEN_EXPORT
-- source: npc_215005.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_215005"
  local refs = {}
  refs[234] = {
    name = "[ ??? ?? ?? ]",
    content0 = "???? ??? ? ??? ?? ?? ??. ?? ?? ??? ?? ???? ?…. ??.",
    reward0_count = 0,
    needLevel = 80,
    bQLoop = 0
  }
  refs[543] = {
    name = "[ ??? ?? ]",
    content0 = "?? ???? ??? ????~!",
    reward0_count = 0,
    needLevel = 77,
    bQLoop = 0
  }
  refs[544] = {
    name = "[ ?????? ???(1) ]",
    content0 = "??? ?? ??? ?????",
    reward0_count = 0,
    needLevel = 77,
    bQLoop = 0
  }
  refs[545] = {
    name = "[ ?????? ???(2) ]",
    content0 = "? ???? ???? ?? ??? ??? ?? ????.",
    reward0_count = 0,
    needLevel = 77,
    bQLoop = 0
  }
  refs[546] = {
    name = "[ ????? ? ?? ]",
    content0 = "? ???? ???? ?? ??? ?????.",
    reward0_count = 0,
    needLevel = 77,
    bQLoop = 0
  }
  refs[557] = {
    name = "[ ????? ]",
    content0 = "??.. ???.. PLAYERNAME?? ????. ??? ???? ?? ?? ?????.",
    reward0_count = 0,
    needLevel = 70,
    bQLoop = 0
  }
  refs[1070] = {
    name = "[ ?????? ?? ]",
    content0 = "??~ ?? ??? ?????.",
    reward0_count = 0,
    needLevel = 76,
    bQLoop = 0
  }
  refs[1284] = {
    name = "[ 支援龙通路 ]",
    content0 = "您听说龙通路无法顺利施工的消息了吗？",
    reward0_count = 0,
    needLevel = 66,
    bQLoop = 0
  }
  refs[1302] = {
    name = "[ 剩下的担忧 ]",
    content0 = "少侠，龙林银行急着找您呢。",
    reward0_count = 0,
    needLevel = 70,
    bQLoop = 0
  }
  refs[1303] = {
    name = "[ 权宜之计 ]",
    content0 = "大家都认为已经结束了，但问题现在才刚刚出现。",
    reward0_count = 5,
    needLevel = 71,
    bQLoop = 0
  }
  refs[1304] = {
    name = "[ 新方法 ]",
    content0 = "果然没什么作用。",
    reward0_count = 5,
    needLevel = 71,
    bQLoop = 0
  }
  refs[1305] = {
    name = "[ 神檀树的净化 ]",
    content0 = "少侠带来的羊逃之符咒好像让神檀树多少稳定了一些。",
    reward0_count = 0,
    needLevel = 72,
    bQLoop = 0
  }
  return refs
end
