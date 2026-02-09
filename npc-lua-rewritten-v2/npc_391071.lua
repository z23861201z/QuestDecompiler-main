function npcsay(id)
  if id ~= 4391071 then
    return
  end
  clickNPCid = id
  ADD_NPC_WARP_INDUN2(id)
end
function chkQState(id)
  QSTATE(id, false)
end
