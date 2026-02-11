function npcsay(id)
  if id ~= 4341015 then
    return
  end
  clickNPCid = id
  NPC_SAY("想把这个孩子养的阳光一点。")
end
function chkQState(id)
  QSTATE(id, -1)
end
