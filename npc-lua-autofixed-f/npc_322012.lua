function npcsay(id)
  if id ~= 4322012 then
    return
  end
  clickNPCid = id
  NPC_SAY(".... ZZZ")
  if qData[2661].state == 1 and qData[2661].killMonster[qt[2661].goal.killMonster[1].id] >= qt[2661].goal.killMonster[1].count then
    NPC_SAY("啊啊…")
    SET_QUEST_STATE(2661, 2)
    return
  end
  if qData[2662].state == 1 then
    NPC_SAY("（秋叨鱼精神不太正常啊。去找{0xFFFFFF00}吕林城宝芝林{END}吧。）")
  end
  if qData[2668].state == 1 then
    NPC_SAY("…（秋叨鱼晕过去了。得重新去找{0xFFFFFF00}吕林城宝芝林{END}。）")
    SET_QUEST_STATE(2668, 2)
    return
  end
  if qData[2674].state == 1 and __QUEST_HAS_ALL_ITEMS(qt[2674].goal.getItem) then
    NPC_SAY("啊啊…（吃了药的秋叨鱼停止了呻吟，安稳的睡着了。表情很平稳。）")
    SET_QUEST_STATE(2674, 2)
    return
  end
  if qData[2688].state == 1 then
    NPC_SAY("以后的计划...")
    SET_QUEST_STATE(2688, 2)
    return
  end
  if qData[2689].state == 1 then
    NPC_SAY("击退50个{0xFFFFFF00}嗜食怪{END}后去见冬混汤转达我的想法吧。他肯定会赞成的！")
  end
  if qData[2695].state == 1 then
    NPC_SAY("封印结界在晃动...到底是怎么回事？")
    SET_QUEST_STATE(2695, 2)
    return
  end
  if qData[2696].state == 1 then
    NPC_SAY("梅花弱师兄还活着的话，可以做到吗？")
    SET_QUEST_STATE(2696, 2)
    return
  end
  if qData[2696].state == 1 then
    NPC_SAY("巨木神啊...会是什么样的存在啊？")
  end
  if qData[2710].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[2710].goal.getItem) then
      NPC_SAY("谢谢。")
      SET_QUEST_STATE(2710, 2)
      return
    else
      NPC_SAY("在{0xFFFFFF00}干涸的沼泽{END}击退{0xFFFFFF00}嗜食怪{END}收集30个 {0xFFFFFF00}嗜食怪的眼睛{END}， 击退{0xFFFFFF00}临浦怪{END}收集30个{0xFFFFFF00}临浦怪的眼睛{END}回来吧。")
    end
  end
  if qData[2711].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[2711].goal.getItem) then
      NPC_SAY("谢谢。")
      SET_QUEST_STATE(2711, 2)
      return
    else
      NPC_SAY("在{0xFFFFFF00}干涸的沼泽{END}击退{0xFFFFFF00}嗜食怪{END}收集15个 {0xFFFFFF00}嗜食怪的眼睛{END}， 击退{0xFFFFFF00}临浦怪{END}收集15个{0xFFFFFF00}临浦怪的眼睛{END}回来吧。")
    end
  end
  if qData[2730].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[2730].goal.getItem) then
      NPC_SAY("那就...（秋叨鱼在运功调息后，伸手去拿{0xFFFFFF00}志鬼心火火焰{END}。）啊，好烫！")
      SET_QUEST_STATE(2730, 2)
      return
    else
      NPC_SAY("在{0xFFFFFF00}干涸的沼泽{END}击退{0xFFFFFF00}志鬼心火{END}，收集回来30个{0xFFFFFF00}志鬼心火火焰{END}吧。")
    end
  end
  if qData[2731].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[2731].goal.getItem) then
      NPC_SAY("再来一次！（秋叨鱼拿起咒术杖发力。）这...这不可能...（秋叨鱼失魂落魄的坐在椅子上）")
      SET_QUEST_STATE(2731, 2)
      return
    else
      NPC_SAY("在{0xFFFFFF00}干涸的沼泽{END}击退{0xFFFFFF00}破戒僧{END}，收集30个{0xFFFFFF00}咒术仗{END}回来吧。")
    end
  end
  if qData[2739].state == 1 then
    NPC_SAY("好久不见。你拿着的是什么信啊？")
    SET_QUEST_STATE(2739, 2)
    return
  end
  if qData[2740].state == 1 then
    NPC_SAY("还没出发吗？{0xFFFFFF00}封印之石{END}在干涸的沼泽地带的旁边。")
    SET_QUEST_STATE(2740, 2)
    return
  end
  if qData[2796].state == 1 then
    NPC_SAY("好久不见，我现在恢复的差不多了。")
    SET_QUEST_STATE(2796, 2)
    return
  end
  if qData[2797].state == 1 then
    NPC_SAY("去找{0xFFFFFF00}吕林都城{END}的{0xFFFFFF00}清丽公主{END}，针对当前的情况商量一下吧。")
  end
  if qData[2662].state == 0 and qData[2661].state == 2 and GET_PLAYER_LEVEL() >= qt[2661].needLevel then
    ADD_QUEST_BTN(qt[2662].id, qt[2662].name)
  end
  if qData[2668].state == 0 and qData[2667].state == 2 and GET_PLAYER_LEVEL() >= qt[2668].needLevel then
    ADD_QUEST_BTN(qt[2668].id, qt[2668].name)
  end
  if qData[2688].state == 0 and qData[2674].state == 2 and GET_PLAYER_LEVEL() >= qt[2688].needLevel then
    ADD_QUEST_BTN(qt[2688].id, qt[2688].name)
  end
  if qData[2689].state == 0 and qData[2688].state == 2 and GET_PLAYER_LEVEL() >= qt[2689].needLevel then
    ADD_QUEST_BTN(qt[2689].id, qt[2689].name)
  end
  if qData[2695].state == 0 and qData[2694].state == 2 and GET_PLAYER_LEVEL() >= qt[2695].needLevel then
    ADD_QUEST_BTN(qt[2695].id, qt[2695].name)
  end
  if qData[2696].state == 0 and qData[2695].state == 2 and GET_PLAYER_LEVEL() >= qt[2696].needLevel then
    ADD_QUEST_BTN(qt[2696].id, qt[2696].name)
  end
  if qData[2697].state == 0 and qData[2696].state == 2 and GET_PLAYER_LEVEL() >= qt[2697].needLevel then
    ADD_QUEST_BTN(qt[2697].id, qt[2697].name)
  end
  if qData[2710].state == 0 and GET_PLAYER_LEVEL() >= qt[2710].needLevel then
    ADD_QUEST_BTN(qt[2710].id, qt[2710].name)
  end
  if qData[2711].state == 0 and qData[2710].state == 2 and GET_PLAYER_LEVEL() >= qt[2711].needLevel then
    ADD_QUEST_BTN(qt[2711].id, qt[2711].name)
  end
  if qData[2730].state == 0 and qData[2709].state == 2 and GET_PLAYER_LEVEL() >= qt[2730].needLevel then
    ADD_QUEST_BTN(qt[2730].id, qt[2730].name)
  end
  if qData[2731].state == 0 and qData[2730].state == 2 and GET_PLAYER_LEVEL() >= qt[2731].needLevel then
    ADD_QUEST_BTN(qt[2731].id, qt[2731].name)
  end
  if qData[2740].state == 0 and qData[2739].state == 2 and GET_PLAYER_LEVEL() >= qt[2740].needLevel then
    ADD_QUEST_BTN(qt[2740].id, qt[2740].name)
  end
  if qData[2797].state == 0 and qData[2796].state == 2 and GET_PLAYER_LEVEL() >= qt[2797].needLevel then
    ADD_QUEST_BTN(qt[2797].id, qt[2797].name)
  end
  if qData[2812].state == 0 and qData[2799].state == 2 and GET_PLAYER_LEVEL() >= qt[2812].needLevel then
    ADD_QUEST_BTN(qt[2812].id, qt[2812].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[2661].state == 1 then
    if qData[2661].killMonster[qt[2661].goal.killMonster[1].id] >= qt[2661].goal.killMonster[1].count then
      QSTATE(id, 2)
    else
      QSTATE(id, 1)
    end
  end
  if qData[2662].state ~= 2 and qData[2661].state == 2 and GET_PLAYER_LEVEL() >= qt[2662].needLevel then
    if qData[2662].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2668].state ~= 2 and qData[2667].state == 2 and GET_PLAYER_LEVEL() >= qt[2668].needLevel then
    if qData[2668].state == 1 then
      QSTATE(id, 2)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2674].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[2674].goal.getItem) then
      QSTATE(id, 2)
    else
      QSTATE(id, 1)
    end
  end
  if qData[2688].state ~= 2 and qData[2674].state == 2 and GET_PLAYER_LEVEL() >= qt[2688].needLevel then
    if qData[2688].state == 1 then
      QSTATE(id, 2)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2689].state ~= 2 and qData[2688].state == 2 and GET_PLAYER_LEVEL() >= qt[2689].needLevel then
    if qData[2689].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2695].state ~= 2 and qData[2694].state == 2 and GET_PLAYER_LEVEL() >= qt[2695].needLevel then
    if qData[2695].state == 1 then
      QSTATE(id, 2)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2696].state ~= 2 and qData[2695].state == 2 and GET_PLAYER_LEVEL() >= qt[2696].needLevel then
    if qData[2696].state == 1 then
      QSTATE(id, 2)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2697].state ~= 2 and qData[2696].state == 2 and GET_PLAYER_LEVEL() >= qt[2697].needLevel then
    if qData[2697].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2710].state ~= 2 and GET_PLAYER_LEVEL() >= qt[2710].needLevel then
    if qData[2710].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[2710].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2711].state ~= 2 and qData[2710].state == 2 and GET_PLAYER_LEVEL() >= qt[2711].needLevel then
    if qData[2711].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[2711].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2730].state ~= 2 and qData[2709].state == 2 and GET_PLAYER_LEVEL() >= qt[2730].needLevel then
    if qData[2730].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[2730].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2731].state ~= 2 and qData[2730].state == 2 and GET_PLAYER_LEVEL() >= qt[2731].needLevel then
    if qData[2731].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[2731].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2739].state == 1 then
    QSTATE(id, 2)
  end
  if qData[2740].state ~= 2 and qData[2739].state == 2 and GET_PLAYER_LEVEL() >= qt[2740].needLevel then
    if qData[2740].state == 1 then
      QSTATE(id, 2)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2796].state == 1 then
    QSTATE(id, 2)
  end
  if qData[2797].state ~= 2 and qData[2796].state == 2 and GET_PLAYER_LEVEL() >= qt[2797].needLevel then
    if qData[2797].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2812].state ~= 2 and qData[2799].state == 2 and GET_PLAYER_LEVEL() >= qt[2812].needLevel then
    if qData[2812].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
end
