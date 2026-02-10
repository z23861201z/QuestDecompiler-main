function npcsay(id)
  if id ~= 4323011 then
    return
  end
  NPC_SAY("哇啊！真好。真的，真的很高兴吧！")
  clickNPCid = id
end
function chkQState(id)
  QSTATE(id, -1)
end
