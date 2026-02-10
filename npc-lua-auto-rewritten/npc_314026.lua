function npcsay(id)
  if id ~= 4314026 then
    return
  end
  clickNPCid = id
  if EVENT_OX_STATE() == 1 then
    EVENT_OX_QUIZ(id)
  end
end
function chkQState(id)
  QSTATE(id, -1)
end
