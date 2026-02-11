-- DB_DRIVEN_EXPORT
-- source: npc_324010.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_324010"
  local refs = {}
  refs[2612] = {
    name = "[ 魔布加-可疑的羊皮纸 ]",
    content0 = "六长…，永健… … ..元凶是…。暗杀者…。中原…",
    reward0_count = 15,
    needLevel = 60,
    bQLoop = 0
  }
  refs[2613] = {
    name = "[ 魔布加-结束探索 ]",
    content0 = "（这是..邪教制作的毒药啊…是把这个混进策士们的补给品里了吗？…)",
    reward0_count = 0,
    needLevel = 60,
    bQLoop = 0
  }
  refs[2618] = {
    name = "[ 耶单-可疑的羊皮纸 ]",
    content0 = "六长…，永健… … ..元凶是…。暗杀者…。中原…",
    reward0_count = 15,
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
  return refs
end
