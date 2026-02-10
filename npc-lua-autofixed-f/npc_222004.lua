function npcsay(id)
  if id ~= 4222004 then
    return
  end
  clickNPCid = id
  NPC_SAY("挑选自己想要的武器吧。没有事情就离开吧。")
  if qData[1051].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[1051].goal.getItem) then
      if 1 <= CHECK_INVENTORY_CNT(4) then
        NPC_SAY("啊哈~数量不少呢，没想到这么快就弄回来了，真的很厉害啊，这些巨大的钳子我会好好使用的，谢谢~")
        SET_QUEST_STATE(1051, 2)
        return
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("啊，想快点完成这个武器。帮我收集回来{0xFFFFFF00}10个巨大的钳子{END}吧 就10个~！")
    end
  end
  if qData[1057].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[1057].goal.getItem) then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("好好。刚好是各100个啊。材料不足时还会拜托你的")
        SET_QUEST_STATE(1057, 2)
        return
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("击退{0xFFFFFF00}百足神怪{END}和{0xFFFFFF00}太极蜈蚣{END}吧！不会是浪费时间击退别的怪物吧？是各{0xFFFFFF00}100个{END}")
    end
  end
  if qData[2665].state == 1 then
    NPC_SAY("额，什么事情啊？")
    SET_QUEST_STATE(2665, 2)
    return
  end
  if qData[2666].state == 1 then
    if qData[2666].killMonster[qt[2666].goal.killMonster[1].id] >= qt[2666].goal.killMonster[1].count then
      NPC_SAY("确实击退了吗？")
      SET_QUEST_STATE(2666, 2)
      return
    else
      NPC_SAY("想要应急药就去击退50个{0xFFFFFF00}太极蜈蚣{END}吧。这是我个人的报复。")
    end
  end
  if qData[2667].state == 1 then
    NPC_SAY("想要保护自己，武器再好不过了。")
  end
  if qData[2675].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[2675].goal.getItem) and qData[2675].killMonster[qt[2675].goal.killMonster[1].id] >= qt[2675].goal.killMonster[1].count then
      NPC_SAY("谢谢，太感谢了。")
      SET_QUEST_STATE(2675, 2)
      return
    else
      NPC_SAY("{0xFFFFFF00}太极蜈蚣{END}藏在{0xFFFFFF00}巨木重林{END}。击退50个{0xFFFFFF00}太极蜈蚣{END}，收集50个{0xFFFFFF00}巨大的钳子{END}回来吧。")
    end
  end
  if qData[2676].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[2676].goal.getItem) and qData[2676].killMonster[qt[2676].goal.killMonster[1].id] >= qt[2676].goal.killMonster[1].count then
      NPC_SAY("真心感谢！")
      SET_QUEST_STATE(2676, 2)
      return
    else
      NPC_SAY("{0xFFFFFF00}太极蜈蚣的触须{END}是在{0xFFFFFF00}巨木重林{END}击退{0xFFFFFF00}太极蜈蚣{END}就能获得。击退50个{0xFFFFFF00}太极蜈蚣{END}，收集50个{0xFFFFFF00}太极蜈蚣的触须{END}回来吧。")
    end
  end
  ADD_NEW_SHOP_BTN(id, 10054)
  if qData[1051].state == 0 then
    ADD_QUEST_BTN(qt[1051].id, qt[1051].name)
  end
  if qData[1057].state == 0 then
    ADD_QUEST_BTN(qt[1057].id, qt[1057].name)
  end
  if qData[2666].state == 0 and qData[2665].state == 2 and GET_PLAYER_LEVEL() >= qt[2665].needLevel then
    ADD_QUEST_BTN(qt[2666].id, qt[2666].name)
  end
  if qData[2667].state == 0 and qData[2666].state == 2 and GET_PLAYER_LEVEL() >= qt[2666].needLevel then
    ADD_QUEST_BTN(qt[2667].id, qt[2667].name)
  end
  if qData[2675].state == 0 and GET_PLAYER_LEVEL() >= qt[2675].needLevel then
    ADD_QUEST_BTN(qt[2675].id, qt[2675].name)
  end
  if qData[2676].state == 0 and qData[2675].state == 2 and GET_PLAYER_LEVEL() >= qt[2676].needLevel then
    ADD_QUEST_BTN(qt[2676].id, qt[2676].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[1051].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1051].needLevel then
    if qData[1051].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[1051].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1057].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1057].needLevel then
    if qData[1057].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[1057].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2665].state == 1 then
    QSTATE(id, 2)
  end
  if qData[2666].state ~= 2 and qData[2665].state == 2 and GET_PLAYER_LEVEL() >= qt[2666].needLevel then
    if qData[2666].state == 1 then
      if qData[2666].killMonster[qt[2666].goal.killMonster[1].id] >= qt[2666].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2667].state ~= 2 and qData[2666].state == 2 and GET_PLAYER_LEVEL() >= qt[2667].needLevel then
    if qData[2667].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2675].state ~= 2 and GET_PLAYER_LEVEL() >= qt[2675].needLevel then
    if qData[2675].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[2675].goal.getItem) and qData[2675].killMonster[qt[2675].goal.killMonster[1].id] >= qt[2675].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2676].state ~= 2 and qData[2675].state == 2 and GET_PLAYER_LEVEL() >= qt[2676].needLevel then
    if qData[2676].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[2676].goal.getItem) and qData[2676].killMonster[qt[2676].goal.killMonster[1].id] >= qt[2676].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
end
