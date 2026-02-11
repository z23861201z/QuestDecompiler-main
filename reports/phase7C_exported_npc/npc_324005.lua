function npcsay(id)
  if id ~= 4324005 then
    return
  end
  clickNPCid = id
  NPC_SAY("嗷呜..")
  if qData[1912].state == 1 then
    NPC_SAY("嗷呜..。（拥有强大力量的不祥的怪物正在威胁着受伤的老人）")
    SET_QUEST_STATE(1912, 2)
    return
  end
  if qData[1918].state == 1 then
    NPC_SAY("嗷呜..。（拥有强大力量的不祥的怪物正在威胁着受伤的老人）�")
    SET_QUEST_STATE(1918, 2)
    return
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[1912].state == 1 then
    QSTATE(id, 2)
  end
  if qData[1918].state == 1 then
    QSTATE(id, 2)
  end
end
