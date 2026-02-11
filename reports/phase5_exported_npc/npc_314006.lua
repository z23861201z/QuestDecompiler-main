-- DB_DRIVEN_EXPORT
-- source: npc_314006.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_314006"
  local refs = {}
  refs[1119] = {
    name = "[ 清阴关的友爱 ]",
    content0 = "现在都烦清阴关了！乡下也就算了，没有一个人帮我！",
    reward0_count = 0,
    needLevel = 13,
    bQLoop = 0
  }
  refs[1120] = {
    name = "[ 帮忙的代价 ]",
    content0 = "并不是完全相信你的话，但是既然你帮了我，我也会帮你。听说你为了找回自己的记忆，到处在找认识你的人？",
    reward0_count = 5,
    needLevel = 13,
    bQLoop = 0
  }
  return refs
end
