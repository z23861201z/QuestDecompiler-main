-- DB_DRIVEN_EXPORT
-- source: npc_240002.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_240002"
  local refs = {}
  refs[2181] = {
    name = "[ 针线活必需品 ]",
    content0 = "哎呀...",
    reward0_count = 0,
    needLevel = 175,
    bQLoop = 0
  }
  refs[3644] = {
    name = "[ 顶针材料 ]",
    content0 = "{0xFF99ff99}PLAYERNAME{END}，你好啊",
    reward0_count = 0,
    needLevel = 175,
    bQLoop = 0
  }
  refs[3702] = {
    name = "[ 巫师的旧披风 ]",
    content0 = "嗯..订单很多，但是材料不够可怎么办啊？",
    reward0_count = 0,
    needLevel = 184,
    bQLoop = 0
  }
  return refs
end
