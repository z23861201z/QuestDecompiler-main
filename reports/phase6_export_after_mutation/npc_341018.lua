function npcsay(id)
  if id ~= 4341018 then
    return
  end
  clickNPCid = id
  NPC_SAY("已经没有配给了吗？")
end
function chkQState(id)
  QSTATE(id, -1)
end
