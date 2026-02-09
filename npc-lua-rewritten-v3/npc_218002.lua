function npcsay(id)
  if id ~= 4218002 then
    return
  end
  clickNPCid = id
  ADD_NEW_SHOP_BTN(id, 10023)
  ADD_MOVESOUL_BTN(id)
  ADD_PURIFICATION_BTN(id)
end
function chkQState(id)
  QSTATE(id, -1)
end
