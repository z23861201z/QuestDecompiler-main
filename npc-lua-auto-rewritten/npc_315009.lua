function npcsay(id)
  if id ~= 4315009 then
    return
  end
  clickNPCid = id
  if qData[166].state == 1 then
    if CHECK_ITEM_CNT(qt[166].goal.getItem[1].id) >= qt[166].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("????! ?? ???. ?? ??? ??? ??? ?? ?? ????.")
        SET_QUEST_STATE(166, 2)
      else
        NPC_SAY("ÐÐÄÒÌ«³Á¡£")
      end
    else
      NPC_SAY("??? ??? ??? ?? ???. ???? ?????? 30?? ??????")
    end
  end
  if qData[166].state == 0 and GET_PLAYER_LEVEL() >= qt[166].needLevel then
    ADD_QUEST_BTN(qt[166].id, qt[166].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
end
