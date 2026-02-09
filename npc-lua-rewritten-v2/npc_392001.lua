function npcsay(id)
  if id ~= 4392001 then
    return
  end
  clickNPCid = id
  NPC_SAY("做好参加服务器最强者战的准备了吗？")
  ADD_TOURNAMENT_ENTRY_BTN(id)
  ADD_RETURN_WARP_BTN(id)
  if qData[965].state == 0 then
    ADD_QUEST_BTN(qt[965].id, qt[965].name)
  end
  if qData[943].state == 0 then
    ADD_QUEST_BTN(qt[943].id, qt[943].name)
  end
end
function chkQState(id)
  QSTATE(id, false)
end
