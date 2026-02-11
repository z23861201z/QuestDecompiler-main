function npcsay(id)
  if id ~= 4240006 then
    return
  end
  NPC_SAY("在此可以购买门派大战中使用的恢复药水")
  clickNPCid = id
  ADD_NEW_SHOP_BTN(id, 10073)
  ADD_NPC_WARP_PVPLEAGUE_OUT(id)
end
function chkQState(id)
  QSTATE(id, -1)
end
