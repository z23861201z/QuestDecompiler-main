-- DB_DRIVEN_EXPORT
-- source: npc_318002.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_318002"
  local refs = {}
  refs[566] = {
    name = "[ ??? ?? ]",
    content0 = "?? ???? ?? ???? ??? ??? ???. ? ??? ???? ?? ? ?? ??? ????? ??? ????. ??? ?? ?? ???? ????? ????.",
    reward0_count = 0,
    needLevel = 1,
    bQLoop = 0
  }
  refs[567] = {
    name = "[ ???? ?? ]",
    content0 = "????? ?? ?? ?? ??????",
    reward0_count = 0,
    needLevel = 1,
    bQLoop = 0
  }
  refs[858] = {
    name = "[ 改造的士兵等候室 ]",
    content0 = "鬼谷城是载着兰霉匠军队的巨大的军舰。",
    reward0_count = 30,
    needLevel = 15,
    bQLoop = 0
  }
  refs[859] = {
    name = "[ 改造的火焰之房 ]",
    content0 = "改造的火焰之房原来是叫做风炎之房的很可怕的地方。是风中带着无数火焰和火花的充满杀气的地方",
    reward0_count = 30,
    needLevel = 35,
    bQLoop = 0
  }
  refs[860] = {
    name = "[ 改造的岩石下投室 ]",
    content0 = "改造的岩石下投室是位于鬼谷城边缘的地方，飘在高空中向下投掷岩石的地方",
    reward0_count = 30,
    needLevel = 25,
    bQLoop = 0
  }
  refs[1064] = {
    name = "[ 在训练场训练！ ]",
    content0 = "哈哈哈哈！欢迎欢迎啊。有了你这样的少侠，就不怕兰霉匠的军队入侵了",
    reward0_count = 0,
    needLevel = 15,
    bQLoop = 0
  }
  return refs
end
