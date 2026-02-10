function npcsay(id)
  if id ~= 4216005 then
    return
  end
  clickNPCid = id
  NPC_SAY("欢迎光临。信誉保证任何物品都会安全帮您保管。")
  ADD_STORE_BTN(id)
  GIVE_DONATION_ITEM(id)
  ADD_PARCEL_SERVICE_BTN(id)
end
function chkQState(id)
  QSTATE(id, -1)
end
