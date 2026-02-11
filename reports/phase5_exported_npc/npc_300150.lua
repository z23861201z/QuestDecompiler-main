function npcsay(id)
  if id ~= 4300150 then
    return
  end
  clickNPCid = id
  NPC_SAY("捐给3周年石像会有好事发生")
  ADD_10TH_ANNIVERSARY_CAKEDECO_EVENT_GIVE(id)
  ADD_10TH_ANNIVERSARY_CAKEDECO_EVENT_SHOW(id)
end
function chkQState(id)
  QSTATE(id, -1)
end
