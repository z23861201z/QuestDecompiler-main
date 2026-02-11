function npcsay(id)
  if id ~= 4324008 then
    return
  end
  clickNPCid = id
  NPC_SAY("...")
  if qData[2610].state == 1 and qData[2610].killMonster[qt[2610].goal.killMonster[1].id] >= qt[2610].goal.killMonster[1].count then
    NPC_SAY("牟永健有话要说，来这边吧。")
    SET_QUEST_STATE(2610, 2)
  end
  if qData[2616].state == 1 and qData[2616].killMonster[qt[2616].goal.killMonster[1].id] >= qt[2616].goal.killMonster[1].count then
    NPC_SAY("牟永健有话要说，来这边吧。")
    SET_QUEST_STATE(2616, 2)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[2610].state == 1 then
    if qData[2610].killMonster[qt[2610].goal.killMonster[1].id] >= qt[2610].goal.killMonster[1].count then
      QSTATE(id, 2)
    else
      QSTATE(id, 1)
    end
  end
  if qData[2616].state == 1 then
    if qData[2616].killMonster[qt[2616].goal.killMonster[1].id] >= qt[2616].goal.killMonster[1].count then
      QSTATE(id, 2)
    else
      QSTATE(id, 1)
    end
  end
end
