function npcsay(id)
  if id ~= 4214012 then
    return
  end
  clickNPCid = id
  NPC_SAY("试着换一下发型吧~也可以进行眼形整容和皮肤美容")
  ADD_BEAUTYSHOP_BTN(id)
end
function chkQState(id)
  QSTATE(id, -1)
end
