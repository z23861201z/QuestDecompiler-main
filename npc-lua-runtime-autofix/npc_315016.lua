function npcsay(id)
  if id ~= 4315016 then
    return
  end
  clickNPCid = id
  if qData[143].state == 1 then
    NPC_SAY("{0xFFFFFF00}[?????]{END}? ??? ??? ????.")
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[143].state ~= 2 and GET_PLAYER_LEVEL() >= qt[143].needLevel then
    if qData[143].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
end
