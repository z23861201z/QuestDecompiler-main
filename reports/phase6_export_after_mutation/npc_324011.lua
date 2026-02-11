function npcsay(id)
  if id ~= 4324011 then
    return
  end
  clickNPCid = id
  NPC_SAY("...")
  if qData[2613].state == 1 then
    NPC_SAY("！！咳！！")
    SET_QUEST_STATE(2613, 2)
  end
  if qData[2614].state == 1 then
    NPC_SAY("...")
  end
  if qData[2619].state == 1 then
    NPC_SAY("！！咳！！")
    SET_QUEST_STATE(2619, 2)
  end
  if qData[2620].state == 1 then
    NPC_SAY("...")
  end
  if qData[2614].state == 0 and qData[2613].state == 2 then
    ADD_QUEST_BTN(qt[2614].id, qt[2614].name)
  end
  if qData[2620].state == 0 and qData[2619].state == 2 then
    ADD_QUEST_BTN(qt[2620].id, qt[2620].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[2613].state == 1 then
    QSTATE(id, 2)
  end
  if qData[2614].state ~= 2 and qData[2613].state == 2 then
    if qData[2614].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2619].state == 1 then
    QSTATE(id, 2)
  end
  if qData[2620].state ~= 2 and qData[2619].state == 2 then
    if qData[2620].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
end
