-- DB_DRIVEN_EXPORT
-- source: npc_300008.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_300008"
  local refs = {}
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
  refs[718] = {
    name = "[ 冬混汤-为了得到信任(1) ]",
    content0 = "原来如此，兰霉匠攻陷了冬混汤师兄的城池。好在冬混汤师兄能够平安无事。每次秋叨鱼师兄从皇宫出去都到冬混汤师兄的城里居住，所以冬混汤师兄也许知道秋叨鱼师兄的行踪",
    reward0_count = 0,
    needLevel = 99,
    bQLoop = 0
  }
  refs[719] = {
    name = "[ 冬混汤-为了得到信任(2) ]",
    content0 = "你从谁那么抢来的冬混汤一族的文章？之前就有人用相同的方法从我的熟人手里抢来，下场就是死在我的剑下。如果你不如实招来，我不会原谅你",
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
  refs[1457] = {
    name = "[化境-好消息]",
    content0 = "秋叨鱼师兄竟然经历了这样的苦楚…那也就是说，师兄现在还在渡头守护着结界？",
    reward0_count = 0,
    needLevel = 130,
    bQLoop = 0
  }
  refs[1458] = {
    name = "[化境-火器痕迹]",
    content0 = "古老的渡头原本水资源丰富，怪异的是这里烈火旺盛起来，我也觉得奇怪",
    reward0_count = 0,
    needLevel = 130,
    bQLoop = 0
  }
  refs[2341] = {
    name = "[ 荤扼柳 焙荤甫 茫酒扼 ]",
    content0 = "困瘤荐丛俊 措茄 巴捞扼搁 傈秦甸篮 唱焊促 歹 肋 酒绰 荤恩捞 乐扁绰 窍瘤.",
    reward0_count = 0,
    needLevel = 126,
    bQLoop = 0
  }
  refs[3650] = {
    name = "[ 修炼：击退片麻怪(每日) ]",
    content0 = "你应该也知道片麻怪在西危?谷威胁着人们的事情吧？",
    reward0_count = 0,
    needLevel = 118,
    bQLoop = 0
  }
  refs[3651] = {
    name = "[ 修炼：击退巫蛊娃娃(每日) ]",
    content0 = "你应该也知道巫蛊娃娃在西危?谷威胁着人们的事情吧？",
    reward0_count = 0,
    needLevel = 119,
    bQLoop = 0
  }
  refs[3652] = {
    name = "[ 修炼：击退妈妈星星(每日) ]",
    content0 = "你应该也知道妈妈星星在西危?谷威胁着人们的事情吧？",
    reward0_count = 0,
    needLevel = 120,
    bQLoop = 0
  }
  return refs
end
