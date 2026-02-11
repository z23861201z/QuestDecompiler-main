-- DB_DRIVEN_EXPORT
-- source: npc_314021.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_314021"
  local refs = {}
  refs[60] = {
    name = "[ 选择派系 ]",
    content0 = "所谓正派指的是尊敬长辈，遵守江湖秩序，胸怀大志，作风正直的武林人士。我相信只有正派人士才能拯救被恶鬼扰乱的世界。你也加入正派吧？",
    reward0_count = 0,
    needLevel = 1,
    bQLoop = 0
  }
  refs[64] = {
    name = "[ 选择派系 ]",
    content0 = "唯有力量才是江湖的秩序。所谓力量也可以让我们获得我们想要的东西。可不要像看怪物一样看我。我们邪派在和怪物们的战争当中最为活跃。哈哈哈！",
    reward0_count = 0,
    needLevel = 1,
    bQLoop = 0
  }
  refs[113] = {
    name = "[ 创建门派 ]",
    content0 = "为了守住自从太和老君消失之后开始怪物横行的江湖，元老院决定允许门派的创立。",
    reward0_count = 0,
    needLevel = 1,
    bQLoop = 0
  }
  refs[118] = {
    name = "[ 飞龙掌 ]",
    content0 = "所谓正义指的不完全是大义。守护并帮助被恶徒和怪物迫害的弱者也是正义的一种。",
    reward0_count = 0,
    needLevel = 50,
    bQLoop = 0
  }
  refs[119] = {
    name = "[ 飞龙掌 ]",
    content0 = "所谓正义指的不完全是大义。守护并帮助被恶徒和怪物迫害的弱者也是正义的一种。",
    reward0_count = 0,
    needLevel = 50,
    bQLoop = 0
  }
  refs[120] = {
    name = "[ 飞龙掌 ]",
    content0 = "所谓正义指的不完全是大义。守护并帮助被恶徒和怪物迫害的弱者也是正义的一种。",
    reward0_count = 0,
    needLevel = 50,
    bQLoop = 0
  }
  refs[167] = {
    name = "[ 2次转职(体)-任务1次 ]",
    content0 = "使用刀剑的人需要知道其刀刃的意义。毕竟小孩子也能把武器举起来。你使用武器是为了什么？",
    reward0_count = 1,
    needLevel = 60,
    bQLoop = 0
  }
  refs[168] = {
    name = "[ 2次转职(正)-任务2次 ]",
    content0 = "成为真正的武士不但要坚强，还要具备自制力、耐力和风流。这次的考验是去钓鱼，帮助贫困的人们。",
    reward0_count = 1,
    needLevel = 60,
    bQLoop = 0
  }
  refs[169] = {
    name = "[ 2次转职(人)-任务3次 ]",
    content0 = "这是最后的考验。集中精神，听好了。在这个世界上没有一件事情可以靠自己的力量来实现。你受到多少人的认可呢？",
    reward0_count = 1,
    needLevel = 60,
    bQLoop = 0
  }
  refs[173] = {
    name = "[ 2次转职(体)-任务1次 ]",
    content0 = "踩影子的人需要了解生与死的含义。如果连这些都不知道就掌控别人的死活，那只能称其为杀人者。你使用武器是为了什么？",
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
  refs[175] = {
    name = "[ 2次转职(人)-任务3次 ]",
    content0 = "这是最后的考验。集中精神，听好了。在这个世界上没有一件事情可以靠自己的力量来实现。你受到多少人的认可呢？",
    reward0_count = 1,
    needLevel = 60,
    bQLoop = 0
  }
  refs[179] = {
    name = "[ 2次转职(体)-任务1次 ]",
    content0 = "修道首先要了解自己。世上一切的开始源于自身，也终止于自身。你的内心装着什么？",
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
  refs[181] = {
    name = "[ 2次转职(人)-任务3次 ]",
    content0 = "这是最后的考验。集中精神，听好了。在这个世界上没有一件事情可以靠自己的力量来实现。你受到多少人的认可呢？",
    reward0_count = 1,
    needLevel = 60,
    bQLoop = 0
  }
  refs[363] = {
    name = "[ 连冲跳 ]",
    content0 = "在池塘里畅游的鲢鱼真是充满了生机。看着鲢鱼我想起在很久以前正邪派之间起了很大的冲突，那时突然出现了一名武人。",
    reward0_count = 0,
    needLevel = 45,
    bQLoop = 0
  }
  refs[364] = {
    name = "[ 连冲跳 ]",
    content0 = "在池塘里畅游的鲢鱼真是充满了生机。看着鲢鱼我想起在很久以前正邪派之间起了很大的冲突，那时突然出现了一名武人。",
    reward0_count = 0,
    needLevel = 45,
    bQLoop = 0
  }
  refs[365] = {
    name = "[ 连冲跳 ]",
    content0 = "在池塘里畅游的鲢鱼真是充满了生机。看着鲢鱼我想起在很久以前正邪派之间起了很大的冲突，那时突然出现了一名武人。",
    reward0_count = 0,
    needLevel = 45,
    bQLoop = 0
  }
  refs[366] = {
    name = "[ 连冲跳 ]",
    content0 = "在池塘里畅游的鲢鱼真是充满了生机。看着鲢鱼我想起在很久以前正邪派之间起了很大的冲突，那时突然出现了一名武人。",
    reward0_count = 0,
    needLevel = 45,
    bQLoop = 0
  }
  refs[371] = {
    name = "[ 天然聚气 ]",
    content0 = "太和老君'突然出现在阿鼻叫唤的时代，击退怪物，引领正邪两派，他不仅传授了'连冲跳'，还传授了另外一种武功。",
    reward0_count = 0,
    needLevel = 55,
    bQLoop = 0
  }
  refs[372] = {
    name = "[ 天然聚气 ]",
    content0 = "太和老君'突然出现在阿鼻叫唤的时代，击退怪物，引领正邪两派，他不仅传授了'连冲跳'，还传授了另外一种武功。",
    reward0_count = 0,
    needLevel = 55,
    bQLoop = 0
  }
  refs[373] = {
    name = "[ 天然聚气 ]",
    content0 = "太和老君'突然出现在阿鼻叫唤的时代，击退怪物，引领正邪两派，他不仅传授了'连冲跳'，还传授了另外一种武功。",
    reward0_count = 0,
    needLevel = 55,
    bQLoop = 0
  }
  refs[374] = {
    name = "[ 天然聚气 ]",
    content0 = "太和老君'突然出现在阿鼻叫唤的时代，击退怪物，引领正邪两派，他不仅传授了'连冲跳'，还传授了另外一种武功。",
    reward0_count = 0,
    needLevel = 55,
    bQLoop = 0
  }
  refs[381] = {
    name = "[ 飞龙掌 ]",
    content0 = "所谓正义指的不完全是大义。守护并帮助被恶徒和怪物迫害的弱者也是正义的一种。",
    reward0_count = 0,
    needLevel = 50,
    bQLoop = 0
  }
  refs[383] = {
    name = "[ 2次转职(体)-任务1次 ]",
    content0 = "可以自由使用斧和轮的无尽的力量！你觉得那力量的源泉是什么？",
    reward0_count = 1,
    needLevel = 60,
    bQLoop = 0
  }
  refs[384] = {
    name = "[ 2次转职(正)-任务2次 ]",
    content0 = "成为真正的武士不但要坚强，还要具备自制力、耐力和风流。这次的考验是去钓鱼，一边学会聚精会神。",
    reward0_count = 1,
    needLevel = 60,
    bQLoop = 0
  }
  refs[385] = {
    name = "[ 2次转职(人)-任务3次 ]",
    content0 = "这么快~就到了最后的考验。集中精神，听好了。并非武力，真正得到认可才是高人一等。你受到多少人的认可呢？",
    reward0_count = 1,
    needLevel = 60,
    bQLoop = 0
  }
  refs[483] = {
    name = "[ ???? ?? ]",
    content0 = "??..? ?? ?? ???? ?? ?? ??? 2??? ??? ??????… ???? ??? ???.. ,..",
    reward0_count = 1,
    needLevel = 98,
    bQLoop = 0
  }
  refs[626] = {
    name = "[ 连冲跳 ]",
    content0 = "在池塘里畅游的鲢鱼真是充满了生机。看着鲢鱼我想起在很久以前正邪派之间起了很大的冲突，那时突然出现了一名武人。",
    reward0_count = 0,
    needLevel = 45,
    bQLoop = 0
  }
  refs[627] = {
    name = "[ 飞龙掌 ]",
    content0 = "所谓正义指的不完全是大义。守护并帮助被恶徒和怪物迫害的弱者也是正义的一种。",
    reward0_count = 0,
    needLevel = 50,
    bQLoop = 0
  }
  refs[628] = {
    name = "[ 天然聚气 ]",
    content0 = "太和老君'突然出现在阿鼻叫唤的时代，击退怪物，引领正邪两派，他不仅传授了'连冲跳'，还传授了另外一种武功。",
    reward0_count = 0,
    needLevel = 55,
    bQLoop = 0
  }
  refs[633] = {
    name = "[ 2次转职(体)-任务1次 ]",
    content0 = "射手的义务是帮助弱者，消除邪恶。{0xFF99FF99}PLAYERNAME{END}是否一直在忠于射手的义务了呢？",
    reward0_count = 1,
    needLevel = 60,
    bQLoop = 0
  }
  refs[634] = {
    name = "[ 2次转职(正)-任务2次 ]",
    content0 = "做侠义之事也要有时机的。轻率的行侠仗义有时别说是帮忙了，反而会雪上加霜。",
    reward0_count = 1,
    needLevel = 60,
    bQLoop = 0
  }
  refs[635] = {
    name = "[ 2次转职(人)-任务3次 ]",
    content0 = "最后一次考验。我已经确认了{0xFF99FF99}PLAYERNAME{END}通过修炼获得了能力。这次是要了解别人是怎么评价你的。",
    reward0_count = 1,
    needLevel = 60,
    bQLoop = 0
  }
  refs[675] = {
    name = "[ 开启新的黄泉（1） ]",
    content0 = "呵呵。末日到了。兰霉匠终于动手了。啧啧。",
    reward0_count = 0,
    needLevel = 20,
    bQLoop = 0
  }
  refs[676] = {
    name = "[ 开启新的黄泉（2） ]",
    content0 = "邪派那些家伙不但不会告诉你，还会拿你逗乐子，不过我们正派就算再累也会秉持正义。因此清阴胡须张才让你来找我的吧。",
    reward0_count = 0,
    needLevel = 20,
    bQLoop = 0
  }
  refs[803] = {
    name = "[ 暗血地狱-太和老君的教诲 ]",
    content0 = "嗯？为什么找我？不过你看起来好眼熟啊…无所谓啦，你在找需要你帮助的人吗？那你愿意去帮助陷入困境的冥珠城父母官吗？",
    reward0_count = 0,
    needLevel = 60,
    bQLoop = 0
  }
  refs[955] = {
    name = "{0xFFFFB4B4}[ 泰华武功基础篇 ]{END}",
    content0 = "完成从白斩姬或乌骨鸡处领取的[ 太和老君的教诲 ]就被赋予可以获得泰华武功的资格。",
    reward0_count = 0,
    needLevel = 0,
    bQLoop = 0
  }
  refs[956] = {
    name = "{0xFFFFB4B4}[ 泰华武功武士篇 ]{END}",
    content0 = "{0xFFFFFF00}[ 太 ]注魂器(功力65){END}-之前武功是气力转换，恢复鬼力的功能消失，变成每次攻击时提升致命率的武功。但对人不适用。",
    reward0_count = 0,
    needLevel = 0,
    bQLoop = 0
  }
  refs[957] = {
    name = "{0xFFFFB4B4}[ 泰华武功刺客篇 ]{END}",
    content0 = "{0xFFFFFF00}[ 太 ]破解术(功力65){END}-之前武功是解毒术，中和毒性的功能消失，变成每次攻击时提升致命率的武功。但，对人不适用。",
    reward0_count = 0,
    needLevel = 0,
    bQLoop = 0
  }
  refs[958] = {
    name = "{0xFFFFB4B4}[ 泰华武功道士篇 ]{END}",
    content0 = "{0xFFFFFF00}[ 太 ]气运血(功力65){END}-之前武功是阴阳幻移，恢复体力的功能消失，变成每次攻击时提升致命率的武功。但，对人不适用。",
    reward0_count = 0,
    needLevel = 0,
    bQLoop = 0
  }
  refs[959] = {
    name = "{0xFFFFB4B4}[ 泰华武功力士篇 ]{END}",
    content0 = "{0xFFFFFF00}[ 太 ]内劲魄力(功力65){END}-之前武功是碧波雷，把所受到的伤害转换成鬼力的功能消失，变成每次攻击时提升致命率的武功。但，对人不适用。",
    reward0_count = 0,
    needLevel = 0,
    bQLoop = 0
  }
  refs[960] = {
    name = "{0xFFFFB4B4}[ 泰华武功射手篇 ]{END}",
    content0 = "{0xFFFFFF00}[ 太 ]弱点观测(功力65){END}-之前武功是津液弹，使敌人的移动速度变缓慢的功能消失，变成每次攻击时提升致命率的武功。但，对人不适用。",
    reward0_count = 0,
    needLevel = 0,
    bQLoop = 0
  }
  refs[1072] = {
    name = "[ 太和老君的教诲 ]",
    content0 = "你顺利通过了2次转职的考验，有资格接收太和老君的教诲",
    reward0_count = 0,
    needLevel = 60,
    bQLoop = 0
  }
  refs[1120] = {
    name = "[ 帮忙的代价 ]",
    content0 = "并不是完全相信你的话，但是既然你帮了我，我也会帮你。听说你为了找回自己的记忆，到处在找认识你的人？",
    reward0_count = 5,
    needLevel = 13,
    bQLoop = 0
  }
  refs[1121] = {
    name = "[ 名声(1) ]",
    content0 = "失去了记忆？可惜我也是第一次见到少侠。但是想推荐一个能找到认识少侠的人的方法。只要少侠出了名，不是自然就会有认识少侠的人出现了吗？",
    reward0_count = 1,
    needLevel = 14,
    bQLoop = 0
  }
  refs[1125] = {
    name = "[ 乌骨鸡的考验 ]",
    content0 = "虽然证实了你有击退螳螂勇勇的实力，但还没有完。现在开始才是真正的考验。",
    reward0_count = 1,
    needLevel = 15,
    bQLoop = 0
  }
  refs[1126] = {
    name = "[ 白斩姬的召唤 ]",
    content0 = "{0xFFFFFF00}白斩姬{END}在找你。她再清阴关正派建筑里。",
    reward0_count = 0,
    needLevel = 15,
    bQLoop = 0
  }
  refs[1127] = {
    name = "[ 白斩姬的方式 ]",
    content0 = "怎么可以先去找邪派呢？少侠不是崇尚正义，热于助人的吗？好在你现在重新走回正道。还有你在邪派接受了什么考验啊？",
    reward0_count = 20,
    needLevel = 15,
    bQLoop = 0
  }
  refs[1128] = {
    name = "[ 正派的考验 ]",
    content0 = "什么？在邪派接受了两次考验？那我们也要再来一次。",
    reward0_count = 1,
    needLevel = 15,
    bQLoop = 0
  }
  refs[1145] = {
    name = "[ 不明身份的袭击者 ]",
    content0 = "最近去往冥珠城的押镖之路每次都被不知名的敌人袭击。在这样下去，连清阴关的生活必需品也不够。",
    reward0_count = 20,
    needLevel = 21,
    bQLoop = 0
  }
  refs[1146] = {
    name = "[ 正派的请求 ]",
    content0 = "怎么这么久啊？总之来了就好。有件事要拜托你。这是正派的正式邀请，不会拒绝吧？",
    reward0_count = 0,
    needLevel = 21,
    bQLoop = 0
  }
  refs[1148] = {
    name = "[ 谍报活动 ]",
    content0 = "有情报说{0xFFFFFF00}无名湖的精灵匠人{END}对这次的袭击有所了解。我们调查怪老子的眼珠的时候，你去他那边把情报弄到手吧。",
    reward0_count = 0,
    needLevel = 21,
    bQLoop = 0
  }
  refs[1150] = {
    name = "[ 谍报活动2 ]",
    content0 = "嗯，制作精灵的时候最重要的应该是材料对吧？但这材料有时候很难收集到。",
    reward0_count = 20,
    needLevel = 22,
    bQLoop = 0
  }
  refs[1152] = {
    name = "[ 白斩姬的失策 ]",
    content0 = "可能情报出错了。应该是因为邪派的妨碍工作才会发生这种事情的。但也不是一无所获。",
    reward0_count = 1,
    needLevel = 23,
    bQLoop = 0
  }
  refs[1174] = {
    name = "[ 证据 ]",
    content0 = "其实具体的我也不清楚。只是在巷道逃跑的时候向后看了一眼，看到了巨大的怪物。",
    reward0_count = 0,
    needLevel = 32,
    bQLoop = 0
  }
  refs[1176] = {
    name = "[ 回到白斩姬处 ]",
    content0 = "白斩姬捎来一封信让你回去呢。看样子时你击退猪大长分身的瞬间，邪恶的灵魂飞到了芦苇林。所以马上叫你过去想了解情况。",
    reward0_count = 0,
    needLevel = 33,
    bQLoop = 0
  }
  refs[1178] = {
    name = "[ 情报战 ]",
    content0 = "你击退了叫{0xFFFFFF00}猪大长{END}的怪物的分身？而且他的灵魂飞到了芦苇林？",
    reward0_count = 0,
    needLevel = 34,
    bQLoop = 0
  }
  refs[1326] = {
    name = "[ 破天掌 ]",
    content0 = "伸张正义指的并不仅仅是击退凶恶的怪物。",
    reward0_count = 0,
    needLevel = 1,
    bQLoop = 0
  }
  refs[1327] = {
    name = "[ 破天掌 ]",
    content0 = "伸张正义指的并不仅仅是击退凶恶的怪物。",
    reward0_count = 0,
    needLevel = 1,
    bQLoop = 0
  }
  refs[1328] = {
    name = "[ 破天掌 ]",
    content0 = "伸张正义指的并不仅仅是击退凶恶的怪物。",
    reward0_count = 0,
    needLevel = 1,
    bQLoop = 0
  }
  refs[1329] = {
    name = "[ 破天掌 ]",
    content0 = "伸张正义指的并不仅仅是击退凶恶的怪物。",
    reward0_count = 0,
    needLevel = 1,
    bQLoop = 0
  }
  refs[1330] = {
    name = "[ 破天掌 ]",
    content0 = "伸张正义指的并不仅仅是击退凶恶的怪物。",
    reward0_count = 0,
    needLevel = 1,
    bQLoop = 0
  }
  refs[1395] = {
    name = "[ ??? ???! ]",
    content0 = "PLAYERNAME?, ?? ? ????!",
    reward0_count = 0,
    needLevel = 1,
    bQLoop = 0
  }
  refs[1398] = {
    name = "[ ??? ?? ]",
    content0 = "?? ????. ?? ?????? ? ??? ?????? ????. ?????? ???? ?? ???.",
    reward0_count = 0,
    needLevel = 1,
    bQLoop = 0
  }
  refs[1399] = {
    name = "[ ??? ?? ]",
    content0 = "?, ?? ??!",
    reward0_count = 1,
    needLevel = 1,
    bQLoop = 0
  }
  refs[2051] = {
    name = "[ 军士 - 派系与中原 ]",
    content0 = "现在营地已经整理好了，要开始修复跟各派系领导者之间的联系方式了",
    reward0_count = 0,
    needLevel = 36,
    bQLoop = 0
  }
  refs[2052] = {
    name = "[ 军士 - 有力无处使 ]",
    content0 = "正派就是正义。重视仁义和道德，绝不容许恶。在军士有难的时候也毫不犹豫的赶去支援，也正是因为我们是正派",
    reward0_count = 0,
    needLevel = 36,
    bQLoop = 0
  }
  refs[2082] = {
    name = "[ 连冲跳 ]",
    content0 = "在池塘里畅游的鲢鱼真是充满了生机。看着鲢鱼我想起在很久以前正邪派之间起了很大的冲突，那时突然出现了一名武人。",
    reward0_count = 0,
    needLevel = 45,
    bQLoop = 0
  }
  refs[2083] = {
    name = "[ 飞龙掌 ]",
    content0 = "所谓正义指的不完全是大义。守护并帮助被恶徒和怪物迫害的弱者也是正义的一种。",
    reward0_count = 0,
    needLevel = 50,
    bQLoop = 0
  }
  refs[2084] = {
    name = "[ 天然聚气 ]",
    content0 = "太和老君'突然出现在阿鼻叫唤的时代，击退怪物，引领正邪两派，他不仅传授了'连冲跳'，还传授了另外一种武功。",
    reward0_count = 0,
    needLevel = 55,
    bQLoop = 0
  }
  refs[2085] = {
    name = "[ 破天掌 ]",
    content0 = "伸张正义指的并不仅仅是击退凶恶的怪物。",
    reward0_count = 0,
    needLevel = 1,
    bQLoop = 0
  }
  refs[2090] = {
    name = "[ 2次转职(体)-任务1次 ]",
    content0 = "射手的义务是帮助弱者，消除邪恶。{0xFF99FF99}PLAYERNAME{END}是否一直在忠于射手的义务了呢？",
    reward0_count = 1,
    needLevel = 60,
    bQLoop = 0
  }
  refs[2091] = {
    name = "[ 2次转职(正)-任务2次 ]",
    content0 = "成为真正的武士不但要坚强，还要具备自制力、耐力和风流。这次的考验是去钓鱼，一边学会聚精会神。",
    reward0_count = 1,
    needLevel = 60,
    bQLoop = 0
  }
  refs[2092] = {
    name = "[ 2次转职(人)-任务3次 ]",
    content0 = "这么快~就到了最后的考验。集中精神，听好了。并非武力，真正得到认可才是高人一等。你受到多少人的认可呢？",
    reward0_count = 1,
    needLevel = 60,
    bQLoop = 0
  }
  return refs
end
