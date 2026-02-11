function npcsay(id)
  if id ~= 4300161 then
    return
  end
  clickNPCid = id
  NPC_SAY("捐赠7周年孔明灯完成7周年铜像吧。")
  ADD_14THANIVERSARY_SOUVENIR_EVENT_GIVE(id)
  ADD_14THANIVERSARY_SOUVENIR_EVENT_SHOW(id)
end
function chkQState(id)
  QSTATE(id, -1)
end
