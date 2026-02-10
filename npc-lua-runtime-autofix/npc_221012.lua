function npcsay(id)
  if id ~= 4221012 then
    return
  end
  clickNPCid = id
  ADD_NEW_SHOP_BTN(id, 10046)
  GIHON_MIXTURE(id)
end
function chkQState(id)
  QSTATE(id, -1)
end
