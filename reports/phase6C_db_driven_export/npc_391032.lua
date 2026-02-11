-- DB_DRIVEN_EXPORT
-- source: npc_391032.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_391032"
  local refs = {}
  refs[676] = {
    name = "[ 开启新的黄泉（2） ]",
    content0 = "邪派那些家伙不但不会告诉你，还会拿你逗乐子，不过我们正派就算再累也会秉持正义。因此清阴胡须张才让你来找我的吧。",
    reward0_count = 0,
    needLevel = 20,
    bQLoop = 0
  }
  refs[806] = {
    name = "[ 八豆妖地狱-贪婪的猪大长 ]",
    content0 = "哎呦，减寿十年啊。喂，你知道吗？前不久清野江对面的清江村里发生了一件大事儿。",
    reward0_count = 1,
    needLevel = 30,
    bQLoop = 0
  }
  return refs
end
