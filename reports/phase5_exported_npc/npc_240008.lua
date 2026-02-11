-- DB_DRIVEN_EXPORT
-- source: npc_240008.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_240008"
  local refs = {}
  refs[3699] = {
    name = "[ 去赚钱1 ]",
    content0 = "人活着可真累啊……",
    reward0_count = 0,
    needLevel = 181,
    bQLoop = 0
  }
  refs[3700] = {
    name = "[ 去赚钱2 ]",
    content0 = "我们又见面了~",
    reward0_count = 0,
    needLevel = 182,
    bQLoop = 0
  }
  refs[3703] = {
    name = "[ 去赚钱3 ]",
    content0 = "(商人帕提玛想跟我说话！)",
    reward0_count = 0,
    needLevel = 185,
    bQLoop = 0
  }
  return refs
end
