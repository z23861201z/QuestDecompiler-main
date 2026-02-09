function npcsay(id)
  if id ~= 4300146 then
    return
  end
  clickNPCid = id
  NPC_SAY("想去清阴镖局的时候告诉我吧.")
  NPC_WARP_NEKOISLAND_EXIT(id)
end
function chkQState(id)
  QSTATE(id, -1)
end
