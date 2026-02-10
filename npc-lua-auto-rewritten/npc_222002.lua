function npcsay(id)
  if id ~= 4222002 then
    return
  end
  clickNPCid = id
  NPC_SAY("准备好吕林符了吗？危险的时候请使用回城符。")
  if qData[1049].state == 1 then
    if CHECK_ITEM_CNT(qt[1049].goal.getItem[1].id) >= qt[1049].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("真的帮我收集了符咒啊，太感谢你了！{0xFFFFFF00}PLAYERNAME{END}，果然名不虚传啊！")
        SET_QUEST_STATE(1049, 2)
        return
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("拜托了，那个符咒力量很强大，必须得迅速收取才行，你帮我收取{0xFFFFFF00}10张{END}吧！")
    end
  end
  if qData[1056].state == 1 then
    if CHECK_ITEM_CNT(qt[1056].goal.getItem[1].id) >= qt[1056].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("如果是{0xFFFFFF00}PLAYERNAME{END}的话，收取100张左右是易如反掌的事吧！太感谢了！")
        SET_QUEST_STATE(1056, 2)
        return
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("必须得找到符咒才行，我需要很多人的帮助。你就帮我收取{0xFFFFFF00}100张{END}吧！")
    end
  end
  ADD_NEW_SHOP_BTN(id, 10052)
  ADD_MOVESOUL_BTN(id)
  ADD_ENCHANT_BTN(id)
  ADD_PURIFICATION_BTN(id)
  if qData[1049].state == 0 then
    ADD_QUEST_BTN(qt[1049].id, qt[1049].name)
  end
  if qData[1056].state == 0 then
    ADD_QUEST_BTN(qt[1056].id, qt[1056].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[1049].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1049].needLevel then
    if qData[1049].state == 1 then
      if CHECK_ITEM_CNT(qt[1049].goal.getItem[1].id) >= qt[1049].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1056].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1056].needLevel then
    if qData[1056].state == 1 then
      if CHECK_ITEM_CNT(qt[1056].goal.getItem[1].id) >= qt[1056].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
end
