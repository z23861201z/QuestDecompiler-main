function npcsay(id)
  if id ~= 4300154 then
    return
  end
  clickNPCid = id
  NPC_SAY("请捐赠12周年纪念品，完成12周年铜像。")
  ADD_12THANIVERSARY_SOUVENIR_EVENT_GIVE(id)
  ADD_12THANIVERSARY_SOUVENIR_EVENT_SHOW(id)
end
function chkQState(id)
  QSTATE(id, -1)
end
