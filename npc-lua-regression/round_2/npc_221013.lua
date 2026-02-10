function npcsay(id)
  if id ~= 4221013 then
    return
  end
  clickNPCid = id
  ADD_NEW_SHOP_BTN(id, 10047)
  GIVE_DONATION_BUFF(id)
end
function chkQState(id)
  QSTATE(id, -1)
end
