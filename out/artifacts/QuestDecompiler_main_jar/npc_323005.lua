function npcsay(id)
  if id ~= 4323005 then
    return
  end
  NPC_SAY("不管发生什么事，我都要用我的剑一并解决！")
  clickNPCid = id
  if qData[1480].state == 1 then
    NPC_SAY("是听{0xFFFFFF00}近卫兵降落伞{END}说的。穿过{0xFFFFFF00}獐子潭洞穴{END}的旅行者数百年来第一次。先欢迎一下吧")
    SET_QUEST_STATE(1480, 2)
    return
  end
  if qData[1481].state == 1 then
    NPC_SAY("首先去{0xFFFFFF00}安哥拉王宫{END}的{0xFFFFFF00}近卫兵可心{END}处吧。详细的他会告诉你的")
    return
  end
  if qData[2186].state == 1 then
    if CHECK_ITEM_CNT(qt[2186].goal.getItem[1].id) >= qt[2186].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(4) then
        NPC_SAY("谢谢！这是谢礼，希望你能好好利用")
        SET_QUEST_STATE(2186, 2)
        return
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("击退火龙，收集1个龙角回来吧")
    end
  end
  if qData[2586].state == 1 then
    if qData[2586].killMonster[qt[2586].goal.killMonster[1].id] >= qt[2586].goal.killMonster[1].count then
      NPC_SAY("谢谢。现在可以加快开发黑色丘陵的速度了~")
      SET_QUEST_STATE(2586, 2)
      return
    else
      NPC_SAY("击退栖息在黑色丘陵的{0xFFFFFF00}100个[黑色阿拉克涅]{END}就可以了。")
    end
  end
  if qData[2883].state == 1 then
    if CHECK_ITEM_CNT(qt[2883].goal.getItem[1].id) >= qt[2883].goal.getItem[1].count then
      NPC_SAY("那就开始用魔灵的酸橙榨汁了~")
      SET_QUEST_STATE(2883, 2)
      return
    else
      NPC_SAY("收集回来15个{0xFFFFFF00}咸兴魔灵{END}身上携带的{0xFFFFFF00}魔灵的酸橙{END}吧。")
    end
  end
  if qData[2884].state == 1 then
    NPC_SAY("{0xFFFFFF00}近卫兵可心{END}在{0xFFFFFF00}安哥拉王宫{END}。")
    return
  end
  if qData[2885].state == 1 then
    NPC_SAY("我相信可心也能长点记性了。谢谢你的帮忙。")
    SET_QUEST_STATE(2885, 2)
    return
  end
  if qData[2891].state == 1 then
    NPC_SAY("{0xFFFFFF00}安哥拉大世子{END}在{0xFFFFFF00}安哥拉王宫内部{END}。你仔细找的话一定能找到。")
    return
  end
  if qData[3649].state == 1 then
    if CHECK_ITEM_CNT(qt[3649].goal.getItem[1].id) >= qt[3649].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(4) then
        NPC_SAY("谢谢！这是谢礼，希望你能好好利用")
        SET_QUEST_STATE(3649, 2)
        return
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("击退火龙，收集1个龙角回来吧")
    end
  end
  if qData[3701].state == 1 then
    if qData[3701].killMonster[qt[3701].goal.killMonster[1].id] >= qt[3701].goal.killMonster[1].count then
      NPC_SAY("谢谢。这下探险进度能加快了！")
      SET_QUEST_STATE(3701, 2)
      return
    else
      NPC_SAY("只要帮忙击退燃烧的废墟里的{0xFFFFFF00}100个[泥娃娃]{END}就可以了。")
    end
  end
  if qData[1481].state == 0 and qData[1480].state == 2 then
    ADD_QUEST_BTN(qt[1481].id, qt[1481].name)
  end
  if qData[2186].state == 0 then
    ADD_QUEST_BTN(qt[2186].id, qt[2186].name)
  end
  if qData[2586].state == 0 and GET_PLAYER_LEVEL() >= qt[2586].needLevel then
    ADD_QUEST_BTN(qt[2586].id, qt[2586].name)
  end
  if qData[2883].state == 0 and qData[2882].state == 2 and GET_PLAYER_LEVEL() >= qt[2883].needLevel then
    ADD_QUEST_BTN(qt[2883].id, qt[2883].name)
  end
  if qData[2884].state == 0 and qData[2883].state == 2 and GET_PLAYER_LEVEL() >= qt[2884].needLevel then
    ADD_QUEST_BTN(qt[2884].id, qt[2884].name)
  end
  if qData[2891].state == 0 and qData[2890].state == 2 and GET_PLAYER_LEVEL() >= qt[2891].needLevel then
    ADD_QUEST_BTN(qt[2891].id, qt[2891].name)
  end
  if qData[3649].state == 0 and qData[2186].state == 2 then
    ADD_QUEST_BTN(qt[3649].id, qt[3649].name)
  end
  if qData[3701].state == 0 and GET_PLAYER_LEVEL() >= qt[3701].needLevel then
    ADD_QUEST_BTN(qt[3701].id, qt[3701].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[1480].state == 1 then
    QSTATE(id, 2)
  end
  if qData[1481].state ~= 2 and qData[1480].state == 2 then
    if qData[1481].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2186].state ~= 2 and GET_PLAYER_LEVEL() >= qt[2186].needLevel then
    if qData[2186].state == 1 then
      if CHECK_ITEM_CNT(qt[2186].goal.getItem[1].id) >= qt[2186].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2586].state ~= 2 and GET_PLAYER_LEVEL() >= qt[2586].needLevel then
    if qData[2586].state == 1 then
      if qData[2586].killMonster[qt[2586].goal.killMonster[1].id] >= qt[2586].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2884].state ~= 2 and qData[2883].state == 2 then
    if qData[2884].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2883].state ~= 2 and qData[2882].state == 2 and GET_PLAYER_LEVEL() >= qt[2883].needLevel then
    if qData[2883].state == 1 then
      if CHECK_ITEM_CNT(qt[2883].goal.getItem[1].id) >= qt[2883].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2885].state == 1 then
    QSTATE(id, 2)
  end
  if qData[2891].state ~= 2 and qData[2890].state == 2 then
    if qData[2891].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[3649].state ~= 2 and qData[2186].state == 2 and GET_PLAYER_LEVEL() >= qt[3649].needLevel then
    if qData[3649].state == 1 then
      if CHECK_ITEM_CNT(qt[3649].goal.getItem[1].id) >= qt[3649].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[3701].state ~= 2 and GET_PLAYER_LEVEL() >= qt[3701].needLevel then
    if qData[3701].state == 1 then
      if qData[3701].killMonster[qt[3701].goal.killMonster[1].id] >= qt[3701].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
end
