function npcsay(id)
  if id ~= 4314053 then
    return
  end
  clickNPCid = id
  NPC_SAY("做好参加天下第一比武大会的准备了吗？")
  ADD_TOURNAMENT_BTN(id)
  ADD_RETURN_WARP_BTN(id)
  if qData[942].state == 0 then
    ADD_QUEST_BTN(qt[942].id, qt[942].name)
  end
  if qData[943].state == 0 then
    ADD_QUEST_BTN(qt[943].id, qt[943].name)
  end
end
function chkQState(id)
  QSTATE(id, false)
end
