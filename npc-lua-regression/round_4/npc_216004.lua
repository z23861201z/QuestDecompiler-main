function npcsay(id)
  if id ~= 4216004 then
    return
  end
  clickNPCid = id
  ADD_NEW_SHOP_BTN(id, 10021)
end
function chkQState(id)
  QSTATE(id, -1)
end
