function npcsay(id)
  if id ~= 4391041 then
    return
  end
  clickNPCid = id
  ADD_NPC_WARP_INDUN(id)
end
function chkQState(id)
  QSTATE(id, -1)
end
