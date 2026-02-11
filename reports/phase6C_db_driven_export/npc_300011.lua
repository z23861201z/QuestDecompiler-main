-- DB_DRIVEN_EXPORT
-- source: npc_300011.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_300011"
  local refs = {}
  refs[91] = {
    name = "[ ???? ??? ]",
    content0 = "?? ???? ?? ???? ??? ??? ????? ?????. ?? ?? ? ???? ???? ???? ???? ?????? ???? ?? ??? ????? ???.",
    reward0_count = 0,
    needLevel = 15,
    bQLoop = 0
  }
  refs[132] = {
    name = "[ ???? ??1 ]",
    content0 = "??, ?? ??? ?? ???? ??? ?? ????",
    reward0_count = 1,
    needLevel = 35,
    bQLoop = 0
  }
  refs[133] = {
    name = "[ ???? ??2 ]",
    content0 = "??? ???? ?????? {0xFFFFFF00}??? 100?{END}? ??? ???? ?? {0xFFFFFF00}'???'{END}?? ??? ???????. ? ?? ??? ?????.",
    reward0_count = 1,
    needLevel = 35,
    bQLoop = 0
  }
  refs[134] = {
    name = "[ ???? ??3 ]",
    content0 = "'????'?? ? ????? ???? ??? ? ??? ??? ??? ?? ??? ?????.",
    reward0_count = 1,
    needLevel = 35,
    bQLoop = 0
  }
  refs[135] = {
    name = "[ ???? ??4 ]",
    content0 = "?…??? ? ??? ????… ?? {0xFFFFFF00}'???'{END}??? ??? ? ? ?? ? ?? ??? ??? ??? ??? ???? ???…",
    reward0_count = 1,
    needLevel = 35,
    bQLoop = 0
  }
  refs[136] = {
    name = "[ 寻找南呱湃 ]",
    content0 = "我会专注寻找'东泼肉'的。…红色…嘈杂的地方…醉酒的人们…嗯？怎么不是'东泼肉'而是年轻的女子啊…？不会是…",
    reward0_count = 0,
    needLevel = 35,
    bQLoop = 0
  }
  refs[458] = {
    name = "[ ???? ?? - ?? (1) ]",
    content0 = "? ? ???? ???, ??? ??? ??? ?? ????",
    reward0_count = 0,
    needLevel = 80,
    bQLoop = 0
  }
  refs[459] = {
    name = "[ ???? ?? - ?? (2) ]",
    content0 = "??? ??? ??? ???. ?? ????? ?? ???? ?? ???. ?????? ?? ?? ??? ?????",
    reward0_count = 0,
    needLevel = 80,
    bQLoop = 0
  }
  refs[460] = {
    name = "[ ???? ?? (1) ]",
    content0 = "{0xFFFFFF00}????{END}? ?? ???? ????. ?? {0xFFFFFF00}????{END}? ??? ?? ????",
    reward0_count = 0,
    needLevel = 80,
    bQLoop = 0
  }
  refs[461] = {
    name = "[ ???? ?? (2) ]",
    content0 = "?? ?? ?? ???. ?? ?? ?? ??????.",
    reward0_count = 0,
    needLevel = 80,
    bQLoop = 0
  }
  refs[462] = {
    name = "[希望-寻找秋叨鱼（1）]",
    content0 = "{0xFFFFFF00}秋叨鱼在兰霉匠{END}掌控皇宫的时候，被卷入邪恶的奸计，躲避这个世界，隐居了起来。",
    reward0_count = 0,
    needLevel = 80,
    bQLoop = 0
  }
  refs[743] = {
    name = "[ 西米路的强灵牌 ]",
    content0 = "好久不见。见到南呱湃了吗？她现在在哪儿啊？",
    reward0_count = 1,
    needLevel = 35,
    bQLoop = 0
  }
  refs[750] = {
    name = "[ 仙人的智慧 ]",
    content0 = "从你身上能看到[太和老君]的影子..\n不要过分相信自己的力量，好好使用吧",
    reward0_count = 1,
    needLevel = 150,
    bQLoop = 0
  }
  refs[1004] = {
    name = "[ 察觉危险! ]",
    content0 = "你是谁啊，竟然出现在我面前！",
    reward0_count = 0,
    needLevel = 41,
    bQLoop = 0
  }
  refs[1005] = {
    name = "[ 通报危险！ ]",
    content0 = "[ 皇宫武士魏朗 ]吗…。不用担心。我换了一张脸，他们没办法认出我。只希望不要有怪物的伤害…",
    reward0_count = 0,
    needLevel = 41,
    bQLoop = 0
  }
  refs[1007] = {
    name = "[ 兰霉匠手下的供词！ ]",
    content0 = "这是哪里…哎呦好晕啊。你…你是谁？",
    reward0_count = 0,
    needLevel = 41,
    bQLoop = 0
  }
  refs[1044] = {
    name = "[ 混沌的进攻 ]",
    content0 = "我在龙林城还有没完成的事情，你把我的话再次转达给柳江。",
    reward0_count = 0,
    needLevel = 60,
    bQLoop = 0
  }
  refs[1045] = {
    name = "[ 解读暗号 ]",
    content0 = "天下第一鬼谷城，天下太平兰霉匠’？嗯，像是某种暗号，不过不知道它具体的意思。",
    reward0_count = 0,
    needLevel = 60,
    bQLoop = 0
  }
  refs[1180] = {
    name = "[ 回到北瓶押处 ]",
    content0 = "真是以惊人的速度成长了啊。到现在没见过像你这样的人。不知道你是不是正在找回自己失去的力量啊。",
    reward0_count = 20,
    needLevel = 35,
    bQLoop = 0
  }
  refs[1206] = {
    name = "[ 丢失的物品 ]",
    content0 = "是北瓶押师弟派你来的？但是… 你… 这种独特的气息像是… 不是，不可能的。你到底是谁？",
    reward0_count = 0,
    needLevel = 35,
    bQLoop = 0
  }
  refs[1207] = {
    name = "[ 或许…。 ]",
    content0 = "嗯…这样看来{0xFFFFFF00}金刚项链和金刚戒指{END}不是因为狗骨头丢失的啊…。自言自语…。",
    reward0_count = 1,
    needLevel = 35,
    bQLoop = 0
  }
  refs[1210] = {
    name = "[ 西米路的决心 ]",
    content0 = "来，相信我敞开心扉吧。慢慢的深呼吸平复心情。像是睡着了一样安心的…。（把手放在少侠的头上）玛尼玛尼哄！",
    reward0_count = 1,
    needLevel = 1,
    bQLoop = 0
  }
  refs[1211] = {
    name = "[ 西米路的决心2 ]",
    content0 = "我恢复功力需要点时间。",
    reward0_count = 95,
    needLevel = 1,
    bQLoop = 0
  }
  refs[1241] = {
    name = "[ 南呱湃 ]",
    content0 = "来了？看来要找回我的功力还需要点时间。现在还没恢复到一半。要更久的时间才行啊。",
    reward0_count = 95,
    needLevel = 50,
    bQLoop = 0
  }
  refs[1433] = {
    name = "[化境-唤醒记忆的方法]",
    content0 = "唤醒秋叨鱼记忆的方法…绝顶天才竟然得了失心疯…南无阿弥陀佛…",
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
  refs[1436] = {
    name = "[化境-疯癫的天才军师]",
    content0 = "嘻，嘻…我什么也不知道。嘻…",
    reward0_count = 0,
    needLevel = 130,
    bQLoop = 0
  }
  refs[1437] = {
    name = "[修理ben10手镯!]",
    content0 = "借助大怪物的符咒，名为ben10手镯的物品从遥远的卡通网络世界到了我们这个世界",
    reward0_count = 1,
    needLevel = 1,
    bQLoop = 0
  }
  refs[1457] = {
    name = "[化境-好消息]",
    content0 = "秋叨鱼师兄竟然经历了这样的苦楚…那也就是说，师兄现在还在渡头守护着结界？",
    reward0_count = 0,
    needLevel = 130,
    bQLoop = 0
  }
  refs[2066] = {
    name = "[ 军士 - 为了西米路 ]",
    content0 = "为了找到太和老君到处打听过，但是一个人悄悄离开后谁都没有见过了。雪上加霜的是，兰霉匠派出了手下在找剩下的弟子",
    reward0_count = 0,
    needLevel = 49,
    bQLoop = 0
  }
  refs[2067] = {
    name = "[ 军士 - 为了西米路 ]",
    content0 = "北瓶押不知道，其实我因为之前的事情失去了千里眼的能力。准确的说是弱的没有多大用处了",
    reward0_count = 0,
    needLevel = 50,
    bQLoop = 0
  }
  refs[2068] = {
    name = "[ 军士 - 兰霉匠的手下 ]",
    content0 = "我在这里看着冥珠城每天的变化，知道了兰霉匠的可怕！",
    reward0_count = 0,
    needLevel = 51,
    bQLoop = 0
  }
  refs[2069] = {
    name = "[ 军士 - 证明管理人 ]",
    content0 = "像派系战这种血腥的战斗背后有皇宫高级装备的诱惑。我想那个装备应该归我们所有才是",
    reward0_count = 0,
    needLevel = 52,
    bQLoop = 0
  }
  refs[2070] = {
    name = "[ 军士 - 到底做了什么事？ ]",
    content0 = "你现在是要回到那位身边吗？他住在哪里啊？年纪呢？你知道他的名字的吧？告诉我吧，好不好？",
    reward0_count = 0,
    needLevel = 52,
    bQLoop = 0
  }
  refs[2071] = {
    name = "[ 军士 - 没有我不行？ ]",
    content0 = "连兰霉匠的左右手证明管理人也能上当的程度的话，我就不怕被发现了！对了，你不在的时候佣兵领袖派人来找过你，还让你在回去的路上完成一些事",
    reward0_count = 0,
    needLevel = 53,
    bQLoop = 0
  }
  refs[2898] = {
    name = "[ 泰华栏开放-谷玉 ]",
    content0 = "那个，你。看来终于准备好了。",
    reward0_count = 0,
    needLevel = 80,
    bQLoop = 0
  }
  return refs
end
