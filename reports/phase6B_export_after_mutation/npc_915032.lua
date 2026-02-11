function npcsay(id)
  if id ~= 4915032 then
    return
  end
  clickNPCid = id
  if qData[243].state == 1 and qData[241].state == 2 and qData[242].state == 1 and qData[243].meetNpc[1] ~= qt[243].goal.meetNpc[1] then
    if 1 <= CHECK_INVENTORY_CNT(4) then
      NPC_SAY("{0xFFFFFF00}???{END}? ?????.")
      SET_MEETNPC(243, 1, id)
      return
    else
      NPC_SAY("行囊太沉。")
    end
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[243].state == 1 and GET_PLAYER_LEVEL() >= qt[243].needLevel then
    if qData[243].meetNpc[1] ~= qt[243].goal.meetNpc[1] then
      QSTATE(id, 2)
    else
      QSTATE(id, 1)
    end
  end
end
