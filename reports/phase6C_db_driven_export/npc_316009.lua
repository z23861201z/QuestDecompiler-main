-- DB_DRIVEN_EXPORT
-- source: npc_316009.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_316009"
  local refs = {}
  refs[485] = {
    name = "[ 维持符咒阵(1) ]",
    content0 = "那个，稍微停一下…咳咳…",
    reward0_count = 0,
    needLevel = 110,
    bQLoop = 0
  }
  refs[486] = {
    name = "[ 维持符咒阵(2) ]",
    content0 = "那这次就去收集咒术阵的第二个材料-幽灵帽子吧。幽灵帽子是用地狱的线编成的，是怪物们都很惧怕的东西",
    reward0_count = 0,
    needLevel = 110,
    bQLoop = 0
  }
  refs[487] = {
    name = "[ 维持符咒阵(3) ]",
    content0 = "是最后一个材料了…咳咳…这个可能不好收集。不过希望你能尽力到最后",
    reward0_count = 0,
    needLevel = 110,
    bQLoop = 0
  }
  refs[488] = {
    name = "[ 符咒阵的秘密 ]",
    content0 = "有了你的帮忙，可以安全的维持咒术阵了。不明来历的僧人说想报答你的辛劳。如果你没有什么急事，就去见见吧",
    reward0_count = 0,
    needLevel = 110,
    bQLoop = 0
  }
  refs[489] = {
    name = "[ 太乙仙女的原因 ]",
    content0 = "你可以破解咒术阵…嗯…咳咳…说一下你破译的内容吧",
    reward0_count = 0,
    needLevel = 110,
    bQLoop = 0
  }
  refs[490] = {
    name = "[ 千手妖女的弱点(1) ]",
    content0 = "不要太关注千手妖女。咳咳…血…是老人的咯血，不要太在意…千手妖女不是以人的力量可以打败的妖怪…",
    reward0_count = 0,
    needLevel = 110,
    bQLoop = 0
  }
  refs[491] = {
    name = "[ 千手妖女的弱点(2) ]",
    content0 = "我们研究龙凤鸣妖气的过程中，依稀找出了对抗千手妖女的方法…咳咳…",
    reward0_count = 0,
    needLevel = 110,
    bQLoop = 0
  }
  refs[492] = {
    name = "[ 千手妖女的弱点(3) ]",
    content0 = "咳咳…那就是要用寒气来保护自己的同时还要保护生命力不被抢夺的意思…咳咳…不太理解吗？",
    reward0_count = 0,
    needLevel = 110,
    bQLoop = 0
  }
  refs[493] = {
    name = "[ 决战！千手妖女(1) ]",
    content0 = "就因为你鼓起勇气…咳咳…站出来，才找到了方法…还有，如果不是你说要去击退千手妖女…也就不会想到要找这种方法了吧…",
    reward0_count = 1,
    needLevel = 110,
    bQLoop = 0
  }
  refs[494] = {
    name = "[ 决战！千手妖女(2) ]",
    content0 = "现在要开始了吧…一定要注意安全…咳咳",
    reward0_count = 1,
    needLevel = 110,
    bQLoop = 0
  }
  refs[495] = {
    name = "[ 决战！千手妖女(3) ]",
    content0 = "击退了千手妖女啊。千手妖女终于要从这个世间消失了",
    reward0_count = 0,
    needLevel = 110,
    bQLoop = 0
  }
  refs[497] = {
    name = "[ 制造第一寺印章 ]",
    content0 = "想要第一寺印章啊…咳咳…要制作是很费事的，还得制作啊…帮我收集材料吧…那我就帮你制作第一寺印章",
    reward0_count = 1,
    needLevel = 110,
    bQLoop = 0
  }
  refs[533] = {
    name = "[ 脱胎换骨 ]",
    content0 = "咳咳…千手妖女是什么样的妖怪啊？",
    reward0_count = 0,
    needLevel = 110,
    bQLoop = 0
  }
  refs[713] = {
    name = "[ 新希望 ]",
    content0 = "真是费了好久的时间。放飞出去的赤鬼鸟们现在回来了。但是…",
    reward0_count = 0,
    needLevel = 99,
    bQLoop = 0
  }
  refs[714] = {
    name = "[ 新希望-符咒阵完成 ]",
    content0 = "能够见到秋叨鱼的符咒阵 咳咳！设在西…西危?谷的深处。不过万一有危险他说会撤掉符咒阵。咳咳，咳咳！嗯哼！现在那边已经没有符咒阵了",
    reward0_count = 0,
    needLevel = 99,
    bQLoop = 0
  }
  refs[715] = {
    name = "[ 新希望-符咒阵破解 ]",
    content0 = "看，就是这个。就算是秋叨鱼也没办法这么快就做出来。呵呵。咳咳咳。现在只要烧掉幽灵帽子就可以发动起来了",
    reward0_count = 0,
    needLevel = 99,
    bQLoop = 0
  }
  refs[716] = {
    name = "[ 冬混汤-谁都不可信 ]",
    content0 = "不许动。动一下我就用这把快天飞龙剑割断你的喉咙。兰霉匠的狗腿子！就是你放来红鸟打探情况呢吧！？",
    reward0_count = 0,
    needLevel = 99,
    bQLoop = 0
  }
  refs[717] = {
    name = "[ 冬混汤-安危 ]",
    content0 = "嗯…因为冬混汤的城池被兰霉匠的兵给攻陷，我还正担心冬混汤的安危，幸好他还活着。呵呵，咳咳咳",
    reward0_count = 0,
    needLevel = 99,
    bQLoop = 0
  }
  refs[720] = {
    name = "[ 冬混汤-联系中断 ]",
    content0 = "我相信你说的话了。之前兰霉匠的狗腿子们乔装成我认识的人，或者乔装成村民，使用各种各样幼稚的方法想要接近并除掉我…",
    reward0_count = 0,
    needLevel = 99,
    bQLoop = 0
  }
  refs[721] = {
    name = "[ 冬混汤-秋叨鱼的符咒(1) ]",
    content0 = "哈啾！（吸溜鼻子）把这个秋叨鱼的符咒用在符咒阵中就能移动到秋叨鱼的住处？不过秋叨鱼布下的符咒阵已经消失了？",
    reward0_count = 0,
    needLevel = 99,
    bQLoop = 0
  }
  refs[722] = {
    name = "[ 冬混汤-秋叨鱼的符咒(2) ]",
    content0 = "不错，成功解开了封锁装置。嗯…嗯…竟然使用了这种阵法，不愧被称为稀世天才啊。几十年前做的符咒都让我应对得有些困难…",
    reward0_count = 0,
    needLevel = 99,
    bQLoop = 0
  }
  refs[723] = {
    name = "[ 冬混汤-术法分析 ]",
    content0 = "呼…可能是老了，光是准备就花了一天时间。我也老了，呵呵…和秋叨鱼的术法大战要开始了。我开始分析的话，就要集中精神，你一定要注意这点",
    reward0_count = 0,
    needLevel = 99,
    bQLoop = 0
  }
  refs[724] = {
    name = "[ 冬混汤-帮助 ]",
    content0 = "嗯…很久之前，一直憧憬秋叨鱼的学者们说想研究一下，让给看秋叨鱼的符咒。研究了几个月之后，大家都累的放弃了",
    reward0_count = 0,
    needLevel = 99,
    bQLoop = 0
  }
  refs[891] = {
    name = "[ 守护天吟的奖励 ]",
    content0 = "{0xFFFFFF00}击退60个[血姜丝男]{END}之后回来就给你{0xFFFFFF00}1个古乐守护符{END}。记住了，这个任务是{0xFFFFFF00}一天只能完成一次{END}。",
    reward0_count = 1,
    needLevel = 120,
    bQLoop = 0
  }
  refs[908] = {
    name = "{0xFFFFB4B4}[ 千手妖女是什么？ ]{END}",
    content0 = "千手妖女是…吸收万年花种子，拥有强大力量的怪物。千手妖女原本是和蜘蛛相似的低级怪物，吸收了万年花种子之后脱胎为巨大的大怪物了。",
    reward0_count = 0,
    needLevel = 0,
    bQLoop = 0
  }
  refs[909] = {
    name = "{0xFFFFB4B4}[ 什么是脱胎换骨？ ]{END}",
    content0 = "脱胎换骨意味着大量的真气进入体内，打通生死玄关，可以自由控制体内所有力量，召唤出无限的潜力。",
    reward0_count = 0,
    needLevel = 0,
    bQLoop = 0
  }
  refs[910] = {
    name = "{0xFFFFB4B4}[ 脱胎换骨的能力 ]{END}",
    content0 = "有达到脱胎换骨境界的人才能使用的武功。此武功是那些没能达到脱胎换骨境界的人想都不敢想的。",
    reward0_count = 0,
    needLevel = 0,
    bQLoop = 0
  }
  refs[911] = {
    name = "{0xFFFFB4B4}[ 脱胎换骨的条件 ]{END}",
    content0 = "原本经过长时间的修炼才能达到脱胎换骨的境界，这种境界不是轻易就可以达到的。偶尔有些人会得到灵药，从而脱胎换骨，因此人们也会错误的认为只吃灵药也可以脱胎换骨。",
    reward0_count = 0,
    needLevel = 0,
    bQLoop = 0
  }
  refs[975] = {
    name = "{0xFFFFB4B4}[ 天吟守护符 ]{END}",
    content0 = "过去镇压了妖怪们的不只是太和老君和他的12个弟子。也不能忘了没来得及留下名字就倒下的无数的英雄们。",
    reward0_count = 0,
    needLevel = 0,
    bQLoop = 0
  }
  refs[1010] = {
    name = "[住持的请求]",
    content0 = "直到去年为止我还没觉得这么冷，不知道为什么今年额外的冷…",
    reward0_count = 0,
    needLevel = 132,
    bQLoop = 0
  }
  refs[1371] = {
    name = "[供奉步骤]",
    content0 = "年轻的施主，能不能为了安抚这些亡魂，最后一次去趟第一寺啊？",
    reward0_count = 0,
    needLevel = 92,
    bQLoop = 0
  }
  refs[1372] = {
    name = "[回到生死之塔(1)]",
    content0 = "原来武艺僧长经那么辛劳啊。知道了。少侠也辛苦了。",
    reward0_count = 3,
    needLevel = 92,
    bQLoop = 0
  }
  refs[1429] = {
    name = "[化境-雾气来源]",
    content0 = "击退怪物后雾气和热气也没有消失…这肯定是因为时空的皲裂",
    reward0_count = 0,
    needLevel = 130,
    bQLoop = 0
  }
  refs[1430] = {
    name = "[化境-独门结界]",
    content0 = "皲裂也是出现雾气和热气的原因…不过原因不止这些",
    reward0_count = 0,
    needLevel = 130,
    bQLoop = 0
  }
  refs[1432] = {
    name = "[化境-意外相遇]",
    content0 = "嘟嘟囔囔…为了阻止师兄我也打算去西域。可是为了阻止大怪物打开地狱门召唤怪物们，结界…嘟囔…",
    reward0_count = 0,
    needLevel = 130,
    bQLoop = 0
  }
  refs[1433] = {
    name = "[化境-唤醒记忆的方法]",
    content0 = "唤醒秋叨鱼记忆的方法…绝顶天才竟然得了失心疯…南无阿弥陀佛…",
    reward0_count = 0,
    needLevel = 130,
    bQLoop = 0
  }
  refs[1562] = {
    name = "[长老候补-最终结果]",
    content0 = "能够领导古乐村的人才众多，我也不再一直让外甥女来当长老了。",
    reward0_count = 0,
    needLevel = 105,
    bQLoop = 0
  }
  refs[2130] = {
    name = "[ 用眼享受的料理？ ]",
    content0 = "好久不见，我有事情要拜托你",
    reward0_count = 1,
    needLevel = 108,
    bQLoop = 0
  }
  refs[2161] = {
    name = "[ 净化的千手妖女妖气 ]",
    content0 = "去击退千手妖女之前…咳咳…我有重要的话要说",
    reward0_count = 1,
    needLevel = 110,
    bQLoop = 0
  }
  refs[3631] = {
    name = "[ 千手妖女的复活 ]",
    content0 = "太乙仙女来信了",
    reward0_count = 1,
    needLevel = 110,
    bQLoop = 0
  }
  return refs
end
