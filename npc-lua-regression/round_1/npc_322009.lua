function npcsay(id)
  if id ~= 4322009 then
    return
  end
  clickNPCid = id
  if qData[1054].state == 1 then
    if qData[1054].killMonster[qt[1054].goal.killMonster[1].id] >= qt[1054].goal.killMonster[1].count then
      NPC_SAY("很厉害啊，不过，没过多长时间怪物又会多起来的，下次也拜托你了！")
      SET_QUEST_STATE(1054, 2)
      return
    else
      NPC_SAY("{0xFFFFFF00}20个太极蜈蚣{END}还没击退完吗？你连太极蜈蚣都没办法击退吗？再努力看看吧！")
      return
    end
  end
  if qData[2327].state == 1 then
    NPC_SAY("咳咳...帮，帮帮我吧")
    SET_QUEST_STATE(2327, 2)
    return
  end
  if qData[2328].state == 1 then
    NPC_SAY("…(没有反应)")
  end
  if qData[2330].state == 1 and __QUEST_HAS_ALL_ITEMS(qt[2330].goal.getItem) then
    NPC_SAY("爷爷？初次见面")
    SET_QUEST_STATE(2330, 2)
  end
  if qData[2331].state == 1 then
    NPC_SAY("…(突然安静下来了)")
  end
  if qData[2332].state == 1 then
    NPC_SAY("谢谢，托你的福我活过来了！我告诉你新重林的情况吧。那里就是{0xFFFFFF00}[巨木重林中心]{END}。在{0xFFFFFF00}[巨木重林[4]]{END}找到了去往那里的路")
    SET_QUEST_STATE(2332, 2)
    return
  end
  if qData[2563].state == 1 then
    NPC_SAY("只能帮你这些了，不好意思")
    SET_QUEST_STATE(2563, 2)
    return
  end
  if qData[2791].state == 1 then
    NPC_SAY("突然有什么事吗？这个石板不会是！")
    SET_QUEST_STATE(2791, 2)
    return
  end
  if qData[2792].state == 1 then
    NPC_SAY("击退30个{0xFFFFFF00}太极蜈蚣{END}后去{0xFFFFFF00}吕林城{END}看看吧。肯定会有人知道的。")
  end
  if qData[2328].state == 0 and qData[2327].state == 2 and GET_PLAYER_LEVEL() >= qt[2328].needLevel then
    ADD_QUEST_BTN(qt[2328].id, qt[2328].name)
  end
  if qData[2331].state == 0 and qData[2330].state == 2 and GET_PLAYER_LEVEL() >= qt[2331].needLevel then
    ADD_QUEST_BTN(qt[2331].id, qt[2331].name)
  end
  if qData[2563].state == 0 and qData[2562].state == 2 and GET_PLAYER_LEVEL() >= qt[2563].needLevel then
    ADD_QUEST_BTN(qt[2563].id, qt[2563].name)
  end
  if qData[2792].state == 0 and qData[2791].state == 2 and GET_PLAYER_LEVEL() >= qt[2792].needLevel then
    ADD_QUEST_BTN(qt[2792].id, qt[2792].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[2327].state == 1 then
    QSTATE(id, 2)
  end
  if qData[2328].state ~= 2 and GET_PLAYER_LEVEL() >= qt[2328].needLevel then
    if qData[2328].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2330].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[2330].goal.getItem) then
      QSTATE(id, 2)
    else
      QSTATE(id, 1)
    end
  end
  if qData[2331].state ~= 2 and qData[2330].state == 2 and GET_PLAYER_LEVEL() >= qt[2331].needLevel then
    if qData[2331].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2332].state == 1 then
    QSTATE(id, 2)
  end
  if qData[2563].state ~= 2 and qData[2562].state == 2 and GET_PLAYER_LEVEL() >= qt[2563].needLevel then
    if qData[2563].state == 1 then
      QSTATE(id, 2)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2791].state == 1 and CHECK_ITEM_CNT(qt[2791].goal.getItem[1].id) >= qt[2791].goal.getItem[1].count and qData[2791].killMonster[qt[2791].goal.killMonster[1].id] >= qt[2791].goal.killMonster[1].count then
    QSTATE(id, 2)
  end
  if qData[2792].state ~= 2 and qData[2791].state == 2 and GET_PLAYER_LEVEL() >= qt[2792].needLevel then
    if qData[2792].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
end
