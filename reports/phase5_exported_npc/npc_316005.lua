-- DB_DRIVEN_EXPORT
-- source: npc_316005.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_316005"
  local refs = {}
  refs[110] = {
    name = "[每晚都传来的怪声]",
    content0 = "欢迎光临。看着没什么精神？是因为最近每晚都传来的怪声，晚上无法入睡才这样的。",
    reward0_count = 0,
    needLevel = 61,
    bQLoop = 0
  }
  refs[480] = {
    name = "[ ????!(1) ]",
    content0 = "? ?? ? ???? ??? ???? ?? ??? ?????. ????? ?? ???? ??? ?????? ? ??? ?????.",
    reward0_count = 0,
    needLevel = 96,
    bQLoop = 0
  }
  refs[1554] = {
    name = "[长老候补-寻找候补的方法]",
    content0 = "我担心爷爷给少侠添了太多麻烦。",
    reward0_count = 3,
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
  return refs
end
