function npcsay(id)
  if id ~= 4321008 then
    return
  end
  clickNPCid = id
  NPC_SAY("要找回记忆需要钱。")
  LearnSkill(id)
  if qData[1465].state == 1 then
    NPC_SAY("记忆治疗？当然可以~只要有钱的话...")
    SET_QUEST_STATE(1465, 2)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[1465].state == 1 then
    QSTATE(id, 2)
  end
end
