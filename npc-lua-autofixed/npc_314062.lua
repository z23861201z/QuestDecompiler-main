function npcsay(id)
  if id ~= 4314062 then
    return
  end
  clickNPCid = id
  if GET_PLAYER_JOB1() == 11 then
    NPC_SAY("将我们佣兵团的名字告知天下吧！")
  else
    NPC_SAY("我就是佣兵领袖，你不是我们佣兵团的人，没事就赶紧走开吧~")
  end
  if qData[2018].state == 1 then
    SET_QUEST_STATE(2018, 2)
    NPC_SAY("来得正好，伤已经痊愈了？")
  end
  if qData[2019].state == 1 then
    SET_QUEST_STATE(2019, 2)
    NPC_SAY("叫[枪术精通]的内功是使用枪的基本能力。这个技能会使你的枪更加锋利")
  end
  if qData[2020].state == 1 then
    SET_QUEST_STATE(2020, 2)
    NPC_SAY("通过[血气印记]，你的血门能获得强大的力量。下面要教你的技能叫什么来着..")
  end
  if qData[2021].state == 1 then
    if qData[2021].killMonster[qt[2021].goal.killMonster[1].id] >= qt[2021].goal.killMonster[1].count then
      SET_QUEST_STATE(2021, 2)
      NPC_SAY("辛苦了。这次要教你的技能是{0xFFFFFF00}[穿刺枪]{END}。以光靠肉体的力量是无法达到的速度快速刺2次的技能。这个技能可以累积血门")
    else
      NPC_SAY("还没完成吗？你去击退10个浑身是黑毛的[毛毛]吧。你完成任务期间我会准备要教你的武功")
    end
  end
  if qData[2022].state == 1 then
    if qData[2022].killMonster[qt[2022].goal.killMonster[1].id] >= qt[2022].goal.killMonster[1].count then
      SET_QUEST_STATE(2022, 2)
      NPC_SAY("辛苦了。{0xFFFFFF00}[冲击波]{END}是血门开放武功。血门开放武功可以直接使用，但是如果累积血门后使用的话变得更强大。特别是击退、定身等效果的成功率会提升")
    else
      NPC_SAY("没找到[螳螂勇勇]吗？你通过左边的传送点过去的话能看到长得像螳螂的怪物，你击退12个后回来吧。这期间我会准备下一个技能的")
    end
  end
  if qData[2023].state == 1 then
    NPC_SAY("关于北瓶押，胡须张比我更了解，我正好有事要向[胡须张]报告的，你去一趟吧。他在[清阴镖局]")
  end
  if qData[2027].state == 1 then
    SET_QUEST_STATE(2027, 2)
    NPC_SAY("怎么这么晚啊？有人在找你")
  end
  if qData[2028].state == 1 then
    NPC_SAY("快去{0xFFFFFF00}[隐藏的清阴谷]{END}见{0xFFFFFF00}[北瓶押]{END}吧")
  end
  if qData[2029].state == 1 then
    SET_QUEST_STATE(2029, 2)
    NPC_SAY("怎么这么慢啊？总之来得正好~我刚好在找你呢")
  end
  if qData[2030].state == 1 then
    if qData[2030].killMonster[qt[2030].goal.killMonster[1].id] >= qt[2030].goal.killMonster[1].count then
      SET_QUEST_STATE(2030, 2)
      NPC_SAY("做得好~人要想获得什么东西，就要付出相应的代价。来，我教你武功")
    else
      NPC_SAY("你击退[北清阴平原]的20个[触目仔]后回来吧，那我会教你技能的")
    end
  end
  if qData[2031].state == 1 then
    if qData[2031].killMonster[qt[2031].goal.killMonster[1].id] >= qt[2031].goal.killMonster[1].count then
      SET_QUEST_STATE(2031, 2)
      NPC_SAY("怎么样？现在应该可以来回更远的地方了，交给你更重要的任务吧~")
    else
      NPC_SAY("这次的佣兵任务是击退[北清阴平原]的[铜铃眼]。击退10个就可以了")
    end
  end
  if qData[2032].state == 1 then
    NPC_SAY("清阴关最西边有[黄泉结界高僧]，通过他进入异界门就可以了。在异界门见见[汉谟拉比商人]后回来吧")
  end
  if qData[2033].state == 1 then
    SET_QUEST_STATE(2033, 2)
    NPC_SAY("什么？黄泉是那种地方？危险不是问题，但是已经有人在管理了就不可能当成秘密营地使用了。总之辛苦了~")
  end
  if qData[2034].state == 1 then
    if qData[2034].killMonster[qt[2034].goal.killMonster[1].id] >= qt[2034].goal.killMonster[1].count and __QUEST_HAS_ALL_ITEMS(qt[2034].goal.getItem) then
      SET_QUEST_STATE(2034, 2)
      NPC_SAY("能力确实比之前提高了不少啊，是该教你新的武功了吗？")
    else
      NPC_SAY("在芦苇林击退20个[怪老子]，收集10个[姜丝男的牙齿]回来吧")
    end
  end
  if qData[2035].state == 1 then
    NPC_SAY("进入市集入口能看到[委托销售]的很大的箱子，你点击查看巡视日记吧。后面的事情那里都写着呢")
  end
  if qData[2036].state == 1 then
    SET_QUEST_STATE(2036, 2)
    NPC_SAY("辛苦了。现在教你[碎云斩]。枪不仅仅刀刃是武器，风也具有威胁性。[碎云斩]是将锋部分向地面击打利用冲击的武功")
  end
  if qData[2037].state == 1 then
    NPC_SAY("快去[无名湖]的建筑物说服[路边摊]吧")
  end
  if qData[2038].state == 1 then
    SET_QUEST_STATE(2038, 2)
    NPC_SAY("竹林里有李无极？HOHO..不错啊~")
  end
  if qData[2039].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[2039].goal.getItem) then
      SET_QUEST_STATE(2039, 2)
      NPC_SAY("辛苦了。还有一件事要你帮忙，稍等一下")
    else
      NPC_SAY("你去芦苇林击退[红毛龟]，收集10个红毛龟的壳回来吧")
    end
  end
  if qData[2040].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[2040].goal.getItem) then
      SET_QUEST_STATE(2040, 2)
      NPC_SAY("很好~加上你带过来的，差不多够啦")
    else
      NPC_SAY("去芦苇林击退[背影杀手]，收集12个背影杀手的镜回来吧")
    end
  end
  if qData[2041].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[2041].goal.getItem) then
      SET_QUEST_STATE(2041, 2)
      NPC_SAY("肉质确实很好啊~辛苦了")
    else
      NPC_SAY("去清阴关找[云善道人]，他会把你送到[鬼谷村]的。你就去村子东边的[白血鬼谷林]击退[双头猪怪]，收集15个双头猪怪五花肉回来吧")
    end
  end
  if qData[2042].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[2042].goal.getItem) then
      SET_QUEST_STATE(2042, 2)
      NPC_SAY("这个武功一直以来都是未完成状态的，但是现在利用李无极的毒完成了。是制作毒雾使对方中毒的技能。收集血门释放的话效果更好")
    else
      NPC_SAY("你能帮忙完成这件事，我就教你很好用的武功。路过清江村去强悍巷道深处击退[蓝色大菜头]，收集10个蓝色的灯油回来吧")
    end
  end
  if qData[2043].state == 1 then
    NPC_SAY("还没去吗？去见[汉谟拉比商人]吧。她会告诉你你要做的事情")
  end
  if qData[2045].state == 1 then
    SET_QUEST_STATE(2045, 2)
    NPC_SAY("快过来吧，我给你准备了事情。先听我说")
  end
  if qData[2046].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[2046].goal.getItem) then
      SET_QUEST_STATE(2046, 2)
      NPC_SAY("嗯..很好。这些足够了")
    else
      NPC_SAY("去竹林击退箭骨头，收集12个[受诅咒的骨头]回来吧")
    end
  end
  if qData[2047].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[2047].goal.getItem) then
      SET_QUEST_STATE(2047, 2)
      NPC_SAY("嗯..是这个啊。这些足够研究用了。辛苦了~")
    else
      NPC_SAY("需要调查蛇腹窟怪物中的[黄金猎犬]，你去击退黄金猎犬，收集10个[黄金猎犬的牙]回来吧")
    end
  end
  if qData[2048].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[2048].goal.getItem) then
      SET_QUEST_STATE(2048, 2)
      NPC_SAY("很好，这就是[太极护盾]。可以提升你的防御力，也提升你对各种状态异常的耐性")
    else
      NPC_SAY("你再去击退前不久你击退过的黄金猎犬，收集15个[黄金猎犬的牙]回来吧。我会用那个传授你武功~")
    end
  end
  if qData[2049].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[2049].goal.getItem) then
      SET_QUEST_STATE(2049, 2)
      NPC_SAY("现在比之前更熟练的使用武功了啊~辛苦你了！")
    else
      NPC_SAY("击退蛇腹窟的[糯米肠]，收集10个[糯米肠的蛋]回来吧")
    end
  end
  if qData[2050].state == 1 then
    if qData[2050].killMonster[qt[2050].goal.killMonster[1].id] >= qt[2050].goal.killMonster[1].count then
      SET_QUEST_STATE(2050, 2)
      NPC_SAY("实力提高了不少啊~做得好！怪物的头目以后还会出现的，那时候别的军士应该能解决，你就不用担心了")
    else
      NPC_SAY("去击退1个蛇腹窟深处的[狗骨头]吧。狗骨头很会藏身，要静等10分钟左右，注意观察才行。击退后马上回到我这边吧")
    end
  end
  if qData[2051].state == 1 then
    NPC_SAY("你去[清阴关]中央的[正派建筑]见见[白斩姬]吧")
  end
  if qData[2052].state == 1 then
    SET_QUEST_STATE(2052, 2)
    NPC_SAY("我刚刚也见了几名正派人。辛苦了~")
  end
  if qData[2053].state == 1 then
    NPC_SAY("去[清阴关]西边的[邪派建筑]见[乌骨鸡]吧")
  end
  if qData[2054].state == 1 then
    SET_QUEST_STATE(2054, 2)
    NPC_SAY("辛苦了。你应该也听说过了吧，现在各派系为了补充实力，一直在招募新人。如果功力达到40或以上还没有选择派系的话，就有资格的")
  end
  if qData[2055].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[2055].goal.getItem) then
      SET_QUEST_STATE(2055, 2)
      NPC_SAY("[横扫八方]是挥舞枪横扫周围的武功，被怪物围起来的时候能发挥很强大的力。当然，它的射程很远，普通时候也很有用。会对你的实力有帮助的")
    else
      NPC_SAY("击退出没于竹林西边的[双节龙]，收集15个双节龙的牙齿回来吧")
    end
  end
  if qData[2056].state == 1 then
    if qData[2056].killMonster[qt[2056].goal.killMonster[1].id] >= qt[2056].goal.killMonster[1].count then
      SET_QUEST_STATE(2056, 2)
      NPC_SAY("辛苦了。现在营地的安全在一定时间内能得到保障了~")
    else
      NPC_SAY("这次的任务是击退出没于竹林的[美丽人参]。击退50个后回来吧")
    end
  end
  if qData[2057].state == 1 then
    if GET_PLAYER_FACTION() == 0 or GET_PLAYER_FACTION() == 1 then
      SET_QUEST_STATE(2057, 2)
      NPC_SAY("哦..你选择的是那边啊？你选择哪边对我来说都无所谓。你军士的身份始终没变就行。我现在就能感觉得到你身上更强大的力量了~你把这个带到辅助装备上吧，佩戴盾牌你就变的更强大了。哈哈哈！")
    else
      NPC_SAY("你决定了要加入哪个派系的话，就去正派或邪派建筑找[白斩姬]或[乌骨鸡]加入派系吧~")
    end
  end
  if qData[2058].state == 1 then
    if qData[2058].killMonster[qt[2058].goal.killMonster[1].id] >= qt[2058].goal.killMonster[1].count then
      SET_QUEST_STATE(2058, 2)
      NPC_SAY("刚刚好~安全强化也刚结束。还获悉了新的情报")
    else
      NPC_SAY("你要能帮忙击退50个左右的[飞头鬼]，就能帮我们争取加强结界所需的时间。加油！")
    end
  end
  if qData[2059].state == 1 then
    NPC_SAY("快去[韩野都城]吧。那里有第9弟子冬混汤的孙子[高一燕]，你去告诉他进攻的阴谋吧~")
  end
  if qData[2060].state == 1 then
    SET_QUEST_STATE(2060, 2)
    NPC_SAY("以后会有请求他们帮助的时候，这次能建立有好的关系，你的功劳很大。我为你准备了武功。是使用血门的武功，能远距离攻击")
  end
  if qData[2061].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[2061].goal.getItem) then
      SET_QUEST_STATE(2061, 2)
      NPC_SAY("佣兵事务虽然辛苦，但是为了储备军资还要认真的做事才行~再说帮助他们，也可以报恩")
    else
      NPC_SAY("胡须张派人来说需要[独角阿鲁巴巴]的[断掉的链子]，可能要用在运送装备上的。你去收集15个[断掉的链子]回来吧")
    end
  end
  if qData[2062].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[2062].goal.getItem) then
      SET_QUEST_STATE(2062, 2)
      NPC_SAY("辛苦了~虽然可以跟韩野城的少侠们一起进入，但是想要了解他们的阴谋，最好是悄悄潜入窃取情报。这些事会由以前跟随暗部团长的暗部们进行")
    else
      NPC_SAY("你帮我收集潜入鬼谷城所需的15个[飞头鬼]的[黑粉]吧")
    end
  end
  if qData[2063].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[2063].goal.getItem) then
      SET_QUEST_STATE(2063, 2)
      NPC_SAY("这就是大怪物的精髓啊~辛苦了")
    else
      NPC_SAY("击退任何怪物都有可能获得[大怪物的精髓]，击退怪物的过程中收集到了就送我1个吧")
    end
  end
  if qData[2064].state == 1 then
    if qData[2064].killMonster[qt[2064].goal.killMonster[1].id] >= qt[2064].goal.killMonster[1].count then
      SET_QUEST_STATE(2064, 2)
      NPC_SAY("每完成一次佣兵事务，你都能迅速成长。你果然是天生的武林人士啊~")
    else
      NPC_SAY("在冥珠平原击退60个变成妖怪的[大胡子]后再回来吧")
    end
  end
  if qData[2065].state == 1 then
    NPC_SAY("击退青岳秀洞的蓝蜗牛，收集15个[蓝蜗牛的壳]拿给[北瓶押]吧")
  end
  if qData[2071].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[2071].goal.getItem) then
      SET_QUEST_STATE(2071, 2)
      NPC_SAY("哦！你来了？怎么这么晚啊")
    else
      NPC_SAY("让你带过来的拿来了吗？快去收集15个[绿蜗牛]的[绿蜗牛的壳]回来吧")
    end
  end
  if qData[2072].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[2072].goal.getItem) then
      SET_QUEST_STATE(2072, 2)
      NPC_SAY("果然还是你厉害，就知道你能马上完成！")
    else
      NPC_SAY("这次的佣兵业务是收集龙林山[黑熊]的15个熊胆，对你来说是小意思~")
    end
  end
  if qData[2073].state == 1 then
    NPC_SAY("去冥珠城的中心[冥珠都城]吧。那里会有[冥珠城父母官]迎接你的。对了，可别空手过去~击退龙林谷的[虾米狼]，收集15个[虾米狼的皮]拿过去吧！")
  end
  if qData[2076].state == 1 then
    SET_QUEST_STATE(2076, 2)
    NPC_SAY("什么？黄泉出现了皲裂？巨大鬼怪？知道了，我马上做准备~")
  end
  if qData[2077].state == 1 then
    NPC_SAY("收集20个[肉块]后马上交给[冥珠城父母官]吧。时间紧迫，你快点行动吧~")
  end
  if qData[2079].state == 1 then
    SET_QUEST_STATE(2079, 2)
    NPC_SAY("这样啊..力量的必要性~知道有一天你会想进行2次转职，但没想到会这么快...")
  end
  if qData[2080].state == 1 then
    if GET_PLAYER_JOB2() == 17 or GET_PLAYER_JOB2() == 18 then
      SET_QUEST_STATE(2080, 2)
      NPC_SAY("很棒！")
    else
      NPC_SAY("根据你选择的派系，去找[白斩姬]或[乌骨鸡]吧。他们会帮你完成2次转职的")
    end
  end
  if qData[2081].state == 1 then
    NPC_SAY("我已经跟龙林城的[龙林派师兄]打过招呼了，他会帮助你的~")
  end
  if qData[2102].state == 1 then
    if GET_PLAYER_LEVEL() >= 20 then
      SET_QUEST_STATE(2102, 2)
      NPC_SAY("恭喜你达到20级！现在变得很威武了啊~")
    else
      NPC_SAY("你功力达到20级，我会送你特殊的礼物~")
    end
  end
  if qData[3608].state == 1 then
    if 1 <= CHECK_INVENTORY_CNT(2) then
      NPC_SAY("促矫 富阑 吧搁 {0xFFFFFF00}[厘固采]{END}甫 林摆匙. 辑滴福绰霸 亮阑 芭具.")
      SET_QUEST_STATE(3608, 2)
      return
    else
      NPC_SAY("青扯捞 呈公 公疤嚼聪促!")
    end
  end
  if qData[2156].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[2156].goal.getItem) then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("太感谢了！托你的福，我们佣兵团的名誉挽回了不少。这是答应给你的{0xFFFFFF00}[佣兵团箱子]{END}。请好好使用吧")
        SET_QUEST_STATE(2156, 2)
        return
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("你找回10个{0xFFFFFF00}[金牌]{END}就送你我们准备的{0xFFFFFF00}[佣兵团箱子]{END}")
    end
  end
  if qData[2157].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[2157].goal.getItem) then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("太感谢了！托你的福，我们佣兵团的名誉挽回了不少。这是答应给你的{0xFFFFFF00}[佣兵团箱子]{END}。请好好使用吧")
        SET_QUEST_STATE(2157, 2)
        return
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("你找回20个{0xFFFFFF00}[银牌]{END}就送你我们准备的{0xFFFFFF00}[佣兵团箱子]{END}")
    end
  end
  if qData[2158].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[2158].goal.getItem) then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("太感谢了！托你的福，我们佣兵团的名誉挽回了不少。这是答应给你的{0xFFFFFF00}[佣兵团箱子]{END}。请好好使用吧")
        SET_QUEST_STATE(2158, 2)
        return
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("你找回30个{0xFFFFFF00}[铜牌]{END}就送你我们准备的{0xFFFFFF00}[佣兵团箱子]{END}")
    end
  end
  if qData[2019].state == 0 and qData[2018].state == 2 and GET_PLAYER_JOB1() == 11 then
    ADD_QUEST_BTN(qt[2019].id, qt[2019].name)
  end
  if qData[2020].state == 0 and qData[2019].state == 2 and GET_PLAYER_JOB1() == 11 then
    ADD_QUEST_BTN(qt[2020].id, qt[2020].name)
  end
  if qData[2021].state == 0 and qData[2020].state == 2 and GET_PLAYER_JOB1() == 11 then
    ADD_QUEST_BTN(qt[2021].id, qt[2021].name)
  end
  if qData[2022].state == 0 and qData[2021].state == 2 and GET_PLAYER_JOB1() == 11 then
    ADD_QUEST_BTN(qt[2022].id, qt[2022].name)
  end
  if qData[2023].state == 0 and qData[2022].state == 2 and GET_PLAYER_JOB1() == 11 then
    ADD_QUEST_BTN(qt[2023].id, qt[2023].name)
  end
  if qData[2028].state == 0 and qData[2027].state == 2 and GET_PLAYER_JOB1() == 11 then
    ADD_QUEST_BTN(qt[2028].id, qt[2028].name)
  end
  if qData[2030].state == 0 and qData[2029].state == 2 and GET_PLAYER_JOB1() == 11 then
    ADD_QUEST_BTN(qt[2030].id, qt[2030].name)
  end
  if qData[2031].state == 0 and qData[2030].state == 2 and GET_PLAYER_JOB1() == 11 then
    ADD_QUEST_BTN(qt[2031].id, qt[2031].name)
  end
  if qData[2032].state == 0 and qData[2031].state == 2 and GET_PLAYER_JOB1() == 11 then
    ADD_QUEST_BTN(qt[2032].id, qt[2032].name)
  end
  if qData[2034].state == 0 and qData[2033].state == 2 and GET_PLAYER_JOB1() == 11 then
    ADD_QUEST_BTN(qt[2034].id, qt[2034].name)
  end
  if qData[2035].state == 0 and qData[2034].state == 2 and GET_PLAYER_JOB1() == 11 then
    ADD_QUEST_BTN(qt[2035].id, qt[2035].name)
  end
  if qData[2037].state == 0 and qData[2036].state == 2 and GET_PLAYER_JOB1() == 11 then
    ADD_QUEST_BTN(qt[2037].id, qt[2037].name)
  end
  if qData[2039].state == 0 and qData[2038].state == 2 and GET_PLAYER_JOB1() == 11 then
    ADD_QUEST_BTN(qt[2039].id, qt[2039].name)
  end
  if qData[2040].state == 0 and qData[2039].state == 2 and GET_PLAYER_JOB1() == 11 then
    ADD_QUEST_BTN(qt[2040].id, qt[2040].name)
  end
  if qData[2041].state == 0 and qData[2040].state == 2 and GET_PLAYER_JOB1() == 11 then
    ADD_QUEST_BTN(qt[2041].id, qt[2041].name)
  end
  if qData[2042].state == 0 and qData[2041].state == 2 and GET_PLAYER_JOB1() == 11 then
    ADD_QUEST_BTN(qt[2042].id, qt[2042].name)
  end
  if qData[2043].state == 0 and qData[2042].state == 2 and GET_PLAYER_JOB1() == 11 then
    ADD_QUEST_BTN(qt[2043].id, qt[2043].name)
  end
  if qData[2046].state == 0 and qData[2045].state == 2 and GET_PLAYER_JOB1() == 11 then
    ADD_QUEST_BTN(qt[2046].id, qt[2046].name)
  end
  if qData[2047].state == 0 and qData[2046].state == 2 and GET_PLAYER_JOB1() == 11 then
    ADD_QUEST_BTN(qt[2047].id, qt[2047].name)
  end
  if qData[2048].state == 0 and qData[2047].state == 2 and GET_PLAYER_JOB1() == 11 then
    ADD_QUEST_BTN(qt[2048].id, qt[2048].name)
  end
  if qData[2049].state == 0 and qData[2048].state == 2 and GET_PLAYER_JOB1() == 11 then
    ADD_QUEST_BTN(qt[2049].id, qt[2049].name)
  end
  if qData[2050].state == 0 and qData[2049].state == 2 and GET_PLAYER_JOB1() == 11 then
    ADD_QUEST_BTN(qt[2050].id, qt[2050].name)
  end
  if qData[2051].state == 0 and qData[2050].state == 2 and GET_PLAYER_JOB1() == 11 then
    ADD_QUEST_BTN(qt[2051].id, qt[2051].name)
  end
  if qData[2053].state == 0 and qData[2052].state == 2 and GET_PLAYER_JOB1() == 11 then
    ADD_QUEST_BTN(qt[2053].id, qt[2053].name)
  end
  if qData[2055].state == 0 and qData[2054].state == 2 and GET_PLAYER_JOB1() == 11 then
    ADD_QUEST_BTN(qt[2055].id, qt[2055].name)
  end
  if qData[2056].state == 0 and qData[2055].state == 2 and GET_PLAYER_JOB1() == 11 then
    ADD_QUEST_BTN(qt[2056].id, qt[2056].name)
  end
  if qData[2057].state == 0 and qData[2056].state == 2 and GET_PLAYER_JOB1() == 11 then
    ADD_QUEST_BTN(qt[2057].id, qt[2057].name)
  end
  if qData[2058].state == 0 and qData[2057].state == 2 and GET_PLAYER_JOB1() == 11 then
    ADD_QUEST_BTN(qt[2058].id, qt[2058].name)
  end
  if qData[2059].state == 0 and qData[2058].state == 2 and GET_PLAYER_JOB1() == 11 then
    ADD_QUEST_BTN(qt[2059].id, qt[2059].name)
  end
  if qData[2061].state == 0 and qData[2060].state == 2 and GET_PLAYER_JOB1() == 11 then
    ADD_QUEST_BTN(qt[2061].id, qt[2061].name)
  end
  if qData[2062].state == 0 and qData[2061].state == 2 and GET_PLAYER_JOB1() == 11 then
    ADD_QUEST_BTN(qt[2062].id, qt[2062].name)
  end
  if qData[2063].state == 0 and qData[2062].state == 2 and GET_PLAYER_JOB1() == 11 then
    ADD_QUEST_BTN(qt[2063].id, qt[2063].name)
  end
  if qData[2064].state == 0 and qData[2063].state == 2 and GET_PLAYER_JOB1() == 11 then
    ADD_QUEST_BTN(qt[2064].id, qt[2064].name)
  end
  if qData[2065].state == 0 and qData[2064].state == 2 and GET_PLAYER_JOB1() == 11 then
    ADD_QUEST_BTN(qt[2065].id, qt[2065].name)
  end
  if qData[2072].state == 0 and qData[2071].state == 2 and GET_PLAYER_JOB1() == 11 then
    ADD_QUEST_BTN(qt[2072].id, qt[2072].name)
  end
  if qData[2073].state == 0 and qData[2072].state == 2 and GET_PLAYER_JOB1() == 11 then
    ADD_QUEST_BTN(qt[2073].id, qt[2073].name)
  end
  if qData[2077].state == 0 and qData[2076].state == 2 and GET_PLAYER_JOB1() == 11 then
    ADD_QUEST_BTN(qt[2077].id, qt[2077].name)
  end
  if qData[2080].state == 0 and qData[2079].state == 2 and GET_PLAYER_JOB1() == 11 then
    ADD_QUEST_BTN(qt[2080].id, qt[2080].name)
  end
  if qData[2081].state == 0 and qData[2080].state == 2 and GET_PLAYER_JOB1() == 11 then
    ADD_QUEST_BTN(qt[2081].id, qt[2081].name)
  end
  if qData[2102].state == 0 and GET_PLAYER_JOB1() == 11 then
    ADD_QUEST_BTN(qt[2102].id, qt[2102].name)
  end
  if qData[3608].state == 0 and GET_PLAYER_JOB1() == 11 then
    ADD_QUEST_BTN(qt[3608].id, qt[3608].name)
  end
  if qData[2156].state == 0 then
    ADD_QUEST_BTN(qt[2156].id, qt[2156].name)
  end
  if qData[2157].state == 0 then
    ADD_QUEST_BTN(qt[2157].id, qt[2157].name)
  end
  if qData[2158].state == 0 then
    ADD_QUEST_BTN(qt[2158].id, qt[2158].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[2018].state == 1 then
    QSTATE(id, 2)
  end
  if qData[2019].state ~= 2 and qData[2018].state == 2 and GET_PLAYER_JOB1() == 11 then
    if qData[2019].state == 1 then
      QSTATE(id, 2)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2020].state ~= 2 and qData[2019].state == 2 and GET_PLAYER_JOB1() == 11 then
    if qData[2020].state == 1 then
      QSTATE(id, 2)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2021].state ~= 2 and qData[2020].state == 2 and GET_PLAYER_LEVEL() >= qt[2021].needLevel and GET_PLAYER_JOB1() == 11 then
    if qData[2021].state == 1 then
      if qData[2021].killMonster[qt[2021].goal.killMonster[1].id] >= qt[2021].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2022].state ~= 2 and qData[2021].state == 2 and GET_PLAYER_LEVEL() >= qt[2022].needLevel and GET_PLAYER_JOB1() == 11 then
    if qData[2022].state == 1 then
      if qData[2022].killMonster[qt[2022].goal.killMonster[1].id] >= qt[2022].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2023].state ~= 2 and qData[2022].state == 2 and GET_PLAYER_JOB1() == 11 then
    if qData[2023].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2027].state == 1 then
    QSTATE(id, 2)
  end
  if qData[2028].state ~= 2 and qData[2027].state == 2 and GET_PLAYER_JOB1() == 11 then
    if qData[2028].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2029].state == 1 then
    QSTATE(id, 2)
  end
  if qData[2030].state ~= 2 and qData[2029].state == 2 and GET_PLAYER_LEVEL() >= qt[2030].needLevel and GET_PLAYER_JOB1() == 11 then
    if qData[2030].state == 1 then
      if qData[2030].killMonster[qt[2030].goal.killMonster[1].id] >= qt[2030].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2031].state ~= 2 and qData[2030].state == 2 and GET_PLAYER_LEVEL() >= qt[2031].needLevel and GET_PLAYER_JOB1() == 11 then
    if qData[2031].state == 1 then
      if qData[2031].killMonster[qt[2031].goal.killMonster[1].id] >= qt[2031].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2032].state ~= 2 and qData[2031].state == 2 and GET_PLAYER_LEVEL() >= qt[2032].needLevel and GET_PLAYER_JOB1() == 11 then
    if qData[2032].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2033].state == 1 then
    QSTATE(id, 2)
  end
  if qData[2034].state ~= 2 and qData[2033].state == 2 and GET_PLAYER_LEVEL() >= qt[2034].needLevel and GET_PLAYER_JOB1() == 11 then
    if qData[2034].state == 1 then
      if qData[2034].killMonster[qt[2034].goal.killMonster[1].id] >= qt[2034].goal.killMonster[1].count and __QUEST_HAS_ALL_ITEMS(qt[2034].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2035].state ~= 2 and qData[2034].state == 2 and GET_PLAYER_LEVEL() >= qt[2035].needLevel and GET_PLAYER_JOB1() == 11 then
    if qData[2035].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2036].state == 1 then
    QSTATE(id, 2)
  end
  if qData[2037].state ~= 2 and qData[2036].state == 2 and GET_PLAYER_LEVEL() >= qt[2037].needLevel and GET_PLAYER_JOB1() == 11 then
    if qData[2037].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2038].state == 1 then
    QSTATE(id, 2)
  end
  if qData[2039].state ~= 2 and qData[2038].state == 2 and GET_PLAYER_LEVEL() >= qt[2039].needLevel and GET_PLAYER_JOB1() == 11 then
    if qData[2039].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[2039].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2040].state ~= 2 and qData[2039].state == 2 and GET_PLAYER_LEVEL() >= qt[2040].needLevel and GET_PLAYER_JOB1() == 11 then
    if qData[2040].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[2040].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2041].state ~= 2 and qData[2040].state == 2 and GET_PLAYER_LEVEL() >= qt[2041].needLevel and GET_PLAYER_JOB1() == 11 then
    if qData[2041].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[2041].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2042].state ~= 2 and qData[2041].state == 2 and GET_PLAYER_LEVEL() >= qt[2042].needLevel and GET_PLAYER_JOB1() == 11 then
    if qData[2042].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[2042].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2043].state ~= 2 and qData[2042].state == 2 and GET_PLAYER_LEVEL() >= qt[2043].needLevel and GET_PLAYER_JOB1() == 11 then
    if qData[2043].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2045].state == 1 then
    QSTATE(id, 2)
  end
  if qData[2046].state ~= 2 and qData[2045].state == 2 and GET_PLAYER_LEVEL() >= qt[2046].needLevel and GET_PLAYER_JOB1() == 11 then
    if qData[2046].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[2046].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2047].state ~= 2 and qData[2046].state == 2 and GET_PLAYER_LEVEL() >= qt[2047].needLevel and GET_PLAYER_JOB1() == 11 then
    if qData[2047].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[2047].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2048].state ~= 2 and qData[2047].state == 2 and GET_PLAYER_LEVEL() >= qt[2048].needLevel and GET_PLAYER_JOB1() == 11 then
    if qData[2048].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[2048].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2049].state ~= 2 and qData[2048].state == 2 and GET_PLAYER_LEVEL() >= qt[2049].needLevel and GET_PLAYER_JOB1() == 11 then
    if qData[2049].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[2049].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2050].state ~= 2 and qData[2049].state == 2 and GET_PLAYER_LEVEL() >= qt[2050].needLevel and GET_PLAYER_JOB1() == 11 then
    if qData[2050].state == 1 then
      if qData[2050].killMonster[qt[2050].goal.killMonster[1].id] >= qt[2050].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2051].state ~= 2 and qData[2050].state == 2 and GET_PLAYER_LEVEL() >= qt[2051].needLevel and GET_PLAYER_JOB1() == 11 then
    if qData[2051].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2052].state == 1 then
    QSTATE(id, 2)
  end
  if qData[2053].state ~= 2 and qData[2052].state == 2 and GET_PLAYER_LEVEL() >= qt[2053].needLevel and GET_PLAYER_JOB1() == 11 then
    if qData[2053].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2054].state == 1 then
    QSTATE(id, 2)
  end
  if qData[2055].state ~= 2 and qData[2054].state == 2 and GET_PLAYER_LEVEL() >= qt[2055].needLevel and GET_PLAYER_JOB1() == 11 then
    if qData[2055].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[2055].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2056].state ~= 2 and qData[2055].state == 2 and GET_PLAYER_LEVEL() >= qt[2056].needLevel and GET_PLAYER_JOB1() == 11 then
    if qData[2056].state == 1 then
      if qData[2056].killMonster[qt[2056].goal.killMonster[1].id] >= qt[2056].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2057].state ~= 2 and qData[2056].state == 2 and GET_PLAYER_LEVEL() >= qt[2057].needLevel and GET_PLAYER_JOB1() == 11 then
    if qData[2057].state == 1 then
      if GET_PLAYER_FACTION() == 0 or GET_PLAYER_FACTION() == 1 then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2058].state ~= 2 and qData[2057].state == 2 and GET_PLAYER_LEVEL() >= qt[2058].needLevel and GET_PLAYER_JOB1() == 11 then
    if qData[2058].state == 1 then
      if qData[2058].killMonster[qt[2058].goal.killMonster[1].id] >= qt[2058].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2059].state ~= 2 and qData[2058].state == 2 and GET_PLAYER_LEVEL() >= qt[2059].needLevel and GET_PLAYER_JOB1() == 11 then
    if qData[2059].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2060].state == 1 then
    QSTATE(id, 2)
  end
  if qData[2061].state ~= 2 and qData[2060].state == 2 and GET_PLAYER_LEVEL() >= qt[2061].needLevel and GET_PLAYER_JOB1() == 11 then
    if qData[2061].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[2061].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2062].state ~= 2 and qData[2061].state == 2 and GET_PLAYER_LEVEL() >= qt[2062].needLevel and GET_PLAYER_JOB1() == 11 then
    if qData[2062].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[2062].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2063].state ~= 2 and qData[2062].state == 2 and GET_PLAYER_LEVEL() >= qt[2063].needLevel and GET_PLAYER_JOB1() == 11 then
    if qData[2063].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[2063].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2064].state ~= 2 and qData[2063].state == 2 and GET_PLAYER_LEVEL() >= qt[2064].needLevel and GET_PLAYER_JOB1() == 11 then
    if qData[2064].state == 1 then
      if qData[2064].killMonster[qt[2064].goal.killMonster[1].id] >= qt[2064].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2065].state ~= 2 and qData[2064].state == 2 and GET_PLAYER_LEVEL() >= qt[2065].needLevel and GET_PLAYER_JOB1() == 11 then
    if qData[2065].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2071].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[2071].goal.getItem) then
      QSTATE(id, 2)
    else
      QSTATE(id, 1)
    end
  end
  if qData[2072].state ~= 2 and qData[2071].state == 2 and GET_PLAYER_LEVEL() >= qt[2072].needLevel and GET_PLAYER_JOB1() == 11 then
    if qData[2072].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[2072].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2073].state ~= 2 and qData[2072].state == 2 and GET_PLAYER_LEVEL() >= qt[2073].needLevel and GET_PLAYER_JOB1() == 11 then
    if qData[2073].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2076].state == 1 then
    QSTATE(id, 2)
  end
  if qData[2077].state ~= 2 and qData[2076].state == 2 and GET_PLAYER_LEVEL() >= qt[2077].needLevel and GET_PLAYER_JOB1() == 11 then
    if qData[2077].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2079].state == 1 then
    QSTATE(id, 2)
  end
  if qData[2080].state ~= 2 and qData[2079].state == 2 and GET_PLAYER_LEVEL() >= qt[2080].needLevel and GET_PLAYER_JOB1() == 11 then
    if qData[2080].state == 1 then
      if GET_PLAYER_JOB2() == 17 or GET_PLAYER_JOB2() == 18 then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2081].state ~= 2 and qData[2080].state == 2 and GET_PLAYER_LEVEL() >= qt[2081].needLevel and GET_PLAYER_JOB1() == 11 then
    if qData[2081].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2102].state ~= 2 and GET_PLAYER_LEVEL() >= qt[2102].needLevel and GET_PLAYER_JOB1() == 11 then
    if qData[2102].state == 1 then
      if GET_PLAYER_LEVEL() >= 20 then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[3608].state ~= 2 and GET_PLAYER_LEVEL() >= qt[3608].needLevel and GET_PLAYER_JOB1() == 11 then
    if qData[3608].state == 1 then
      if 1 <= CHECK_INVENTORY_CNT(2) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2156].state ~= 2 then
    if qData[2156].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[2156].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2157].state ~= 2 then
    if qData[2157].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[2157].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2158].state ~= 2 then
    if qData[2158].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[2158].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
end
