-- DB_DRIVEN_EXPORT
-- source: npc_314058.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_314058"
  local refs = {}
  refs[1100] = {
    name = "[ 新的开始 ]",
    content0 = "终于清醒过来了。做了什么美梦了吗？",
    reward0_count = 0,
    needLevel = 1,
    bQLoop = 0
  }
  refs[1101] = {
    name = "[ 长老的请求 ]",
    content0 = "我们艾里村村民原本出生于大陆，被恶势力迫害来到这里定居。通过村子怪物来锻炼自己，准备回故乡的那一天。",
    reward0_count = 0,
    needLevel = 1,
    bQLoop = 0
  }
  refs[1102] = {
    name = "[ 变强（能力） ]",
    content0 = "你可真是坚强的武士啊。恢复的速度惊人。既然功力已经恢复，你想不想提高一下能力？",
    reward0_count = 0,
    needLevel = 2,
    bQLoop = 0
  }
  refs[1103] = {
    name = "[ 变强（武功） ]",
    content0 = "功力提升的话除了能力[ 武功 ]也会变强。这次提升一下武功怎么样？",
    reward0_count = 0,
    needLevel = 2,
    bQLoop = 0
  }
  refs[1104] = {
    name = "[ 吃了才有力气 ]",
    content0 = "说了好半天，嗓子又干了…",
    reward0_count = 20,
    needLevel = 3,
    bQLoop = 0
  }
  refs[1105] = {
    name = "[ 小甜甜妈妈的请求1 ]",
    content0 = "说了这么多话，好累啊。我要休息了。嗯…你也不要闲着，干点什么怎么样？",
    reward0_count = 0,
    needLevel = 4,
    bQLoop = 0
  }
  refs[1112] = {
    name = "[ 另一个开始 ]",
    content0 = "好像恢复很多了。但记忆好像还没有恢复呢？",
    reward0_count = 0,
    needLevel = 9,
    bQLoop = 0
  }
  refs[1202] = {
    name = "[ 长老的想法 ]",
    content0 = "长老好像在找你…好像知道找回你记忆的方法了。咳咳。咳咳。",
    reward0_count = 1,
    needLevel = 1,
    bQLoop = 0
  }
  refs[1467] = {
    name = "[ 长老的智慧 ]",
    content0 = "呵呵！没想到我救起来的人会成长的这么优秀啊",
    reward0_count = 1,
    needLevel = 170,
    bQLoop = 0
  }
  refs[2018] = {
    name = "[ 军士 - 跟佣兵领袖的会面 ]",
    content0 = "看起来恢复的不错啊！不过，还是什么都想不起来吗？",
    reward0_count = 1,
    needLevel = 1,
    bQLoop = 0
  }
  return refs
end
