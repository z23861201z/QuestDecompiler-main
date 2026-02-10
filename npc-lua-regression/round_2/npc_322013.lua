function npcsay(id)
  if id ~= 4322013 then
    return
  end
  clickNPCid = id
  NPC_SAY("")
  if qData[2670].state == 1 and qData[2670].killMonster[qt[2670].goal.killMonster[1].id] >= qt[2670].goal.killMonster[1].count then
    NPC_SAY("额？师傅…？")
    SET_QUEST_STATE(2670, 2)
    return
  end
  if qData[2671].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[2671].goal.getItem) then
      NPC_SAY("这么快！")
      SET_QUEST_STATE(2671, 2)
      return
    else
      NPC_SAY("因为我的失误，秋叨鱼才…快去{0xFFFFFF00}巨木重林{END}收集50个{0xFFFFFF00}八脚魔怪的蜘蛛网{END}回来吧。")
    end
  end
  if qData[2672].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[2672].goal.getItem) then
      NPC_SAY("好的，我现在就处理太极蜈蚣的触须。")
      SET_QUEST_STATE(2672, 2)
      return
    else
      NPC_SAY("在{0xFFFFFF00}巨木重林{END}击退{0xFFFFFF00}太极蜈蚣{END}，收集回来50个{0xFFFFFF00}太极蜈蚣的触须{END}吧。")
    end
  end
  if qData[2673].state == 1 then
    if CHECK_ITEM_CNT(qt[2673].goal.getItem[1].id) >= qt[2673].goal.getItem[1].count and CHECK_ITEM_CNT(qt[2673].goal.getItem[2].id) >= qt[2673].goal.getItem[2].count then
      NPC_SAY("正等你呢，再等会儿就好。")
      SET_QUEST_STATE(2673, 2)
      return
    else
      NPC_SAY("秋叨鱼，请在坚持一下。{0xFFFFFF00}僵硬的跳蚤{END}和{0xFFFFFF00}临浦怪的独角{END}各收集50个就行。可以在{0xFFFFFF00}干涸的沼泽{END}收集。")
    end
  end
  if qData[2674].state == 1 then
    NPC_SAY("秋叨鱼，对不起了。")
  end
  if qData[2689].state == 1 and qData[2689].killMonster[qt[2689].goal.killMonster[1].id] >= qt[2689].goal.killMonster[1].count then
    NPC_SAY("好久不见。秋叨鱼还好吗？")
    SET_QUEST_STATE(2689, 2)
    return
  end
  if qData[2690].state == 1 then
    NPC_SAY("{0xFFFFFF00}临浦怪{END}在{0xFFFFFF00}干涸的沼泽{END}出没。{0xFFFFFF00}竹统泛{END}师兄在{0xFFFFFF00}血魔深窟结界{END}。")
  end
  if qData[2691].state == 1 and qData[2691].killMonster[qt[2691].goal.killMonster[1].id] >= qt[2691].goal.killMonster[1].count then
    NPC_SAY("现在出了什么事了吗？")
    SET_QUEST_STATE(2691, 2)
    return
  end
  if qData[2692].state == 1 then
    if qData[2692].killMonster[qt[2692].goal.killMonster[1].id] >= qt[2692].goal.killMonster[1].count then
      NPC_SAY("呼，危机暂时解除了。你再去竹统泛处看看吧。")
      SET_QUEST_STATE(2692, 2)
      return
    else
      NPC_SAY("超火车轮怪的逆袭！这样不行，你快去击退{0xFFFFFF00}破戒僧{END}吧。")
    end
  end
  if qData[2693].state == 1 then
    NPC_SAY("这里的危机已经解除了。为了以后的对策，将这里的情况告诉竹统泛师兄吧。")
  end
  if qData[2702].state == 1 then
    NPC_SAY("{0xFF99ff99}PLAYERNAME{END}！")
    SET_QUEST_STATE(2702, 2)
    return
  end
  if qData[2703].state == 1 then
    NPC_SAY("那{0xFF99ff99}PLAYERNAME{END}击退50个{0xFFFFFF00}志鬼心火{END} 后，立刻去见 {0xFFFFFF00}竹统泛{END}吧！")
  end
  if qData[2671].state == 0 and qData[2670].state == 2 and GET_PLAYER_LEVEL() >= qt[2671].needLevel then
    ADD_QUEST_BTN(qt[2671].id, qt[2671].name)
  end
  if qData[2672].state == 0 and qData[2671].state == 2 and GET_PLAYER_LEVEL() >= qt[2672].needLevel then
    ADD_QUEST_BTN(qt[2672].id, qt[2672].name)
  end
  if qData[2673].state == 0 and qData[2672].state == 2 and GET_PLAYER_LEVEL() >= qt[2673].needLevel then
    ADD_QUEST_BTN(qt[2673].id, qt[2673].name)
  end
  if qData[2674].state == 0 and qData[2673].state == 2 and GET_PLAYER_LEVEL() >= qt[2674].needLevel then
    ADD_QUEST_BTN(qt[2674].id, qt[2674].name)
  end
  if qData[2690].state == 0 and qData[2689].state == 2 and GET_PLAYER_LEVEL() >= qt[2690].needLevel then
    ADD_QUEST_BTN(qt[2690].id, qt[2690].name)
  end
  if qData[2692].state == 0 and qData[2691].state == 2 and GET_PLAYER_LEVEL() >= qt[2692].needLevel then
    ADD_QUEST_BTN(qt[2692].id, qt[2692].name)
  end
  if qData[2693].state == 0 and qData[2692].state == 2 and GET_PLAYER_LEVEL() >= qt[2693].needLevel then
    ADD_QUEST_BTN(qt[2693].id, qt[2693].name)
  end
  if qData[2703].state == 0 and qData[2702].state == 2 and GET_PLAYER_LEVEL() >= qt[2703].needLevel then
    ADD_QUEST_BTN(qt[2703].id, qt[2703].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[2670].state == 1 then
    if qData[2670].killMonster[qt[2670].goal.killMonster[1].id] >= qt[2670].goal.killMonster[1].count then
      QSTATE(id, 2)
    else
      QSTATE(id, 1)
    end
  end
  if qData[2671].state ~= 2 and qData[2670].state == 2 and GET_PLAYER_LEVEL() >= qt[2671].needLevel then
    if qData[2671].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[2671].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2672].state ~= 2 and qData[2671].state == 2 and GET_PLAYER_LEVEL() >= qt[2672].needLevel then
    if qData[2672].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[2672].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2673].state ~= 2 and qData[2672].state == 2 and GET_PLAYER_LEVEL() >= qt[2673].needLevel then
    if qData[2673].state == 1 then
      if CHECK_ITEM_CNT(qt[2673].goal.getItem[1].id) >= qt[2673].goal.getItem[1].count and CHECK_ITEM_CNT(qt[2673].goal.getItem[2].id) >= qt[2673].goal.getItem[2].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2674].state ~= 2 and qData[2673].state == 2 and GET_PLAYER_LEVEL() >= qt[2674].needLevel then
    if qData[2674].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2689].state == 1 and qData[2689].killMonster[qt[2689].goal.killMonster[1].id] >= qt[2689].goal.killMonster[1].count then
    QSTATE(id, 2)
  end
  if qData[2690].state ~= 2 and qData[2689].state == 2 and GET_PLAYER_LEVEL() >= qt[2690].needLevel then
    if qData[2690].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2691].state == 1 and qData[2691].killMonster[qt[2691].goal.killMonster[1].id] >= qt[2691].goal.killMonster[1].count then
    QSTATE(id, 2)
  end
  if qData[2692].state ~= 2 and qData[2691].state == 2 and GET_PLAYER_LEVEL() >= qt[2692].needLevel then
    if qData[2692].state == 1 then
      if qData[2692].killMonster[qt[2692].goal.killMonster[1].id] >= qt[2692].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2693].state ~= 2 and qData[2692].state == 2 and GET_PLAYER_LEVEL() >= qt[2693].needLevel then
    if qData[2693].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2702].state == 1 then
    QSTATE(id, 2)
  end
  if qData[2703].state ~= 2 and qData[2702].state == 2 and GET_PLAYER_LEVEL() >= qt[2703].needLevel then
    if qData[2703].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
end
