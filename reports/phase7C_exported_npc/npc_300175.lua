function npcsay(id)
  if id ~= 4300175 then
    return
  end
  clickNPCid = id
  NPC_SAY("国家的语言跟中国不同，所以无法沟通...")
  if qData[3769].state == 1 then
    NPC_SAY("我特意给你这个训民正音，一定要好好看看并使用。")
    SET_QUEST_STATE(3769, 2)
    return
  end
  if qData[3769].state == 0 then
    ADD_QUEST_BTN(qt[3769].id, qt[3769].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[3769].state ~= 2 then
    if qData[3769].state == 1 then
      QSTATE(id, 2)
    else
      QSTATE(id, 0)
    end
  end
end
