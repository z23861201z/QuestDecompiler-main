-- DB_DRIVEN_EXPORT
-- source: npc_315025.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_315025"
  local refs = {}
  refs[867] = {
    name = "[ ???? ?? ]",
    content0 = "???? ?????? ????? ???? ? ?? ????? ??? ???. ??? ?? ??? ??? ? ? ???.",
    reward0_count = 1,
    needLevel = 99,
    bQLoop = 0
  }
  refs[889] = {
    name = "[ 守护生死的奖励 ]",
    content0 = "{0xFFFFFF00}击退40个[影魔]{END}之后回来就给你{0xFFFFFF00}1个生死守护符{END}。记住了，这个任务是{0xFFFFFF00}一天只能完成一次{END}。",
    reward0_count = 1,
    needLevel = 80,
    bQLoop = 0
  }
  refs[973] = {
    name = "{0xFFFFB4B4}[ 生死守护符 ]{END}",
    content0 = "过去镇压了妖怪们的不只是太和老君和他的12个弟子。也不能忘了没来得及留下名字就倒下的无数的英雄们。",
    reward0_count = 0,
    needLevel = 0,
    bQLoop = 0
  }
  refs[1347] = {
    name = "[ 修行之路 ]",
    content0 = "拿来了叛徒南呱湃的信？我为什么要收那个？拿回去吧！",
    reward0_count = 0,
    needLevel = 80,
    bQLoop = 0
  }
  refs[1348] = {
    name = "[ 第一寺的逃犯 ]",
    content0 = "年轻的施主有何事来找在下啊？",
    reward0_count = 0,
    needLevel = 80,
    bQLoop = 0
  }
  refs[1349] = {
    name = "[ 解析密码的方法 ]",
    content0 = "耳环性能怎么样啊？",
    reward0_count = 3,
    needLevel = 80,
    bQLoop = 0
  }
  refs[1350] = {
    name = "[ 异界的侵蚀 ]",
    content0 = "我们第一寺的僧侣对空间的裂缝特别敏感，但是感觉这塔就是在异界和现实的境界。",
    reward0_count = 3,
    needLevel = 81,
    bQLoop = 0
  }
  refs[1351] = {
    name = "[ 引起健忘症的粉末 ]",
    content0 = "侵蚀的理由现在还不清楚，但这期间对塔内的结构一直有研究。对塔内的结构说明的话… ",
    reward0_count = 80,
    needLevel = 81,
    bQLoop = 0
  }
  refs[1352] = {
    name = "[ 引发暴力的喷嚏 ]",
    content0 = "年、年轻的施主，不是故意的。相信我。",
    reward0_count = 30,
    needLevel = 82,
    bQLoop = 0
  }
  refs[1353] = {
    name = "[ 为了确信的研究 ]",
    content0 = "查出侵蚀的原因很难啊。还得收集更多的材料，彻底的研究一下。",
    reward0_count = 3,
    needLevel = 82,
    bQLoop = 0
  }
  refs[1354] = {
    name = "[ 塔的结构 ]",
    content0 = "吞噬了塔表面的巨大的树。利用被叫做血玉髓的那棵巨大的树的藤的话，应该不用经过塔救你能上去了吧。",
    reward0_count = 30,
    needLevel = 83,
    bQLoop = 0
  }
  refs[1355] = {
    name = "[ 为了更方便的移动 ]",
    content0 = "连续来回塔内，累了吧？",
    reward0_count = 3,
    needLevel = 83,
    bQLoop = 0
  }
  refs[1356] = {
    name = "[ 盲目的挑战（1） ]",
    content0 = "哇哈哈哈！全烧掉了~！…… 年轻的施主…. 看来火力不够啊。",
    reward0_count = 0,
    needLevel = 84,
    bQLoop = 0
  }
  refs[1357] = {
    name = "[ 盲目的挑战（2） ]",
    content0 = "忘却之房上面的苦痛之房墙壁出了个洞。现在应该很方便的进去了。",
    reward0_count = 30,
    needLevel = 84,
    bQLoop = 0
  }
  refs[1358] = {
    name = "[ 无止境的恶性循环 ]",
    content0 = "苦痛之房的岩石怪是，鬼声符咒碰触到构成塔的石头诞生的。所以收集了所有的鬼声符咒才能说是击退了岩石怪。",
    reward0_count = 30,
    needLevel = 85,
    bQLoop = 0
  }
  refs[1359] = {
    name = "[ 私人请求 ]",
    content0 = "年轻施主，我知道有点过分，但能不能帮我个人的一个忙啊？",
    reward0_count = 3,
    needLevel = 85,
    bQLoop = 0
  }
  refs[1360] = {
    name = "[ 蛀蚀的怪物 ]",
    content0 = "这次应该是魔眼了。魔眼是个很奇特的怪物，是从别的世界通过间隙挤进了这个世界的怪物。",
    reward0_count = 0,
    needLevel = 86,
    bQLoop = 0
  }
  refs[1361] = {
    name = "[ 另一侵蚀 ]",
    content0 = "你是说苦痛之房也有被侵蚀的怪物吗？",
    reward0_count = 1,
    needLevel = 86,
    bQLoop = 0
  }
  refs[1362] = {
    name = "[材料不足]",
    content0 = "年轻的施主，虽然有点过意不去，但能不能再帮我击退侵蚀岩石怪啊？",
    reward0_count = 0,
    needLevel = 87,
    bQLoop = 0
  }
  refs[1363] = {
    name = "[到悲伤之房]",
    content0 = "不能再上去了？具体是什么问题啊？",
    reward0_count = 0,
    needLevel = 87,
    bQLoop = 0
  }
  refs[1364] = {
    name = "[新入口的可能性]",
    content0 = "研究施主带过来的痛苦的粘液，知道了有趣的结果。",
    reward0_count = 1,
    needLevel = 88,
    bQLoop = 0
  }
  refs[1365] = {
    name = "[一直都很危险的毒物]",
    content0 = "东泼肉那么说的？",
    reward0_count = 0,
    needLevel = 88,
    bQLoop = 0
  }
  refs[1366] = {
    name = "[事前预防]",
    content0 = "刚才刮风的时候发现从悲伤之房再次渗出毒性粉末。",
    reward0_count = 3,
    needLevel = 89,
    bQLoop = 0
  }
  refs[1367] = {
    name = "[从毒雾中]",
    content0 = "施，施主 看到了吗？从毒雾中看到的巨大的蛇头的…",
    reward0_count = 30,
    needLevel = 90,
    bQLoop = 0
  }
  refs[1368] = {
    name = "[追赶逃跑的蛇]",
    content0 = "尽然没看出是这样的人物。",
    reward0_count = 30,
    needLevel = 90,
    bQLoop = 0
  }
  refs[1369] = {
    name = "[灵魂的解放(1)]",
    content0 = "施主。其实我来到生死之塔之后开始，一直担心着一件事情。",
    reward0_count = 3,
    needLevel = 91,
    bQLoop = 0
  }
  refs[1370] = {
    name = "[灵魂的解放(2)]",
    content0 = "施主，幽灵甲真的是向我们猜测的一样，是邪教群的实验中成为牺牲品的人困在盔甲之中形成的怪物。",
    reward0_count = 0,
    needLevel = 91,
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
  refs[1373] = {
    name = "[ 出人意料的活用 ]",
    content0 = "趁着施主去第一寺的这段时间，我研究了下有没有更简单的方法来回生死之塔。",
    reward0_count = 0,
    needLevel = 93,
    bQLoop = 0
  }
  refs[1374] = {
    name = "[ 不足的材料 ]",
    content0 = "咒术需要的材料是幽灵魔珠和穷鬼布袋。各需要15个。",
    reward0_count = 30,
    needLevel = 93,
    bQLoop = 0
  }
  refs[1375] = {
    name = "[术法的行踪]",
    content0 = "那，红、红色的树！",
    reward0_count = 3,
    needLevel = 94,
    bQLoop = 0
  }
  refs[1376] = {
    name = "[生死之房的侵蚀度]",
    content0 = "生死之房比其他下面层侵蚀度更高。得特别注意才行。",
    reward0_count = 0,
    needLevel = 94,
    bQLoop = 0
  }
  refs[1377] = {
    name = "[渐渐清晰的真相]",
    content0 = "缠绕着生死之塔的巨大的红色树枝和黑树妖肯定有什么关联。",
    reward0_count = 0,
    needLevel = 95,
    bQLoop = 0
  }
  refs[1378] = {
    name = "[独特的油]",
    content0 = "施主收集回来的这些粘性很强的油真的很独特啊。在常温下是马上就会干掉的。",
    reward0_count = 0,
    needLevel = 95,
    bQLoop = 0
  }
  refs[1379] = {
    name = "[一定会被需要]",
    content0 = "我研究了黑树妖皮，得到了惊人的事实。",
    reward0_count = 30,
    needLevel = 96,
    bQLoop = 0
  }
  refs[1381] = {
    name = "[回到生死之塔(2)]",
    content0 = "不知道该怎么报答这恩惠啊。但是少侠为什么回来生死之塔？",
    reward0_count = 0,
    needLevel = 96,
    bQLoop = 0
  }
  refs[1382] = {
    name = "[扎下跟的危险（1）]",
    content0 = "趁你不在的时候我做了进一步的调查，结果发现塔内部到处生根的树枝竟是血玉髓的树枝。",
    reward0_count = 3,
    needLevel = 97,
    bQLoop = 0
  }
  refs[1383] = {
    name = "[扎下跟的危险（2）]",
    content0 = "看来这些还是不够啊。为了安全，可不可以再辛苦一次啊？",
    reward0_count = 1,
    needLevel = 97,
    bQLoop = 0
  }
  refs[1384] = {
    name = "[红树生死液]",
    content0 = "黑树妖喝了血玉髓的生死液，在以叫红树妖的更强大的怪物重新诞生。",
    reward0_count = 0,
    needLevel = 98,
    bQLoop = 0
  }
  refs[1385] = {
    name = "[血玉髓的来历（1）]",
    content0 = "血玉髓这个怪物是过去邪教的人研究出来的最强的怪物。",
    reward0_count = 0,
    needLevel = 98,
    bQLoop = 0
  }
  refs[1386] = {
    name = "[血玉髓的来历（2）]",
    content0 = "所有的事情都连在一起了。所有的事…。凶徒匪人把第一寺的视线引到这里来的，东泼肉施主冒着危险前往生死地狱的事等等…。",
    reward0_count = 1,
    needLevel = 99,
    bQLoop = 0
  }
  refs[1388] = {
    name = "[要经过的顺序(2) ]",
    content0 = "其实所有的方法武艺僧长经那孩子都知道。只是在担心可不可以击退像我子女一样的血玉髓，对我会不会有影响。",
    reward0_count = 0,
    needLevel = 99,
    bQLoop = 0
  }
  refs[1389] = {
    name = "[准备完毕]",
    content0 = "其实也猜到了一点，所以已经都准备完毕了。",
    reward0_count = 30,
    needLevel = 99,
    bQLoop = 0
  }
  refs[1390] = {
    name = "[去往生死地狱]",
    content0 = "黄泉结界僧们应该打开了通往生死地狱的通道。但，跟之前不同，这次需要中级灯火。中级灯火可以在汉谟拉比商人处购买。",
    reward0_count = 1,
    needLevel = 99,
    bQLoop = 0
  }
  refs[1391] = {
    name = "[凶徒的意义]",
    content0 = "施主，你先听听。",
    reward0_count = 0,
    needLevel = 99,
    bQLoop = 0
  }
  refs[1426] = {
    name = "[化境-渡头变故]",
    content0 = "施主，听说西危?谷另一边的古老的渡头出现了时空皲裂",
    reward0_count = 0,
    needLevel = 130,
    bQLoop = 0
  }
  refs[1428] = {
    name = "[化境-散不去的雾气]",
    content0 = "击退火车轮怪也没有什么变化啊。到底问题出在哪儿呢？",
    reward0_count = 0,
    needLevel = 130,
    bQLoop = 0
  }
  refs[1429] = {
    name = "[化境-雾气来源]",
    content0 = "击退怪物后雾气和热气也没有消失…这肯定是因为时空的皲裂",
    reward0_count = 0,
    needLevel = 130,
    bQLoop = 0
  }
  refs[1434] = {
    name = "[化境-一丝线索]",
    content0 = "秋叨鱼师兄的精神异常…怎么可能…",
    reward0_count = 0,
    needLevel = 130,
    bQLoop = 0
  }
  refs[1435] = {
    name = "[化境-结界的位置]",
    content0 = "要找到结界的位置？你不说我也已经差人把疯癫的老人抓起来搜查了",
    reward0_count = 1,
    needLevel = 130,
    bQLoop = 0
  }
  refs[3630] = {
    name = "[ 重生的血玉髓 ]",
    content0 = "你来的正好~你去帮忙击退血玉髓吧",
    reward0_count = 1,
    needLevel = 99,
    bQLoop = 0
  }
  return refs
end
