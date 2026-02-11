function npcsay(id)
  if id ~= 4203001 then
    return
  end
  clickNPCid = id
  NPC_SAY("哈哈哈.想要挖矿的话得先要有锄头哦.")
  if qData[1190].state == 1 then
    if CHECK_ITEM_CNT(qt[1190].goal.getItem[1].id) >= qt[1190].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(4) then
        NPC_SAY("呵呵，收集了[ 灰煤 ]啊。谢谢。这是我的小小心意，收下吧。")
        SET_QUEST_STATE(1190, 2)
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("去矿山采矿，帮我收集1个[ 灰煤 ]吧。")
    end
  end
  if qData[1191].state == 1 then
    if CHECK_ITEM_CNT(qt[1191].goal.getItem[1].id) >= qt[1191].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(2) then
        NPC_SAY("呵呵  用蓝水晶块提炼了啊。这是你接受我提议的奖励。")
        SET_QUEST_STATE(1191, 2)
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("用100个蓝水晶块提炼试试怎么样？")
    end
  end
  if qData[1192].state == 1 then
    NPC_SAY("对矿物和装备强化有什么疑问可以随时来找我。")
    SET_QUEST_STATE(1192, 2)
  end
  if qData[1193].state == 1 then
    NPC_SAY("对矿物和装备强化有什么疑问可以随时来找我。")
    SET_QUEST_STATE(1193, 2)
  end
  ADD_NEW_SHOP_BTN(id, 10016)
  ADD_EVENT_BTN_H(id)
  ADD_ENCHANTEQUIP_BTN(id)
  ADD_ENCHANTEACCESSORY_BTN(id)
  if qData[1190].state == 0 then
    ADD_QUEST_BTN(qt[1190].id, qt[1190].name)
  end
  if qData[1190].state == 2 and qData[1191].state == 0 then
    ADD_QUEST_BTN(qt[1191].id, qt[1191].name)
  end
  if qData[1191].state == 2 and qData[1192].state == 0 then
    ADD_QUEST_BTN(qt[1192].id, qt[1192].name)
  end
  if qData[1192].state == 2 and qData[1193].state == 0 then
    ADD_QUEST_BTN(qt[1193].id, qt[1193].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[1190].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1190].needLevel then
    if qData[1190].state == 1 then
      if CHECK_ITEM_CNT(qt[1190].goal.getItem[1].id) >= qt[1190].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1191].state ~= 2 and qData[1190].state == 2 and GET_PLAYER_LEVEL() >= qt[1190].needLevel then
    if qData[1191].state == 1 then
      if CHECK_ITEM_CNT(qt[1191].goal.getItem[1].id) >= qt[1191].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1192].state ~= 2 and qData[1191].state == 2 and GET_PLAYER_LEVEL() >= qt[1190].needLevel then
    if qData[1192].state == 1 then
      QSTATE(id, 2)
    else
      QSTATE(id, 0)
    end
  end
  if qData[1193].state ~= 2 and qData[1192].state == 2 and GET_PLAYER_LEVEL() >= qt[1190].needLevel then
    if qData[1193].state == 1 then
      QSTATE(id, 2)
    else
      QSTATE(id, 0)
    end
  end
end
