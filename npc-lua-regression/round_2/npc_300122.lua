function npcsay(id)
  if id ~= 4300122 then
    return
  end
  clickNPCid = id
  ADD_PVPWINNER_EVENT(id)
  ADD_PVPWINNER_EVENT_SHOW(id)
end
function chkQState(id)
  QSTATE(id, -1)
end
