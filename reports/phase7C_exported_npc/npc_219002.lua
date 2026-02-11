function npcsay(id)
  if id ~= 4219002 then
    return
  end
  clickNPCid = id
  ADD_NEW_SHOP_BTN(id, 10037)
end
function chkQState(id)
  QSTATE(id, -1)
end
