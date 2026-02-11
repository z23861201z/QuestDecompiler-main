function npcsay(id)
  if id ~= 4319002 then
    return
  end
  clickNPCid = id
  ADD_NEW_SHOP_BTN(id, 10064)
end
function chkQState(id)
  QSTATE(id, -1)
end
