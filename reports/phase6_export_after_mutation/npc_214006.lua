function npcsay(id)
  if id ~= 4214006 then
    return
  end
  clickNPCid = id
  NPC_SAY("精灵一定要有灵力才可以发挥应有的效果。不要懒于给精灵补充灵力了。")
  if qData[1148].state == 1 then
    NPC_SAY("咦？你对精灵感兴趣？年轻人有很好的兴趣啊。哈哈哈。")
    SET_QUEST_STATE(1148, 2)
  end
  if qData[1150].state == 1 then
    if CHECK_ITEM_CNT(qt[1150].goal.getItem[1].id) >= qt[1150].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("谢谢。嗯？目击了袭击的情况？不是，不是我。好像有什么误会。你重新回到白斩姬那儿看看吧。")
        SET_QUEST_STATE(1150, 2)
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("要想制作精灵，得击退芦苇林的红毛龟收集15个[ 红毛龟的壳 ]。")
    end
  end
  if qData[1183].state == 1 and CHECK_ITEM_CNT(qt[1183].goal.getItem[1].id) >= qt[1183].goal.getItem[1].count then
    if 1 <= CHECK_INVENTORY_CNT(3) then
      NPC_SAY("真是太感谢了，你一定会有好报的。")
      SET_QUEST_STATE(1183, 2)
    else
      NPC_SAY("行囊太沉。")
    end
  end
  if qData[1184].state == 1 then
    if CHECK_ITEM_CNT(qt[1184].goal.getItem[1].id) >= qt[1184].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("真是太感谢了，你一定会有好报的。")
        SET_QUEST_STATE(1184, 2)
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("再拜托你帮我收集制作精灵用的20个[黄金猎犬的牙]吧。黄金猎犬在蛇腹窟...")
    end
  end
  if qData[1187].state == 1 then
    if CHECK_ITEM_CNT(qt[1187].goal.getItem[1].id) >= qt[1187].goal.getItem[1].count then
      NPC_SAY("期待吧！会制作出很可爱的精灵的！")
      SET_QUEST_STATE(1187, 2)
    else
      NPC_SAY("有了15个[ 独脚天狗仙的角 ]才能完成精灵。就拜托你了。独角天狗仙在竹林。")
    end
  end
  ADD_NEW_SHOP_BTN(id, 10033)
  if qData[953].state == 0 then
    ADD_QUEST_BTN(qt[953].id, qt[953].name)
  end
  if qData[1148].state == 2 and qData[1150].state == 0 then
    ADD_QUEST_BTN(qt[1150].id, qt[1150].name)
  end
  if qData[1184].state == 0 then
    ADD_QUEST_BTN(qt[1184].id, qt[1184].name)
  end
  if qData[1187].state == 0 then
    ADD_QUEST_BTN(qt[1187].id, qt[1187].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[1146].state == 2 and qData[1148].state ~= 2 and qData[1148].state == 1 then
    QSTATE(id, 2)
  end
  if qData[1148].state == 2 and qData[1150].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1150].needLevel then
    if qData[1150].state == 1 then
      if CHECK_ITEM_CNT(qt[1150].goal.getItem[1].id) >= qt[1150].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1183].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1183].needLevel and qData[1183].state == 1 and CHECK_ITEM_CNT(qt[1183].goal.getItem[1].id) >= qt[1183].goal.getItem[1].count then
    QSTATE(id, 2)
  end
  if qData[1184].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1184].needLevel then
    if qData[1184].state == 1 then
      if CHECK_ITEM_CNT(qt[1184].goal.getItem[1].id) >= qt[1184].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1187].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1187].needLevel then
    if qData[1187].state == 1 then
      if CHECK_ITEM_CNT(qt[1187].goal.getItem[1].id) >= qt[1187].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
end
