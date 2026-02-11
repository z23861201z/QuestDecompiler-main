function npcsay(id)
  if id ~= 4241005 then
    return
  end
  clickNPCid = id
  NPC_SAY("交给我的东西，我一定会保管好。")
  ADD_STORE_BTN(id)
  ADD_EVENT_BTN_JEWEL(id)
  GIVE_DONATION_ITEM(id)
  ADD_PARCEL_SERVICE_BTN(id)
end
function chkQState(id)
  QSTATE(id, -1)
end
