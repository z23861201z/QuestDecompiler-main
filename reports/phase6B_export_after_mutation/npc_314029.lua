function npcsay(id)
  if id ~= 4314029 then
    return
  end
  clickNPCid = id
  NPC_SAY("我是{0xFFFFFF00}进行派系战的五行禅师{END}。有什么需要的吗？")
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
