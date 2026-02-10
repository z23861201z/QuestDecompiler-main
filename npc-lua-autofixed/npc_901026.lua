function npcsay(id)
  if id ~= 4901026 then
    return
  end
  clickNPCid = id
  if qData[106].state == 1 then
    if qData[106].meetNpc[1] ~= qt[106].goal.meetNpc[1] then
      SET_INFO(106, 1)
      NPC_QSAY(106, 1)
      SET_MEETNPC(106, 1, id)
    else
      NPC_SAY("{0xFFFFFF00}[??]? ??{END}? ???? ???. {0xFFFFFF00}10?{END}? ? ?????")
    end
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[106].state == 1 and GET_PLAYER_LEVEL() >= qt[106].needLevel then
    QSTATE(id, 1)
  end
end
