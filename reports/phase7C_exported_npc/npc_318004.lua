function npcsay(id)
  if id ~= 4318004 then
    return
  end
  clickNPCid = id
  if qData[574].state == 1 then
    if qData[574].killMonster[qt[574].goal.killMonster[1].id] >= qt[574].goal.killMonster[1].count then
      NPC_SAY("?? ??? ??? ???? ???? ???~ ?? ?? ???? ???. ? ?? ????")
      SET_QUEST_STATE(574, 2)
      return
    else
      NPC_SAY("?? ???? ?? {0xFFFFFF00}[???] 10??{END}? ??????.")
      return
    end
  end
  if qData[578].state == 1 then
    if qData[578].killMonster[qt[578].goal.killMonster[1].id] >= qt[578].goal.killMonster[1].count then
      NPC_SAY("????.. ????.. ?? ?? ??? ?? ?? ?? ? ?? ? ???.")
      SET_QUEST_STATE(578, 2)
      return
    else
      NPC_SAY("?? ??? ?? ??? ??? {0xFFFFFF00}[??] 10??{END} ? ? ??????.")
      return
    end
  end
  if qData[574].state == 0 then
    ADD_QUEST_BTN(qt[574].id, qt[574].name)
  end
  if qData[578].state == 0 then
    ADD_QUEST_BTN(qt[578].id, qt[578].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[574].state ~= 2 and GET_PLAYER_LEVEL() >= qt[574].needLevel then
    if qData[574].state == 1 then
      if qData[574].killMonster[qt[574].goal.killMonster[1].id] >= qt[574].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[578].state ~= 2 and GET_PLAYER_LEVEL() >= qt[578].needLevel then
    if qData[578].state == 1 then
      if qData[578].killMonster[qt[578].goal.killMonster[1].id] >= qt[578].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
end
