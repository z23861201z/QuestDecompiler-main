local function __QUEST_HAS_ALL_ITEMS(goalItems)
  for i, v in ipairs(goalItems) do
    if CHECK_ITEM_CNT(v.id) < v.count then
      return false
    end
  end
  return true
end

local function __QUEST_FIRST_ITEM_ID(goalItems)
  if goalItems == nil or goalItems[1] == nil then
    return 0
  end
  return goalItems[1].id
end

local function __QUEST_FIRST_ITEM_COUNT(goalItems)
  if goalItems == nil or goalItems[1] == nil then
    return 0
  end
  return goalItems[1].count
end

function npcsay(id)
  if id ~= 4316009 then
    return
  end
  clickNPCid = id
  if qData[891].state == 1 then
    if qData[891].killMonster[qt[891].goal.killMonster[1].id] >= qt[891].goal.killMonster[1].count then
      NPC_SAY("辛苦了。果然你就是可以继承英雄们的人才啊。")
      SET_QUEST_STATE(891, 2)
      return
    else
      NPC_SAY("击退{0xFFFFFF00}60个[血姜丝男]{END}之后回来，就给你{0xFFFFFF00}1个天吟守护符{END}。不过要记住，这个任务{0xFFFFFF00}一天只能完成一次{END}。")
    end
  end
  if qData[1562].state == 1 then
    if qData[1562].killMonster[qt[1562].goal.killMonster[1].id] >= qt[1562].goal.killMonster[1].count then
      NPC_SAY("击退了幽灵使者？真的太感谢了…")
      SET_QUEST_STATE(1562, 2)
      return
    else
      NPC_SAY("有没有谁能帮忙击退幽灵使者呢？")
    end
  end
  if qData[485].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[485].goal.getItem) then
      NPC_SAY("果然收集回来了啊…咳咳…看人的眼光没人比我厉害啊…咳咳…")
      SET_QUEST_STATE(485, 2)
      return
    else
      NPC_SAY("红树生死液可以在红树妖身上获得…需要50个…不是49个，而是50个")
    end
  end
  if qData[485].state == 2 and qData[486].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[486].goal.getItem) then
      NPC_SAY("这些量应该就够了。咳咳…其实可以从幽灵帽子获得的幽灵使者的线没几根的…")
      SET_QUEST_STATE(486, 2)
      return
    else
      NPC_SAY("幽灵帽子可以从幽灵使者身上获得。幽灵使者徘徊在来第一寺的途中路过的第一阶梯里")
    end
  end
  if qData[486].state == 2 and qData[487].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[487].goal.getItem) then
      NPC_QSAY(487, 1)
      SET_QUEST_STATE(487, 2)
      return
    else
      NPC_SAY("在天吟仙?或固落峰可以发现冰肌怪。收集回来冰肌怪身上的冰柱50个吧。这是最后的材料了")
    end
  end
  if qData[488].state == 1 then
    if qData[488].meetNpc[1] == qt[488].goal.meetNpc[1] then
      NPC_SAY("嗯…你怎么知道那些的？你就是可以破解咒术阵的人…咳咳…很意外啊。是很久以前做成的阵法啊…咳咳…")
      SET_QUEST_STATE(488, 2)
      return
    else
      NPC_SAY("快点去吧…不明来历的僧人很感谢你的…咳咳..")
    end
  end
  if qData[489].state == 1 then
    if qData[489].meetNpc[1] == qt[489].goal.meetNpc[1] then
      NPC_SAY("千手妖女啊…咳咳…竟然对千手妖女感兴趣…是功名心啊？还是好奇心啊？")
      SET_QUEST_STATE(489, 2)
      return
    else
      NPC_SAY("进入第一寺内部吧。太乙仙女会告诉你详细内容的")
    end
  end
  if qData[490].state == 1 then
    if qData[490].killMonster[qt[490].goal.killMonster[1].id] >= qt[490].goal.killMonster[1].count then
      NPC_SAY("你周边充满了龙凤鸣的妖气啊。咳咳，稍等一下。要采集妖气。咳咳…")
      SET_QUEST_STATE(490, 2)
      return
    else
      NPC_SAY("击退1个龙凤鸣，那妖怪的力量就会围绕你身边一会儿")
    end
  end
  if qData[490].state == 2 and qData[491].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[491].goal.getItem) then
      NPC_SAY("拿来了啊。你…咳咳…你去收集冰花的期间，我知道了另一件事…")
      SET_QUEST_STATE(491, 2)
      return
    else
      NPC_SAY("是雪魔女身上的冰花…收集50个冰花回来吧…天气寒冷，要注意身体啊…咳咳")
    end
  end
  if qData[491].state == 2 and qData[492].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[492].goal.getItem) then
      NPC_SAY("已经准备就绪了。稍等一下。我为你制作第一寺印章…咳咳…装有可以跟千手妖女对抗的保护力量…")
      SET_QUEST_STATE(492, 2)
      return
    else
      NPC_SAY("红树妖在生死之塔里。要小心，千万别被夺去灵魂…要注意身体…咳咳 收集50个红树生死液回来吧…")
    end
  end
  if qData[492].state == 2 and qData[2161].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[2161].goal.getItem) then
      if 1 <= CHECK_INVENTORY_CNT(2) then
        NPC_SAY("拿来了？这些就足够了。你果然是与众不同啊！稍等一下，我这就给你制作第一寺墨珠")
        SET_QUEST_STATE(2161, 2)
        return
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("收集5个含有千手妖女妖气的四天王碑的精气交给我，就能制作第一寺墨珠（想要获得四天王碑的精气就去找太乙仙女吧）")
    end
  end
  if qData[492].state == 2 and qData[493].state == 1 then
    if qData[493].meetNpc[1] == qt[493].goal.meetNpc[1] then
      if 1 <= CHECK_INVENTORY_CNT(4) then
        NPC_SAY("来了啊…咳咳…这里…是第一寺印章…已经准备就绪了吧")
        SET_QUEST_STATE(493, 2)
        return
      else
        NPC_SAY("行囊太沉。")
        return
      end
    else
      NPC_SAY("快去见见太乙仙女吧")
    end
  end
  if qData[494].state == 1 then
    NPC_SAY("拿着第一寺印章去找太乙仙女吧。太乙仙女会把你送到封印着千手妖女的地下的。请一定要击退千手妖女啊")
  end
  if qData[495].state == 1 and qData[495].meetNpc[1] ~= id then
    NPC_SAY("咳咳…你…平安回来了啊？击退了千手妖女？…咳咳…天啊…长久以来没人能击退的妖怪，你竟然击退了…你真的很了不起啊")
    SET_MEETNPC(495, 1, id)
    SET_QUEST_STATE(495, 2)
    return
  end
  if qData[497].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[497].goal.getItem) then
      if 1 <= CHECK_INVENTORY_CNT(4) then
        NPC_SAY("来看一下…1,2,3…数目对了，是100个雪卵…现在可以制作第一寺印章了…来 在这儿呢，拿着吧")
        SET_QUEST_STATE(497, 2)
      else
        NPC_SAY("行囊太沉。")
        return
      end
    else
      NPC_SAY("可以装寒气的雪卵…可以从天吟仙?或固落峰的双头鸡怪身上获得。帮忙收集50个雪卵回来吧")
    end
  end
  if qData[533].state == 1 then
    NPC_SAY("但是…那种灵药哪里是那么容易就能获得的啊…快去见见太乙仙女吧")
    return
  end
  if qData[713].state == 1 then
    NPC_SAY("是搜查团长让你来的？咳咳。来的路上辛苦了，但很可惜，很久之前开始我和秋叨鱼的联络就中断了。咳咳")
    SET_QUEST_STATE(713, 2)
    return
  end
  if qData[714].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[714].goal.getItem) and __QUEST_HAS_ALL_ITEMS(qt[714].goal.getItem) then
      NPC_SAY("哦…。拿来了？稍等。马上做准备。恩恩。")
      SET_QUEST_STATE(714, 2)
      return
    else
      NPC_SAY("咳咳。还没拿来吗？有{0xFFFFFF00}8个[牛角]，10个[毒蘑菇]，10个[幽灵帽子]{END}，才能完成咒术阵…。咳咳。才可以完成的。啊哈！")
    end
  end
  if qData[715].state == 1 then
    NPC_SAY("准备好了吗？不知道那对面会有什么…。你的雄心壮志，真让我惭愧啊。呵呵。咳咳。来，那就启动咒术阵了。")
    SET_QUEST_STATE(715, 2)
    return
  end
  if qData[716].state == 1 then
    NPC_SAY("咳咳。嗯？你见到了冬混汤？那位怎么会在那儿呢？")
    SET_QUEST_STATE(716, 2)
    return
  end
  if qData[717].state == 1 then
    NPC_SAY("快去{0xFFFFFF00}[东泼肉]{END}那儿了解一下可以得到冬混汤的信任的方法。咳咳。")
    return
  end
  if qData[720].state == 1 and __QUEST_HAS_ALL_ITEMS(qt[720].goal.getItem) then
    NPC_SAY("秋叨鱼找到了吗？咳咳。嗯？这个符咒是什么？")
    SET_QUEST_STATE(720, 2)
    return
  end
  if qData[721].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[721].goal.getItem) then
      NPC_SAY("拿来了品质很好的骷髅鸟碎片了啊。这些就够了。稍等一下。")
      SET_QUEST_STATE(721, 2)
      return
    else
      NPC_SAY("有骷髅鸟的{0xFFFFFF00}32个[骷髅鸟碎片]{END}，就可以解除保护秋叨鱼的符咒的锁住状态。快去收集回来吧。咳咳。")
    end
  end
  if qData[722].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[722].goal.getItem) then
      NPC_SAY("哇啊。收集回来了吗？咳咳。那现在要开始分析术法的准备了。")
      SET_QUEST_STATE(722, 2)
      return
    else
      NPC_SAY("还要很久吗？咳咳。要有{0xFFFFFF00}1个[万年寒铁]{END}才行。现在的我一旦受了内伤，就很难恢复…为了完整的术法分析是一定要有的。")
    end
  end
  if qData[723].state == 1 then
    NPC_SAY("自言自语…。（之前说过为了分析术法背诵咒文的时候是决不能打扰的。得快去[冬混汤]那儿看看。）")
    NPC_WARP_THEME_36_1(id)
    return
  end
  if qData[1010].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[1010].goal.getItem) then
      NPC_SAY("托你的福，穿上了很好的衣服。谢谢")
      SET_QUEST_STATE(1010, 2)
      return
    else
      NPC_SAY("50个怪异的虎皮还没收集完吗？")
    end
  end
  if qData[1371].state == 1 then
    NPC_SAY("你说是武艺僧长经派来的？那种不幸的事情…不用担心。我会尽全力的。")
    SET_QUEST_STATE(1371, 2)
    return
  end
  if qData[1372].state == 1 then
    NPC_SAY("回到生死之塔入口的武艺僧长经处就可以了。")
  end
  if qData[1429].state == 1 then
    NPC_SAY("嗯？裂缝？大雾不散去？那不会是…")
    SET_QUEST_STATE(1429, 2)
    return
  end
  if qData[1430].state == 1 then
    NPC_SAY("重新回到古老的渡头[ 6 ]见受苦的导游调查秋叨鱼的行踪吧")
  end
  if qData[1432].state == 1 then
    NPC_SAY("找到了秋叨鱼？可是精神有点不正常？这…")
    SET_QUEST_STATE(1432, 2)
    return
  end
  if qData[1433].state == 1 then
    NPC_SAY("据我所知，西米路在冥珠城西")
  end
  if qData[2130].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[2130].goal.getItem) then
      NPC_SAY("看起来很好吃...不，很好看啊.")
      SET_QUEST_STATE(2130, 2)
      return
    else
      NPC_SAY("雪卵是什么味道，啊不...是什么模样呢？")
    end
  end
  if qData[3631].state == 1 then
    NPC_SAY("击退千手妖女后去见四天王碑吧.")
  end
  ADD_NEW_SHOP_BTN(id, 10068)
  if qData[975].state == 0 and GET_PLAYER_LEVEL() >= qt[975].needLevel and GET_PLAYER_JOB2() ~= 13 then
    ADD_QUEST_BTN(qt[975].id, qt[975].name)
  end
  if qData[891].state == 0 and GET_PLAYER_LEVEL() >= qt[891].needLevel and GET_PLAYER_JOB2() ~= 13 then
    ADD_QUEST_BTN(qt[891].id, qt[891].name)
  end
  if 1 <= GET_PLAYER_JOB2() and qData[485].state == 0 and GET_PLAYER_LEVEL() >= qt[485].needLevel then
    ADD_QUEST_BTN(qt[485].id, qt[485].name)
  end
  if qData[485].state == 2 and qData[486].state == 0 then
    ADD_QUEST_BTN(qt[486].id, qt[486].name)
  end
  if qData[486].state == 2 and qData[487].state == 0 then
    ADD_QUEST_BTN(qt[487].id, qt[487].name)
  end
  if qData[487].state == 2 and qData[488].state == 0 then
    ADD_QUEST_BTN(qt[488].id, qt[488].name)
  end
  if qData[488].state == 2 and qData[489].state == 0 then
    ADD_QUEST_BTN(qt[489].id, qt[489].name)
  end
  if qData[489].state == 2 and qData[490].state == 0 then
    ADD_QUEST_BTN(qt[490].id, qt[490].name)
  end
  if qData[490].state == 2 and qData[491].state == 0 then
    ADD_QUEST_BTN(qt[491].id, qt[491].name)
  end
  if qData[491].state == 2 and qData[492].state == 0 then
    ADD_QUEST_BTN(qt[492].id, qt[492].name)
  end
  if qData[492].state == 2 and qData[2161].state == 0 then
    ADD_QUEST_BTN(qt[2161].id, qt[2161].name)
  end
  if qData[492].state == 2 and qData[493].state == 0 then
    ADD_QUEST_BTN(qt[493].id, qt[493].name)
  end
  if qData[493].state == 2 and qData[494].state == 0 then
    ADD_QUEST_BTN(qt[494].id, qt[494].name)
  end
  if qData[493].state == 2 and qData[497].state == 0 then
    ADD_QUEST_BTN(qt[497].id, qt[497].name)
  end
  if qData[3631].state == 0 and qData[495].state == 2 and GET_PLAYER_LEVEL() >= qt[3631].needLevel then
    ADD_QUEST_BTN(qt[3631].id, qt[3631].name)
  end
  if 1 <= GET_PLAYER_JOB2() and qData[495].state == 2 and qData[533].state == 0 then
    ADD_QUEST_BTN(qt[533].id, qt[533].name)
  end
  if qData[489].state == 2 and qData[908].state == 0 then
    ADD_QUEST_BTN(qt[908].id, qt[908].name)
  end
  if qData[489].state == 2 and qData[909].state == 0 then
    ADD_QUEST_BTN(qt[909].id, qt[909].name)
  end
  if qData[489].state == 2 and qData[910].state == 0 then
    ADD_QUEST_BTN(qt[910].id, qt[910].name)
  end
  if qData[489].state == 2 and qData[911].state == 0 then
    ADD_QUEST_BTN(qt[911].id, qt[911].name)
  end
  if qData[713].state == 2 and qData[714].state == 0 then
    ADD_QUEST_BTN(qt[714].id, qt[714].name)
  end
  if qData[714].state == 2 and qData[715].state == 0 then
    ADD_QUEST_BTN(qt[715].id, qt[715].name)
  end
  if qData[715].state == 2 then
    NPC_WARP_THEME_36_1(id)
  end
  if qData[716].state == 2 and qData[717].state == 0 then
    ADD_QUEST_BTN(qt[717].id, qt[717].name)
  end
  if qData[720].state == 2 and qData[721].state == 0 then
    ADD_QUEST_BTN(qt[721].id, qt[721].name)
  end
  if qData[721].state == 2 and qData[722].state == 0 then
    ADD_QUEST_BTN(qt[722].id, qt[722].name)
  end
  if qData[722].state == 2 and qData[723].state == 0 then
    ADD_QUEST_BTN(qt[723].id, qt[723].name)
  end
  if qData[723].state == 2 and qData[724].state == 0 then
    ADD_QUEST_BTN(qt[724].id, qt[724].name)
  end
  if qData[1010].state == 0 then
    ADD_QUEST_BTN(qt[1010].id, qt[1010].name)
  end
  if qData[1372].state == 0 and qData[1371].state == 2 and GET_PLAYER_LEVEL() >= qt[1372].needLevel then
    ADD_QUEST_BTN(qt[1372].id, qt[1372].name)
  end
  if qData[1430].state == 0 and qData[1429].state == 2 and GET_PLAYER_LEVEL() >= qt[1430].needLevel then
    ADD_QUEST_BTN(qt[1430].id, qt[1430].name)
  end
  if qData[1433].state == 0 and qData[1432].state == 2 and GET_PLAYER_LEVEL() >= qt[1433].needLevel then
    ADD_QUEST_BTN(qt[1433].id, qt[1433].name)
  end
  if qData[2130].state == 0 then
    ADD_QUEST_BTN(qt[2130].id, qt[2130].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[891].state ~= 2 and GET_PLAYER_LEVEL() >= qt[891].needLevel then
    if qData[891].state == 1 then
      if qData[891].killMonster[qt[891].goal.killMonster[1].id] >= qt[891].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1562].state == 1 and GET_PLAYER_LEVEL() >= qt[1562].needLevel then
    if qData[1562].killMonster[qt[1562].goal.killMonster[1].id] >= qt[1562].goal.killMonster[1].count then
      QSTATE(id, 2)
    else
      QSTATE(id, 1)
    end
  end
  if 1 <= GET_PLAYER_JOB2() and qData[485].state ~= 2 and GET_PLAYER_LEVEL() >= qt[485].needLevel then
    if qData[485].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[485].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[485].state == 2 and qData[486].state ~= 2 and GET_PLAYER_LEVEL() >= qt[486].needLevel then
    if qData[486].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[486].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[486].state == 2 and qData[487].state ~= 2 and GET_PLAYER_LEVEL() >= qt[487].needLevel then
    if qData[487].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[487].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[487].state == 2 and qData[488].state ~= 2 and GET_PLAYER_LEVEL() >= qt[488].needLevel then
    if qData[488].state == 1 then
      if qData[488].meetNpc[1] == qt[488].goal.meetNpc[1] then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[488].state == 2 and qData[489].state ~= 2 and GET_PLAYER_LEVEL() >= qt[489].needLevel then
    if qData[489].state == 1 then
      if qData[489].meetNpc[1] == qt[489].goal.meetNpc[1] then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[489].state == 2 and qData[490].state ~= 2 and GET_PLAYER_LEVEL() >= qt[490].needLevel then
    if qData[490].state == 1 then
      if qData[490].killMonster[qt[490].goal.killMonster[1].id] >= qt[490].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[490].state == 2 and qData[491].state ~= 2 and GET_PLAYER_LEVEL() >= qt[491].needLevel then
    if qData[491].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[491].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[491].state == 2 and qData[492].state ~= 2 and GET_PLAYER_LEVEL() >= qt[492].needLevel then
    if qData[492].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[492].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[492].state == 2 and qData[2161].state ~= 2 and GET_PLAYER_LEVEL() >= qt[2161].needLevel then
    if qData[2161].state == 1 then
      if qData[2161].meetNpc[1] == qt[2161].goal.meetNpc[1] then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[492].state == 2 and qData[493].state ~= 2 and GET_PLAYER_LEVEL() >= qt[493].needLevel then
    if qData[493].state == 1 then
      if qData[493].meetNpc[1] == qt[493].goal.meetNpc[1] then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[493].state == 2 and qData[494].state ~= 2 and GET_PLAYER_LEVEL() >= qt[494].needLevel then
    if qData[494].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[493].state == 2 and qData[497].state ~= 2 and GET_PLAYER_LEVEL() >= qt[497].needLevel then
    if qData[497].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[497].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if 1 <= GET_PLAYER_JOB2() and qData[495].state ~= 2 and qData[533].state == 0 and GET_PLAYER_LEVEL() >= qt[495].needLevel then
    if qData[495].state == 1 then
      if qData[495].meetNpc[1] ~= id then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[713].state == 1 and GET_PLAYER_LEVEL() >= qt[713].needLevel then
    if qData[713].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[713].state == 2 and qData[714].state ~= 2 and GET_PLAYER_LEVEL() >= qt[714].needLevel then
    if qData[714].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[714].goal.getItem) and __QUEST_HAS_ALL_ITEMS(qt[714].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[714].state == 2 and qData[715].state ~= 2 and GET_PLAYER_LEVEL() >= qt[715].needLevel then
    if qData[715].state == 1 then
      QSTATE(id, 2)
    else
      QSTATE(id, 0)
    end
  end
  if qData[716].state == 1 and GET_PLAYER_LEVEL() >= qt[716].needLevel then
    QSTATE(id, 2)
  end
  if qData[716].state == 2 and qData[717].state ~= 2 and GET_PLAYER_LEVEL() >= qt[717].needLevel then
    if qData[717].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[720].state == 1 and GET_PLAYER_LEVEL() >= qt[720].needLevel then
    QSTATE(id, 2)
  end
  if qData[720].state == 2 and qData[721].state ~= 2 and GET_PLAYER_LEVEL() >= qt[721].needLevel then
    if qData[721].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[721].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[721].state == 2 and qData[722].state ~= 2 and GET_PLAYER_LEVEL() >= qt[722].needLevel then
    if qData[722].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[722].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[722].state == 2 and qData[723].state ~= 2 and GET_PLAYER_LEVEL() >= qt[723].needLevel then
    if qData[723].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[1010].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1010].needLevel then
    if qData[1010].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[1010].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1371].state == 1 then
    QSTATE(id, 2)
  end
  if qData[1372].state ~= 2 and qData[1371].state == 2 and GET_PLAYER_LEVEL() >= qt[1372].needLevel then
    if qData[1372].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[1429].state == 1 then
    QSTATE(id, 2)
  end
  if qData[1430].state ~= 2 and qData[1429].state == 2 and GET_PLAYER_LEVEL() >= qt[1430].needLevel then
    if qData[1430].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[1432].state == 1 then
    QSTATE(id, 2)
  end
  if qData[1433].state ~= 2 and qData[1432].state == 2 and GET_PLAYER_LEVEL() >= qt[1433].needLevel then
    if qData[1433].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2130].state ~= 2 and GET_PLAYER_LEVEL() >= qt[2130].needLevel then
    if qData[2130].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[2130].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[3631].state ~= 2 and qData[495].state == 2 and GET_PLAYER_LEVEL() >= qt[3631].needLevel then
    if qData[3631].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
end
