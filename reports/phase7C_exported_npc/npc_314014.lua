function npcsay(id)
  if id ~= 4314014 then
    return
  end
  clickNPCid = id
  NPC_SAY("卡哈哈！！一看你就是个能拯救世界的人。就收你{0xFFFFFF00}占卜费10000钱{END}给你看运势吧。怎么样，要试试吗？机会{0xFFFFFF00}一天只有一次{END}。")
  if qData[3712].state == 1 then
    if CHECK_ITEM_CNT(qt[3712].goal.getItem[1].id) >= qt[3712].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("辛苦了。年初应该会总拜托你相同的事情！")
        SET_QUEST_STATE(3712, 2)
        return
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("快去击退怪物，收集20个{0xFFFFFF00}丙午年的气韵{END}回来吧。我不会少给你奖励的。")
    end
  end
  ADD_NPC_CARD_DIVINE(id)
  if qData[3712].state == 0 then
    ADD_QUEST_BTN(qt[3712].id, qt[3712].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[3712].state ~= 2 then
    if qData[3712].state == 1 then
      if CHECK_ITEM_CNT(qt[3712].goal.getItem[1].id) >= qt[3712].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
end
