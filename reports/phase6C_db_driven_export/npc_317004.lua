-- DB_DRIVEN_EXPORT
-- source: npc_317004.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_317004"
  local refs = {}
  refs[1138] = {
    name = "[ 新鲜的食材 ]",
    content0 = "{0xFF99FF99}PLAYERNAME{END}，我有个请求。",
    reward0_count = 1,
    needLevel = 18,
    bQLoop = 0
  }
  refs[1151] = {
    name = "[ 要挟请求2 ]",
    content0 = "我小的时候嘴角被鸟啄，留下了伤疤。这胡须其实也是为了伤疤才留的。",
    reward0_count = 0,
    needLevel = 22,
    bQLoop = 0
  }
  refs[1153] = {
    name = "[ 乌骨鸡的性急 ]",
    content0 = "嗯，去见路边摊了？",
    reward0_count = 1,
    needLevel = 23,
    bQLoop = 0
  }
  refs[1155] = {
    name = "[ 厨师的疑心 ]",
    content0 = "您是之前见过的？是乌骨鸡让你来的？（语气变了）哼，就你一个人能干什么事啊？我也是邪派的武人呢。我们邪派的武人平时就这样隐藏着身份。",
    reward0_count = 1,
    needLevel = 23,
    bQLoop = 0
  }
  refs[1160] = {
    name = "[ 新的料理 ]",
    content0 = "你得帮帮我。",
    reward0_count = 0,
    needLevel = 25,
    bQLoop = 0
  }
  refs[1166] = {
    name = "[ 厨师的魂 ]",
    content0 = "你看，再次深刻体会到新的料理材料很正要。",
    reward0_count = 0,
    needLevel = 28,
    bQLoop = 0
  }
  refs[1173] = {
    name = "[ 厨师的失误 ]",
    content0 = "油到底去哪儿了啊？",
    reward0_count = 20,
    needLevel = 31,
    bQLoop = 0
  }
  refs[1175] = {
    name = "[ 厨师的情报 ]",
    content0 = "据逃离强悍巷道的矿工们说，巨大的猪头怪物控制着其他怪物，使用各种邪恶的法术掌控着巷道。",
    reward0_count = 50,
    needLevel = 32,
    bQLoop = 0
  }
  refs[1177] = {
    name = "[ 给乌骨鸡的礼物 ]",
    content0 = "和预计的一样，你收集来的{0xFFFFFF00}[ 破烂的灯 ]{END}一直朝向芦苇林亮着。快把这件事情告诉乌骨鸡大侠吧。",
    reward0_count = 20,
    needLevel = 33,
    bQLoop = 0
  }
  refs[1400] = {
    name = "[ ???? ????! ]",
    content0 = "????! ? ??? ??? ????!",
    reward0_count = 0,
    needLevel = 1,
    bQLoop = 0
  }
  refs[1401] = {
    name = "[ ??? ??! ]",
    content0 = "?? ?? ????? ??? ?? ??? ?? ???. ?? ?? ??? ? ????, ???? ??? ????",
    reward0_count = 0,
    needLevel = 1,
    bQLoop = 0
  }
  return refs
end
