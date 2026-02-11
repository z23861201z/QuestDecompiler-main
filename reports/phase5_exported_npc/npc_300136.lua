function npcsay(id)
  if id ~= 4300136 then
    return
  end
  clickNPCid = id
  NPC_SAY("辛苦了.")
  BTN_SNOWMAN_OUT(id)
end
function chkQState(id)
  QSTATE(id, -1)
end
