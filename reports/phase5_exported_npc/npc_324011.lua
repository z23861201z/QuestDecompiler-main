-- DB_DRIVEN_EXPORT
-- source: npc_324011.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_324011"
  local refs = {}
  refs[2613] = {
    name = "[ 魔布加-结束探索 ]",
    content0 = "（这是..邪教制作的毒药啊…是把这个混进策士们的补给品里了吗？…)",
    reward0_count = 0,
    needLevel = 60,
    bQLoop = 0
  }
  refs[2614] = {
    name = "[ 魔布加-去往中原 ]",
    content0 = "咳！！！你…你这家伙也拥有和牟永健弟子们相同力量的啊…啊…啊啊！",
    reward0_count = 1,
    needLevel = 60,
    bQLoop = 0
  }
  refs[2619] = {
    name = "[ 耶单-结束探索 ]",
    content0 = "（这是..邪教制作的毒药啊…是把这个混进策士们的补给品里了吗？…)",
    reward0_count = 0,
    needLevel = 60,
    bQLoop = 0
  }
  refs[2620] = {
    name = "[ 耶单-去往中原 ]",
    content0 = "咳！！！你…你这家伙也拥有和牟永健弟子们相同力量的啊…啊…啊啊！",
    reward0_count = 1,
    needLevel = 60,
    bQLoop = 0
  }
  return refs
end
