-- DB_DRIVEN_EXPORT
-- source: npc_322014.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_322014"
  local refs = {}
  refs[2733] = {
    name = "[ 寻找传说中的药 ]",
    content0 = "巨木神问，想知道什么？",
    reward0_count = 0,
    needLevel = 166,
    bQLoop = 0
  }
  refs[2734] = {
    name = "[ 寻找獐子潭[1] ]",
    content0 = "过了{0xFFFFFF00}封印之石{END}就是{0xFFFFFF00}獐子潭{END}。我现在也在那里修炼。但是，你找{0xFFFFFF00}獐子潭{END}干什么？",
    reward0_count = 0,
    needLevel = 166,
    bQLoop = 0
  }
  refs[2735] = {
    name = "[ 寻找獐子潭[2] ]",
    content0 = "你好，我是来自安哥拉王国的辛巴达。你是从哪里来的啊？",
    reward0_count = 1,
    needLevel = 166,
    bQLoop = 0
  }
  refs[2736] = {
    name = "[ 寻找獐子潭[3] ]",
    content0 = "那里面还有这种{0xFFFFFF00}水晶碎片{END}啊，之前集中修炼都没发现。",
    reward0_count = 0,
    needLevel = 166,
    bQLoop = 0
  }
  refs[2813] = {
    name = "[ 再去獐子潭2 ]",
    content0 = "说服老婆婆了吗？",
    reward0_count = 0,
    needLevel = 170,
    bQLoop = 0
  }
  refs[2814] = {
    name = "[ 再去獐子潭3 ]",
    content0 = "关于石板，有了解到什么吗？",
    reward0_count = 0,
    needLevel = 170,
    bQLoop = 0
  }
  refs[2815] = {
    name = "[ 奇怪的纸条 ]",
    content0 = "掌握了石板内容了吗？",
    reward0_count = 0,
    needLevel = 170,
    bQLoop = 0
  }
  refs[2816] = {
    name = "[ 纸条的来历 ]",
    content0 = "这{0xFFFFFF00}奇怪的纸条{END}的笔迹肯定是{0xFFFFFF00}春水糖{END}的。",
    reward0_count = 0,
    needLevel = 170,
    bQLoop = 0
  }
  refs[2817] = {
    name = "[ 春水糖留下的 ]",
    content0 = "我收集了纸条，发现{0xFFFFFF00}春水糖{END}分明在此处逗留了很久。",
    reward0_count = 0,
    needLevel = 170,
    bQLoop = 0
  }
  refs[2818] = {
    name = "[ 最后的獐子潭人 ]",
    content0 = "别..过..",
    reward0_count = 0,
    needLevel = 170,
    bQLoop = 0
  }
  refs[2819] = {
    name = "[ 春水糖做了什么？ ]",
    content0 = "所以说，是长得像曲怪人的人拿着这本书了是吧。",
    reward0_count = 0,
    needLevel = 170,
    bQLoop = 0
  }
  refs[2820] = {
    name = "[ 春水糖去哪儿了？ ]",
    content0 = "{0xFFFFCCCC}(大家一起集中精神看着那本书。){END}",
    reward0_count = 0,
    needLevel = 170,
    bQLoop = 0
  }
  return refs
end
