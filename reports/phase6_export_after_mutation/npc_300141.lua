function npcsay(id)
  if id ~= 4300141 then
    return
  end
  clickNPCid = id
  NPC_SAY("我现在也是成年人了..有太多的事情想要去做")
end
function chkQState(id)
  QSTATE(id, -1)
end
