-- DB_DRIVEN_EXPORT
-- source: npc_324013.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_324013"
  local refs = {}
  refs[2767] = {
    name = "[ 狂战士(男)-神殿深处 ]",
    content0 = "现在就剩最后的训练了。",
    reward0_count = 15,
    needLevel = 60,
    bQLoop = 0
  }
  refs[2768] = {
    name = "[ 狂战士(男)-最后的训练 ]",
    content0 = "(在这里举行祭祀是吧...烧香后鞠个躬吧。)",
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
  refs[2772] = {
    name = "[ 狂战士(女)-最后的训练 ]",
    content0 = "(在这里举行祭祀是吧...烧香后鞠个躬吧。)",
    reward0_count = 15,
    needLevel = 60,
    bQLoop = 0
  }
  return refs
end
