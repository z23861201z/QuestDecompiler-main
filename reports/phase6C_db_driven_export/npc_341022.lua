-- DB_DRIVEN_EXPORT
-- source: npc_341022.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_341022"
  local refs = {}
  refs[2720] = {
    name = "[ 地龙的舌头佳肴 ]",
    content0 = "唉~有什么什么新的料理啊~一直吃葡萄都已经吃腻了！！那个谁！",
    reward0_count = 29,
    needLevel = 186,
    bQLoop = 0
  }
  refs[2906] = {
    name = "[ 鸡的替代品 ]",
    content0 = "啊啊~听说{0xFFFFFF00}东方料理王飞燕{END}开发了新菜单，我真的很想品尝一下~那个你！",
    reward0_count = 0,
    needLevel = 190,
    bQLoop = 0
  }
  refs[3733] = {
    name = "[ 为了更好吃的烧烤]",
    content0 = "上次我帮你制作的地龙的舌头佳肴，味道怎么样？",
    reward0_count = 30,
    needLevel = 186,
    bQLoop = 0
  }
  refs[3784] = {
    name = "[ 人气爆发！烤多足怪虫的脚 ]",
    content0 = "欢迎光临！欢迎光临！",
    reward0_count = 0,
    needLevel = 190,
    bQLoop = 0
  }
  return refs
end
