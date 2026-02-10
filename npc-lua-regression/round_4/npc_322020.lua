function npcsay(id)
  if id ~= 4322020 then
    return
  end
  clickNPCid = id
  NPC_SAY("..")
  if qData[2817].state == 1 then
    NPC_SAY("ÊÇ...Ë­...°¡...")
    SET_QUEST_STATE(2817, 2)
    return
  end
  if qData[2818].state == 0 and qData[2817].state == 2 and GET_PLAYER_LEVEL() >= qt[2818].needLevel then
    ADD_QUEST_BTN(qt[2818].id, qt[2818].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[2817].state == 1 then
    QSTATE(id, 2)
  end
  if qData[2818].state ~= 2 and qData[2817].state == 2 and GET_PLAYER_LEVEL() >= qt[2818].needLevel then
    if qData[2818].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
end
