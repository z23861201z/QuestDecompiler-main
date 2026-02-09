function npcsay(id)
  if id ~= 4221014 then
    return
  end
  clickNPCid = id
  ADD_STORE_BTN(id)
  GIVE_DONATION_ITEM(id)
  ADD_PARCEL_SERVICE_BTN(id)
  ADD_NEW_SHOP_BTN(id, 10080)
end
function chkQState(id)
  QSTATE(id, -1)
end
