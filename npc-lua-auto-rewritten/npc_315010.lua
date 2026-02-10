function npcsay(id)
  if id ~= 4315010 then
    return
  end
  clickNPCid = id
  if qData[111].state == 1 then
    if qData[111].meetNpc[1] ~= qt[111].goal.meetNpc[1] then
      NPC_QSAY(111, 1)
      SET_MEETNPC(111, 1, id)
      return
    elseif CHECK_ITEM_CNT(qt[111].goal.getItem[1].id) >= qt[111].goal.getItem[1].count then
      NPC_QSAY(111, 8)
      SET_QUEST_STATE(111, 2)
      return
    else
      NPC_SAY("{0xFFFFFF00}??{END}? ?????? {0xFFFFFF00}100?{END}? ??? ??? ??? ???????.")
    end
  end
  if qData[1246].state == 1 and CHECK_ITEM_CNT(qt[1246].goal.getItem[1].id) >= qt[1246].goal.getItem[1].count then
    if 1 <= CHECK_INVENTORY_CNT(3) then
      NPC_SAY("谢谢。托少侠的福，我的伤口已经好了。")
      SET_QUEST_STATE(1246, 2)
    else
      NPC_SAY("行囊太沉。")
    end
  end
  if qData[1247].state == 1 then
    NPC_SAY("去找可能在{0xFFFFFF00}龙林山和冥珠平原{END}的交界处的{0xFFFFFF00}土地公{END}问问吧。")
  end
  if qData[1247].state == 0 and qData[1246].state == 2 and GET_PLAYER_LEVEL() >= qt[1247].needLevel then
    ADD_QUEST_BTN(qt[1247].id, qt[1247].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[111].state == 1 then
    QSTATE(id, 1)
  end
  if qData[1246].state == 1 and CHECK_ITEM_CNT(qt[1246].goal.getItem[1].id) >= qt[1246].goal.getItem[1].count then
    if 1 <= CHECK_INVENTORY_CNT(3) then
      QSTATE(id, 2)
    else
      QSTATE(id, 1)
    end
  end
  if qData[1247].state ~= 2 and qData[1246].state == 2 and GET_PLAYER_LEVEL() >= qt[1247].needLevel then
    if qData[1247].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
end
