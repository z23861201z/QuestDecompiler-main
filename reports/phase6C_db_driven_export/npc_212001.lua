-- DB_DRIVEN_EXPORT
-- source: npc_212001.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_212001"
  local refs = {}
  refs[103] = {
    name = "[ ????(2??) ]",
    content0 = "??? ??? ?? ??? ??? ???. ??? ??? ??? ???, ?? ????? ?????. ???? ??? ??? ????? ?? ??? ????? ??.",
    reward0_count = 0,
    needLevel = 1,
    bQLoop = 0
  }
  refs[110] = {
    name = "[每晚都传来的怪声]",
    content0 = "欢迎光临。看着没什么精神？是因为最近每晚都传来的怪声，晚上无法入睡才这样的。",
    reward0_count = 0,
    needLevel = 61,
    bQLoop = 0
  }
  refs[156] = {
    name = "[ ???? ?? ]",
    content0 = "???? ??? ? ??? ???. ??…. ?? ? ??? ???? ???? ??! ??? ??? ??? ??????….",
    reward0_count = 0,
    needLevel = 66,
    bQLoop = 0
  }
  refs[1240] = {
    name = "[ 支付宴会费用 ]",
    content0 = "武林人之间的矛盾缓和了不少，皇宫武士也消停了。虽不能说很完美，但冥珠城以后也可以恢复平静了。",
    reward0_count = 1,
    needLevel = 50,
    bQLoop = 0
  }
  refs[1250] = {
    name = "[ 不容易的事 ]",
    content0 = "龙林派师兄可以说是现武林最具名望的人物之一。就是想见一面也很难。",
    reward0_count = 1,
    needLevel = 57,
    bQLoop = 0
  }
  refs[1251] = {
    name = "[ 出乎意料的简单方法 ]",
    content0 = "想见龙林派师兄？PLAYERNAME上次帮龙林城父母官积累了名声，应该不会太难。我给你写一封推荐书。",
    reward0_count = 1,
    needLevel = 58,
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
  refs[1256] = {
    name = "[ 真正的理由2 ]",
    content0 = "我没想过你能帮她解决心事。再次感谢。",
    reward0_count = 0,
    needLevel = 53,
    bQLoop = 0
  }
  refs[1580] = {
    name = "[ 准备开学了！ ]",
    content0 = "少侠，你能帮我个忙吗？",
    reward0_count = 0,
    needLevel = 1,
    bQLoop = 0
  }
  refs[1581] = {
    name = "[ 老媪的礼物 ]",
    content0 = "我们都已经有了礼物，但是不能忘记老人家呀。大侠，得麻烦你替我去趟古乐村",
    reward0_count = 1,
    needLevel = 1,
    bQLoop = 0
  }
  return refs
end
