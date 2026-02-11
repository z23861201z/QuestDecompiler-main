-- DB_DRIVEN_EXPORT
-- source: npc_315019.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_315019"
  local refs = {}
  refs[1008] = {
    name = "[ 冒牌部队成员 ]",
    content0 = "兰霉匠您又来了。我还没找到西米路呢…",
    reward0_count = 0,
    needLevel = 41,
    bQLoop = 0
  }
  refs[1043] = {
    name = "[ 支援皇宫武士 ]",
    content0 = "你这家伙是谁？",
    reward0_count = 0,
    needLevel = 41,
    bQLoop = 0
  }
  refs[1046] = {
    name = "[ 剧变开始 ]",
    content0 = "内容说的是兰霉匠带领着鬼谷城，即将开始进攻，做好准备。",
    reward0_count = 0,
    needLevel = 60,
    bQLoop = 0
  }
  refs[1289] = {
    name = "[ 暴风前夜5 ]",
    content0 = "原来有这种事情。我也一直担心冬混汤一族和我们部族年轻人之间的矛盾。",
    reward0_count = 0,
    needLevel = 67,
    bQLoop = 0
  }
  refs[1290] = {
    name = "[ 暴风前夜6 ]",
    content0 = "辛苦了。",
    reward0_count = 0,
    needLevel = 67,
    bQLoop = 0
  }
  refs[1823] = {
    name = "[ ?? ??? ]",
    content0 = "?????????? ?? ???? ?? ??? ?? ??? ? ?? ??? ???? ??? ??? ??? ?? ????\n",
    reward0_count = 0,
    needLevel = 110,
    bQLoop = 0
  }
  return refs
end
