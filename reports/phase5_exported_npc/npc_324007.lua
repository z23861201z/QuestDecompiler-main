-- DB_DRIVEN_EXPORT
-- source: npc_324007.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_324007"
  local refs = {}
  refs[2261] = {
    name = "[ 纳扎尔-危机中的策士 ]",
    content0 = "大家辛苦了。应该口渴了吧，快喝水吧。我已经喝过了",
    reward0_count = 0,
    needLevel = 1,
    bQLoop = 0
  }
  refs[2262] = {
    name = "[ 纳扎尔-去往中原 ]",
    content0 = "赶快把这解毒药吃了！",
    reward0_count = 0,
    needLevel = 1,
    bQLoop = 0
  }
  refs[2266] = {
    name = "[ 娜迪亚-危机中的策士 ]",
    content0 = "大家辛苦了。应该口渴了吧，快喝水吧。我已经喝过了",
    reward0_count = 0,
    needLevel = 1,
    bQLoop = 0
  }
  refs[2267] = {
    name = "[ 娜迪亚-去往中原 ]",
    content0 = "赶快把这解毒药吃了！",
    reward0_count = 0,
    needLevel = 1,
    bQLoop = 0
  }
  return refs
end
