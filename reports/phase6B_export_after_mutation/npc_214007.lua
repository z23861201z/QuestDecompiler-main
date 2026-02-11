function npcsay(id)
  if id ~= 4214007 then
    return
  end
  clickNPCid = id
  ADD_QUEST_BTN(qt[932].id, qt[932].name)
  ADD_QUEST_BTN(qt[933].id, qt[933].name)
  ADD_QUEST_BTN(qt[934].id, qt[934].name)
  ADD_QUEST_BTN(qt[935].id, qt[935].name)
  ADD_QUEST_BTN(qt[936].id, qt[936].name)
  ADD_CHANGE_SEANCECARD_BTN(id)
end
function chkQState(id)
  QSTATE(id, -1)
end
