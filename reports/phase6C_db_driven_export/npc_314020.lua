-- DB_DRIVEN_EXPORT
-- source: npc_314020.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_314020"
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
  refs[112] = {
    name = "[ 创建门派 ]",
    content0 = "为了守住自从太和老君消失之后开始怪物横行的江湖，元老院决定允许门派的创立。",
    reward0_count = 0,
    needLevel = 1,
    bQLoop = 0
  }
  refs[123] = {
    name = "[ 飞龙掌 ]",
    content0 = "正义就是力量。只有强者才有发言权，能引领时代。但是…要知道拳头的力量不是全部。",
    reward0_count = 0,
    needLevel = 50,
    bQLoop = 0
  }
  refs[124] = {
    name = "[ 飞龙掌 ]",
    content0 = "正义就是力量。只有强者才有发言权，能引领时代。但是…要知道拳头的力量不是全部。",
    reward0_count = 0,
    needLevel = 50,
    bQLoop = 0
  }
  refs[125] = {
    name = "[ 飞龙掌 ]",
    content0 = "正义就是力量。只有强者才有发言权，能引领时代。但是…要知道拳头的力量不是全部。",
    reward0_count = 0,
    needLevel = 50,
    bQLoop = 0
  }
  refs[170] = {
    name = "[ 2次转职(体)-任务1次 ]",
    content0 = "使用刀剑的人不能反被刀刃支配了。毕竟小孩子也能把武器举起来。你使用武器是为了什么？",
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
  refs[172] = {
    name = "[ 2次转职(人)-任务3次 ]",
    content0 = "这是最后的考验。集中精神，听好了。并非武力，真正得到认可才是高人一等。你受到多少人的认可呢？",
    reward0_count = 1,
    needLevel = 60,
    bQLoop = 0
  }
  refs[176] = {
    name = "[ 2次转职(体)-任务1次 ]",
    content0 = "以当杀手为生的人需要了解生与死的含义。如果连这些都不知道就掌控别人的死活，那只能称其为杀人者。你使用武器是为了什么？",
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
  refs[178] = {
    name = "[ 2次转职(人)-任务3次 ]",
    content0 = "这是最后的考验。集中精神，听好了。无法得到认可的杀手只能是个杀人者。你受到多少人的认可呢？",
    reward0_count = 1,
    needLevel = 60,
    bQLoop = 0
  }
  refs[182] = {
    name = "[ 2次转职(体)-任务1次 ]",
    content0 = "修道首先要了解自己。世上一切的开始源于自身，也终止于自身。你的内心装着什么？",
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
  refs[184] = {
    name = "[ 2次转职(人)-任务3次 ]",
    content0 = "这是最后的考验。集中精神，听好了。在这个世界上没有一件事情可以靠自己的力量来实现。你受到多少人的认可呢？",
    reward0_count = 1,
    needLevel = 60,
    bQLoop = 0
  }
  refs[367] = {
    name = "[ 连冲跳 ]",
    content0 = "在池塘里畅游的鲢鱼真是充满了生机。看着鲢鱼我想起在很久以前正邪派之间起了很大的冲突，那时突然出现了一名武人。",
    reward0_count = 0,
    needLevel = 45,
    bQLoop = 0
  }
  refs[368] = {
    name = "[ 连冲跳 ]",
    content0 = "在池塘里畅游的鲢鱼真是充满了生机。看着鲢鱼我想起在很久以前正邪派之间起了很大的冲突，那时突然出现了一名武人。",
    reward0_count = 0,
    needLevel = 45,
    bQLoop = 0
  }
  refs[369] = {
    name = "[ 连冲跳 ]",
    content0 = "在池塘里畅游的鲢鱼真是充满了生机。看着鲢鱼我想起在很久以前正邪派之间起了很大的冲突，那时突然出现了一名武人。",
    reward0_count = 0,
    needLevel = 45,
    bQLoop = 0
  }
  refs[370] = {
    name = "[ 连冲跳 ]",
    content0 = "在池塘里畅游的鲢鱼真是充满了生机。看着鲢鱼我想起在很久以前正邪派之间起了很大的冲突，那时突然出现了一名武人。",
    reward0_count = 0,
    needLevel = 45,
    bQLoop = 0
  }
  refs[375] = {
    name = "[ 天然聚气 ]",
    content0 = "太和老君'突然出现在阿鼻叫唤的时代，击退怪物，引领正邪两派，他不仅传授了'连冲跳'，还传授了另外一种武功。",
    reward0_count = 0,
    needLevel = 55,
    bQLoop = 0
  }
  refs[376] = {
    name = "[ 天然聚气 ]",
    content0 = "太和老君'突然出现在阿鼻叫唤的时代，击退怪物，引领正邪两派，他不仅传授了'连冲跳'，还传授了另外一种武功。",
    reward0_count = 0,
    needLevel = 55,
    bQLoop = 0
  }
  refs[377] = {
    name = "[ 天然聚气 ]",
    content0 = "太和老君'突然出现在阿鼻叫唤的时代，击退怪物，引领正邪两派，他不仅传授了'连冲跳'，还传授了另外一种武功。",
    reward0_count = 0,
    needLevel = 55,
    bQLoop = 0
  }
  refs[378] = {
    name = "[ 天然聚气 ]",
    content0 = "太和老君'突然出现在阿鼻叫唤的时代，击退怪物，引领正邪两派，他不仅传授了'连冲跳'，还传授了另外一种武功。",
    reward0_count = 0,
    needLevel = 55,
    bQLoop = 0
  }
  refs[382] = {
    name = "[ 飞龙掌 ]",
    content0 = "正义就是力量。只有强者才有发言权，能引领时代。但是…要知道拳头的力量不是全部。",
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
  refs[386] = {
    name = "[ 2次转职(体)-任务1次 ]",
    content0 = "可以自由使用斧和轮的无尽的力量和外功，你觉得那力量的源泉是什么？",
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
  refs[388] = {
    name = "[ 2次转职(人)-任务3次 ]",
    content0 = "这是最后的考验。集中精神，听好了。并非武力，真正得到认可才是高人一等。你受到多少人的认可呢？",
    reward0_count = 1,
    needLevel = 60,
    bQLoop = 0
  }
  refs[630] = {
    name = "[ 连冲跳 ]",
    content0 = "在池塘里畅游的鲢鱼真是充满了生机。看着鲢鱼我想起在很久以前正邪派之间起了很大的冲突，那时突然出现了一名武人。",
    reward0_count = 0,
    needLevel = 45,
    bQLoop = 0
  }
  refs[631] = {
    name = "[ 飞龙掌 ]",
    content0 = "正义就是力量。只有强者才有发言权，能引领时代。但是…要知道拳头的力量不是全部。",
    reward0_count = 0,
    needLevel = 50,
    bQLoop = 0
  }
  refs[632] = {
    name = "[ 天然聚气 ]",
    content0 = "太和老君'突然出现在阿鼻叫唤的时代，击退怪物，引领正邪两派，他不仅传授了'连冲跳'，还传授了另外一种武功。",
    reward0_count = 0,
    needLevel = 55,
    bQLoop = 0
  }
  refs[636] = {
    name = "[ 2次转职(体)-任务1次 ]",
    content0 = "射手的义务是帮助弱者，消除邪恶。{0xFF99FF99}PLAYERNAME{END}是否一直在忠于射手的义务了呢？",
    reward0_count = 1,
    needLevel = 60,
    bQLoop = 0
  }
  refs[637] = {
    name = "[ 2次转职(正)-任务2次 ]",
    content0 = "做侠义之事也要有时机的。轻率的行侠仗义有时别说是帮忙了，反而会雪上加霜。",
    reward0_count = 1,
    needLevel = 60,
    bQLoop = 0
  }
  refs[638] = {
    name = "[ 2次转职(人)-任务3次 ]",
    content0 = "最后一次考验。我已经确认了{0xFF99FF99}PLAYERNAME{END}通过修炼获得了能力。这次是要了解别人是怎么评价你的。",
    reward0_count = 1,
    needLevel = 60,
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
  refs[1073] = {
    name = "[ 太和老君的教诲 ]",
    content0 = "你顺利通过了2次转职的考验，有资格接收太和老君的教诲！",
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
  refs[1122] = {
    name = "[ 名声(2) ]",
    content0 = "他们应该不会给少侠事情做的。之前先证明少侠的实力为好。",
    reward0_count = 0,
    needLevel = 14,
    bQLoop = 0
  }
  refs[1123] = {
    name = "[ 名声(3) ]",
    content0 = "少侠独自击退5只螳螂勇勇的事迹已经传开来了。所以乌骨鸡大侠正在找您。",
    reward0_count = 1,
    needLevel = 14,
    bQLoop = 0
  }
  refs[1124] = {
    name = "[ 邪派的方式 ]",
    content0 = "你一个人击退了5只螳螂勇勇吗？",
    reward0_count = 0,
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
  refs[1145] = {
    name = "[ 不明身份的袭击者 ]",
    content0 = "最近去往冥珠城的押镖之路每次都被不知名的敌人袭击。在这样下去，连清阴关的生活必需品也不够。",
    reward0_count = 20,
    needLevel = 21,
    bQLoop = 0
  }
  refs[1147] = {
    name = "[ 邪派的请求 ]",
    content0 = "来了？有事情要托付给你。",
    reward0_count = 1,
    needLevel = 21,
    bQLoop = 0
  }
  refs[1149] = {
    name = "[ 要挟请求 ]",
    content0 = "刚收到谍报，发现了袭击事件的嫌疑人。{0xFFFFFF00}无名湖的路边摊{END}好像就是那个嫌疑人。",
    reward0_count = 20,
    needLevel = 21,
    bQLoop = 0
  }
  refs[1151] = {
    name = "[ 要挟请求2 ]",
    content0 = "我小的时候嘴角被鸟啄，留下了伤疤。这胡须其实也是为了伤疤才留的。",
    reward0_count = 0,
    needLevel = 22,
    bQLoop = 0
  }
  refs[1153] = {
    name = "[ 乌骨鸡的性急 ]",
    content0 = "嗯，去见路边摊了？",
    reward0_count = 1,
    needLevel = 23,
    bQLoop = 0
  }
  refs[1175] = {
    name = "[ 厨师的情报 ]",
    content0 = "据逃离强悍巷道的矿工们说，巨大的猪头怪物控制着其他怪物，使用各种邪恶的法术掌控着巷道。",
    reward0_count = 50,
    needLevel = 32,
    bQLoop = 0
  }
  refs[1177] = {
    name = "[ 给乌骨鸡的礼物 ]",
    content0 = "和预计的一样，你收集来的{0xFFFFFF00}[ 破烂的灯 ]{END}一直朝向芦苇林亮着。快把这件事情告诉乌骨鸡大侠吧。",
    reward0_count = 20,
    needLevel = 33,
    bQLoop = 0
  }
  refs[1179] = {
    name = "[ 歼灭战 ]",
    content0 = "嗯？灯光朝向芦苇林？果然…自从你和{0xFFFFFF00}猪大长{END}大战之后，我们才发现了那个怪物的存在。那家伙现在在芦苇林，一直操控怪物们袭击镖队。之前一直藏身巷道，时而出现时而消失。",
    reward0_count = 0,
    needLevel = 34,
    bQLoop = 0
  }
  refs[1331] = {
    name = "[ 破天掌 ]",
    content0 = "我认为伸张正义指的并不仅仅是击退凶恶的怪物。",
    reward0_count = 0,
    needLevel = 1,
    bQLoop = 0
  }
  refs[1332] = {
    name = "[ 破天掌 ]",
    content0 = "我认为伸张正义指的并不仅仅是击退凶恶的怪物。",
    reward0_count = 0,
    needLevel = 1,
    bQLoop = 0
  }
  refs[1333] = {
    name = "[ 破天掌 ]",
    content0 = "我认为伸张正义指的并不仅仅是击退凶恶的怪物。",
    reward0_count = 0,
    needLevel = 1,
    bQLoop = 0
  }
  refs[1334] = {
    name = "[ 破天掌 ]",
    content0 = "我认为伸张正义指的并不仅仅是击退凶恶的怪物。",
    reward0_count = 0,
    needLevel = 1,
    bQLoop = 0
  }
  refs[1335] = {
    name = "[ 破天掌 ]",
    content0 = "我认为伸张正义指的并不仅仅是击退凶恶的怪物。",
    reward0_count = 0,
    needLevel = 1,
    bQLoop = 0
  }
  refs[1400] = {
    name = "[ ???? ????! ]",
    content0 = "????! ? ??? ??? ????!",
    reward0_count = 0,
    needLevel = 1,
    bQLoop = 0
  }
  refs[1403] = {
    name = "[ ??? ?? ]",
    content0 = "? ???. ??? ????? ????. ?? ? ?? ????. ??… ? ?????",
    reward0_count = 0,
    needLevel = 1,
    bQLoop = 0
  }
  refs[1404] = {
    name = "[ ??? ?? ]",
    content0 = "????? ???? ?? ???. ?? ??? ??? ?????? ??? ???? ????.",
    reward0_count = 1,
    needLevel = 1,
    bQLoop = 0
  }
  refs[2053] = {
    name = "[ 军士 - 派系的劝诱1 ]",
    content0 = "这次要去见邪派的人，这次你也辛苦一下吧~",
    reward0_count = 0,
    needLevel = 37,
    bQLoop = 0
  }
  refs[2054] = {
    name = "[ 军士 - 派系的劝诱2 ]",
    content0 = "邪派就是力量。力量可以证明自己，坚持正义。从这方面来说你还很弱，达到40功力后加入邪派吧。我会让你更加强壮的成长的！",
    reward0_count = 0,
    needLevel = 37,
    bQLoop = 0
  }
  refs[2086] = {
    name = "[ 连冲跳 ]",
    content0 = "在池塘里畅游的鲢鱼真是充满了生机。看着鲢鱼我想起在很久以前正邪派之间起了很大的冲突，那时突然出现了一名武人。",
    reward0_count = 0,
    needLevel = 45,
    bQLoop = 0
  }
  refs[2087] = {
    name = "[ 飞龙掌 ]",
    content0 = "所谓正义指的不完全是大义。守护并帮助被恶徒和怪物迫害的弱者也是正义的一种。",
    reward0_count = 0,
    needLevel = 50,
    bQLoop = 0
  }
  refs[2088] = {
    name = "[ 天然聚气 ]",
    content0 = "太和老君'突然出现在阿鼻叫唤的时代，击退怪物，引领正邪两派，他不仅传授了'连冲跳'，还传授了另外一种武功。",
    reward0_count = 0,
    needLevel = 55,
    bQLoop = 0
  }
  refs[2089] = {
    name = "[ 破天掌 ]",
    content0 = "伸张正义指的并不仅仅是击退凶恶的怪物。",
    reward0_count = 0,
    needLevel = 1,
    bQLoop = 0
  }
  refs[2093] = {
    name = "[ 2次转职(体)-任务1次 ]",
    content0 = "可以自由使用斧和轮的无尽的力量和外功，你觉得那力量的源泉是什么？",
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
  refs[2095] = {
    name = "[ 2次转职(人)-任务3次 ]",
    content0 = "这是最后的考验。集中精神，听好了。并非武力，真正得到认可才是高人一等。你受到多少人的认可呢？",
    reward0_count = 1,
    needLevel = 60,
    bQLoop = 0
  }
  return refs
end
