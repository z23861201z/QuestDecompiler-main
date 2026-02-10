function npcsay(id)
  if id ~= 4221001 then
    return
  end
  clickNPCid = id
  NPC_SAY("这里是仙游谷的边防地区，可以去往遥远的西域的天柱。现在因为怪物们的邪恶之气不能去西域，仙游谷充斥着毒雾，只有拥有很强的力量的人才可以服用清明丹之后进入。")
  ADD_NEW_SHOP_BTN(id, 10044)
  NPC_WARP_SUNYOOGOK(id)
  NPC_WARP_THEME_52_19(id)
  if qData[937].state == 0 then
    ADD_QUEST_BTN(qt[937].id, qt[937].name)
  end
  if qData[938].state == 0 then
    ADD_QUEST_BTN(qt[938].id, qt[938].name)
  end
  if qData[939].state == 0 then
    ADD_QUEST_BTN(qt[939].id, qt[939].name)
  end
  if qData[940].state == 0 then
    ADD_QUEST_BTN(qt[940].id, qt[940].name)
  end
  if qData[941].state == 0 then
    ADD_QUEST_BTN(qt[941].id, qt[941].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
end
