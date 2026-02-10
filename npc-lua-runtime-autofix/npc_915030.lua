function npcsay(id)
  if id ~= 4915030 then
    return
  end
  clickNPCid = id
  if qData[144].state == 1 and qData[144].meetNpc[1] ~= qt[144].goal.meetNpc[1] then
    if 1 <= CHECK_INVENTORY_CNT(4) then
      NPC_SAY("{0xFFFFFF00}??{END}? ?????.")
      SET_MEETNPC(144, 1, id)
    else
      NPC_SAY("ÐÐÄÒÌ«³Á¡£")
    end
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[144].state == 1 and GET_PLAYER_LEVEL() >= qt[144].needLevel then
    QSTATE(id, 1)
  end
end
