function npcsay(id)
  if id ~= 4300162 then
    return
  end
  clickNPCid = id
  NPC_SAY("请捐赠大目仔徽章完成铜像吧。")
  ADD_NEKOMARK_SOUVENIR_EVENT_GIVE(id)
  ADD_NEKOMARK_SOUVENIR_EVENT_SHOW(id)
end
function chkQState(id)
  QSTATE(id, -1)
end
