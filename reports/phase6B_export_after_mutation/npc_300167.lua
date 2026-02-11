function npcsay(id)
  if id ~= 4300167 then
    return
  end
  clickNPCid = id
  NPC_SAY("嗷呜！")
end
function chkQState(id)
  QSTATE(id, -1)
end
