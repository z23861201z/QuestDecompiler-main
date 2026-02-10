function npcsay(id)
  if id ~= 4318027 then
    return
  end
  clickNPCid = id
  ADD_WARP_YANGTEMPLE(id)
end
function chkQState(id)
  QSTATE(id, -1)
end
