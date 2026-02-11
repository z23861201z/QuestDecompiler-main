function npcsay(id)
  if id ~= 4300172 then
    return
  end
  clickNPCid = id
  NPC_SAY("捐赠9周年奖杯完成9周年大型奖杯吧。")
  ADD_16THANIVERSARY_SOUVENIR_EVENT_GIVE(id)
  ADD_16THANIVERSARY_SOUVENIR_EVENT_SHOW(id)
end
function chkQState(id)
  QSTATE(id, -1)
end
