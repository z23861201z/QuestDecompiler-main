-- DB_DRIVEN_EXPORT
-- source: npc_321002.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_321002"
  local refs = {}
  refs[939] = {
    name = "{0xFFFFB4B4}[ 仙游谷是什么？ ]{END}",
    content0 = "很久以前是神仙住的地方。不过现在他们都变成了可怕的怪物，受他们的妖气影响，整个仙游谷都被雾毒污染。",
    reward0_count = 0,
    needLevel = 0,
    bQLoop = 0
  }
  refs[940] = {
    name = "{0xFFFFB4B4}[ 仙游谷里有人吗？ ]{END}",
    content0 = "以前住在仙游谷的神仙们如今变成了葫芦怪、琵琶妖女、老妖怪，牛犄角支配着他们。",
    reward0_count = 0,
    needLevel = 0,
    bQLoop = 0
  }
  refs[941] = {
    name = "{0xFFFFB4B4}[ 清明丹是什么？ ]{END}",
    content0 = "清明丹可以解仙游谷的雾毒，是那些去仙游谷的人必备灵药。可以在南丰馆南边的医生爱仕达那里购买清明丹。",
    reward0_count = 0,
    needLevel = 0,
    bQLoop = 0
  }
  refs[3656] = {
    name = "[ 守护南丰馆1 ]",
    content0 = "为了守护南丰馆，需要大侠的帮助",
    reward0_count = 1,
    needLevel = 146,
    bQLoop = 0
  }
  return refs
end
