function npcsay(id)
  if id ~= 4314032 then
    return
  end
  clickNPCid = id
  if qData[483].state == 1 and qData[483].meetNpc[1] == qt[483].goal.meetNpc[1] then
    if qData[483].meetNpc[2] ~= qt[483].goal.meetNpc[2] then
      SET_INFO(483, 2)
      SET_MEETNPC(483, 2, id)
      NPC_QSAY(483, 7)
      return
    else
      NPC_SAY("?? ??? ?? ??? ??? ??? ?? ? ???? ????.")
    end
  end
  if 0 < GET_PLAYER_JOB2() then
    LearnSkill(id)
  end
end
function chkQState(id)
  QSTATE(id, -1)
end
