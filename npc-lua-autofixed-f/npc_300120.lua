function npcsay(id)
  if id ~= 4300120 then
    return
  end
  clickNPCid = id
  ADD_TREE_EVENT(id)
  ADD_TREE_EVENT_SHOW(id)
end
function chkQState(id)
  QSTATE(id, -1)
end
