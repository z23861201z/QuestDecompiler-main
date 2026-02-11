function npcsay(id)
  if id ~= 4200001 then
    return
  end
  clickNPCid = id
  NPC_SAY("我是辅佐天子的皇宫管理员之一，叫天雪。除此之外没有什么可告知的。")
  if qData[1326].state == 1 then
    NPC_SAY("欢迎光临。我早就听说PLAYERNAME了。能见到您我等待的再久也有价值。以后正义就靠您了。")
    SET_QUEST_STATE(1326, 2)
  end
  if qData[1327].state == 1 then
    NPC_SAY("欢迎光临。我早就听说PLAYERNAME了。能见到您我等待的再久也有价值。以后正义就靠您了。")
    SET_QUEST_STATE(1327, 2)
  end
  if qData[1328].state == 1 then
    NPC_SAY("欢迎光临。我早就听说PLAYERNAME了。能见到您我等待的再久也有价值。以后正义就靠您了。")
    SET_QUEST_STATE(1328, 2)
  end
  if qData[1329].state == 1 then
    NPC_SAY("欢迎光临。我早就听说PLAYERNAME了。能见到您我等待的再久也有价值。以后正义就靠您了。")
    SET_QUEST_STATE(1329, 2)
  end
  if qData[1330].state == 1 then
    NPC_SAY("欢迎光临。我早就听说PLAYERNAME了。能见到您我等待的再久也有价值。以后正义就靠您了。")
    SET_QUEST_STATE(1330, 2)
  end
  if qData[2085].state == 1 then
    NPC_SAY("欢迎光临。我早就听说PLAYERNAME了。能见到您我等待的再久也有价值。以后正义就靠您了。")
    SET_QUEST_STATE(2085, 2)
  end
  if qData[1331].state == 1 then
    NPC_SAY("欢迎光临。我早就听说PLAYERNAME了。能见到您我等待的再久也有价值。以后正义就靠您了。")
    SET_QUEST_STATE(1331, 2)
  end
  if qData[1332].state == 1 then
    NPC_SAY("欢迎光临。我早就听说PLAYERNAME了。能见到您我等待的再久也有价值。以后正义就靠您了。")
    SET_QUEST_STATE(1332, 2)
  end
  if qData[1333].state == 1 then
    NPC_SAY("欢迎光临。我早就听说PLAYERNAME了。能见到您我等待的再久也有价值。以后正义就靠您了。")
    SET_QUEST_STATE(1333, 2)
  end
  if qData[1334].state == 1 then
    NPC_SAY("欢迎光临。我早就听说PLAYERNAME了。能见到您我等待的再久也有价值。以后正义就靠您了。")
    SET_QUEST_STATE(1334, 2)
  end
  if qData[1335].state == 1 then
    NPC_SAY("欢迎光临。我早就听说PLAYERNAME了。能见到您我等待的再久也有价值。以后正义就靠您了。")
    SET_QUEST_STATE(1335, 2)
  end
  if qData[2089].state == 1 then
    NPC_SAY("欢迎光临。我早就听说PLAYERNAME了。能见到您我等待的再久也有价值。以后正义就靠您了。")
    SET_QUEST_STATE(2089, 2)
  end
  if qData[2069].state == 1 then
    SET_QUEST_STATE(2069, 2)
    NPC_SAY("天啊~是那位提到过的PLAYERNAME啊！我准备了证明，趁别人还没看到之前赶紧收下吧~")
  end
  if qData[2070].state == 1 then
    NPC_SAY("既然是他的仆人，说不知道也说不过去啊？快点告诉我吧~你等等，你别跑啊！ (快点回到西米路处吧)")
  end
  ADD_NEW_SHOP_BTN(id, 10058)
  ADD_QUEST_BTN(qt[966].id, qt[966].name)
  ADD_QUEST_BTN(qt[967].id, qt[967].name)
  ADD_QUEST_BTN(qt[968].id, qt[968].name)
  ADD_QUEST_BTN(qt[969].id, qt[969].name)
  if qData[2070].state == 0 and qData[2069].state == 2 and GET_PLAYER_JOB1() == 11 then
    ADD_QUEST_BTN(qt[2070].id, qt[2070].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[1326].state == 1 or qData[1327].state == 1 or qData[1328].state == 1 or qData[1329].state == 1 or qData[1330].state == 1 or qData[2085].state == 1 then
    QSTATE(id, 2)
  end
  if qData[1331].state == 1 or qData[1332].state == 1 or qData[1333].state == 1 or qData[1334].state == 1 or qData[1335].state == 1 or qData[2089].state == 1 then
    QSTATE(id, 2)
  end
  if qData[2069].state == 1 then
    QSTATE(id, 2)
  end
  if qData[2070].state ~= 2 and qData[2069].state == 2 and GET_PLAYER_LEVEL() >= qt[2070].needLevel and GET_PLAYER_JOB1() == 11 then
    if qData[2070].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
end
