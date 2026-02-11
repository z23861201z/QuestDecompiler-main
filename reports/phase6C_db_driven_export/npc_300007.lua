-- DB_DRIVEN_EXPORT
-- source: npc_300007.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_300007"
  local refs = {}
  refs[1431] = {
    name = "[化境-疯癫的老人]",
    content0 = "秋叨鱼？皇室军士？太和老君的弟子？这样的人物怎么会在这穷乡僻壤啊？",
    reward0_count = 0,
    needLevel = 130,
    bQLoop = 0
  }
  refs[1432] = {
    name = "[化境-意外相遇]",
    content0 = "嘟嘟囔囔…为了阻止师兄我也打算去西域。可是为了阻止大怪物打开地狱门召唤怪物们，结界…嘟囔…",
    reward0_count = 0,
    needLevel = 130,
    bQLoop = 0
  }
  refs[1435] = {
    name = "[化境-结界的位置]",
    content0 = "要找到结界的位置？你不说我也已经差人把疯癫的老人抓起来搜查了",
    reward0_count = 1,
    needLevel = 130,
    bQLoop = 0
  }
  refs[1436] = {
    name = "[化境-疯癫的天才军师]",
    content0 = "嘻，嘻…我什么也不知道。嘻…",
    reward0_count = 0,
    needLevel = 130,
    bQLoop = 0
  }
  refs[1460] = {
    name = "[化境-隔海消息]",
    content0 = "什么？黑暗的坑？那个不祥之地怎么了？",
    reward0_count = 0,
    needLevel = 130,
    bQLoop = 0
  }
  refs[1461] = {
    name = "[化境-感兴趣的情报]",
    content0 = "什么？黑暗的坑？你也找到黑暗的坑这个线索了？",
    reward0_count = 0,
    needLevel = 130,
    bQLoop = 0
  }
  refs[2654] = {
    name = "[ 鬼魂者的真气 ]",
    content0 = "看你是加入了中原的派系啊。你应该很难完全运用鬼魂者之力啊。",
    reward0_count = 0,
    needLevel = 130,
    bQLoop = 0
  }
  refs[2655] = {
    name = "[ 鬼魂者的真气 ]",
    content0 = "看你是加入了中原的派系啊。你应该很难完全运用鬼魂者之力啊。",
    reward0_count = 0,
    needLevel = 130,
    bQLoop = 0
  }
  return refs
end
