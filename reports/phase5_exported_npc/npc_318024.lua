function npcsay(id)
  if id ~= 4318024 then
    return
  end
  clickNPCid = id
  if qData[790].state == 1 then
    if qData[790].killMonster[qt[790].goal.killMonster[1].id] >= qt[790].goal.killMonster[1].count then
      NPC_SAY("{0xFFFFFF00}???{END}? ???? ?? ?? ???? ?? ??? ?????.")
      SET_QUEST_STATE(790, 2)
      return
    else
      NPC_SAY("{0xFFFFFF00}???{END}? ??? ??????")
    end
  end
  if qData[791].state == 1 then
    if CHECK_ITEM_CNT(qt[791].goal.getItem[1].id) >= qt[791].goal.getItem[1].count then
      NPC_SAY("{0xFFFFFF00}????{END}? ?? ??????? ?? ??????.")
      SET_QUEST_STATE(791, 2)
      return
    else
      NPC_SAY("{0xFFFFFF00}????{END}? ??????")
    end
  end
  if qData[792].state == 1 then
    if qData[792].killMonster[qt[792].goal.killMonster[1].id] >= qt[792].goal.killMonster[1].count then
      NPC_SAY("{0xFFFFFF00}??{END}? ???? ?? ?? ???? ?? ??? ?????.")
      SET_QUEST_STATE(792, 2)
      return
    else
      NPC_SAY("{0xFFFFFF00}??{END}? ??? ??????")
    end
  end
  if qData[793].state == 1 then
    if CHECK_ITEM_CNT(qt[793].goal.getItem[1].id) >= qt[793].goal.getItem[1].count then
      NPC_SAY("??? ??? ???? ??????. ?? ??? ?? ?????.")
      SET_QUEST_STATE(793, 2)
      return
    else
      NPC_SAY("{0xFFFFFF00}????{END}? ??????")
    end
  end
  if qData[794].state == 1 then
    if CHECK_ITEM_CNT(qt[794].goal.getItem[1].id) >= qt[794].goal.getItem[1].count then
      NPC_SAY("??? ??? ???? ??????. ?? ??? ?? ?????.")
      SET_QUEST_STATE(794, 2)
      return
    else
      NPC_SAY("{0xFFFFFF00}?????{END}? ??????")
    end
  end
  if qData[795].state == 1 then
    if CHECK_ITEM_CNT(qt[795].goal.getItem[1].id) >= qt[795].goal.getItem[1].count then
      NPC_SAY("??? ??? ???? ??????. ?? ??? ?? ?????.")
      SET_QUEST_STATE(795, 2)
      return
    else
      NPC_SAY("{0xFFFFFF00}?????{END}? ??????")
    end
  end
  if qData[796].state == 1 then
    if qData[796].killMonster[qt[796].goal.killMonster[1].id] >= qt[796].goal.killMonster[1].count then
      NPC_SAY("{0xFFFFFF00}???{END}? ???? ?? ?? ???? ?? ??? ?????. {0xFFFFFF00}PLAYERNAME{END}?? ?? ?? ??? ??? ?? ????. ??? ?? ???? ???? ??? ???.")
      SET_QUEST_STATE(796, 2)
      return
    else
      NPC_SAY("{0xFFFFFF00}???{END}? ??? ??????")
    end
  end
  if qData[790].state == 0 then
    ADD_QUEST_BTN(qt[790].id, qt[790].name)
  end
  if qData[791].state == 0 then
    ADD_QUEST_BTN(qt[791].id, qt[791].name)
  end
  if qData[792].state == 0 then
    ADD_QUEST_BTN(qt[792].id, qt[792].name)
  end
  if qData[793].state == 0 then
    ADD_QUEST_BTN(qt[793].id, qt[793].name)
  end
  if qData[794].state == 0 then
    ADD_QUEST_BTN(qt[794].id, qt[794].name)
  end
  if qData[795].state == 0 then
    ADD_QUEST_BTN(qt[795].id, qt[795].name)
  end
  if qData[796].state == 0 then
    ADD_QUEST_BTN(qt[796].id, qt[796].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[790].state ~= 2 and GET_PLAYER_LEVEL() >= qt[790].needLevel then
    if qData[790].state == 1 then
      if qData[790].killMonster[qt[790].goal.killMonster[1].id] >= qt[790].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, qData[790].state)
      end
    else
      QSTATE(id, qData[790].state)
    end
  end
  if qData[791].state ~= 2 and GET_PLAYER_LEVEL() >= qt[791].needLevel then
    if qData[791].state == 1 then
      if CHECK_ITEM_CNT(qt[791].goal.getItem[1].id) >= qt[791].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, qData[791].state)
      end
    else
      QSTATE(id, qData[791].state)
    end
  end
  if qData[792].state ~= 2 and GET_PLAYER_LEVEL() >= qt[792].needLevel then
    if qData[792].state == 1 then
      if qData[792].killMonster[qt[792].goal.killMonster[1].id] >= qt[792].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, qData[792].state)
      end
    else
      QSTATE(id, qData[792].state)
    end
  end
  if qData[793].state ~= 2 and GET_PLAYER_LEVEL() >= qt[793].needLevel then
    if qData[793].state == 1 then
      if CHECK_ITEM_CNT(qt[793].goal.getItem[1].id) >= qt[793].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, qData[793].state)
      end
    else
      QSTATE(id, qData[793].state)
    end
  end
  if qData[794].state ~= 2 and GET_PLAYER_LEVEL() >= qt[794].needLevel then
    if qData[794].state == 1 then
      if CHECK_ITEM_CNT(qt[794].goal.getItem[1].id) >= qt[794].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, qData[794].state)
      end
    else
      QSTATE(id, qData[794].state)
    end
  end
  if qData[795].state ~= 2 and GET_PLAYER_LEVEL() >= qt[795].needLevel then
    if qData[795].state == 1 then
      if CHECK_ITEM_CNT(qt[795].goal.getItem[1].id) >= qt[795].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, qData[795].state)
      end
    else
      QSTATE(id, qData[795].state)
    end
  end
  if qData[796].state ~= 2 and GET_PLAYER_LEVEL() >= qt[796].needLevel then
    if qData[796].state == 1 then
      if qData[796].killMonster[qt[796].goal.killMonster[1].id] >= qt[796].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, qData[796].state)
      end
    else
      QSTATE(id, qData[796].state)
    end
  end
end
