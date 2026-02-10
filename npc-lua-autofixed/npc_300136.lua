function npcsay(id)
  if id ~= 4300136 then
    return
  end
  clickNPCid = id
  NPC_SAY("–¡ø‡¡À.")
  BTN_SNOWMAN_OUT(id)
end
function chkQState(id)
  QSTATE(id, -1)
end
