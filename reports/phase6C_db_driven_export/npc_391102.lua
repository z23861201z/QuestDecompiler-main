-- DB_DRIVEN_EXPORT
-- source: npc_391102.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_391102"
  local refs = {}
  refs[803] = {
    name = "[ 暗血地狱-太和老君的教诲 ]",
    content0 = "嗯？为什么找我？不过你看起来好眼熟啊…无所谓啦，你在找需要你帮助的人吗？那你愿意去帮助陷入困境的冥珠城父母官吗？",
    reward0_count = 0,
    needLevel = 60,
    bQLoop = 0
  }
  refs[1263] = {
    name = "[ 营救冥珠城！ ]",
    content0 = "咳咳，不能磨蹭了，得像皇宫禀明情况获得允许后，得召集武人了。",
    reward0_count = 1,
    needLevel = 59,
    bQLoop = 0
  }
  return refs
end
