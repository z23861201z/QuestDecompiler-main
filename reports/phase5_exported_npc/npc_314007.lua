-- DB_DRIVEN_EXPORT
-- source: npc_314007.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_314007"
  local refs = {}
  refs[1116] = {
    name = "[ 哞读册的友情？ ]",
    content0 = "少侠就是宝芝林说的那个人啊。可以帮下我吗？",
    reward0_count = 5,
    needLevel = 12,
    bQLoop = 0
  }
  refs[1143] = {
    name = "[ 稻草人 ]",
    content0 = "哎哟，少侠你帮帮我吧。",
    reward0_count = 30,
    needLevel = 20,
    bQLoop = 0
  }
  return refs
end
