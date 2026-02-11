function npcsay(id)
  if id ~= 4221011 then
    return
  end
  clickNPCid = id
  if qData[3658].state == 1 then
    if CHECK_ITEM_CNT(qt[3658].goal.getItem[1].id) >= qt[3658].goal.getItem[1].count and CHECK_ITEM_CNT(qt[3658].goal.getItem[2].id) >= qt[3658].goal.getItem[2].count and CHECK_ITEM_CNT(qt[3658].goal.getItem[3].id) >= qt[3658].goal.getItem[3].count then
      if 1 <= CHECK_INVENTORY_CNT(4) then
        NPC_SAY("谢谢。明天也拜托了！")
        SET_QUEST_STATE(3658, 2)
      else
        NPC_SAY("行囊空间不足")
      end
    else
      NPC_SAY("收集幽灵使徒的幽灵使徒披风，土野族的土野族宝珠，黑色食铁怪兽的黑色食铁怪兽鼻子各10个回来吧。这样一点点击退下去的话，以后亡者的山谷也能通过的吧？")
    end
  end
  ADD_NEW_SHOP_BTN(id, 10048)
  ADD_MOVESOUL_BTN(id)
  ADD_ENCHANT_BTN(id)
  ADD_PURIFICATION_BTN(id)
  if qData[3658].state == 0 then
    ADD_QUEST_BTN(qt[3658].id, qt[3658].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[3658].state ~= 2 then
    if qData[3658].state == 1 then
      if CHECK_ITEM_CNT(qt[3658].goal.getItem[1].id) >= qt[3658].goal.getItem[1].count and CHECK_ITEM_CNT(qt[3658].goal.getItem[2].id) >= qt[3658].goal.getItem[2].count and CHECK_ITEM_CNT(qt[3658].goal.getItem[3].id) >= qt[3658].goal.getItem[3].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
end
