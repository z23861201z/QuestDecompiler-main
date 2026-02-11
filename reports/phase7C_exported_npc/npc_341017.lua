function npcsay(id)
  if id ~= 4341017 then
    return
  end
  clickNPCid = id
  NPC_SAY("肚子好饿啊…")
end
function chkQState(id)
  QSTATE(id, -1)
end
