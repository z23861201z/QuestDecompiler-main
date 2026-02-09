function npcsay(id)
  if id ~= 4218005 then
    return
  end
  clickNPCid = id
  ADD_STORE_BTN(id)
  ADD_SOULALCOHOL_CHANGE_BTN(id)
  ADD_PARCEL_SERVICE_BTN(id)
end
function chkQState(id)
  QSTATE(id, -1)
end
