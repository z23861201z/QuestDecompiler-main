function npcsay(id)
  if id ~= 4300133 then
    return
  end
  clickNPCid = id
  if qData[894].state == 1 then
    if qData[894].killMonster[qt[894].goal.killMonster[1].id] >= qt[894].goal.killMonster[1].count then
      if 1 <= CHECK_INVENTORY_CNT(4) then
        NPC_SAY("???, ???? ??? ?? ???. ??? ????.")
        SET_QUEST_STATE(894, 2)
        return
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("?? ???? ???? ???.")
    end
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[894].state == 1 then
    if qData[894].killMonster[qt[894].goal.killMonster[1].id] >= qt[894].goal.killMonster[1].count then
      QSTATE(id, 2)
    else
      QSTATE(id, 1)
    end
  end
end
