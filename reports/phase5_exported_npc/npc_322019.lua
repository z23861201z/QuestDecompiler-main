-- DB_DRIVEN_EXPORT
-- source: npc_322019.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_322019"
  local refs = {}
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
  refs[2746] = {
    name = "[ 搜查中断 ]",
    content0 = "真是一场艰难的战斗啊！",
    reward0_count = 0,
    needLevel = 167,
    bQLoop = 0
  }
  refs[2786] = {
    name = "[ 辛巴达的联系 ]",
    content0 = "少侠，你来的正好。",
    reward0_count = 0,
    needLevel = 168,
    bQLoop = 0
  }
  refs[2787] = {
    name = "[ 来历不明的石板(1) ]",
    content0 = "你好，我有个东西要给你看看，所以通过刘备联系了你。",
    reward0_count = 0,
    needLevel = 168,
    bQLoop = 0
  }
  refs[2790] = {
    name = "[ 来历不明的石板(4) ]",
    content0 = "{0xFFFFCCCC}(把黏糊糊的分泌物和灰色妖精粉混在一起抹在脏了的獐子潭石板上。){END}啊，好了。现在干净了。",
    reward0_count = 0,
    needLevel = 168,
    bQLoop = 0
  }
  refs[2791] = {
    name = "[ 来历不明的石板(5) ]",
    content0 = "但是我完全看不懂啊。中原的人看懂了吗？",
    reward0_count = 0,
    needLevel = 168,
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
  refs[2820] = {
    name = "[ 春水糖去哪儿了？ ]",
    content0 = "{0xFFFFCCCC}(大家一起集中精神看着那本书。){END}",
    reward0_count = 0,
    needLevel = 170,
    bQLoop = 0
  }
  refs[2821] = {
    name = "[ 去往安哥拉王国 ]",
    content0 = "想去安哥拉王国？",
    reward0_count = 0,
    needLevel = 170,
    bQLoop = 0
  }
  refs[2830] = {
    name = "[ 獐子潭羊皮纸1 ]",
    content0 = "你来了啊。我仔细看了下，这{0xFFFFFF00}獐子潭纸条{END}是用羊皮纸做的。",
    reward0_count = 0,
    needLevel = 170,
    bQLoop = 0
  }
  refs[2831] = {
    name = "[ 獐子潭羊皮纸2 ]",
    content0 = "我想了想，觉得{0xFFFFFF00}曲怪人{END}拥有{0xFFFFFF00}獐子潭羊皮纸碎片{END}的可能性更高。",
    reward0_count = 0,
    needLevel = 170,
    bQLoop = 0
  }
  refs[2832] = {
    name = "[ 恢复羊皮纸1 ]",
    content0 = "但是..这个根本没法看啊。",
    reward0_count = 0,
    needLevel = 170,
    bQLoop = 0
  }
  refs[2835] = {
    name = "[ 羊皮纸恢复完成 ]",
    content0 = "{0xFFFFFF00}獐子潭羊皮纸{END}复原好了。",
    reward0_count = 0,
    needLevel = 170,
    bQLoop = 0
  }
  refs[2836] = {
    name = "[ 獐子潭诅咒的真相1 ]",
    content0 = "这么快就回来了啊！果然厉害~",
    reward0_count = 0,
    needLevel = 170,
    bQLoop = 0
  }
  return refs
end
