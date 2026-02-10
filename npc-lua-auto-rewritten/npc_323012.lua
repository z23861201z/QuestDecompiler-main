function npcsay(id)
  if id ~= 4323012 then
    return
  end
  NPC_SAY("世界再怎么混乱，我还是很悠闲啊。")
  clickNPCid = id
  if qData[2183].state == 1 then
    if CHECK_ITEM_CNT(qt[2183].goal.getItem[1].id) >= qt[2183].goal.getItem[1].count then
      NPC_SAY("谢谢啊~")
      SET_QUEST_STATE(2183, 2)
      return
    else
      NPC_SAY("既然你也吃了，就去击退地狱三头犬，收集50个三头犬尾巴回来吧")
    end
  end
  if qData[2589].state == 1 then
    if CHECK_ITEM_CNT(qt[2589].goal.getItem[1].id) >= qt[2589].goal.getItem[1].count then
      NPC_SAY("谢谢。这下终于有可以炫耀的收藏品了。")
      SET_QUEST_STATE(2589, 2)
      return
    else
      NPC_SAY("击退{0xFFFFFF00}[红色阿拉克涅]{END}，收集回来{0xFFFFFF00}50个阿拉克涅的腿{END}交给我吧。{0xFFFFFF00}[红色阿拉克涅]{END}在黑色丘陵。")
    end
  end
  if qData[2595].state == 1 then
    if CHECK_ITEM_CNT(qt[2595].goal.getItem[1].id) >= qt[2595].goal.getItem[1].count then
      NPC_SAY("辛苦了。这是我送你的礼物。")
      SET_QUEST_STATE(2595, 2)
      return
    else
      NPC_SAY("赶紧去击退黑色丘陵的{0xFFFFFF00}[黄色阿佩普]{END}，只要收集回来{0xFFFFFF00}50个黄色阿佩普的眼球{END}就可以了。尽量拿来新鲜的眼球！")
    end
  end
  if qData[3646].state == 1 then
    if CHECK_ITEM_CNT(qt[3646].goal.getItem[1].id) >= qt[3646].goal.getItem[1].count then
      NPC_SAY("一，二，三，四，，，四十九，五十。恩！刚好。想吃的话随时过来吧")
      SET_QUEST_STATE(3646, 2)
      return
    else
      NPC_SAY("你收集回来，我一定会给你烤的香香的。拜托你收集回来50个三头犬尾巴吧")
    end
  end
  ADD_NEW_SHOP_BTN(id, 10082)
  if qData[2183].state == 0 then
    ADD_QUEST_BTN(qt[2183].id, qt[2183].name)
  end
  if qData[2589].state == 0 and GET_PLAYER_LEVEL() >= qt[2589].needLevel then
    ADD_QUEST_BTN(qt[2589].id, qt[2589].name)
  end
  if qData[2595].state == 0 and qData[2589].state == 2 and GET_PLAYER_LEVEL() >= qt[2595].needLevel then
    ADD_QUEST_BTN(qt[2595].id, qt[2595].name)
  end
  if qData[3646].state == 0 and qData[2183].state == 2 then
    ADD_QUEST_BTN(qt[3646].id, qt[3646].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[2183].state ~= 2 and GET_PLAYER_LEVEL() >= qt[2183].needLevel then
    if qData[2183].state == 1 then
      if CHECK_ITEM_CNT(qt[2183].goal.getItem[1].id) >= qt[2183].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2589].state ~= 2 and GET_PLAYER_LEVEL() >= qt[2589].needLevel then
    if qData[2589].state == 1 then
      if CHECK_ITEM_CNT(qt[2589].goal.getItem[1].id) >= qt[2589].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2595].state ~= 2 and qData[2589].state == 2 and GET_PLAYER_LEVEL() >= qt[2595].needLevel then
    if qData[2595].state == 1 then
      if CHECK_ITEM_CNT(qt[2595].goal.getItem[1].id) >= qt[2595].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[3646].state ~= 2 and qData[2183].state == 2 and GET_PLAYER_LEVEL() >= qt[3646].needLevel then
    if qData[3646].state == 1 then
      if CHECK_ITEM_CNT(qt[3646].goal.getItem[1].id) >= qt[3646].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
end
