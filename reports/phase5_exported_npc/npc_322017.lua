-- DB_DRIVEN_EXPORT
-- source: npc_322017.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_322017"
  local refs = {}
  refs[2709] = {
    name = "[ 新的修炼 ]",
    content0 = "{0xFF99ff99}PLAYERNAME{END}，辛苦了！以后打算做什么啊？",
    reward0_count = 0,
    needLevel = 165,
    bQLoop = 0
  }
  refs[2787] = {
    name = "[ 来历不明的石板(1) ]",
    content0 = "你好，我有个东西要给你看看，所以通过刘备联系了你。",
    reward0_count = 0,
    needLevel = 168,
    bQLoop = 0
  }
  refs[2788] = {
    name = "[ 来历不明的石板(2) ]",
    content0 = "我是刘备的异性兄弟张飞。你就是那个有名的{0xFF99ff99}PLAYERNAME{END}啊。",
    reward0_count = 0,
    needLevel = 168,
    bQLoop = 0
  }
  refs[2860] = {
    name = "[ 哈玛特品尝酒2 ]",
    content0 = "{0xFFFFCCCC}(哈玛特很认真的在品酒。){END}这是..第一次品尝的味道！",
    reward0_count = 0,
    needLevel = 171,
    bQLoop = 0
  }
  refs[2861] = {
    name = "[ 张飞拿来的酒 ]",
    content0 = "好久不见了！",
    reward0_count = 1,
    needLevel = 171,
    bQLoop = 0
  }
  return refs
end
