function npcsay(id)
  if id ~= 4240007 then
    return
  end
  NPC_SAY("在此可以购买PVP过程中使用的恢复药水。")
  clickNPCid = id
  ADD_NEW_SHOP_BTN(id, 10074)
end
function chkQState(id)
  QSTATE(id, -1)
end
