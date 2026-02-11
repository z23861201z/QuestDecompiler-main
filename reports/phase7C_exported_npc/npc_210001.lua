function npcsay(id)
  if id ~= 4210001 then
    return
  end
  clickNPCid = id
  ADD_NEW_SHOP_BTN(id, 10041)
  if qData[918].state == 0 then
    ADD_QUEST_BTN(qt[918].id, qt[918].name)
  end
  if qData[919].state == 0 then
    ADD_QUEST_BTN(qt[919].id, qt[919].name)
  end
  if qData[920].state == 0 then
    ADD_QUEST_BTN(qt[920].id, qt[920].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
end
