function npcsay(id)
  if id ~= 4300142 then
    return
  end
  clickNPCid = id
  NPC_SAY("这个双亲节我想制作大的纸康乃馨")
end
function chkQState(id)
  QSTATE(id, -1)
end
