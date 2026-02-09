function npcsay(id)
  if id ~= 4324009 then
    return
  end
  clickNPCid = id
  if qData[2611].state == 1 and qData[2611].killMonster[qt[2611].goal.killMonster[1].id] >= qt[2611].goal.killMonster[1].count then
    NPC_SAY("我就知道这里有线索（破损严重，很难读懂了…）")
    SET_QUEST_STATE(2611, 2)
  end
  if qData[2612].state == 1 then
    NPC_SAY("(这可能是解开事件之谜的钥匙…可能还有什么线索…）")
  end
  if qData[2617].state == 1 and qData[2617].killMonster[qt[2617].goal.killMonster[1].id] >= qt[2617].goal.killMonster[1].count then
    NPC_SAY("我就知道这里有线索（破损严重，很难读懂了…）")
    SET_QUEST_STATE(2617, 2)
  end
  if qData[2618].state == 1 then
    NPC_SAY("(这可能是解开事件之谜的钥匙…可能还有什么线索…）")
  end
  if qData[2612].state == 0 and qData[2611].state == 2 then
    ADD_QUEST_BTN(qt[2612].id, qt[2612].name)
  end
  if qData[2618].state == 0 and qData[2617].state == 2 then
    ADD_QUEST_BTN(qt[2618].id, qt[2618].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[2611].state == 1 then
    if qData[2611].killMonster[qt[2611].goal.killMonster[1].id] >= qt[2611].goal.killMonster[1].count then
      QSTATE(id, 2)
    else
      QSTATE(id, 1)
    end
  end
  if qData[2612].state ~= 2 and qData[2611].state == 2 then
    if qData[2612].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2617].state == 1 then
    if qData[2617].killMonster[qt[2617].goal.killMonster[1].id] >= qt[2617].goal.killMonster[1].count then
      QSTATE(id, 2)
    else
      QSTATE(id, 1)
    end
  end
  if qData[2618].state ~= 2 and qData[2617].state == 2 then
    if qData[2618].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
end
