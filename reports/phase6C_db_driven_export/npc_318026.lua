-- DB_DRIVEN_EXPORT
-- source: npc_318026.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_318026"
  local refs = {}
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
  return refs
end
