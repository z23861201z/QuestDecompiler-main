function npcsay(id)
  if id ~= 4314033 then
    return
  end
  clickNPCid = id
  if 0 < GET_PLAYER_JOB2() then
    LearnSkill(id)
  end
end
function chkQState(id)
  QSTATE(id, -1)
end
