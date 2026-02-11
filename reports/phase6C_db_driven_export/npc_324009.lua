-- DB_DRIVEN_EXPORT
-- source: npc_324009.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_324009"
  local refs = {}
  refs[2611] = {
    name = "[ 魔布加-深处的深渊 ]",
    content0 = "听说教主在找你。你去更深处调查后就回去吧。",
    reward0_count = 15,
    needLevel = 60,
    bQLoop = 0
  }
  refs[2612] = {
    name = "[ 魔布加-可疑的羊皮纸 ]",
    content0 = "六长…，永健… … ..元凶是…。暗杀者…。中原…",
    reward0_count = 15,
    needLevel = 60,
    bQLoop = 0
  }
  refs[2617] = {
    name = "[ 耶单-深处的深渊 ]",
    content0 = "听说教主在找你。你去更深处调查后就回去吧。",
    reward0_count = 15,
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
  return refs
end
