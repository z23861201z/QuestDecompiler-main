-- DB_DRIVEN_EXPORT
-- source: npc_391092.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_391092"
  local refs = {}
  refs[857] = {
    name = "[ 凶徒地狱-邪恶魔王犬 ]",
    content0 = "到底是鬼谷村？鬼谷村这个地方果然和地狱很近。又出现裂缝了。吓坏的仆人告诉我这件事，我才去的…",
    reward0_count = 0,
    needLevel = 35,
    bQLoop = 0
  }
  return refs
end
