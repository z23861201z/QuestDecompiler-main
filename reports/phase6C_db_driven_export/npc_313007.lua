-- DB_DRIVEN_EXPORT
-- source: npc_313007.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_313007"
  local refs = {}
  refs[676] = {
    name = "[ 开启新的黄泉（2） ]",
    content0 = "邪派那些家伙不但不会告诉你，还会拿你逗乐子，不过我们正派就算再累也会秉持正义。因此清阴胡须张才让你来找我的吧。",
    reward0_count = 0,
    needLevel = 20,
    bQLoop = 0
  }
  refs[804] = {
    name = "[ 巨大鬼怪-炫耀实力 ]",
    content0 = "糟糕。头一次看到那么无知的家伙，连封印结界也吃掉了。嗯？干嘛目不转睛的看着我。你认识我吗？哼。虽然不记得你了，但是你还得给我帮个忙。可以吧？",
    reward0_count = 1,
    needLevel = 60,
    bQLoop = 0
  }
  refs[869] = {
    name = "[ 愤怒的巨大鬼怪! ]",
    content0 = "PLAYERNAME！大事不妙了。之前出现的巨大鬼怪变得更加残暴，又开始捣乱了",
    reward0_count = 2,
    needLevel = 130,
    bQLoop = 0
  }
  refs[925] = {
    name = "{0xFFFFB4B4}[ 冥珠都城巨大鬼怪 ]{END}",
    content0 = "冥珠城巨大鬼怪黄泉总共分为3阶段。",
    reward0_count = 0,
    needLevel = 0,
    bQLoop = 0
  }
  refs[1229] = {
    name = "[ 冥珠城秘闻的真相 ]",
    content0 = "托少侠的福富翁们的横暴稍有好转，但是冥珠城的混乱仍在继续。富翁们的气势减弱了很多，但冥珠城武林人间的矛盾依然。",
    reward0_count = 1,
    needLevel = 46,
    bQLoop = 0
  }
  refs[1230] = {
    name = "[ 皇宫的阴谋 ]",
    content0 = "冥珠城银行跟少侠说了那样的话吗？是的。我也是这么想的。虽然说是拿着皇宫的俸禄，但我也是为这卑劣的阴谋很气愤啊。",
    reward0_count = 0,
    needLevel = 46,
    bQLoop = 0
  }
  refs[1231] = {
    name = "[ 快嘴 ]",
    content0 = "你对我有什么所求吗？",
    reward0_count = 0,
    needLevel = 46,
    bQLoop = 0
  }
  refs[1232] = {
    name = "[ 为布告做准备 ]",
    content0 = "我计划把少侠偷取来的圣旨抄写数百份，在冥珠城全域散布。但是得秘密进行所以有点难度。",
    reward0_count = 1,
    needLevel = 47,
    bQLoop = 0
  }
  refs[1233] = {
    name = "[ 皇宫的愤怒 ]",
    content0 = "出事了。皇宫武士们为了找回圣旨折腾无辜的居民。哭泣美眉的父母因被怀疑是窃贼抓去，受到严刑拷打之后放回来了。",
    reward0_count = 0,
    needLevel = 48,
    bQLoop = 0
  }
  refs[1237] = {
    name = "[ 为了美人计做准备2 ]",
    content0 = "头发是解决了，但衣服是个问题。少侠能再帮我一次吗？",
    reward0_count = 1,
    needLevel = 49,
    bQLoop = 0
  }
  refs[1238] = {
    name = "[ 宴会的成功 ]",
    content0 = "不知道衫菜表现的怎么样？计划成功了吧？少侠去冥珠都城找冥珠城父母官了解一下结果吧。",
    reward0_count = 0,
    needLevel = 49,
    bQLoop = 0
  }
  refs[1239] = {
    name = "[ 宴会的成功2 ]",
    content0 = "来了？",
    reward0_count = 0,
    needLevel = 49,
    bQLoop = 0
  }
  refs[1240] = {
    name = "[ 支付宴会费用 ]",
    content0 = "武林人之间的矛盾缓和了不少，皇宫武士也消停了。虽不能说很完美，但冥珠城以后也可以恢复平静了。",
    reward0_count = 1,
    needLevel = 50,
    bQLoop = 0
  }
  refs[2073] = {
    name = "[ 军士 - 派遣到冥珠城 ]",
    content0 = "将营地转移到竹林的时候开始和冥珠城的官员们有了接触。万幸的是，兰霉匠的魔掌还没有伸向冥珠城的官员们",
    reward0_count = 0,
    needLevel = 55,
    bQLoop = 0
  }
  refs[2074] = {
    name = "[ 军士 - 兰霉匠的压迫 ]",
    content0 = "事情变得复杂了~跟佣兵团达成协议没多久，从皇宫传来了消息。到现在为止是除了像皇宫进贡土特产之外没有任何要求的..",
    reward0_count = 0,
    needLevel = 56,
    bQLoop = 0
  }
  refs[2075] = {
    name = "[ 军士 - 对于压迫的对策 ]",
    content0 = "得先把下次的税收也准备好。这次需要红蜗牛的壳。充一次电能长时间散发热气，所以在天寒地冻的国家很受欢迎",
    reward0_count = 0,
    needLevel = 57,
    bQLoop = 0
  }
  refs[2076] = {
    name = "[ 军士 - 巨大鬼怪的出现 ]",
    content0 = "出大事了！因为把注意力都放在皇宫那边，所以都没发现黄泉产生了皲裂！现在因为从那个皲裂钻出了巨大鬼怪，冥珠城的仓库受到了攻击",
    reward0_count = 0,
    needLevel = 58,
    bQLoop = 0
  }
  refs[2077] = {
    name = "[ 军士 - 巨大鬼怪横行 ]",
    content0 = "我已经向冥珠城派去了精英，不过有些事要你来做才行",
    reward0_count = 0,
    needLevel = 58,
    bQLoop = 0
  }
  refs[2078] = {
    name = "[ 军士 - 防御巨大鬼怪 ]",
    content0 = "虽然佣兵团成员在抵挡，但也是一场苦战啊！我也不能就这么干坐着，所以一直在研究击退方法，这一想还真让我想到了",
    reward0_count = 0,
    needLevel = 59,
    bQLoop = 0
  }
  refs[2079] = {
    name = "[ 军士 - 2次转职的必要性 ]",
    content0 = "果然很有效果啊，巨大鬼怪逃到了黄泉里了。但现在放松还太早",
    reward0_count = 0,
    needLevel = 60,
    bQLoop = 0
  }
  return refs
end
