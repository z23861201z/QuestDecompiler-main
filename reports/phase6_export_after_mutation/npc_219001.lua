function npcsay(id)
  if id ~= 4219001 then
    return
  end
  clickNPCid = id
  ADD_NEW_SHOP_BTN(id, 10038)
end
function chkQState(id)
  QSTATE(id, -1)
end
