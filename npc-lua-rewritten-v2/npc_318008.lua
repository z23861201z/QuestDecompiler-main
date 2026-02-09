function npcsay(id)
  if id ~= 4318008 then
    return
  end
  clickNPCid = id
  ADD_EQUIP_DELIVERY(id)
  ADD_EQUIP_DELIVERY_CURRENT(id)
  if qData[944].state == 0 then
    ADD_QUEST_BTN(qt[944].id, qt[944].name)
  end
  if qData[945].state == 0 then
    ADD_QUEST_BTN(qt[945].id, qt[945].name)
  end
  if qData[946].state == 0 then
    ADD_QUEST_BTN(qt[946].id, qt[946].name)
  end
  if qData[947].state == 0 then
    ADD_QUEST_BTN(qt[947].id, qt[947].name)
  end
  if qData[948].state == 0 then
    ADD_QUEST_BTN(qt[948].id, qt[948].name)
  end
  if qData[949].state == 0 then
    ADD_QUEST_BTN(qt[949].id, qt[949].name)
  end
  if qData[950].state == 0 then
    ADD_QUEST_BTN(qt[950].id, qt[950].name)
  end
  if qData[951].state == 0 then
    ADD_QUEST_BTN(qt[951].id, qt[951].name)
  end
  if qData[952].state == 0 then
    ADD_QUEST_BTN(qt[952].id, qt[952].name)
  end
  if qData[1045].state == 2 and qData[1046].state == 0 then
    ADD_QUEST_BTN(qt[1046].id, qt[1046].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
end
