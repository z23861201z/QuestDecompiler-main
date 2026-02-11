function npcsay(id)
  if id ~= 4324010 then
    return
  end
  clickNPCid = id
  if qData[2612].state == 1 then
    NPC_SAY("这是？？")
    SET_QUEST_STATE(2612, 2)
  end
  if qData[2613].state == 1 then
    NPC_SAY("这里没有可查探得了。")
  end
  if qData[2618].state == 1 then
    NPC_SAY("这是？？")
    SET_QUEST_STATE(2618, 2)
  end
  if qData[2619].state == 1 then
    NPC_SAY("这里没有可查探得了。")
  end
  if qData[2613].state == 0 and qData[2612].state == 2 then
    ADD_QUEST_BTN(qt[2613].id, qt[2613].name)
  end
  if qData[2619].state == 0 and qData[2618].state == 2 then
    ADD_QUEST_BTN(qt[2619].id, qt[2619].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[2612].state == 1 then
    QSTATE(id, 2)
  end
  if qData[2613].state ~= 2 and qData[2612].state == 2 then
    if qData[2613].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2618].state == 1 then
    QSTATE(id, 2)
  end
  if qData[2619].state ~= 2 and qData[2618].state == 2 then
    if qData[2619].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
end
