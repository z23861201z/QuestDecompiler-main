-- DB_DRIVEN_EXPORT
-- source: npc_218008.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_218008"
  local refs = {}
  refs[110] = {
    name = "[每晚都传来的怪声]",
    content0 = "欢迎光临。看着没什么精神？是因为最近每晚都传来的怪声，晚上无法入睡才这样的。",
    reward0_count = 0,
    needLevel = 61,
    bQLoop = 0
  }
  refs[676] = {
    name = "[ 开启新的黄泉（2） ]",
    content0 = "邪派那些家伙不但不会告诉你，还会拿你逗乐子，不过我们正派就算再累也会秉持正义。因此清阴胡须张才让你来找我的吧。",
    reward0_count = 0,
    needLevel = 20,
    bQLoop = 0
  }
  refs[802] = {
    name = "[ 怪林地狱-磷火的盛宴 ]",
    content0 = "我的记忆力不是很好，你是不是说过要拯救百姓于水火之中？那么我给你分配一个任务。对你来说不会很难。",
    reward0_count = 1,
    needLevel = 30,
    bQLoop = 0
  }
  refs[803] = {
    name = "[ 暗血地狱-太和老君的教诲 ]",
    content0 = "嗯？为什么找我？不过你看起来好眼熟啊…无所谓啦，你在找需要你帮助的人吗？那你愿意去帮助陷入困境的冥珠城父母官吗？",
    reward0_count = 0,
    needLevel = 60,
    bQLoop = 0
  }
  refs[804] = {
    name = "[ 巨大鬼怪-炫耀实力 ]",
    content0 = "糟糕。头一次看到那么无知的家伙，连封印结界也吃掉了。嗯？干嘛目不转睛的看着我。你认识我吗？哼。虽然不记得你了，但是你还得给我帮个忙。可以吧？",
    reward0_count = 1,
    needLevel = 60,
    bQLoop = 0
  }
  refs[806] = {
    name = "[ 八豆妖地狱-贪婪的猪大长 ]",
    content0 = "哎呦，减寿十年啊。喂，你知道吗？前不久清野江对面的清江村里发生了一件大事儿。",
    reward0_count = 1,
    needLevel = 30,
    bQLoop = 0
  }
  refs[855] = {
    name = "[ 霸主地狱-逃亡者猪大长 ]",
    content0 = "喂，你知道吗？最近白血鬼谷林里出现了黄泉裂缝，鬼舞蛇魔眼找我帮忙。所以我去帮他们封印了。",
    reward0_count = 0,
    needLevel = 20,
    bQLoop = 0
  }
  refs[856] = {
    name = "[ 杀气地狱-邪恶恶魂天鬼 ]",
    content0 = "你认识鬼谷村的带花女吗？精神稍微有点异常。据说她总在村子里吵嚷着看到黄泉的裂缝。",
    reward0_count = 0,
    needLevel = 29,
    bQLoop = 0
  }
  refs[857] = {
    name = "[ 凶徒地狱-邪恶魔王犬 ]",
    content0 = "到底是鬼谷村？鬼谷村这个地方果然和地狱很近。又出现裂缝了。吓坏的仆人告诉我这件事，我才去的…",
    reward0_count = 0,
    needLevel = 35,
    bQLoop = 0
  }
  refs[870] = {
    name = "[ 皲裂地狱-暴走的火车轮怪 ]",
    content0 = "这次皲裂好像非常严重！好像有人用巨大的结界在阻挡，但是怪物依旧存在！",
    reward0_count = 1,
    needLevel = 130,
    bQLoop = 0
  }
  refs[871] = {
    name = "[ ??? ??? ?? ]",
    content0 = "??? ??? ???? ???? ??? ??? ?????. [?????]? ???? ????",
    reward0_count = 6,
    needLevel = 1,
    bQLoop = 0
  }
  refs[872] = {
    name = "[ 击退超火车轮怪! ]",
    content0 = "你知道吗？血魔深窟的皲裂导致超火车轮怪又出现了。竹统泛和菊花碴正在找你呢",
    reward0_count = 1,
    needLevel = 130,
    bQLoop = 0
  }
  refs[912] = {
    name = "{0xFFFFB4B4}[ 什么是黄泉？ ]{END}",
    content0 = "什么？你不知道什么是黄泉吗？那你知道地狱吗？是的，没错。生前作恶的人死后就会下地狱的。你就把黄泉当成地狱的前院儿就可以了。这里又叫冥府，生活着各种各样的怪物和鬼魂。",
    reward0_count = 0,
    needLevel = 0,
    bQLoop = 0
  }
  refs[914] = {
    name = "{0xFFFFB4B4}[ 如何进入黄泉的裂缝？ ]{END}",
    content0 = "嗯？要进那里？疯了吧。啊！不过非要进去的话带着指引用的灯火一起去吧。当然没有免费的啦。千万别觉得人心险恶哦。不管怎样把灯火扔进封印的入口，路就打开了。",
    reward0_count = 0,
    needLevel = 0,
    bQLoop = 0
  }
  refs[916] = {
    name = "{0xFFFFB4B4}[ 现在还有人因为黄泉的裂缝而受苦吗？ ]{END}",
    content0 = "嗯…我最后封印的黄泉裂缝是芦苇林中的某个农田，好像是清阴关里面露难色的农夫的地。人们称他为钱难赚。裂缝那边的地狱是怪林地狱，亦称磷火地狱，",
    reward0_count = 0,
    needLevel = 0,
    bQLoop = 0
  }
  refs[1458] = {
    name = "[化境-火器痕迹]",
    content0 = "古老的渡头原本水资源丰富，怪异的是这里烈火旺盛起来，我也觉得奇怪",
    reward0_count = 0,
    needLevel = 130,
    bQLoop = 0
  }
  refs[1459] = {
    name = "[化境-市场调查]",
    content0 = "等等！等等！看你不像来买东西的，如果不是客人恕不招待！",
    reward0_count = 1,
    needLevel = 130,
    bQLoop = 0
  }
  refs[1460] = {
    name = "[化境-隔海消息]",
    content0 = "什么？黑暗的坑？那个不祥之地怎么了？",
    reward0_count = 0,
    needLevel = 130,
    bQLoop = 0
  }
  refs[1525] = {
    name = "[ 生存教育-黄泉 ]",
    content0 = "我们这个地方叫做现世，相反，其他异界的空间称作黄泉",
    reward0_count = 0,
    needLevel = 1,
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
  refs[2043] = {
    name = "[ 军士 - 十二妖怪们 ]",
    content0 = "你有见过十二妖怪吗？外形像庞大的猪或狗，但是身体像人类的会飞的怪物",
    reward0_count = 0,
    needLevel = 29,
    bQLoop = 0
  }
  refs[2044] = {
    name = "[ 军士 - 击退猪大长 ]",
    content0 = "也不是什么大事。猪大长总想破坏通往霸主地狱的黄泉封印，你去制服吧",
    reward0_count = 0,
    needLevel = 30,
    bQLoop = 0
  }
  refs[2045] = {
    name = "[ 军士 - 佣兵领袖的召唤 ]",
    content0 = "除了霸主地狱，还有很多地狱的。如果有实力的话也试着挑战其他地狱吧。奖励少不了你的！",
    reward0_count = 0,
    needLevel = 31,
    bQLoop = 0
  }
  refs[3623] = {
    name = "[ 第一寺地下-千手妖女的手下们 ]",
    content0 = "听说最近第一寺附近出现了很多千手妖女的手下们…",
    reward0_count = 0,
    needLevel = 110,
    bQLoop = 0
  }
  refs[3653] = {
    name = "[ 土谷桃园-帮我找回东西 ]",
    content0 = "啊，来得正好.",
    reward0_count = 0,
    needLevel = 120,
    bQLoop = 0
  }
  return refs
end
