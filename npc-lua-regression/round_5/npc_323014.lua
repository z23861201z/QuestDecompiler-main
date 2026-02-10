function npcsay(id)
  if id ~= 4323014 then
    return
  end
  NPC_SAY("听听。听听。这真是惊人的消息啊？")
  clickNPCid = id
end
function chkQState(id)
  QSTATE(id, -1)
end
