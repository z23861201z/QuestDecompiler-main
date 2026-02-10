function npcsay(id)
  if id ~= 4341022 then
    return
  end
  clickNPCid = id
  NPC_SAY("我的料理没有人不喜欢。")
  if qData[2720].state == 1 and qData[2720].meetNpc[1] ~= id and CHECK_ITEM_CNT(8990217) >= 30 then
    if 1 <= CHECK_INVENTORY_CNT(4) then
      NPC_SAY("啊~你好。我是东方料理王飞燕。我来介绍一下最近我新研发的料理{0xFFFFFF00}地龙的舌头佳肴{END}。啊~已经拿来了{0xFFFFFF00}地龙的舌头{END}啊，那我马上就给你制作。")
      SET_INFO(2720, 1)
      SET_MEETNPC(2720, 1, id)
      return
    else
      NPC_SAY("行囊太沉。")
      return
    end
  end
  if qData[2906].state == 1 and __QUEST_HAS_ALL_ITEMS(qt[2906].goal.getItem) then
    NPC_SAY("你~你好。我是东方料理王飞燕。最近我新研发的料理{0xFFFFFF00}烤多足怪虫的脚{END}材料不足..天啊！送来了这么多材料！啊，外卖吗？没问题，交给我。")
    SET_QUEST_STATE(2906, 2)
    return
  end
  if qData[3733].state == 1 then
    if CHECK_ITEM_CNT(qt[3733].goal.getItem[1].id) >= qt[3733].goal.getItem[1].count then
      NPC_SAY("这次我可以去确信味道很好。")
      SET_QUEST_STATE(3733, 2)
      return
    else
      NPC_SAY("地龙的舌头不够了。你能帮我收集些地龙的舌头吗？30个就够了。")
    end
  end
  if qData[3784].state == 1 then
    if CHECK_ITEM_CNT(qt[3784].goal.getItem[1].id) >= qt[3784].goal.getItem[1].count then
      NPC_SAY("这么快！太感谢了~")
      SET_QUEST_STATE(3784, 2)
      return
    else
      NPC_SAY("帮手收集回来10个{0xFFFFFF00}多足怪虫的脚{END}吧。能快点吗？")
    end
  end
  if qData[3733].state == 0 and qData[2720].state == 2 and GET_PLAYER_LEVEL() >= qt[3733].needLevel then
    ADD_QUEST_BTN(qt[3733].id, qt[3733].name)
  end
  if qData[3784].state == 0 and qData[2906].state == 2 and GET_PLAYER_LEVEL() >= qt[3784].needLevel then
    ADD_QUEST_BTN(qt[3784].id, qt[3784].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[2720].state == 1 and qData[2720].meetNpc[1] ~= id and CHECK_ITEM_CNT(8990217) >= 30 then
    QSTATE(id, 1)
  end
  if qData[2906].state == 1 then
    QSTATE(id, 2)
  end
  if qData[3733].state ~= 2 and qData[2720].state == 2 and GET_PLAYER_LEVEL() >= qt[3733].needLevel then
    if qData[3733].state == 1 then
      if CHECK_ITEM_CNT(qt[3733].goal.getItem[1].id) >= qt[3733].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[3784].state ~= 2 and qData[2906].state == 2 and GET_PLAYER_LEVEL() >= qt[3784].needLevel then
    if qData[3784].state == 1 then
      if CHECK_ITEM_CNT(qt[3784].goal.getItem[1].id) >= qt[3784].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
end
