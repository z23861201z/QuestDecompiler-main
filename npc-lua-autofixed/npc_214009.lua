function npcsay(id)
  if id ~= 4214009 then
    return
  end
  clickNPCid = id
  ADD_NEW_SHOP_BTN(id, 10056)
end
function chkQState(id)
  QSTATE(id, -1)
end
