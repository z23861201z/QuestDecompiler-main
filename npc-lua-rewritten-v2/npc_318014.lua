function npcsay(id)
  if id ~= 4318014 then
    return
  end
  clickNPCid = id
  ADD_NPC_WARP_CHUNGYAKANG(id)
end
function chkQState(id)
  QSTATE(id, -1)
end
