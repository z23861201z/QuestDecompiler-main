-- DB_DRIVEN_EXPORT
-- source: npc_392001.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_392001"
  local refs = {}
  refs[943] = {
    name = "{0xFFFFB4B4}[ 有关判定 ]{END}",
    content0 = "限制时间内无法分出胜负的话，将用判定的方式决定胜负。",
    reward0_count = 0,
    needLevel = 0,
    bQLoop = 0
  }
  refs[965] = {
    name = "{0xFFFFB4B4}[ 服务器最强者战大会介绍 ]{END}",
    content0 = "天下第一比武大会指的是选举比武最强者的大会。按功力分为4组，进行淘汰赛，最终获胜者即为冠军。",
    reward0_count = 0,
    needLevel = 0,
    bQLoop = 0
  }
  return refs
end
