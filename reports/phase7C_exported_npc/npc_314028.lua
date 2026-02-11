function npcsay(id)
  if id ~= 4314028 then
    return
  end
  clickNPCid = id
  if FACTION_ON_OFF() >= 1 then
    SHOW_FACTION_LIST_1(id)
  end
  if FACTION_ON_OFF() == 2 or FACTION_ON_OFF() == 21 or FACTION_ON_OFF() == 22 or FACTION_ON_OFF() == 23 or FACTION_ON_OFF() == 3 or FACTION_ON_OFF() == 31 then
    FACTIONWAR_IN(id)
    FACTIONWRR_SHOW(id)
  elseif FACTION_ON_OFF() >= 4 and FACTION_ON_OFF() < 6 then
    FACTIONWRR_SHOW(id)
  end
end
function chkQState(id)
  QSTATE(id, -1)
end
