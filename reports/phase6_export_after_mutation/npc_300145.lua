function npcsay(id)
  if id ~= 4300145 then
    return
  end
  clickNPCid = id
  NPC_SAY("呼哈！呼哈！认真运动后你也会像我一样肌肉发达")
  if qData[2582].state == 1 then
    if CHECK_ITEM_CNT(qt[2582].goal.getItem[1].id) >= qt[2582].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("是3个，这是我给你的礼物！")
        SET_QUEST_STATE(2582, 2)
        return
      else
        NPC_SAY("留出点行囊空间后再来吧！")
      end
    else
      NPC_SAY("拿来3个{0xFFFFFF00}[大目仔币]{END}吧。.")
    end
  end
  ADD_NEW_SHOP_BTN(id, 10094)
  if qData[2582].state == 0 then
    ADD_QUEST_BTN(qt[2582].id, qt[2582].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[2582].state ~= 2 then
    if qData[2582].state == 1 then
      if CHECK_ITEM_CNT(qt[2582].goal.getItem[1].id) >= qt[2582].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
end
