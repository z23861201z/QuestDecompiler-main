function npcsay(id)
  if id ~= 4213007 then
    return
  end
  clickNPCid = id
  ADD_NEW_SHOP_BTN(id, 10028)
end
function chkQState(id)
  QSTATE(id, -1)
end
