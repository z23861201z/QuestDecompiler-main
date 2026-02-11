function npcsay(id)
  if id ~= 4218009 then
    return
  end
  clickNPCid = id
  NPC_SAY("韩野城怪物横行，人们都避难去了。相信高一燕会召集人重新夺回韩野城的。")
  ADD_NEW_SHOP_BTN(id, 10040)
  if qData[921].state == 0 then
    ADD_QUEST_BTN(qt[921].id, qt[921].name)
  end
  if qData[922].state == 0 then
    ADD_QUEST_BTN(qt[922].id, qt[922].name)
  end
  if qData[923].state == 0 then
    ADD_QUEST_BTN(qt[923].id, qt[923].name)
  end
  if qData[924].state == 0 then
    ADD_QUEST_BTN(qt[924].id, qt[924].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
end
