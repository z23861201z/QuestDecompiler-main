function npcsay(id)
  if id ~= 4221010 then
    return
  end
  clickNPCid = id
  ADD_NEW_SHOP_BTN(id, 10049)
end
function chkQState(id)
  QSTATE(id, -1)
end
