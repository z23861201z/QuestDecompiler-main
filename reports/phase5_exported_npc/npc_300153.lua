function npcsay(id)
  if id ~= 4300153 then
    return
  end
  clickNPCid = id
  NPC_SAY("捐赠莲花点亮莲灯吧。")
  ADD_NELUMBO_SOUVENIR_EVENT_GIVE(id)
  ADD_NELUMBO_SOUVENIR_EVENT_SHOW(id)
end
function chkQState(id)
  QSTATE(id, -1)
end
