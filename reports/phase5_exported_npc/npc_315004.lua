function npcsay(id)
  if id ~= 4315004 then
    return
  end
  clickNPCid = id
  if qData[141].state == 1 then
    if qData[141].killMonster[qt[141].goal.killMonster[1].id] >= qt[141].goal.killMonster[1].count then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("????. ?? ??? ?? ???? ????? ?? ???? ? ? ????.")
        SET_QUEST_STATE(141, 2)
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("{0xFFFFFF00}[??] 20??{END}? ? ??? ? ??? ? ???.")
    end
  end
  if qData[803].state == 1 then
    if qData[803].meetNpc[1] ~= qt[803].goal.meetNpc[1] then
      NPC_QSAY(803, 1)
      SET_MEETNPC(803, 1, id)
      SET_INFO(803, 2)
      return
    else
      NPC_SAY("???? ???? ????? ?? ??? ??. ?? ?? ????....")
      return
    end
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[803].state == 1 and GET_PLAYER_LEVEL() >= qt[803].needLevel then
    QSTATE(id, 1)
  end
  if qData[141].state ~= 2 and GET_PLAYER_LEVEL() >= qt[141].needLevel then
    if qData[141].state == 1 then
      if qData[141].killMonster[qt[141].goal.killMonster[1].id] >= qt[141].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
end
