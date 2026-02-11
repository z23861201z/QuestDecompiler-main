-- DB_DRIVEN_EXPORT
-- source: npc_314036.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_314036"
  local refs = {}
  refs[2119] = {
    name = "[ 最好的料理（1） ]",
    content0 = "喂！你！",
    reward0_count = 0,
    needLevel = 107,
    bQLoop = 0
  }
  refs[2120] = {
    name = "[ 最好的料理（2） ]",
    content0 = "喂！你！",
    reward0_count = 0,
    needLevel = 107,
    bQLoop = 0
  }
  refs[2121] = {
    name = "[ 最好的料理（3） ]",
    content0 = "喂！你！",
    reward0_count = 1,
    needLevel = 107,
    bQLoop = 0
  }
  refs[2131] = {
    name = "[ 体力锻炼（1） ]",
    content0 = "喂！你！",
    reward0_count = 0,
    needLevel = 109,
    bQLoop = 0
  }
  refs[2132] = {
    name = "[ 体力锻炼（2） ]",
    content0 = "喂！你！",
    reward0_count = 0,
    needLevel = 109,
    bQLoop = 0
  }
  refs[2133] = {
    name = "[ 体力锻炼（3） ]",
    content0 = "喂！你！",
    reward0_count = 0,
    needLevel = 109,
    bQLoop = 0
  }
  refs[2134] = {
    name = "[ 我的斧头最棒了 ]",
    content0 = "喂！你！",
    reward0_count = 0,
    needLevel = 109,
    bQLoop = 0
  }
  return refs
end
