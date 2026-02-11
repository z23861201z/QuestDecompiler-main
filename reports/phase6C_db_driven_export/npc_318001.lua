-- DB_DRIVEN_EXPORT
-- source: npc_318001.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_318001"
  local refs = {}
  refs[611] = {
    name = "[ ???? 1?? ]",
    content0 = "???????? ?? ????.",
    reward0_count = 0,
    needLevel = 1,
    bQLoop = 0
  }
  refs[612] = {
    name = "[ 射手转职 ]",
    content0 = "??? ?? ??????",
    reward0_count = 1,
    needLevel = 1,
    bQLoop = 0
  }
  refs[862] = {
    name = "[ ???? ??? ]",
    content0 = "??? ?? ??? ??? ??? ? ????? ??? ???? ?????",
    reward0_count = 1,
    needLevel = 1,
    bQLoop = 0
  }
  refs[944] = {
    name = "{0xFFFFB4B4}[ 什么是兰霉匠的进攻？ ]{END}",
    content0 = "有人密报，兰霉匠找到韩野城，正在全面进攻。万幸的是兰霉匠没有显露真身，用分身来指挥战斗，因此韩野城的军队还能够抵挡他们的攻击。",
    reward0_count = 0,
    needLevel = 0,
    bQLoop = 0
  }
  refs[945] = {
    name = "{0xFFFFB4B4}[ 什么是鬼谷城？ ]{END}",
    content0 = "鬼谷城是兰霉匠的战斗主力怪物。飘在空中奇怪的东西便是鬼谷城了。真不知道怎么会有这种东西存在，它是活着的，兰霉匠手下操纵着无数的鬼谷城朝这里进军。",
    reward0_count = 0,
    needLevel = 0,
    bQLoop = 0
  }
  refs[946] = {
    name = "{0xFFFFB4B4}[ 鬼谷城的入侵和击退 ]{END}",
    content0 = "虽说鬼谷城是活着的巨大怪物，如果没有兰霉匠的手下在其内部操纵，它只是单纯的一个大块头而已。",
    reward0_count = 0,
    needLevel = 0,
    bQLoop = 0
  }
  refs[947] = {
    name = "{0xFFFFB4B4}[ 给我们的时间是？ ]{END}",
    content0 = "韩野城军队可以抵挡鬼谷城进攻的时间是30分钟。这也正是各位可以在鬼谷城内部停留的时间。",
    reward0_count = 0,
    needLevel = 0,
    bQLoop = 0
  }
  refs[948] = {
    name = "{0xFFFFB4B4}[ 所谓兰霉匠的手下？ ]{END}",
    content0 = "据情报员传来的消息，兰霉匠的直属下属精锐部队中有金冠怪和银冠怪的职位。还有，现在进攻的鬼谷城中各有一名金冠怪和银冠怪在指挥。",
    reward0_count = 0,
    needLevel = 0,
    bQLoop = 0
  }
  refs[949] = {
    name = "{0xFFFFB4B4}[ 击退之后呢？ ]{END}",
    content0 = "各位击退兰霉匠的手下之后，我将重新启动符咒阵将各位带回韩野城。还有，韩野城的咒师们会用千里眼观察你们在鬼谷城的战斗情况，根据各位的表现评分后奖励[ 积分 ]。",
    reward0_count = 0,
    needLevel = 0,
    bQLoop = 0
  }
  refs[950] = {
    name = "{0xFFFFB4B4}[ 什么是提交军需物品？ ]{END}",
    content0 = "我接受的军需物品是武器和防具，是我们的士兵为了防御兰霉匠的进攻要使用的。当然质量越好防御的就更坚固，那样你们就可以赚取进攻鬼谷城时的时间。",
    reward0_count = 0,
    needLevel = 0,
    bQLoop = 0
  }
  refs[951] = {
    name = "{0xFFFFB4B4}[ 什么是宝玉？ ]{END}",
    content0 = "在鬼谷城可以获得红宝玉或黄宝玉之类的宝玉。那是皇宫的宝物，佩戴在武器或防具等多种装备上可以使装备变强的神奇的玉珠。",
    reward0_count = 0,
    needLevel = 0,
    bQLoop = 0
  }
  refs[952] = {
    name = "{0xFFFFB4B4}[ 鬼谷城的妖怪们 ]{END}",
    content0 = "鬼谷城的妖怪可不是普通的妖怪。是兰霉匠使用邪恶的法术制作的人工妖怪。所以听先前入侵过的侠客们说，跟普通妖怪不同，对普通物攻有很强的防御力。",
    reward0_count = 0,
    needLevel = 0,
    bQLoop = 0
  }
  refs[983] = {
    name = "{0xFFFFB4B4}[ 新的鬼谷城和金冠怪的登场 ]{END}",
    content0 = "被接二连三的失败愤怒的兰霉匠投入了由金冠怪领导的新的鬼谷城。所以每次进攻时会出现2个鬼谷城。",
    reward0_count = 0,
    needLevel = 0,
    bQLoop = 0
  }
  refs[1045] = {
    name = "[ 解读暗号 ]",
    content0 = "天下第一鬼谷城，天下太平兰霉匠’？嗯，像是某种暗号，不过不知道它具体的意思。",
    reward0_count = 0,
    needLevel = 60,
    bQLoop = 0
  }
  refs[1046] = {
    name = "[ 剧变开始 ]",
    content0 = "内容说的是兰霉匠带领着鬼谷城，即将开始进攻，做好准备。",
    reward0_count = 0,
    needLevel = 60,
    bQLoop = 0
  }
  refs[1286] = {
    name = "[ 暴风前夜2 ]",
    content0 = "你帮忙造的战船聚集在鬼谷林渡头，由皇宫武士柳江指挥，打算包围韩野城码头。嘿嘿。",
    reward0_count = 0,
    needLevel = 67,
    bQLoop = 0
  }
  refs[1287] = {
    name = "[ 暴风前夜3 ]",
    content0 = "既然如此我们也应该准备一下战船。",
    reward0_count = 0,
    needLevel = 67,
    bQLoop = 0
  }
  refs[1293] = {
    name = "[ 暴风前夜9 ]",
    content0 = "高一燕好像在找您呢。",
    reward0_count = 0,
    needLevel = 67,
    bQLoop = 0
  }
  refs[1294] = {
    name = "[ 团结力量 ]",
    content0 = "多亏PLAYERNAME，我们冬混汤一族和土著民们才能团结起来。感激之情无以言表…",
    reward0_count = 0,
    needLevel = 68,
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
  refs[3659] = {
    name = "[ 韩野城的物资储备：寿衣(每日) ]",
    content0 = "韩野城是进行和兰霉匠战斗的战争村",
    reward0_count = 0,
    needLevel = 121,
    bQLoop = 0
  }
  refs[3660] = {
    name = "[ 韩野城的物资储备：突眼怪的尾巴(每日) ]",
    content0 = "韩野城是进行和兰霉匠战斗的战争村",
    reward0_count = 0,
    needLevel = 123,
    bQLoop = 0
  }
  refs[3661] = {
    name = "[ 韩野城的物资储备：野蛮族的宝珠(每日) ]",
    content0 = "韩野城是进行和兰霉匠战斗的战争村",
    reward0_count = 0,
    needLevel = 125,
    bQLoop = 0
  }
  return refs
end
