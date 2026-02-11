-- DB_DRIVEN_EXPORT
-- source: npc_214001.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_214001"
  local refs = {}
  refs[1111] = {
    name = "[ 广柱的健康状态 ]",
    content0 = "咳，咳咳！这么快就来了？托我的福你现在变得又聪明又敏捷呢。",
    reward0_count = 0,
    needLevel = 9,
    bQLoop = 0
  }
  refs[1112] = {
    name = "[ 另一个开始 ]",
    content0 = "好像恢复很多了。但记忆好像还没有恢复呢？",
    reward0_count = 0,
    needLevel = 9,
    bQLoop = 0
  }
  refs[1113] = {
    name = "[ 记忆的线索 ]",
    content0 = "找回记忆的方法吗？那个嘛…你看看这个怎么样？使头脑清醒，增加记忆力的针灸术，不过做针的材料刚好用完了。",
    reward0_count = 20,
    needLevel = 1,
    bQLoop = 0
  }
  refs[1114] = {
    name = "[ 找回记忆的方法 ]",
    content0 = "针灸术好像对你没什么作用，那么就只能让你施展一下你的能力了。",
    reward0_count = 0,
    needLevel = 1,
    bQLoop = 0
  }
  refs[1115] = {
    name = "[ 派报员的小聪明 ]",
    content0 = "刚好我有要给商人转达的简讯，一边送简讯一边见到人，没准能遇到少侠记得的人或记得少侠的人，不是吗？",
    reward0_count = 1,
    needLevel = 1,
    bQLoop = 0
  }
  refs[1341] = {
    name = "[ 以防万一 ]",
    content0 = "最近怎么样？没有因为打怪受伤什么的吧？",
    reward0_count = 20,
    needLevel = 12,
    bQLoop = 0
  }
  return refs
end
