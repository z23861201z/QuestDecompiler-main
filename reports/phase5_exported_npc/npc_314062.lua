-- DB_DRIVEN_EXPORT
-- source: npc_314062.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_314062"
  local refs = {}
  refs[2018] = {
    name = "[ 军士 - 跟佣兵领袖的会面 ]",
    content0 = "看起来恢复的不错啊！不过，还是什么都想不起来吗？",
    reward0_count = 1,
    needLevel = 1,
    bQLoop = 0
  }
  refs[2019] = {
    name = "[军士-军士的第一个技能：枪术精通 ]",
    content0 = "看你身体强壮、恢复力也很强、眼里还放出光彩，看来我没看错，你真的很适合军士这个职业",
    reward0_count = 0,
    needLevel = 1,
    bQLoop = 0
  }
  refs[2020] = {
    name = "[ 军士 - 技能: 血气印记 ]",
    content0 = "现在要教你的血门技能是证明军士职业存在的代表性技能",
    reward0_count = 0,
    needLevel = 1,
    bQLoop = 0
  }
  refs[2021] = {
    name = "[ 军士 - 技能: 穿刺枪 ]",
    content0 = "对了，我还没告诉你既然现在是佣兵团，为什么还说是军士、皇帝直属部队的原因。过去是皇帝直属部队没错，但现在是佣兵团，严格的说应该是伪装的佣兵团",
    reward0_count = 0,
    needLevel = 11,
    bQLoop = 0
  }
  refs[2022] = {
    name = "[ 军士 - 技能: 冲击波 ]",
    content0 = "之前也跟你说过，我们是军士，是保护国家最高领导人的[皇帝直属部队的一员]。你千万不要忘记！",
    reward0_count = 0,
    needLevel = 12,
    bQLoop = 0
  }
  refs[2023] = {
    name = "[ 军士 - 清阴关和佣兵团的关系1 ]",
    content0 = "我还没跟你说我们是怎么会来保护清阴关的，我简单说明一下",
    reward0_count = 0,
    needLevel = 13,
    bQLoop = 0
  }
  refs[2027] = {
    name = "[ 军士 - 新的帮手2 ]",
    content0 = "北瓶押是太和老君的第12个弟子。很久以前怪物横行的时候太和老君领着12位弟子突然出现，经过3年的血战把怪物都击退了！",
    reward0_count = 0,
    needLevel = 16,
    bQLoop = 0
  }
  refs[2028] = {
    name = "[ 军士 - 北瓶押 ]",
    content0 = "刚刚胡须张派人传话说北瓶押在找你呢",
    reward0_count = 0,
    needLevel = 16,
    bQLoop = 0
  }
  refs[2029] = {
    name = "[ 军士 - 战报任务 ]",
    content0 = "嗯..失去记忆了？治愈武功我倒是懂一些，但是治疗失忆我也没办法。不过，有一个人应该可以治疗失忆，但是很久之前去了西域",
    reward0_count = 0,
    needLevel = 17,
    bQLoop = 0
  }
  refs[2030] = {
    name = "[ 军士 - 技能: 血气庇护 ]",
    content0 = "击退怪物的过程中见过[魂]吗？",
    reward0_count = 0,
    needLevel = 18,
    bQLoop = 0
  }
  refs[2031] = {
    name = "[ 军士 - 村子间的来往方法 ]",
    content0 = "你除了清阴关还去过别的村子吗？",
    reward0_count = 0,
    needLevel = 19,
    bQLoop = 0
  }
  refs[2032] = {
    name = "[ 军士 - 佣兵团的秘密任务 ]",
    content0 = "之前也跟你说过，我们为了重新崛起正在储备粮食和资金！",
    reward0_count = 0,
    needLevel = 20,
    bQLoop = 0
  }
  refs[2033] = {
    name = "[ 军士 - 黄泉的存在 ]",
    content0 = "什么？想在黄泉扎营？哈哈…哈哈哈！我的肚子啊~你知道黄泉是什么地方吗？地狱你听说过吧？黄泉是地狱的前院~你要在那儿做什么？卡哈哈！",
    reward0_count = 0,
    needLevel = 21,
    bQLoop = 0
  }
  refs[2034] = {
    name = "[ 军士 - 紧急的佣兵事务 ]",
    content0 = "竟然没有可以当营地的没封印的黄泉，太可惜了！",
    reward0_count = 0,
    needLevel = 22,
    bQLoop = 0
  }
  refs[2035] = {
    name = "[ 军士 - 参观市集 ]",
    content0 = "看着你迅速成长，让我想起了小时候的自己(暂时陷入回忆中)..那时候真好啊！",
    reward0_count = 0,
    needLevel = 23,
    bQLoop = 0
  }
  refs[2036] = {
    name = "[ 军士 - 技能: 碎云斩 ]",
    content0 = "(巡视日记里有几个要确认的事项)",
    reward0_count = 0,
    needLevel = 23,
    bQLoop = 0
  }
  refs[2037] = {
    name = "[ 军士 - 向前进 ]",
    content0 = "做为营地的备选，除了黄泉我还打听了几个地方。其中一个地方就是[无名湖]！",
    reward0_count = 0,
    needLevel = 24,
    bQLoop = 0
  }
  refs[2038] = {
    name = "[ 军士 - 旁敲侧击 ]",
    content0 = "你这人~还没回去啊！我不会离开这里的",
    reward0_count = 0,
    needLevel = 24,
    bQLoop = 0
  }
  refs[2039] = {
    name = "[ 军士 - 建设秘密营的准备1 ]",
    content0 = "李无极的地盘的话正好适合当我们军士的要塞，太合适了！哈哈哈！",
    reward0_count = 0,
    needLevel = 25,
    bQLoop = 0
  }
  refs[2040] = {
    name = "[ 军士 - 建设秘密营的准备2 ]",
    content0 = "这次需要背影杀手的镜。要用那个制作结界，你去收集回来吧",
    reward0_count = 0,
    needLevel = 26,
    bQLoop = 0
  }
  refs[2041] = {
    name = "[ 军士 - 确保营地的军粮 ]",
    content0 = "建设营地的时候军费用得差不多了..现在重新开始了佣兵业务储备资金呢，但是现在急需军粮！我们之前已经受过太多清阴关的恩惠，不好意思再麻烦他们了..",
    reward0_count = 0,
    needLevel = 27,
    bQLoop = 0
  }
  refs[2042] = {
    name = "[ 军士 - 技能: 剧毒喷雾 ]",
    content0 = "这次需要当料理材料的蓝色的灯油",
    reward0_count = 0,
    needLevel = 28,
    bQLoop = 0
  }
  refs[2043] = {
    name = "[ 军士 - 十二妖怪们 ]",
    content0 = "你有见过十二妖怪吗？外形像庞大的猪或狗，但是身体像人类的会飞的怪物",
    reward0_count = 0,
    needLevel = 29,
    bQLoop = 0
  }
  refs[2045] = {
    name = "[ 军士 - 佣兵领袖的召唤 ]",
    content0 = "除了霸主地狱，还有很多地狱的。如果有实力的话也试着挑战其他地狱吧。奖励少不了你的！",
    reward0_count = 0,
    needLevel = 31,
    bQLoop = 0
  }
  refs[2046] = {
    name = "[ 军士 - 防患于未然 ]",
    content0 = "你离开后我给剩下的军士安排了任务，是了解新的秘密营地的任务。但是有一个地方是我亲自去的",
    reward0_count = 0,
    needLevel = 31,
    bQLoop = 0
  }
  refs[2047] = {
    name = "[ 军士 - 第一次调查 ]",
    content0 = "你去收集骨头的时候，我调查了蛇腹窟",
    reward0_count = 0,
    needLevel = 32,
    bQLoop = 0
  }
  refs[2048] = {
    name = "[ 军士 - 技能: 太极护盾 ]",
    content0 = "跟我预测的一样，黄金猎犬的牙有很强的毒性。我之前也跟你说过军士的武功是利用血的吧？对于我们的武功来说，中毒是致命的！",
    reward0_count = 0,
    needLevel = 33,
    bQLoop = 0
  }
  refs[2049] = {
    name = "[ 军士 - 为了伪装营地 ]",
    content0 = "对蛇腹窟的调查也差不多了，现在为了保护营地把营地伪装起来吧。听结界师说，大部分都可以用结界击退的，但是不能防止虫子",
    reward0_count = 0,
    needLevel = 34,
    bQLoop = 0
  }
  refs[2050] = {
    name = "[ 军士 - 击退狗骨头 ]",
    content0 = "刚才有个军士在蛇腹窟看到了狗骨头，感觉比之前发现的怪物妖气更强。谁想到会有这种家伙藏在里面啊！以为是李无极的妖气呢",
    reward0_count = 0,
    needLevel = 35,
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
  refs[2055] = {
    name = "[ 军士 - 技能: 横扫八方 ]",
    content0 = "不久之前中原还只有正派和邪派两个派系的。但是自从龙林客栈里出现了归属魔教的队伍后，现在时不时的能看到魔教派系的人",
    reward0_count = 0,
    needLevel = 38,
    bQLoop = 0
  }
  refs[2056] = {
    name = "[ 军士 - 斗争中的冥珠城 ]",
    content0 = "你来回的时候应该见过竹林西边有个很大的城和村子的吧？那个城是冥珠城，是很有意思的地方",
    reward0_count = 0,
    needLevel = 39,
    bQLoop = 0
  }
  refs[2057] = {
    name = "[ 军士 - 加入派系 ]",
    content0 = "前段时间见派系上级的时候让你参加派系了吧？你现在功力也达到40了，也该选择正派或邪派，修炼的更强大了！",
    reward0_count = 1,
    needLevel = 1,
    bQLoop = 0
  }
  refs[2058] = {
    name = "[ 军士 - 兰霉匠的消息 ]",
    content0 = "你去选择派系的时候情报网传来消息说，兰霉匠开始行动了。其实之前是我们不知道而已，据说已经行动有段时间了",
    reward0_count = 0,
    needLevel = 41,
    bQLoop = 0
  }
  refs[2059] = {
    name = "[ 军士 - 韩野城的危机 ]",
    content0 = "攻击韩野城的兰霉匠军队的目的不一定是破坏韩野城。有情报说是为了诱导12位弟子的出现",
    reward0_count = 0,
    needLevel = 42,
    bQLoop = 0
  }
  refs[2060] = {
    name = "[ 军士 - 技能: 游龙枪 ]",
    content0 = "军士..原是皇宫里最优秀的精英，兰霉匠真是罪恶滔天啊！谢谢你的情报，不过请放心吧。我们韩野城的军队有很可靠的少侠们的支援",
    reward0_count = 0,
    needLevel = 43,
    bQLoop = 0
  }
  refs[2061] = {
    name = "[ 大怪物的存在 ]",
    content0 = "我跟你说过怪物的来源了吗？是兰霉匠打开了这世界尽头的地狱之门~那时候开始这个世界变成了到处是恶鬼和怪物的地狱！",
    reward0_count = 0,
    needLevel = 44,
    bQLoop = 0
  }
  refs[2062] = {
    name = "[ 人工怪物鬼谷城 ]",
    content0 = "你出去的这段时间我对兰霉匠的军队带过来的奇怪的城做了调查…在调查的过程中知道了是和魔教有关",
    reward0_count = 0,
    needLevel = 45,
    bQLoop = 0
  }
  refs[2063] = {
    name = "[ 军士 - 大怪物的低吟 ]",
    content0 = "你知道[大怪物的精髓]吗？最近听说少侠们通过那个东西做了很奇怪的梦，所以我也想试试，不过没有找到大怪物的精髓",
    reward0_count = 0,
    needLevel = 46,
    bQLoop = 0
  }
  refs[2064] = {
    name = "[ 军士 - 鬼谷城的实体 ]",
    content0 = "多亏了前暗部团长的帮忙，终于掌握了鬼谷城的结构。鬼谷城一共有10层，最底层和中间有一层没有怪物，可以当成休息地",
    reward0_count = 0,
    needLevel = 47,
    bQLoop = 0
  }
  refs[2065] = {
    name = "[ 军士 - 寻找太和老君 ]",
    content0 = "先把韩野城的事情放一放，现在中原需要的是可以管治兰霉匠的[太和老君]。不仅仅是中原，连皇宫也是.. 如果能见到他的话，有很多问题要请教的",
    reward0_count = 0,
    needLevel = 48,
    bQLoop = 0
  }
  refs[2071] = {
    name = "[ 军士 - 没有我不行？ ]",
    content0 = "连兰霉匠的左右手证明管理人也能上当的程度的话，我就不怕被发现了！对了，你不在的时候佣兵领袖派人来找过你，还让你在回去的路上完成一些事",
    reward0_count = 0,
    needLevel = 53,
    bQLoop = 0
  }
  refs[2072] = {
    name = "[ 军士 - 都城战的权力斗争 ]",
    content0 = "嗯..原来冥珠城的设施还有那种隐情啊~这样说来我之前也听过关于都城战的事情。以佣兵团的身份活动的时候还收到过让参加都城战的邀请",
    reward0_count = 0,
    needLevel = 54,
    bQLoop = 0
  }
  refs[2073] = {
    name = "[ 军士 - 派遣到冥珠城 ]",
    content0 = "将营地转移到竹林的时候开始和冥珠城的官员们有了接触。万幸的是，兰霉匠的魔掌还没有伸向冥珠城的官员们",
    reward0_count = 0,
    needLevel = 55,
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
  refs[2079] = {
    name = "[ 军士 - 2次转职的必要性 ]",
    content0 = "果然很有效果啊，巨大鬼怪逃到了黄泉里了。但现在放松还太早",
    reward0_count = 0,
    needLevel = 60,
    bQLoop = 0
  }
  refs[2080] = {
    name = "[ 军士 - 2次转职 ]",
    content0 = "军士的2次转职可以让你拥有更强的力量。还可以拥有其他的",
    reward0_count = 0,
    needLevel = 60,
    bQLoop = 0
  }
  refs[2081] = {
    name = "[ 军士 - 离别 ]",
    content0 = "现在你成长成可以独自行动的境地了~你已经选择了2次转职，那就该说再见了~",
    reward0_count = 0,
    needLevel = 60,
    bQLoop = 0
  }
  refs[2102] = {
    name = "[ 军士 - 佣兵领袖的礼物 ]",
    content0 = "现在才10级啊…只要按照我的指示行事，升级就容易得多了",
    reward0_count = 1,
    needLevel = 1,
    bQLoop = 0
  }
  refs[2156] = {
    name = "[ 佣兵团的名誉(金牌) ]",
    content0 = "你来的正好，我正在找你呢！",
    reward0_count = 1,
    needLevel = 1,
    bQLoop = 0
  }
  refs[2157] = {
    name = "[ 佣兵团的名誉(银牌) ]",
    content0 = "你来的正好，我正在找你呢！",
    reward0_count = 1,
    needLevel = 1,
    bQLoop = 0
  }
  refs[2158] = {
    name = "[ 佣兵团的名誉(铜牌) ]",
    content0 = "你来的正好，我正在找你呢！",
    reward0_count = 1,
    needLevel = 1,
    bQLoop = 0
  }
  refs[3608] = {
    name = "[ 胶铰丛膊 巩救 牢荤 靛府扁[焙荤] ]",
    content0 = "坷阀悼救 磊匙甫 扁促啡促匙.",
    reward0_count = 1,
    needLevel = 1,
    bQLoop = 0
  }
  return refs
end
