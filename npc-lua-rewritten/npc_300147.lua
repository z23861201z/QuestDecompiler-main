function npcsay(id)
  if id ~= 4300147 then
    return
  end
  clickNPCid = id
  NPC_SAY("只有大目仔和粉目仔可以去大目仔村")
  NPC_WARP_NEKOISLAND_ENTER(id)
end
function chkQState(id)
  QSTATE(id, -1)
end
