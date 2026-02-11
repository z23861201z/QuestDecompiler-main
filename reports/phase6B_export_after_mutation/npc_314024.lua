function npcsay(id)
  if id ~= 4314024 then
    return
  end
  clickNPCid = id
  ADD_NEW_SHOP_BTN(id, 10079)
  ADD_NPC_TOOHO(id)
end
function chkQState(id)
  QSTATE(id, -1)
end
