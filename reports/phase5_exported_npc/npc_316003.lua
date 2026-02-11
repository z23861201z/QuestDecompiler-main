-- DB_DRIVEN_EXPORT
-- source: npc_316003.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_316003"
  local refs = {}
  refs[284] = {
    name = "[ ?????(1) ]",
    content0 = "?? ?? ? ???? ?? {0xFFFFFF00}???? ??{END}? ?? ????",
    reward0_count = 0,
    needLevel = 90,
    bQLoop = 0
  }
  refs[285] = {
    name = "[ ?????(2) ]",
    content0 = "??… ?? ???? ??? ?? ?? ????… ??? ?? ??? ???…",
    reward0_count = 0,
    needLevel = 90,
    bQLoop = 0
  }
  refs[288] = {
    name = "[ ???? ??(3) ]",
    content0 = "???...? ?? ??? ?? ??? ???. ?? ?? ?? ??? ????",
    reward0_count = 1,
    needLevel = 90,
    bQLoop = 0
  }
  refs[479] = {
    name = "[ ??? ??? ??? ]",
    content0 = "??? ?? ?? ?? ?? ??? ??? ??? ?? ?? ??. ?? ????? ?? ??? ?? ???? ???? ?? ?? ??? ?? ????? ??. ",
    reward0_count = 0,
    needLevel = 95,
    bQLoop = 0
  }
  refs[562] = {
    name = "[ 冒牌幽灵使者 ]",
    content0 = "最近气力不足，浑身无力啊。到时间离开这世上了吗…",
    reward0_count = 0,
    needLevel = 106,
    bQLoop = 0
  }
  refs[890] = {
    name = "[ 守护古乐的奖励 ]",
    content0 = "{0xFFFFFF00}击退50个[幽灵使者]{END}之后回来就给你{0xFFFFFF00}1个古乐守护符{END}。记住了，这个任务是{0xFFFFFF00}一天只能完成一次{END}。",
    reward0_count = 1,
    needLevel = 99,
    bQLoop = 0
  }
  refs[974] = {
    name = "{0xFFFFB4B4}[ 古乐守护符 ]{END}",
    content0 = "过去镇压了妖怪们的不只是太和老君和他的12个弟子。也不能忘了没来得及留下名字就倒下的无数的英雄们。",
    reward0_count = 0,
    needLevel = 0,
    bQLoop = 0
  }
  refs[1541] = {
    name = "[沉默的诺言]",
    content0 = "难道是我误会了…",
    reward0_count = 0,
    needLevel = 99,
    bQLoop = 0
  }
  refs[1542] = {
    name = "[古乐村重建计划!]",
    content0 = "受宠若惊…太和老君的9弟子东泼肉竟然挂念这落后的村子…",
    reward0_count = 3,
    needLevel = 99,
    bQLoop = 0
  }
  refs[1543] = {
    name = "[面临重建…]",
    content0 = "重建村子要做的事情像小山一样多，再加上最近我的身体状态不是很好，很是苦恼。",
    reward0_count = 0,
    needLevel = 99,
    bQLoop = 0
  }
  refs[1544] = {
    name = "[特殊药材]",
    content0 = "为长老治病的这段时间，我又找到了一种治疗方法。",
    reward0_count = 30,
    needLevel = 99,
    bQLoop = 0
  }
  refs[1545] = {
    name = "[对身体好的东西!]",
    content0 = "多亏少侠帮忙，我已经收到古乐村宝芝林的药了。",
    reward0_count = 0,
    needLevel = 101,
    bQLoop = 0
  }
  refs[1547] = {
    name = "[中和的汤药(1)]",
    content0 = "现在全都结束了，回到老长老那儿把。",
    reward0_count = 0,
    needLevel = 101,
    bQLoop = 0
  }
  refs[1548] = {
    name = "[中和的汤药(2)]",
    content0 = "我认为这些还不够。中和的还不彻底的感觉。该不会把蘑菇都给了年轻书生的母亲，给我的蘑菇少了吧？",
    reward0_count = 0,
    needLevel = 101,
    bQLoop = 0
  }
  refs[1549] = {
    name = "[长老装病]",
    content0 = "虽然少侠千方百计地帮助我，但是我可能再也撑不下去了。咳咳。",
    reward0_count = 0,
    needLevel = 102,
    bQLoop = 0
  }
  refs[1551] = {
    name = "[假药效应(1)]",
    content0 = "你问这是什么药么？吼吼吼。不知少侠是否听说过假药效应一词？",
    reward0_count = 0,
    needLevel = 102,
    bQLoop = 0
  }
  refs[1552] = {
    name = "[假药效应(2)]",
    content0 = "呃，没办法，好像稍微好点儿了。",
    reward0_count = 30,
    needLevel = 102,
    bQLoop = 0
  }
  refs[1553] = {
    name = "[ 永不放弃! ]",
    content0 = "现在我就实话实说了吧。事实上我们家族就好像古乐村的土地爷，长老职位代代相传。",
    reward0_count = 0,
    needLevel = 103,
    bQLoop = 0
  }
  refs[1561] = {
    name = "[长老候补-候补评价]",
    content0 = "少侠。回来了啊。和长老候补们见面后感觉如何？",
    reward0_count = 0,
    needLevel = 105,
    bQLoop = 0
  }
  refs[1562] = {
    name = "[长老候补-最终结果]",
    content0 = "能够领导古乐村的人才众多，我也不再一直让外甥女来当长老了。",
    reward0_count = 0,
    needLevel = 105,
    bQLoop = 0
  }
  return refs
end
