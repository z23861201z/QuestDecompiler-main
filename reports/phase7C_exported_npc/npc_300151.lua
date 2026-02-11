function npcsay(id)
  if id ~= 4300151 then
    return
  end
  clickNPCid = id
  NPC_SAY("捐给大目仔石像会有好事发生")
  ADD_11TH_ANNIVERSARY_SOUVENIR_EVENT_GIVE(id)
  ADD_11TH_ANNIVERSARY_SOUVENIR_EVENT_SHOW(id)
end
function chkQState(id)
  QSTATE(id, -1)
end
