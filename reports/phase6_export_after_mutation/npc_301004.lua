function npcsay(id)
  if id ~= 4301004 then
    return
  end
  clickNPCid = id
  NPC_SAY("好饿啊~谁要是能给我鱼就好了~")
end
function chkQState(id)
  QSTATE(id, -1)
end
