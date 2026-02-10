function npcsay(id)
  if id ~= 4316003 then
    return
  end
  clickNPCid = id
  if qData[890].state == 1 then
    if qData[890].killMonster[qt[890].goal.killMonster[1].id] >= qt[890].goal.killMonster[1].count then
      NPC_SAY("辛苦了。果然少侠才是真正可以继承英雄们的材料啊。")
      SET_QUEST_STATE(890, 2)
      return
    else
      NPC_SAY("击退{0xFFFFFF00}50个[幽灵使者]{END}回来就给你{0xFFFFFF00}1个古乐守护符{END}。记住了。这个任务{0xFFFFFF00}一天只能完成一次{END}。")
    end
  end
  if qData[1541].state == 1 then
    NPC_SAY("恩恩。找我什么事啊？")
    SET_QUEST_STATE(1541, 2)
    return
  end
  if qData[1542].state == 1 then
    if CHECK_ITEM_CNT(qt[1542].goal.getItem[1].id) >= qt[1542].goal.getItem[1].count and CHECK_ITEM_CNT(qt[1542].goal.getItem[2].id) >= qt[1542].goal.getItem[2].count then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("果然很了不起啊。希望能理解一下卡宴你的我的用意。")
        SET_QUEST_STATE(1542, 2)
        return
      else
        NPC_SAY("行囊太沉。")
        return
      end
    else
      NPC_SAY("希望你能击退{0xFFFFFF00}古乐山的豆腐鬼童和灯鬼{END}，收集{0xFFFFFF00}30个腐烂的豆腐和30个燃烧的石头{END}回来。")
      return
    end
  end
  if qData[1562].state == 1 then
    NPC_SAY("击退{0xFFFFFF00}60个第一阶梯的幽灵使者{END}之后，去找{0xFFFFFF00}第一寺的住持{END}吧。")
    return
  end
  if qData[1561].state == 1 then
    NPC_SAY("少侠帮着调查了长老候选人？真的很感谢。但是…。")
    SET_QUEST_STATE(1561, 2)
    return
  end
  if qData[1553].state == 1 then
    NPC_SAY("既然少侠推荐，那我也可以放心的交付了。（啊！先去{0xFFFFFF00}古乐村南边的长老的外甥女{END}那儿看看。）")
    return
  end
  if qData[1552].state == 1 then
    if CHECK_ITEM_CNT(qt[1552].goal.getItem[1].id) >= qt[1552].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("那是什么？怎么收集了那么恶心的东西…。啊！对，对了！是我，我拜托你的。真的辛苦了。")
        SET_QUEST_STATE(1552, 2)
        return
      else
        NPC_SAY("行囊太沉。")
        return
      end
    else
      NPC_SAY("去{0xFFFFFF00}第一阶梯{END}击退{0xFFFFFF00}骷髅鸟{END}，作为证据收集回来{0xFFFFFF00}40个骷髅鸟碎片{END}吧。")
      return
    end
  end
  if qData[1551].state == 1 then
    NPC_SAY("没，没有恶臭…。怎，怎么会这样…")
    SET_QUEST_STATE(1551, 2)
    return
  end
  if qData[1549].state == 1 then
    NPC_SAY("能把这个消息告诉{0xFFFFFF00}古乐村南边{END}的{0xFFFFFF00}长老的外甥女{END}吗？")
    return
  end
  if qData[1548].state == 1 then
    if CHECK_ITEM_CNT(qt[1548].goal.getItem[1].id) >= qt[1548].goal.getItem[1].count then
      NPC_SAY("谢谢。如果不是我亲手做的，就没办法相信…。哇哇！真的没办法吃啊！现在很恶心，等我平复之后再来找我吧。你{0xFFFFFF00}功力达102{END}的时候应该就可以了。")
      SET_QUEST_STATE(1548, 2)
      return
    else
      NPC_SAY("希望你去{0xFFFFFF00}第一阶梯{END}再次击退{0xFFFFFF00}大脚怪{END}，收集{0xFFFFFF00}40个毒蘑菇{END}回来。")
      return
    end
  end
  if qData[1547].state == 1 then
    NPC_SAY("来了？汤药？那个…恩恩…那个…")
    SET_QUEST_STATE(1547, 2)
    return
  end
  if qData[1545].state == 1 then
    NPC_SAY("听说{0xFFFFFF00}古乐村北边{END}的{0xFFFFFF00}年轻书生{END}为了体弱的老母亲研究出了不难喝的药的方法。你可以帮我去问问吗？ ")
    return
  end
  if qData[1543].state == 1 then
    NPC_SAY("去{0xFFFFFF00}古乐村南边{END}的{0xFFFFFF00}古乐村宝芝林{END}处拜托诊治吧。")
    return
  end
  if qData[1551].state == 1 then
    NPC_SAY("没，没有恶臭…。怎，怎么会这样…")
    SET_QUEST_STATE(1551, 2)
    return
  end
  if qData[288].state == 2 and qData[284].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[284].goal.getItem) then
      NPC_SAY("哦…这就是记录着老婆婆秘密的书啊…真的谢谢你啊…呵呵呵")
      SET_QUEST_STATE(284, 2)
      return
    else
      NPC_SAY("请告诉我{0xFFFFFF00}心情很坏的老媪的秘密{END}吧…拜托了…")
      return
    end
  end
  if qData[284].state == 2 and qData[285].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[285].goal.getItem) then
      SET_QUEST_STATE(285, 2)
      NPC_QSAY(285, 1)
      return
    else
      NPC_SAY("把{0xFFFFFF00}书拿到古乐村哞读册{END}处，破译之后拿来吧…")
      return
    end
  end
  if qData[479].state == 1 then
    if qData[479].killMonster[qt[479].goal.killMonster[1].id] >= qt[479].goal.killMonster[1].count then
      NPC_SAY("嗯…影妖不能把我的白发变少啊..本来还抱有一点希望的..郁闷啊..但你还是辛苦了，这是一点报答")
      SET_QUEST_STATE(479, 2)
      return
    else
      NPC_SAY("对{0xFFFFFF00}影妖{END}还不是很熟？哎~击退80个左右，再了解之后过来吧")
      return
    end
  end
  if qData[562].state == 1 then
    if qData[562].killMonster[qt[562].goal.killMonster[1].id] >= qt[562].goal.killMonster[1].count then
      NPC_SAY("谢谢…呵呵…我最近累也许是因为被假的幽灵使者迷惑了..呵呵..现在有力量了..呵呵")
      SET_QUEST_STATE(562, 2)
      return
    else
      NPC_SAY("100个幽灵使者击退完了吗？")
      return
    end
  end
  ADD_NEW_SHOP_BTN(id, 10067)
  if qData[974].state == 0 and GET_PLAYER_LEVEL() >= qt[974].needLevel and GET_PLAYER_JOB2() ~= 13 then
    ADD_QUEST_BTN(qt[974].id, qt[974].name)
  end
  if qData[890].state == 0 and GET_PLAYER_LEVEL() >= qt[890].needLevel and GET_PLAYER_JOB2() ~= 13 then
    ADD_QUEST_BTN(qt[890].id, qt[890].name)
  end
  if qData[1542].state ~= 2 and qData[1541].state == 2 and GET_PLAYER_LEVEL() >= qt[1542].needLevel then
    ADD_QUEST_BTN(qt[1542].id, qt[1542].name)
  end
  if qData[1562].state ~= 2 and qData[1561].state == 2 and GET_PLAYER_LEVEL() >= qt[1562].needLevel then
    ADD_QUEST_BTN(qt[1562].id, qt[1562].name)
  end
  if qData[1553].state ~= 2 and qData[1552].state == 2 and GET_PLAYER_LEVEL() >= qt[1553].needLevel then
    ADD_QUEST_BTN(qt[1553].id, qt[1553].name)
  end
  if qData[1552].state == 0 and qData[1551].state == 2 and GET_PLAYER_LEVEL() >= qt[1552].needLevel then
    ADD_QUEST_BTN(qt[1552].id, qt[1552].name)
  end
  if qData[1549].state ~= 2 and qData[1548].state == 2 and GET_PLAYER_LEVEL() >= qt[1549].needLevel then
    ADD_QUEST_BTN(qt[1549].id, qt[1549].name)
  end
  if qData[1548].state ~= 2 and qData[1547].state == 2 and GET_PLAYER_LEVEL() >= qt[1548].needLevel then
    ADD_QUEST_BTN(qt[1548].id, qt[1548].name)
  end
  if qData[1545].state ~= 2 and qData[1544].state == 2 and GET_PLAYER_LEVEL() >= qt[1545].needLevel then
    ADD_QUEST_BTN(qt[1545].id, qt[1545].name)
  end
  if qData[1543].state ~= 2 and qData[1542].state == 2 and GET_PLAYER_LEVEL() >= qt[1543].needLevel then
    ADD_QUEST_BTN(qt[1543].id, qt[1543].name)
  end
  if qData[562].state ~= 2 and GET_PLAYER_LEVEL() >= qt[562].needLevel then
    ADD_QUEST_BTN(qt[562].id, qt[562].name)
  end
  if qData[284].state ~= 2 then
    ADD_QUEST_BTN(qt[284].id, qt[284].name)
  end
  if qData[284].state == 2 and qData[285].state == 0 then
    ADD_QUEST_BTN(qt[285].id, qt[285].name)
  end
  if qData[479].state ~= 2 then
    ADD_QUEST_BTN(qt[479].id, qt[479].name)
    return
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[890].state ~= 2 and GET_PLAYER_LEVEL() >= qt[890].needLevel then
    if qData[890].state == 1 then
      if qData[890].killMonster[qt[890].goal.killMonster[1].id] >= qt[890].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1542].state ~= 2 and qData[1541].state == 2 and GET_PLAYER_LEVEL() >= qt[1542].needLevel then
    if qData[1542].state == 1 then
      if CHECK_ITEM_CNT(qt[1542].goal.getItem[1].id) >= qt[1542].goal.getItem[1].count and CHECK_ITEM_CNT(qt[1542].goal.getItem[2].id) >= qt[1542].goal.getItem[2].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1541].state == 1 then
    QSTATE(id, 2)
  end
  if qData[1561].state == 1 then
    QSTATE(id, 2)
  end
  if qData[1562].state ~= 2 and qData[1561].state == 2 and GET_PLAYER_LEVEL() >= qt[1562].needLevel then
    if qData[1562].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[1553].state ~= 2 and qData[1552].state == 2 and GET_PLAYER_LEVEL() >= qt[1553].needLevel then
    if qData[1553].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[284].state ~= 2 and GET_PLAYER_LEVEL() >= qt[284].needLevel then
    if qData[284].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[284].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[285].state ~= 2 and qData[284].state == 2 and GET_PLAYER_LEVEL() >= qt[285].needLevel then
    if qData[285].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[285].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[479].state ~= 2 and GET_PLAYER_LEVEL() >= qt[479].needLevel then
    if qData[479].state == 1 then
      if qData[479].killMonster[qt[479].goal.killMonster[1].id] >= qt[479].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1552].state ~= 2 and qData[1551].state == 2 and GET_PLAYER_LEVEL() >= qt[1552].needLevel then
    if qData[1552].state == 1 then
      if CHECK_ITEM_CNT(qt[1552].goal.getItem[1].id) >= qt[1552].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1551].state == 1 then
    QSTATE(id, 2)
  end
  if qData[1549].state ~= 2 and qData[1548].state == 2 and GET_PLAYER_LEVEL() >= qt[1549].needLevel then
    if qData[1549].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[1548].state ~= 2 and qData[1547].state == 2 and GET_PLAYER_LEVEL() >= qt[1548].needLevel then
    if qData[1548].state == 1 then
      if CHECK_ITEM_CNT(qt[1548].goal.getItem[1].id) >= qt[1548].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1547].state == 1 then
    QSTATE(id, 2)
  end
  if qData[1545].state ~= 2 and qData[1544].state == 2 and GET_PLAYER_LEVEL() >= qt[1545].needLevel then
    if qData[1545].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[1543].state ~= 2 and qData[1542].state == 2 and GET_PLAYER_LEVEL() >= qt[1542].needLevel then
    if qData[1543].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[562].state ~= 2 and GET_PLAYER_LEVEL() >= qt[562].needLevel then
    if qData[562].state == 1 then
      if qData[562].killMonster[qt[562].goal.killMonster[1].id] >= qt[562].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
end
