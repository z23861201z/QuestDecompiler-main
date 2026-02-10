function npcsay(id)
  if id ~= 4391911 then
    return
  end
  clickNPCid = id
  ADD_NPC_WARP_INDUN(id)
  ADD_NPC_WARP_INDUN_GHOST(id)
end
function chkQState(id)
  QSTATE(id, -1)
end
