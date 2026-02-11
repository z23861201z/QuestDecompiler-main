function npcsay(id)
  if id ~= 4322019 then
    return
  end
  clickNPCid = id
  NPC_SAY("在这里到底能找到什么呢？")
  if qData[2734].state == 1 then
    NPC_SAY("额？在这种地方还能再见到人！")
    SET_QUEST_STATE(2734, 2)
    return
  end
  if qData[2735].state == 1 then
    if CHECK_ITEM_CNT(qt[2735].goal.getItem[1].id) >= qt[2735].goal.getItem[1].count then
      NPC_SAY("按照约定，给你1个{0xFFFFFF00}水晶碎片{END}。现在去找外面的中原人{0xFFFFFF00}菊花碴{END}告知调查结果吧。")
      SET_QUEST_STATE(2735, 2)
      return
    else
      NPC_SAY("击退{0xFFFFFF00}獐子潭洞穴[1]{END}的{0xFFFFFF00}原虫{END}和{0xFFFFFF00}妖粉怪{END}，收集31个{0xFFFFFF00}水晶碎片{END}就可以了。")
    end
  end
  if qData[2786].state == 1 then
    if qData[2786].killMonster[qt[2786].goal.killMonster[1].id] >= qt[2786].goal.killMonster[1].count then
      NPC_SAY("好久不见～我有东西要给你看看。")
      SET_QUEST_STATE(2786, 2)
      return
    else
      NPC_SAY("在这里到底能找到什么呢？")
    end
  end
  if qData[2787].state == 1 then
    NPC_SAY("在{0xFFFFFF00}獐子潭洞穴{END}击退30个{0xFFFFFF00}妖粉怪{END}后去{0xFFFFFF00}龙林派张飞{END}处吧。")
  end
  if qData[2790].state == 1 and CHECK_ITEM_CNT(qt[2790].goal.getItem[1].id) >= qt[2790].goal.getItem[1].count then
    NPC_SAY("这闪亮的石板！龙林派的人果然很厉害啊！")
    SET_QUEST_STATE(2790, 2)
    return
  end
  if qData[2791].state == 1 then
    NPC_SAY("击退30个{0xFFFFFF00}妖粉怪{END}后，把{0xFFFFFF00}獐子潭石板{END}拿给{0xFFFFFF00}旅行家飞雪{END}吧。她应该能知道。")
  end
  if qData[2814].state == 1 and qData[2814].killMonster[qt[2814].goal.killMonster[1].id] >= qt[2814].goal.killMonster[1].count then
    NPC_SAY("费了些时间啊。石板的内容是什么啊？")
    SET_QUEST_STATE(2814, 2)
    return
  end
  if qData[2820].state == 1 then
    NPC_SAY("好久不见。我看你一直来去匆匆的。")
    SET_QUEST_STATE(2820, 2)
    return
  end
  if qData[2821].state == 1 then
    NPC_SAY("击退10个{0xFFFFFF00}獐子潭洞穴{END}的{0xFFFFFF00}曲怪人{END}后，去找[{0xFFFFFF00}[吕墩平原[废墟]]{END}的{0xFFFFFF00}[近卫兵亚夫]{END}吧。")
  end
  if qData[2830].state == 1 then
    if CHECK_ITEM_CNT(qt[2830].goal.getItem[1].id) >= qt[2830].goal.getItem[1].count then
      NPC_SAY("这么快！果然很厉害。")
      SET_QUEST_STATE(2830, 2)
      return
    else
      NPC_SAY("在{0xFFFFFF00}獐子潭洞穴{END}击退{0xFFFFFF00}原虫{END}和{0xFFFFFF00}妖粉怪{END}，收集30个{0xFFFFFF00}獐子潭羊皮纸碎片{END}吧。")
    end
  end
  if qData[2831].state == 1 then
    if CHECK_ITEM_CNT(qt[2831].goal.getItem[1].id) >= qt[2831].goal.getItem[1].count then
      NPC_SAY("现在所有的{0xFFFFFF00}獐子潭羊皮纸碎片{END}应该都收集齐了。")
      SET_QUEST_STATE(2831, 2)
      return
    else
      NPC_SAY("这次在{0xFFFFFF00}獐子潭洞穴{END}击退{0xFFFFFF00}曲怪人{END}，收集10个{0xFFFFFF00}獐子潭羊皮纸碎片2{END}回来吧。")
    end
  end
  if qData[2832].state == 1 then
    NPC_SAY("拿着{0xFFFFFF00}獐子潭羊皮纸{END}去找{0xFFFFFF00}[龙林派关羽]{END}，拜托他复原一下吧。他在{0xFFFFFF00}封印之石{END}。")
  end
  if qData[2835].state == 1 then
    NPC_SAY("来啦！复原了吗？")
    SET_QUEST_STATE(2835, 2)
    return
  end
  if qData[2836].state == 1 then
    NPC_SAY("击退50个{0xFFFFFF00}妖粉怪{END}后，去找{0xFFFFFF00}吕林都城{END}的{0xFFFFFF00}清丽公主{END}告知{0xFFFFFF00}獐子潭的真相{END}吧。")
  end
  if qData[2735].state == 0 and qData[2734].state == 2 and GET_PLAYER_LEVEL() >= qt[2735].needLevel then
    ADD_QUEST_BTN(qt[2735].id, qt[2735].name)
  end
  if qData[2787].state == 0 and qData[2786].state == 2 and GET_PLAYER_LEVEL() >= qt[2787].needLevel then
    ADD_QUEST_BTN(qt[2787].id, qt[2787].name)
  end
  if qData[2791].state == 0 and qData[2790].state == 2 and GET_PLAYER_LEVEL() >= qt[2791].needLevel then
    ADD_QUEST_BTN(qt[2791].id, qt[2791].name)
  end
  if qData[2815].state == 0 and qData[2814].state == 2 and GET_PLAYER_LEVEL() >= qt[2815].needLevel then
    ADD_QUEST_BTN(qt[2815].id, qt[2815].name)
  end
  if qData[2821].state == 0 and qData[2820].state == 2 and GET_PLAYER_LEVEL() >= qt[2821].needLevel then
    ADD_QUEST_BTN(qt[2821].id, qt[2821].name)
  end
  if qData[2830].state == 0 and qData[2815].state == 2 and GET_PLAYER_LEVEL() >= qt[2830].needLevel then
    ADD_QUEST_BTN(qt[2830].id, qt[2830].name)
  end
  if qData[2831].state == 0 and qData[2830].state == 2 and GET_PLAYER_LEVEL() >= qt[2831].needLevel then
    ADD_QUEST_BTN(qt[2831].id, qt[2831].name)
  end
  if qData[2832].state == 0 and qData[2831].state == 2 and GET_PLAYER_LEVEL() >= qt[2832].needLevel then
    ADD_QUEST_BTN(qt[2832].id, qt[2832].name)
  end
  if qData[2836].state == 0 and qData[2835].state == 2 and GET_PLAYER_LEVEL() >= qt[2836].needLevel then
    ADD_QUEST_BTN(qt[2836].id, qt[2836].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[2734].state == 1 then
    QSTATE(id, 2)
  end
  if qData[2735].state ~= 2 and qData[2734].state == 2 and GET_PLAYER_LEVEL() >= qt[2735].needLevel then
    if qData[2735].state == 1 then
      if CHECK_ITEM_CNT(qt[2735].goal.getItem[1].id) >= qt[2735].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2786].state ~= 2 and qData[2746].state == 2 and GET_PLAYER_LEVEL() >= qt[2786].needLevel then
    if qData[2786].state == 1 then
      if qData[2786].killMonster[qt[2786].goal.killMonster[1].id] >= qt[2786].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2787].state ~= 2 and qData[2786].state == 2 and GET_PLAYER_LEVEL() >= qt[2787].needLevel then
    if qData[2787].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2790].state == 1 then
    QSTATE(id, 2)
  end
  if qData[2791].state ~= 2 and qData[2790].state == 2 and GET_PLAYER_LEVEL() >= qt[2791].needLevel then
    if qData[2791].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2814].state ~= 2 and qData[2813].state == 2 and GET_PLAYER_LEVEL() >= qt[2814].needLevel then
    if qData[2814].state == 1 then
      if qData[2814].killMonster[qt[2814].goal.killMonster[1].id] >= qt[2814].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2815].state ~= 2 and qData[2814].state == 2 and GET_PLAYER_LEVEL() >= qt[2815].needLevel then
    if qData[2815].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2820].state == 1 then
    QSTATE(id, 2)
  end
  if qData[2821].state ~= 2 and qData[2820].state == 2 and GET_PLAYER_LEVEL() >= qt[2821].needLevel then
    if qData[2821].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2830].state ~= 2 and qData[2815].state == 2 and GET_PLAYER_LEVEL() >= qt[2830].needLevel then
    if qData[2830].state == 1 then
      if CHECK_ITEM_CNT(qt[2830].goal.getItem[1].id) >= qt[2830].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2831].state ~= 2 and qData[2830].state == 2 and GET_PLAYER_LEVEL() >= qt[2831].needLevel then
    if qData[2831].state == 1 then
      if CHECK_ITEM_CNT(qt[2831].goal.getItem[1].id) >= qt[2831].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2832].state ~= 2 and qData[2831].state == 2 and GET_PLAYER_LEVEL() >= qt[2832].needLevel then
    if qData[2832].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2835].state == 1 then
    QSTATE(id, 2)
  end
  if qData[2836].state ~= 2 and qData[2835].state == 2 and GET_PLAYER_LEVEL() >= qt[2836].needLevel then
    if qData[2836].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
end
