function npcsay(id)
  if id ~= 4218003 then
    return
  end
  clickNPCid = id
  ADD_NEW_SHOP_BTN(id, 10024)
end
function chkQState(id)
  QSTATE(id, -1)
end
