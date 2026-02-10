function npcsay(id)
  if id ~= 4313004 then
    return
  end
  clickNPCid = id
  if qData[335].state == 1 then
    if qData[335].meetNpc[1] ~= id then
      SET_INFO(335, 1)
      SET_MEETNPC(335, 1, id)
      NPC_QSAY(335, 1)
    else
      NPC_SAY("?? ? ?? ?? ?? ??? ????. ?????? ??? ???? ? ????….")
    end
  end
  if qData[337].state == 1 then
    if qData[337].meetNpc[1] ~= id then
      SET_INFO(337, 1)
      SET_MEETNPC(337, 1, id)
      NPC_QSAY(337, 1)
    else
      NPC_SAY("???? ??? ???? ?? ???….?.")
    end
  end
  if qData[341].state == 1 then
    if qData[341].meetNpc[1] ~= id then
      SET_INFO(341, 1)
      SET_MEETNPC(341, 1, id)
      NPC_QSAY(341, 1)
    else
      NPC_SAY("?????? ? ?? ? ??? ?…. ???. ??? ??? ?? ??? ?? ???.")
    end
  end
  if qData[344].state == 1 then
    if qData[344].meetNpc[1] ~= id then
      SET_INFO(344, 1)
      SET_MEETNPC(344, 1, id)
      NPC_QSAY(344, 1)
    else
      NPC_SAY("?????? ? ?? ? ??? ?…. ???. ??? ??? ?? ??? ?? ???.")
    end
  end
  if qData[345].state == 1 then
    if qData[345].meetNpc[1] ~= id then
      SET_INFO(345, 1)
      SET_MEETNPC(345, 1, id)
      NPC_QSAY(345, 1)
    else
      NPC_SAY("?? ??? ??? ??? ???? ?? ??? ?? ??? ??? ???? ???? ?? ? ???.")
    end
  end
  if qData[1236].state == 1 and __QUEST_HAS_ALL_ITEMS(qt[1236].goal.getItem) then
    if 1 <= CHECK_INVENTORY_CNT(2) then
      NPC_SAY("谢谢。我正在犹豫着剪头发的事情呢。")
      SET_QUEST_STATE(1236, 2)
    else
      NPC_SAY("行囊太沉。")
    end
  end
  if qData[1237].state == 1 then
    NPC_SAY("击退栖息在冥珠平原另一头{0xFFFFFF00}龙林山{END}上的{0xFFFFFF00}桶装黄鼠狼{END}，收集{0xFFFFFF00}20个桶装黄鼠狼的毛{END}拿给{0xFFFFFF00}冥珠城南边{END}的{0xFFFFFF00}冥珠城服装店{END}。")
  end
  if qData[1237].state == 0 and qData[1236].state == 2 and GET_PLAYER_LEVEL() >= qt[1237].needLevel then
    ADD_QUEST_BTN(qt[1237].id, qt[1237].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[335].state == 1 and GET_PLAYER_LEVEL() >= qt[335].needLevel then
    QSTATE(id, 1)
  end
  if qData[337].state == 1 and GET_PLAYER_LEVEL() >= qt[337].needLevel then
    QSTATE(id, 1)
  end
  if qData[341].state == 1 and GET_PLAYER_LEVEL() >= qt[341].needLevel then
    QSTATE(id, 1)
  end
  if qData[344].state == 1 and GET_PLAYER_LEVEL() >= qt[344].needLevel then
    QSTATE(id, 1)
  end
  if qData[345].state == 1 and GET_PLAYER_LEVEL() >= qt[345].needLevel then
    QSTATE(id, 1)
  end
  if qData[1236].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[1236].goal.getItem) then
      if 1 <= CHECK_INVENTORY_CNT(2) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 1)
    end
  end
  if qData[1237].state == 1 then
    QSTATE(id, 1)
  end
  if qData[1237].state == 0 and qData[1236].state == 2 and GET_PLAYER_LEVEL() >= qt[1237].needLevel then
    QSTATE(id, 0)
  end
end
