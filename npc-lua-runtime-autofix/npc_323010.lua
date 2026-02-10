function npcsay(id)
  if id ~= 4323010 then
    return
  end
  NPC_SAY("零食今天也到手了！")
  clickNPCid = id
end
function chkQState(id)
  QSTATE(id, -1)
end
