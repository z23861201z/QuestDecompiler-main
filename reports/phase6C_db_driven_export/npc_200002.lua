-- DB_DRIVEN_EXPORT
-- source: npc_200002.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_200002"
  local refs = {}
  refs[895] = {
    name = "[梦幻的决战]",
    content0 = "你也听说了吧，前不久[梦幻女白蛇]托人传话说，想让人通过承宪道僧进入[梦幻的决战]，击退梦幻的龙凤鸣。如果你有心，也能挑战一下",
    reward0_count = 6,
    needLevel = 170,
    bQLoop = 0
  }
  refs[1578] = {
    name = "[制服老婆婆]",
    content0 = "你~过来一下。如果你觉得不能控制自己的力量，我能给你一个好的提议...",
    reward0_count = 12,
    needLevel = 170,
    bQLoop = 0
  }
  refs[1579] = {
    name = "[化解误会]",
    content0 = "你击退的梦幻的龙凤鸣不是我制作出来的。是这里邪恶的力量按照我记忆中的怪物将之形象化的。还有，我一点都不想回到原来的世界，你回去吧~",
    reward0_count = 1,
    needLevel = 170,
    bQLoop = 0
  }
  return refs
end
