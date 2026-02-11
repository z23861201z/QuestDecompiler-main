-- DB_DRIVEN_EXPORT
-- source: npc_315023.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_315023"
  local refs = {}
  refs[110] = {
    name = "[每晚都传来的怪声]",
    content0 = "欢迎光临。看着没什么精神？是因为最近每晚都传来的怪声，晚上无法入睡才这样的。",
    reward0_count = 0,
    needLevel = 61,
    bQLoop = 0
  }
  refs[1391] = {
    name = "[凶徒的意义]",
    content0 = "施主，你先听听。",
    reward0_count = 0,
    needLevel = 99,
    bQLoop = 0
  }
  refs[1824] = {
    name = "[ ??? ?? ]",
    content0 = "? ??? ? ???? ??.\n",
    reward0_count = 0,
    needLevel = 110,
    bQLoop = 0
  }
  refs[3630] = {
    name = "[ 重生的血玉髓 ]",
    content0 = "你来的正好~你去帮忙击退血玉髓吧",
    reward0_count = 1,
    needLevel = 99,
    bQLoop = 0
  }
  return refs
end
