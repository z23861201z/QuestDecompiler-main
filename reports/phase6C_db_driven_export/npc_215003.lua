-- DB_DRIVEN_EXPORT
-- source: npc_215003.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_215003"
  local refs = {}
  refs[152] = {
    name = "[ ??? ???? ??? ?? ]",
    content0 = "??? ????? ??? ????…. ????…. ?? ???~ ?????? ?? ?? ???? ? ????",
    reward0_count = 1,
    needLevel = 62,
    bQLoop = 0
  }
  refs[165] = {
    name = "[ ????? ??? ]",
    content0 = "??? ?????. ???? ???? ??? ?? ???? ?? ??? ? ?????.",
    reward0_count = 0,
    needLevel = 77,
    bQLoop = 0
  }
  refs[1272] = {
    name = "[ 不断的考验2 ]",
    content0 = "帮我们做船帆的防具店好像有什么困难。如果船帆不能按时做好的话会耽误计划。",
    reward0_count = 0,
    needLevel = 61,
    bQLoop = 0
  }
  refs[1273] = {
    name = "[ 不断的考验3 ]",
    content0 = "帮我做船帆吗？太谢谢了，最近婚礼太多，我这儿正缺帮手呢。",
    reward0_count = 5,
    needLevel = 61,
    bQLoop = 0
  }
  refs[1274] = {
    name = "[ 白灰粉惊人的效用 ]",
    content0 = "你就是帮助龙林城害了了防具店的少侠吗？",
    reward0_count = 1,
    needLevel = 62,
    bQLoop = 0
  }
  refs[1275] = {
    name = "[ 新娘的悲伤 ]",
    content0 = "现在皇宫武士们为了与韩野城的战争正在征收军需品。再这样下去将无法举办婚礼。",
    reward0_count = 1,
    needLevel = 62,
    bQLoop = 0
  }
  return refs
end
