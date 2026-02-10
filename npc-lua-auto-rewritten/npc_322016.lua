function npcsay(id)
  if id ~= 4322016 then
    return
  end
  clickNPCid = id
  if qData[2709].state == 2 then
    NPC_SAY("我是刘备的义弟关羽，请多多关照。")
  else
    NPC_SAY("尽诚竭节")
  end
  if qData[2789].state == 1 then
    NPC_SAY("在{0xFFFFFF00}獐子潭洞穴{END}收集原虫的{0xFFFFFF00}黏糊糊的分泌物{END}和妖粉怪的{0xFFFFFF00}灰色妖精粉{END}各7个后，去找{0xFFFFFF00}龙林派刘备{END}吧。")
  end
  if qData[3743].state == 1 then
    if qData[3743].killMonster[qt[3743].goal.killMonster[1].id] >= qt[3743].goal.killMonster[1].count then
      NPC_SAY("托你的福，我们的修炼圆满结束了。可以的话明天也拜托了。")
      SET_QUEST_STATE(3743, 2)
      return
    else
      NPC_SAY("在{0xFFFFFF00}獐子潭洞穴{END}击退70个{0xFFFFFF00}原虫{END}吧。")
    end
  end
  if qData[3753].state == 1 then
    if qData[3753].killMonster[qt[3753].goal.killMonster[1].id] >= qt[3753].goal.killMonster[1].count then
      NPC_SAY("托你的福，我们的修炼也结束了。可以的话明天也拜托了。")
      SET_QUEST_STATE(3753, 2)
      return
    else
      NPC_SAY("在{0xFFFFFF00}獐子潭洞穴{END}击退70个{0xFFFFFF00}妖粉怪{END}吧。")
    end
  end
  if qData[3755].state == 1 then
    if qData[3755].killMonster[qt[3755].goal.killMonster[1].id] >= qt[3755].goal.killMonster[1].count then
      NPC_SAY("有了少侠的帮助，我们也顺利结束了修炼。可以的话明天也拜托了。")
      SET_QUEST_STATE(3755, 2)
      return
    else
      NPC_SAY("在{0xFFFFFF00}獐子潭洞穴{END}击退5个{0xFFFFFF00}曲怪人{END}吧。")
    end
  end
  if qData[2832].state == 1 then
    NPC_SAY("你好，有什么事吗？")
    SET_QUEST_STATE(2832, 2)
    return
  end
  if qData[2833].state == 1 then
    if CHECK_ITEM_CNT(qt[2833].goal.getItem[1].id) >= qt[2833].goal.getItem[1].count and CHECK_ITEM_CNT(qt[2833].goal.getItem[2].id) >= qt[2833].goal.getItem[2].count then
      NPC_SAY("好了，现在开始复原。")
      SET_QUEST_STATE(2833, 2)
      return
    else
      NPC_SAY("在{0xFFFFFF00}獐子潭洞穴{END}拿来5个原虫的{0xFFFFFF00}黏糊糊的分泌物{END}和10个妖粉怪的{0xFFFFFF00}灰色妖精粉{END}就可以了。")
    end
  end
  if qData[2834].state == 1 then
    if qData[2834].killMonster[qt[2834].goal.killMonster[1].id] >= qt[2834].goal.killMonster[1].count then
      NPC_SAY("击退了{0xFFFFFF00}原虫{END}吗？太感谢了！")
      SET_QUEST_STATE(2834, 2)
      return
    else
      NPC_SAY("要在{0xFFFFFF00}獐子潭洞穴{END}击退50个{0xFFFFFF00}原虫{END}？太感谢了~")
    end
  end
  if qData[2835].state == 1 then
    NPC_SAY("将复原的{0xFFFFFF00}獐子潭羊皮纸{END}交给{0xFFFFFF00}冒险家辛巴达{END}就可以了。")
  end
  if qData[2789].state == 0 and qData[2788].state == 2 and GET_PLAYER_LEVEL() >= qt[2789].needLevel then
    ADD_QUEST_BTN(qt[2789].id, qt[2789].name)
  end
  if qData[3743].state == 0 and qData[2746].state == 2 and GET_PLAYER_LEVEL() >= qt[3743].needLevel then
    ADD_QUEST_BTN(qt[3743].id, qt[3743].name)
  end
  if qData[3753].state == 0 and qData[2798].state == 2 and GET_PLAYER_LEVEL() >= qt[3753].needLevel then
    ADD_QUEST_BTN(qt[3753].id, qt[3753].name)
  end
  if qData[3755].state == 0 and qData[2821].state == 2 and GET_PLAYER_LEVEL() >= qt[3755].needLevel then
    ADD_QUEST_BTN(qt[3755].id, qt[3755].name)
  end
  if qData[2833].state == 0 and qData[2832].state == 2 and GET_PLAYER_LEVEL() >= qt[2833].needLevel then
    ADD_QUEST_BTN(qt[2833].id, qt[2833].name)
  end
  if qData[2834].state == 0 and qData[2833].state == 2 and GET_PLAYER_LEVEL() >= qt[2834].needLevel then
    ADD_QUEST_BTN(qt[2834].id, qt[2834].name)
  end
  if qData[2835].state == 0 and qData[2834].state == 2 and GET_PLAYER_LEVEL() >= qt[2835].needLevel then
    ADD_QUEST_BTN(qt[2835].id, qt[2835].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[2789].state ~= 2 and qData[2788].state == 2 and GET_PLAYER_LEVEL() >= qt[2789].needLevel then
    if qData[2789].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[3743].state ~= 2 and qData[2746].state == 2 and GET_PLAYER_LEVEL() >= qt[3743].needLevel then
    if qData[3743].state == 1 then
      if qData[3743].killMonster[qt[3743].goal.killMonster[1].id] >= qt[3743].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[3753].state ~= 2 and qData[2798].state == 2 and GET_PLAYER_LEVEL() >= qt[3753].needLevel then
    if qData[3753].state == 1 then
      if qData[3753].killMonster[qt[3753].goal.killMonster[1].id] >= qt[3753].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[3755].state ~= 2 and qData[2821].state == 2 and GET_PLAYER_LEVEL() >= qt[3755].needLevel then
    if qData[3755].state == 1 then
      if qData[3755].killMonster[qt[3755].goal.killMonster[1].id] >= qt[3755].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2832].state ~= 2 and qData[2831].state == 2 and GET_PLAYER_LEVEL() >= qt[2832].needLevel then
    if qData[2832].state == 1 then
      if CHECK_ITEM_CNT(qt[2832].goal.getItem[1].id) >= qt[2832].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2833].state ~= 2 and qData[2832].state == 2 and GET_PLAYER_LEVEL() >= qt[2833].needLevel then
    if qData[2833].state == 1 then
      if CHECK_ITEM_CNT(qt[2833].goal.getItem[1].id) >= qt[2833].goal.getItem[1].count and CHECK_ITEM_CNT(qt[2833].goal.getItem[2].id) >= qt[2833].goal.getItem[2].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2834].state ~= 2 and qData[2833].state == 2 and GET_PLAYER_LEVEL() >= qt[2834].needLevel then
    if qData[2834].state == 1 then
      if qData[2834].killMonster[qt[2834].goal.killMonster[1].id] >= qt[2834].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2835].state ~= 2 and qData[2834].state == 2 and GET_PLAYER_LEVEL() >= qt[2835].needLevel then
    if qData[2835].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
end
