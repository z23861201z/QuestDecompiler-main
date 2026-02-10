function npcsay(id)
  if id ~= 4300129 then
    return
  end
  clickNPCid = id
  ADD_NEW_SHOP_BTN(id, 10071)
end
function chkQState(id)
  QSTATE(id, -1)
end
