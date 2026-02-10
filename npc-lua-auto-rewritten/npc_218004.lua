function npcsay(id)
  if id ~= 4218004 then
    return
  end
  clickNPCid = id
  ADD_NEW_SHOP_BTN(id, 10025)
  GIHON_ENDOWMENT(id)
  GIHON_STRENGTHENING(id)
end
function chkQState(id)
  QSTATE(id, -1)
end
