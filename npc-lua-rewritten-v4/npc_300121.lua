function npcsay(id)
  if id ~= 4300121 then
    return
  end
  clickNPCid = id
  ADD_TOMBSTONE_EVENT(id)
  ADD_TOMBSTONE_EVENT_SHOW(id)
end
function chkQState(id)
  QSTATE(id, -1)
end
