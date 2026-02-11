-- DB_DRIVEN_EXPORT
-- source: npc_315024.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_315024"
  local refs = {}
  refs[1091] = {
    name = "[ 花花公子的情人节 ]",
    content0 = "少侠，为了收集糖果忙得不可开交啊，暂时帮我个忙吧！",
    reward0_count = 0,
    needLevel = 1,
    bQLoop = 0
  }
  refs[1240] = {
    name = "[ 支付宴会费用 ]",
    content0 = "武林人之间的矛盾缓和了不少，皇宫武士也消停了。虽不能说很完美，但冥珠城以后也可以恢复平静了。",
    reward0_count = 1,
    needLevel = 50,
    bQLoop = 0
  }
  refs[1254] = {
    name = "[ 真正的理由1 ]",
    content0 = "我睡不着的原因有两个。其中一个就是从冥珠平原传来的鸡叫声。",
    reward0_count = 1,
    needLevel = 51,
    bQLoop = 0
  }
  refs[1255] = {
    name = "[ 鸡叫声的真实面目 ]",
    content0 = "一时失礼了。因为情绪有些激动…。总之我会把知道的都告诉你。大胡子们袭击我们宁静的村落的时候…。父母把我一个人藏在了大坛子里，他们却被杀害了。",
    reward0_count = 1,
    needLevel = 52,
    bQLoop = 0
  }
  refs[1580] = {
    name = "[ 准备开学了！ ]",
    content0 = "少侠，你能帮我个忙吗？",
    reward0_count = 0,
    needLevel = 1,
    bQLoop = 0
  }
  return refs
end
