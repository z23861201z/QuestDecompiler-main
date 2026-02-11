function npcsay(id)
  if id ~= 4214008 then
    return
  end
  clickNPCid = id
  NPC_SAY("给熟人发请柬试试吧…")
  ADD_NEW_SHOP_BTN(id, 10050)
  ADD_BTN_WEDDING_GETOUT(id)
end
function chkQState(id)
  QSTATE(id, -1)
end
