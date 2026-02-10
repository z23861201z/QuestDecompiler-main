function npcsay(id)
  if id ~= 4324007 then
    return
  end
  clickNPCid = id
  NPC_SAY("绝对不要放弃")
  if qData[2261].state == 1 then
    NPC_SAY("被暗算了...")
    SET_QUEST_STATE(2261, 2)
    return
  end
  if qData[2266].state == 1 then
    NPC_SAY("被暗算了...")
    SET_QUEST_STATE(2266, 2)
    return
  end
  if qData[2262].state == 0 and qData[2261].state == 2 and SET_PLAYER_SEX() == 1 then
    ADD_QUEST_BTN(qt[2262].id, qt[2262].name)
  end
  if qData[2267].state == 0 and qData[2266].state == 2 and SET_PLAYER_SEX() == 2 then
    ADD_QUEST_BTN(qt[2267].id, qt[2267].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[2261].state == 1 then
    QSTATE(id, 2)
  end
  if qData[2262].state ~= 2 and qData[2261].state == 2 then
    if qData[2262].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2266].state == 1 then
    QSTATE(id, 2)
  end
  if qData[2267].state ~= 2 and qData[2266].state == 2 then
    if qData[2267].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
end
