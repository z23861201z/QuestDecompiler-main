-- DB_DRIVEN_EXPORT
-- source: npc_300145.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_300145"
  local refs = {}
  refs[2582] = {
    name = "[ 帮助居民们的报酬  ]",
    content0 = "看你有不少大目仔币，看来在我们岛上做了不少好事啊！",
    reward0_count = 1,
    needLevel = 1,
    bQLoop = 0
  }
  return refs
end
