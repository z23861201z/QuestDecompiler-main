-- DB_DRIVEN_EXPORT
-- source: npc_241004.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_241004"
  local refs = {}
  refs[2904] = {
    name = "[ 收集坚硬的材料 ]",
    content0 = "稍等！你不会就是受到{0xFFFFFF00}太医院莫塔亚{END}委托，在{0xFFFFFF00}大瀑布{END}击退{0xFFFFFF00}晶石怪{END}的{0xFF99ff99}PLAYERNAME{END}吧？",
    reward0_count = 0,
    needLevel = 189,
    bQLoop = 0
  }
  refs[2910] = {
    name = "[ 收集坚固的材料 ]",
    content0 = "{0xFFFFCCCC}(大声){END}请等一下！我刚才还在找你呢。你能再帮我一次吗？",
    reward0_count = 0,
    needLevel = 192,
    bQLoop = 0
  }
  return refs
end
