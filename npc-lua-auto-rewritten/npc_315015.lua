function npcsay(id)
  if id ~= 4315015 then
    return
  end
  clickNPCid = id
  if qData[140].state == 1 then
    if qData[140].killMonster[qt[140].goal.killMonster[1].id] >= qt[140].goal.killMonster[1].count then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("????. ?? ?? ???? ?????? ??? ???. ???! ???? ???? ?????.")
        SET_QUEST_STATE(140, 2)
        return
      else
        NPC_SAY("ÐÐÄÒÌ«³Á¡£")
      end
    else
      NPC_SAY("{0xFFFFFF00}[??] 20??{END}? ??? ?? ?? ??? ????.")
    end
  end
  if qData[144].state == 1 then
    if qData[144].meetNpc[1] == qt[144].goal.meetNpc[1] and CHECK_ITEM_CNT(qt[144].goal.getItem[1].id) >= qt[144].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("??¡­. ?? ?? ??? ???. ? ?????. ??? ??? ?? ????? ??? ??? ?? ?? ???. ?, ?? ????.")
        SET_QUEST_STATE(144, 2)
        return
      else
        NPC_SAY("ÐÐÄÒÌ«³Á¡£")
      end
    else
      NPC_SAY("???. ????. ??? ? ? ???? ???. ???? ?? {0xFFFFFF00}[??]{END}? ??????. {0xFFFFFF00}??? ???? ? ?? ??{END}? ???.")
    end
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[140].state ~= 2 and GET_PLAYER_LEVEL() >= qt[140].needLevel then
    if qData[140].state == 1 then
      if qData[140].killMonster[qt[140].goal.killMonster[1].id] >= qt[140].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[140].state == 2 and qData[144].state ~= 2 and GET_PLAYER_LEVEL() >= qt[144].needLevel then
    if qData[144].state == 1 then
      if qData[144].meetNpc[1] == qt[144].goal.meetNpc[1] and CHECK_ITEM_CNT(qt[144].goal.getItem[1].id) >= qt[144].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
end
