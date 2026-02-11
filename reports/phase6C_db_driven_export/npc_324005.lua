-- DB_DRIVEN_EXPORT
-- source: npc_324005.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_324005"
  local refs = {}
  refs[1912] = {
    name = "[ 兰德-大冲击! ]",
    content0 = "虽然不知道是谁，但听他在提到春水糖的名字时，总感觉有点不怀好意！希望春水糖那边别出什么事才好...",
    reward0_count = 0,
    needLevel = 60,
    bQLoop = 0
  }
  refs[1918] = {
    name = "[ 力魔-大冲击！ ]",
    content0 = "虽然不知道是谁，但听他在提到春水糖的名字时，总感觉有点不怀好意！希望春水糖那边别出什么事才好...",
    reward0_count = 0,
    needLevel = 60,
    bQLoop = 0
  }
  return refs
end
