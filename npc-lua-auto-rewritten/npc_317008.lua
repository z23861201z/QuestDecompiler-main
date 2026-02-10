function npcsay(id)
  if id ~= 4317008 then
    return
  end
  clickNPCid = id
  ADD_NPC_WARP_CHUNGYAKANG(id)
end
function chkQState(id)
  QSTATE(id, -1)
end
