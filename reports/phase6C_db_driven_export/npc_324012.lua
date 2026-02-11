-- DB_DRIVEN_EXPORT
-- source: npc_324012.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_324012"
  local refs = {}
  refs[2765] = {
    name = "[ 狂战士(男)-神殿净化(1) ]",
    content0 = "净化此处的神殿之后，就结束训练。",
    reward0_count = 15,
    needLevel = 60,
    bQLoop = 0
  }
  refs[2766] = {
    name = "[ 狂战士(男)-神殿净化(2) ]",
    content0 = "这次是净化更里面的怪物。",
    reward0_count = 15,
    needLevel = 60,
    bQLoop = 0
  }
  refs[2767] = {
    name = "[ 狂战士(男)-神殿深处 ]",
    content0 = "现在就剩最后的训练了。",
    reward0_count = 15,
    needLevel = 60,
    bQLoop = 0
  }
  refs[2769] = {
    name = "[ 狂战士(女)-神殿净化(1) ]",
    content0 = "净化此处的神殿之后，就结束训练。",
    reward0_count = 15,
    needLevel = 60,
    bQLoop = 0
  }
  refs[2770] = {
    name = "[ 狂战士(女)-神殿净化(2) ]",
    content0 = "这次是净化更里面的怪物。",
    reward0_count = 15,
    needLevel = 60,
    bQLoop = 0
  }
  refs[2771] = {
    name = "[ 狂战士(女)-神殿深处 ]",
    content0 = "现在就剩最后的训练了。",
    reward0_count = 15,
    needLevel = 60,
    bQLoop = 0
  }
  return refs
end
