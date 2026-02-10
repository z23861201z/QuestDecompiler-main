function npcsay(id)
  if id ~= 4323006 then
    return
  end
  NPC_SAY("前方出现了居首者！不要再过来，就在那儿说吧！")
  clickNPCid = id
  if qData[1475].state == 1 then
    NPC_SAY("前方出现居首者！不要再过来，就在那儿说吧！可心，确认一下居首者的身份！")
    SET_QUEST_STATE(1475, 2)
    return
  end
  if qData[1476].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[1476].goal.getItem) then
      NPC_SAY("啊，收集回来了啊？但是该怎么办呢？我忘了告诉你我不知道这是不是原虫的！哈哈哈！")
      SET_QUEST_STATE(1476, 2)
      return
    else
      NPC_SAY("击退{0xFFFFFF00}獐子潭洞穴{END}的{0xFFFFFF00}原虫{END}之后，收集{0xFFFFFF00}50个发光的分泌物{END}回来吧！那我就相信你！")
    end
  end
  if qData[1477].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[1477].goal.getItem) then
      NPC_SAY("辛苦了。已经证明你是个可以相信的人，按照约定把你介绍给{0xFFFFFF00}亲卫队长罗新{END}")
      SET_QUEST_STATE(1477, 2)
      return
    else
      NPC_SAY("从{0xFFFFFF00}医生八字胡老头{END}和{0xFFFFFF00}银行员辛巴达{END}处得到{0xFFFFFF00}推荐书{END}之后，把{0xFFFFFF00}2张推荐书{END}给我拿过来吧！")
    end
  end
  if qData[1480].state == 1 then
    NPC_SAY("去找{0xFFFFFF00}安哥拉王宫内部{END}的{0xFFFFFF00}亲卫队长罗新{END}吧！")
  end
  if qData[2593].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[2593].goal.getItem) then
      NPC_SAY("谢谢。这是给你的奖励。")
      SET_QUEST_STATE(2593, 2)
      return
    else
      NPC_SAY("去燃烧的废墟击退{0xFFFFFF00}[红色巨石守护者]{END}，收集{0xFFFFFF00}50个红色巨石碎块{END}回来就可以了。")
    end
  end
  if qData[2880].state == 1 and __QUEST_HAS_ALL_ITEMS(qt[2880].goal.getItem) then
    NPC_SAY("能快点吗？拜托了。")
    SET_QUEST_STATE(2880, 2)
    return
  end
  if qData[2888].state == 1 then
    if CHECK_ITEM_CNT(qt[2888].goal.getItem[1].id) >= qt[2888].goal.getItem[1].count then
      NPC_SAY("谢谢。")
      SET_QUEST_STATE(2888, 2)
      return
    else
      NPC_SAY("在{0xFFFFFF00}吕墩平原{END}击退{0xFFFFFF00}甲山女鬼{END}，收集30个{0xFFFFFF00}椰枣{END}回来吧。")
    end
  end
  if qData[2889].state == 1 then
    if CHECK_ITEM_CNT(qt[2889].goal.getItem[1].id) >= qt[2889].goal.getItem[1].count then
      NPC_SAY("谢谢，这下能安心了。")
      SET_QUEST_STATE(2889, 2)
      return
    else
      NPC_SAY(" 在{0xFFFFFF00}吕墩平原{END}击退{0xFFFFFF00}甲山女鬼{END}，收集50个{0xFFFFFF00}被丢弃的绷带{END}回来吧。")
    end
  end
  if qData[2890].state == 1 then
    NPC_SAY("去见{0xFFFFFF00}[安哥拉王宫]{END}的{0xFFFFFF00}[近卫兵降落伞]{END}吧。")
    SET_QUEST_STATE(2890, 2)
    return
  end
  if qData[1476].state == 0 and qData[1475].state == 2 then
    ADD_QUEST_BTN(qt[1476].id, qt[1476].name)
  end
  if qData[1477].state == 0 and qData[1476].state == 2 then
    ADD_QUEST_BTN(qt[1477].id, qt[1477].name)
  end
  if qData[1480].state == 0 and qData[1477].state == 2 then
    ADD_QUEST_BTN(qt[1480].id, qt[1480].name)
  end
  if qData[2593].state == 0 and GET_PLAYER_LEVEL() >= qt[2593].needLevel then
    ADD_QUEST_BTN(qt[2593].id, qt[2593].name)
  end
  if qData[2880].state == 0 and qData[2879].state == 2 and GET_PLAYER_LEVEL() >= qt[2880].needLevel then
    ADD_QUEST_BTN(qt[2880].id, qt[2880].name)
  end
  if qData[2888].state == 0 and qData[2887].state == 2 and GET_PLAYER_LEVEL() >= qt[2888].needLevel then
    ADD_QUEST_BTN(qt[2888].id, qt[2888].name)
  end
  if qData[2889].state == 0 and qData[2888].state == 2 and GET_PLAYER_LEVEL() >= qt[2889].needLevel then
    ADD_QUEST_BTN(qt[2889].id, qt[2889].name)
  end
  if qData[2890].state == 0 and qData[2889].state == 2 and GET_PLAYER_LEVEL() >= qt[2890].needLevel then
    ADD_QUEST_BTN(qt[2890].id, qt[2890].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[1475].state == 1 then
    QSTATE(id, 2)
  end
  if qData[1476].state ~= 2 and qData[1475].state == 2 then
    if qData[1476].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[1476].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1477].state ~= 2 and qData[1476].state == 2 then
    if qData[1477].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[1477].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1480].state ~= 2 and qData[1477].state == 2 and GET_PLAYER_LEVEL() >= qt[1480].needLevel then
    if qData[1480].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2593].state ~= 2 and GET_PLAYER_LEVEL() >= qt[2593].needLevel then
    if qData[2593].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[2593].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2880].state ~= 2 and qData[2879].state == 2 and GET_PLAYER_LEVEL() >= qt[2880].needLevel then
    if qData[2880].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[2880].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2888].state ~= 2 and qData[2887].state == 2 and GET_PLAYER_LEVEL() >= qt[2888].needLevel then
    if qData[2888].state == 1 then
      if CHECK_ITEM_CNT(qt[2888].goal.getItem[1].id) >= qt[2888].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2889].state ~= 2 and qData[2888].state == 2 and GET_PLAYER_LEVEL() >= qt[2889].needLevel then
    if qData[2889].state == 1 then
      if CHECK_ITEM_CNT(qt[2889].goal.getItem[1].id) >= qt[2889].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2890].state ~= 2 and qData[2889].state == 2 and GET_PLAYER_LEVEL() >= qt[2890].needLevel then
    if qData[2890].state == 1 then
      QSTATE(id, 2)
    else
      QSTATE(id, 0)
    end
  end
end
