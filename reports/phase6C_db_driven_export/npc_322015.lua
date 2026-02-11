-- DB_DRIVEN_EXPORT
-- source: npc_322015.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_322015"
  local refs = {}
  refs[2709] = {
    name = "[ 新的修炼 ]",
    content0 = "{0xFF99ff99}PLAYERNAME{END}，辛苦了！以后打算做什么啊？",
    reward0_count = 0,
    needLevel = 165,
    bQLoop = 0
  }
  refs[2740] = {
    name = "[ 给秋叨鱼的信 ]",
    content0 = "所以那个信是从龙林派来的人给我的吗？",
    reward0_count = 0,
    needLevel = 167,
    bQLoop = 0
  }
  refs[2741] = {
    name = "[ 龙林派三兄弟 ]",
    content0 = "你是谁，请亮明身份！",
    reward0_count = 0,
    needLevel = 167,
    bQLoop = 0
  }
  refs[2742] = {
    name = "[ 夏酒蔡的特工 ]",
    content0 = "通过菊花碴听说了一些，果然很厉害！",
    reward0_count = 0,
    needLevel = 167,
    bQLoop = 0
  }
  refs[2743] = {
    name = "[ 寻找春水糖 ]",
    content0 = "在此过程中我们收到了有人在{0xFFFFFF00}西南沼泽地带{END}见过{0xFFFFFF00}春水糖{END}的消息。",
    reward0_count = 0,
    needLevel = 167,
    bQLoop = 0
  }
  refs[2744] = {
    name = "[ 春水糖的痕迹 ]",
    content0 = "{0xFFFFFF00}春水糖{END}在{0xFFFFFF00}獐子潭洞穴{END}停留的时间比我们想的还要长一些。",
    reward0_count = 0,
    needLevel = 167,
    bQLoop = 0
  }
  refs[2745] = {
    name = "[ 危机！封印之石危险 ]",
    content0 = "(穿着红色盔甲的弟子用很紧急的表情跟刘备说悄悄话。)出大事了啊！",
    reward0_count = 0,
    needLevel = 167,
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
  refs[2789] = {
    name = "[ 来历不明的石板(3) ]",
    content0 = "少侠！这到底是怎么回事啊？",
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
  return refs
end
