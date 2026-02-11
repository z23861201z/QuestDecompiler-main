-- DB_DRIVEN_EXPORT
-- source: npc_310005.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_310005"
  local refs = {}
  refs[93] = {
    name = "[ ??? ?? ]",
    content0 = "??? ??? ???.. ???? ??? ???? ??? ????.. ???.. ???…",
    reward0_count = 0,
    needLevel = 42,
    bQLoop = 0
  }
  refs[95] = {
    name = "[ ???? ??? ]",
    content0 = "???.. ???.. ??",
    reward0_count = 0,
    needLevel = 45,
    bQLoop = 0
  }
  refs[96] = {
    name = "[ ???? ??(?? 1??) ]",
    content0 = "?? ???? ???. ? ????? ????.",
    reward0_count = 0,
    needLevel = 46,
    bQLoop = 0
  }
  refs[97] = {
    name = "[ ???? ??(?? 2??) ]",
    content0 = "?? ???? ?????? ??? ???? ????. .. ???? ???? ??? ?? ??? ???? ??? ???",
    reward0_count = 0,
    needLevel = 46,
    bQLoop = 0
  }
  refs[98] = {
    name = "[ ???? ??(??) ]",
    content0 = "?? ???? ?????? ??? ???? ????. .. ???? ???? ??? ?? ??? ???? ??? ???",
    reward0_count = 0,
    needLevel = 46,
    bQLoop = 0
  }
  refs[168] = {
    name = "[ 2次转职(正)-任务2次 ]",
    content0 = "成为真正的武士不但要坚强，还要具备自制力、耐力和风流。这次的考验是去钓鱼，帮助贫困的人们。",
    reward0_count = 1,
    needLevel = 60,
    bQLoop = 0
  }
  refs[171] = {
    name = "[ 2次转职(正)-任务2次 ]",
    content0 = "成为真正的武士不但要坚强，还要具备自制力、耐力和风流。这次的考验是钓鱼，集中注意力。",
    reward0_count = 1,
    needLevel = 60,
    bQLoop = 0
  }
  refs[174] = {
    name = "[ 2次转职(正)-任务2次 ]",
    content0 = "融入黑暗中的技能，其根本是自制力和耐力。紧张的同时也需要从容。这次的考验是去钓鱼，帮助贫困的人们。",
    reward0_count = 1,
    needLevel = 60,
    bQLoop = 0
  }
  refs[177] = {
    name = "[ 2次转职(正)-任务2次 ]",
    content0 = "融入黑暗中的技能，其根本是自制力和耐力。紧张的同时也需要从容。这次的考验是去钓鱼，帮助贫困的人们。",
    reward0_count = 1,
    needLevel = 60,
    bQLoop = 0
  }
  refs[180] = {
    name = "[ 2次转职(正)-任务2次 ]",
    content0 = "修炼道的基本是自制力和忍耐力。这次就用钓鱼来考验你有没有临危不乱的姿态。",
    reward0_count = 1,
    needLevel = 60,
    bQLoop = 0
  }
  refs[183] = {
    name = "[ 2次转职(正)-任务2次 ]",
    content0 = "修炼道的基本是{0xFFFFFF00}自制力和忍耐力{END}。这次就用钓鱼来考验你有没有临危不乱的姿态。",
    reward0_count = 1,
    needLevel = 60,
    bQLoop = 0
  }
  refs[202] = {
    name = "[ ??? ?? ]",
    content0 = "?? ??? ? ???????? ??? ??? ??? ???? ??? ??? ??? ???. ??",
    reward0_count = 0,
    needLevel = 60,
    bQLoop = 0
  }
  refs[246] = {
    name = "[ ???6??-?? ]",
    content0 = "{0xFFFFFF00}????{END}? ??? {0xFFFFFF00}'????'{END}?? ? ?? ??? {0xFFFFFF00}'????'{END}? ?? ??? ???? ??? ?? ????? ??? ??? ??? ??? ????.",
    reward0_count = 1,
    needLevel = 60,
    bQLoop = 0
  }
  refs[247] = {
    name = "[ ???7??-?? ]",
    content0 = "??? ??? ? ??? ?? {0xFFFFFF00}????{END}? ?? ?? ??? ??????? ?? ??? ???? ???? ??? ????? ??? ??.",
    reward0_count = 0,
    needLevel = 60,
    bQLoop = 0
  }
  refs[248] = {
    name = "[ ???8??-?? ]",
    content0 = "??? ????? {0xFFFFFF00}????{END}? ?? ??..?",
    reward0_count = 1,
    needLevel = 60,
    bQLoop = 0
  }
  refs[249] = {
    name = "[ ???9??-???? ]",
    content0 = "?? ???? {0xFFFFFF00}????{END}? ??? ? ?? ?? ???? ????.  ??? ?? ? ? ??? ??? ??? ??? ??? ???? ??? ??? ?? ????? ???? ??.",
    reward0_count = 0,
    needLevel = 60,
    bQLoop = 0
  }
  refs[274] = {
    name = "[ ??? ?? ]",
    content0 = "???? ???? ???? ???? ??? ??? ???? ?????….?? ????…. ?? ???? ?? ??? ? ???? ?? ??? ??? ???…",
    reward0_count = 0,
    needLevel = 80,
    bQLoop = 0
  }
  refs[275] = {
    name = "[ ??? ? ??? ]",
    content0 = "??? ? ????…. ??? ?? ??? ??? ???? ?????? ???? ??? ??? ????? ????.",
    reward0_count = 0,
    needLevel = 80,
    bQLoop = 0
  }
  refs[277] = {
    name = "[制作嘉和符咒（2）]",
    content0 = "现在符咒是完成了，就剩下给符咒注入鬼力让其能发挥真正的符咒的功能。这个事情我可做不了。",
    reward0_count = 0,
    needLevel = 80,
    bQLoop = 0
  }
  refs[278] = {
    name = "[注入鬼力（1）]",
    content0 = "你…一定要进那里吗？至今为止没有一个人能活着回来的。",
    reward0_count = 0,
    needLevel = 80,
    bQLoop = 0
  }
  refs[280] = {
    name = "[注入鬼力（3）]",
    content0 = "那，好了。拿着这个去见{0xFFFFFF00}刺客转职NPC{END}吧。",
    reward0_count = 0,
    needLevel = 80,
    bQLoop = 0
  }
  refs[281] = {
    name = "[注入鬼力（4）]",
    content0 = "那 ，拿着吧。对了！一定要注意了~去击退血玉髓的时候一定要跟可以帮助自己的人组队进入！那去见见{0xFFFFFF00}偷笔怪盗{END}吧。",
    reward0_count = 1,
    needLevel = 80,
    bQLoop = 0
  }
  refs[282] = {
    name = "[ ??? ?? ]",
    content0 = "?? {0xFFFFFF00}???? ?{END}?? ????? ?? ??? ????, ????? ???? ??? ?? ???. ???? ? ??.",
    reward0_count = 0,
    needLevel = 80,
    bQLoop = 0
  }
  refs[384] = {
    name = "[ 2次转职(正)-任务2次 ]",
    content0 = "成为真正的武士不但要坚强，还要具备自制力、耐力和风流。这次的考验是去钓鱼，一边学会聚精会神。",
    reward0_count = 1,
    needLevel = 60,
    bQLoop = 0
  }
  refs[387] = {
    name = "[ 2次转职(正)-任务2次 ]",
    content0 = "成为真正的武士不但要坚强，还要具备自制力、耐力和风流。这次的考验是去钓鱼，一边学会聚精会神。",
    reward0_count = 1,
    needLevel = 60,
    bQLoop = 0
  }
  refs[462] = {
    name = "[希望-寻找秋叨鱼（1）]",
    content0 = "{0xFFFFFF00}秋叨鱼在兰霉匠{END}掌控皇宫的时候，被卷入邪恶的奸计，躲避这个世界，隐居了起来。",
    reward0_count = 0,
    needLevel = 80,
    bQLoop = 0
  }
  refs[463] = {
    name = "[希望-寻找秋叨鱼（2）]",
    content0 = "需要我帮什么忙？我虽然失去了武功，但总会有什么事情是能帮得上忙的。",
    reward0_count = 0,
    needLevel = 80,
    bQLoop = 0
  }
  refs[464] = {
    name = "[希望-寻找秋叨鱼（3）]",
    content0 = "{0xFFFFFF00}在找秋叨鱼？{END}我就是有在出色的搜查能力，也找不到 {0xFFFFFF00}秋叨鱼{END}。",
    reward0_count = 0,
    needLevel = 80,
    bQLoop = 0
  }
  refs[465] = {
    name = "[希望-寻找秋叨鱼（4）]",
    content0 = "你真的收集回来了啊。利用火焰碎片，可以制作赤鬼鸟。这是在皇宫传下来的秘诀。",
    reward0_count = 0,
    needLevel = 80,
    bQLoop = 0
  }
  refs[466] = {
    name = "[希望-寻找秋叨鱼（5）]",
    content0 = "虽然对不起你，但如果我的秘诀失败了，还得麻烦你去收集材料回来。",
    reward0_count = 1,
    needLevel = 80,
    bQLoop = 0
  }
  refs[477] = {
    name = "[ ??? ??(3) ]",
    content0 = "???? ???? ??? ??? ?? ???? ????? ?? ???????, ???? ? ?? ??, ???? ??? ?? ?? ??? ?? ??? ????.",
    reward0_count = 0,
    needLevel = 85,
    bQLoop = 0
  }
  refs[478] = {
    name = "[ ??? ??(4) ]",
    content0 = "??????? ?? ??? ??? ??? ??? ??? ? ??? ????? ??????.",
    reward0_count = 0,
    needLevel = 85,
    bQLoop = 0
  }
  refs[713] = {
    name = "[ 新希望 ]",
    content0 = "真是费了好久的时间。放飞出去的赤鬼鸟们现在回来了。但是…",
    reward0_count = 0,
    needLevel = 99,
    bQLoop = 0
  }
  refs[749] = {
    name = "[ 得道之人 ]",
    content0 = "哈哈哈，就等你这样的英雄呢...\n像你这种英雄的话，应该能用在好事上的",
    reward0_count = 0,
    needLevel = 150,
    bQLoop = 0
  }
  refs[1218] = {
    name = "[ 收集狂的贪欲 ]",
    content0 = "少侠，帮帮我吧。冥珠城名田瞧是世人都知道的收集狂。只要是自己喜欢的东西，不管方式和手段一定要抢到手。",
    reward0_count = 1,
    needLevel = 42,
    bQLoop = 0
  }
  refs[1219] = {
    name = "[ 收集狂的贪欲2 ]",
    content0 = "不知道偷笔怪盗的用心良苦还误会，我真是没脸啊。虽然麻烦，但能不能请你把这佛像再拿给偷笔怪盗，让他来保管啊？",
    reward0_count = 1,
    needLevel = 42,
    bQLoop = 0
  }
  refs[1220] = {
    name = "[ 更积极地解决方案 ]",
    content0 = "听说少侠最近帮助商人们牵制大富翁们的横暴。",
    reward0_count = 0,
    needLevel = 43,
    bQLoop = 0
  }
  refs[1221] = {
    name = "[ 更积极地解决方案2 ]",
    content0 = "少侠，还剩下一件事情。",
    reward0_count = 0,
    needLevel = 43,
    bQLoop = 0
  }
  refs[1226] = {
    name = "[ 最重要的 ]",
    content0 = "不管结果怎么样，我决定按照约定相信你。",
    reward0_count = 1,
    needLevel = 44,
    bQLoop = 0
  }
  refs[1227] = {
    name = "[ 为了断然行动的准备物 ]",
    content0 = "现在燃烧体的制作也完成了，断然进行就可以的，但是疑心重的名田瞧在家放养了很多可怕的警备犬。我一个人可以瞒过警备犬但是燃烧体的气味可瞒不过去啊。",
    reward0_count = 20,
    needLevel = 45,
    bQLoop = 0
  }
  refs[1228] = {
    name = "[ 断然行动以后 ]",
    content0 = "成功了。以后冥珠城的商人们不用偿还名田瞧的不合理的债务了。",
    reward0_count = 0,
    needLevel = 45,
    bQLoop = 0
  }
  refs[1316] = {
    name = "[ 秘密浮出水面1 ]",
    content0 = "这么快就接近80功力了，果然能力不凡。",
    reward0_count = 0,
    needLevel = 77,
    bQLoop = 0
  }
  refs[1317] = {
    name = "[ 秘密浮出水面2 ]",
    content0 = "神檀树？十二妖怪的目标？原来如此。少侠已经知道了啊。",
    reward0_count = 0,
    needLevel = 77,
    bQLoop = 0
  }
  refs[1318] = {
    name = "[ 秘密浮出水面3 ]",
    content0 = "好久不见。",
    reward0_count = 0,
    needLevel = 77,
    bQLoop = 0
  }
  refs[1319] = {
    name = "[ 秘密浮出水面4 ]",
    content0 = "我不知道神檀树为什么突然沉默了，但我知道谁吃铁。",
    reward0_count = 0,
    needLevel = 77,
    bQLoop = 0
  }
  refs[1320] = {
    name = "[ 秘密浮出水面5 ]",
    content0 = "听说铁腕谷里还剩下许多的四不象。",
    reward0_count = 0,
    needLevel = 78,
    bQLoop = 0
  }
  refs[1321] = {
    name = "[ 永远的秘密 ]",
    content0 = "在少侠击退四不象的时候我又收集了一些情报，知道除了四不象还有其他怪物在帮助马四掌。",
    reward0_count = 1,
    needLevel = 78,
    bQLoop = 0
  }
  refs[1322] = {
    name = "[ 永远的秘密2 ]",
    content0 = "接下来该是豆腐鬼童了。去古乐山击退豆腐鬼童，收集30个腐烂的豆腐回来吧。",
    reward0_count = 0,
    needLevel = 79,
    bQLoop = 0
  }
  refs[1323] = {
    name = "[秘密的重要性]",
    content0 = "愤怒的马四掌终于出面了。只要把它击退了，就不用担心秘密泄露…",
    reward0_count = 1,
    needLevel = 79,
    bQLoop = 0
  }
  refs[1324] = {
    name = "[秘密的重要性2]",
    content0 = "我已经准备好了，就先出发了。少侠去找龙林城北边的龙林派师兄处告诉他已经做好准备了。",
    reward0_count = 0,
    needLevel = 80,
    bQLoop = 0
  }
  refs[2091] = {
    name = "[ 2次转职(正)-任务2次 ]",
    content0 = "成为真正的武士不但要坚强，还要具备自制力、耐力和风流。这次的考验是去钓鱼，一边学会聚精会神。",
    reward0_count = 1,
    needLevel = 60,
    bQLoop = 0
  }
  refs[2094] = {
    name = "[ 2次转职(正)-任务2次 ]",
    content0 = "成为真正的武士不但要坚强，还要具备自制力、耐力和风流。这次的考验是去钓鱼，一边学会聚精会神。",
    reward0_count = 1,
    needLevel = 60,
    bQLoop = 0
  }
  return refs
end
