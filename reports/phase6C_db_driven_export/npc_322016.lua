-- DB_DRIVEN_EXPORT
-- source: npc_322016.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_322016"
  local refs = {}
  refs[2709] = {
    name = "[ 新的修炼 ]",
    content0 = "{0xFF99ff99}PLAYERNAME{END}，辛苦了！以后打算做什么啊？",
    reward0_count = 0,
    needLevel = 165,
    bQLoop = 0
  }
  refs[2746] = {
    name = "[ 搜查中断 ]",
    content0 = "真是一场艰难的战斗啊！",
    reward0_count = 0,
    needLevel = 167,
    bQLoop = 0
  }
  refs[2788] = {
    name = "[ 来历不明的石板(2) ]",
    content0 = "我是刘备的异性兄弟张飞。你就是那个有名的{0xFF99ff99}PLAYERNAME{END}啊。",
    reward0_count = 0,
    needLevel = 168,
    bQLoop = 0
  }
  refs[2789] = {
    name = "[ 来历不明的石板(3) ]",
    content0 = "少侠！这到底是怎么回事啊？",
    reward0_count = 0,
    needLevel = 168,
    bQLoop = 0
  }
  refs[2798] = {
    name = "[ 孤独的清丽公主 ]",
    content0 = "{0xFFFFFF00}吕林城老婆婆{END}为什么会这么强烈的反对呢？",
    reward0_count = 0,
    needLevel = 168,
    bQLoop = 0
  }
  refs[2821] = {
    name = "[ 去往安哥拉王国 ]",
    content0 = "想去安哥拉王国？",
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
  refs[2833] = {
    name = "[ 恢复羊皮纸2 ]",
    content0 = "你拿在手上的是什么东西啊？",
    reward0_count = 0,
    needLevel = 170,
    bQLoop = 0
  }
  refs[2834] = {
    name = "[ 集中！集中！集中！ ]",
    content0 = "少侠，能帮个忙吗？",
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
  refs[3743] = {
    name = "[ 每日讨伐队：击退原虫 ]",
    content0 = "你好，我是刘备的义弟关羽。",
    reward0_count = 0,
    needLevel = 167,
    bQLoop = 0
  }
  refs[3753] = {
    name = "[  每日讨伐队：讨伐妖粉怪 ]",
    content0 = "很高兴见到你，我是刘备的义弟关羽。",
    reward0_count = 0,
    needLevel = 168,
    bQLoop = 0
  }
  refs[3755] = {
    name = "[ 每日讨伐队：讨伐曲怪人 ]",
    content0 = "很高兴见到你。我是刘备的结拜兄弟，叫关羽。",
    reward0_count = 0,
    needLevel = 170,
    bQLoop = 0
  }
  return refs
end
