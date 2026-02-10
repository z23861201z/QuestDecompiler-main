function npcsay(id)
  if id ~= 4322003 then
    return
  end
  clickNPCid = id
  if qData[893].state == 1 then
    if qData[893].killMonster[qt[893].goal.killMonster[1].id] >= qt[893].goal.killMonster[1].count then
      NPC_SAY("辛苦了。果然少侠才是可以继承英雄们的人才啊。")
      SET_QUEST_STATE(893, 2)
      return
    else
      NPC_SAY("击退{0xFFFFFF00}80个[破戒僧]{END}之后回来，就给你{0xFFFFFF00}1个吕林守护符{END}。不过要记住，这个任务{0xFFFFFF00}一天只能完成一次{END}。")
    end
  end
  if qData[1047].state == 1 then
    if qData[1047].killMonster[qt[1047].goal.killMonster[1].id] >= qt[1047].goal.killMonster[1].count then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("谢谢。从此{0xFFFFFF00}PLAYERNAME{END}成为了吕林城的一员。继续努力吧")
        SET_QUEST_STATE(1047, 2)
        return
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("看来你是第一次啊，不要害怕，去巨木重林击退{0xFFFFFF00}10个食人花{END}后回来吧")
      return
    end
  end
  if qData[1904].state == 1 then
    if qData[1904].meetNpc[1] ~= qt[1904].goal.meetNpc[1] then
      NPC_SAY("啊…想穿宽松的衣服")
      return
    else
      NPC_SAY("及时帮我找来了衣服，我身为这王国的公主，不能穿别的村的衣服的。这只是我的愿望而已。PLAYERNAME的心意我收下了")
      SET_QUEST_STATE(1904, 2)
      return
    end
  end
  if qData[2327].state == 1 then
    NPC_SAY("希望没什么事...")
  end
  if qData[2331].state == 1 and __QUEST_HAS_ALL_ITEMS(qt[2331].goal.getItem) then
    NPC_SAY("比我预想的时间要长啊，快告诉我发生了什么事~")
    SET_QUEST_STATE(2331, 2)
  end
  if qData[2332].state == 1 then
    NPC_SAY("新的重林...那里会有什么呢？")
  end
  if qData[2333].state == 1 then
    NPC_SAY("快告诉我新的重林里到底有什么？")
    SET_QUEST_STATE(2333, 2)
    return
  end
  if qData[2334].state == 1 then
    NPC_SAY("吕林城危险了！")
  end
  if qData[2338].state == 1 then
    NPC_SAY("回来了啊，这么久没消息，正担心你呢")
    SET_QUEST_STATE(2338, 2)
    return
  end
  if qData[2339].state == 1 then
    NPC_SAY("好的，我相信少侠。希望吕林城以后也能保持现在的安宁~")
    SET_QUEST_STATE(2339, 2)
    return
  end
  if qData[2677].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[2677].goal.getItem) then
      NPC_SAY("这么快，太谢谢了！")
      SET_QUEST_STATE(2677, 2)
      return
    else
      NPC_SAY("{0xFFFFFF00}嗜食怪{END}在{0xFFFFFF00}干涸的沼泽{END}找就行了。")
    end
  end
  if qData[2792].state == 1 then
    NPC_SAY("好久不见，过得好吗？")
    SET_QUEST_STATE(2792, 2)
    return
  end
  if qData[2793].state == 1 then
    NPC_SAY("去{0xFFFFFF00}吕林城西{END}找{0xFFFFFF00}吕林城老婆婆{END}，给她看看{0xFFFFFF00}獐子潭石板{END}吧。")
  end
  if qData[2794].state == 1 then
    NPC_SAY("老婆婆怎么说的？什么？是诅咒？")
    SET_QUEST_STATE(2794, 2)
    return
  end
  if qData[2795].state == 1 then
    NPC_SAY("拜托你去说服{0xFFFFFF00}吕林城西{END}的{0xFFFFFF00}吕林城老婆婆{END}吧。")
  end
  if qData[2797].state == 1 then
    NPC_SAY("{0xFFFFCCCC}(清丽公主听说后很惊讶。){END}老婆婆让你和秋叨鱼离开村庄？！")
    SET_QUEST_STATE(2797, 2)
    return
  end
  if qData[2798].state == 1 then
    NPC_SAY("谁都不理解我..我只是想让大家幸福..")
    SET_QUEST_STATE(2798, 2)
    return
  end
  if qData[2812].state == 1 then
    NPC_SAY("怎么样了？")
    SET_QUEST_STATE(2812, 2)
    return
  end
  if qData[2813].state == 1 then
    NPC_SAY("击退30个{0xFFFFFF00}干涸的沼泽{END}的{0xFFFFFF00}破戒僧{END}，去找{0xFFFFFF00}[封印之石]{END}的{0xFFFFFF00}[菊花碴]{END}就可以了。")
  end
  if qData[3725].state == 1 then
    if qData[3725].killMonster[qt[3725].goal.killMonster[1].id] >= qt[3725].goal.killMonster[1].count then
      NPC_SAY("谢谢。")
      SET_QUEST_STATE(3725, 2)
      return
    else
      NPC_SAY("为了吕林城我愿意做任何事情。帮我击退80个{0xFFFFFF00}嗜食怪{END}吧。")
    end
  end
  if qData[3726].state == 1 then
    if qData[3726].killMonster[qt[3726].goal.killMonster[1].id] >= qt[3726].goal.killMonster[1].count then
      NPC_SAY("谢谢。")
      SET_QUEST_STATE(3726, 2)
      return
    else
      NPC_SAY("为了吕林城我愿意做任何事情。帮我击退80个{0xFFFFFF00}临浦怪{END}吧。")
    end
  end
  if qData[3727].state == 1 then
    if qData[3727].killMonster[qt[3727].goal.killMonster[1].id] >= qt[3727].goal.killMonster[1].count then
      NPC_SAY("谢谢。")
      SET_QUEST_STATE(3727, 2)
      return
    else
      NPC_SAY("为了吕林城我愿意做任何事情。帮我击退80个{0xFFFFFF00}志鬼心火{END}吧。")
    end
  end
  if qData[3728].state == 1 then
    if qData[3728].killMonster[qt[3728].goal.killMonster[1].id] >= qt[3728].goal.killMonster[1].count then
      NPC_SAY("谢谢。")
      SET_QUEST_STATE(3728, 2)
      return
    else
      NPC_SAY("为了吕林城我愿意做任何事情。帮我击退80个{0xFFFFFF00}破戒僧{END}吧。")
    end
  end
  if qData[2836].state == 1 and qData[2836].killMonster[qt[2836].goal.killMonster[1].id] >= qt[2836].goal.killMonster[1].count then
    NPC_SAY("对獐子潭有什么了解的吗？")
    SET_QUEST_STATE(2836, 2)
  end
  if qData[2837].state == 1 then
    NPC_SAY("我只希望大家都能幸福..")
    SET_QUEST_STATE(2837, 2)
    return
  end
  ADD_NEW_SHOP_BTN(id, 10070)
  if qData[977].state == 0 and GET_PLAYER_LEVEL() >= qt[977].needLevel and GET_PLAYER_JOB2() ~= 13 then
    ADD_QUEST_BTN(qt[977].id, qt[977].name)
  end
  if qData[893].state == 0 and GET_PLAYER_LEVEL() >= qt[893].needLevel and GET_PLAYER_JOB2() ~= 13 then
    ADD_QUEST_BTN(qt[893].id, qt[893].name)
  end
  if qData[1047].state == 0 then
    ADD_QUEST_BTN(qt[1047].id, qt[1047].name)
  end
  if qData[1904].state == 0 and qData[1902].state == 2 then
    ADD_QUEST_BTN(qt[1904].id, qt[1904].name)
  end
  if qData[2327].state == 0 and GET_PLAYER_LEVEL() >= qt[2327].needLevel then
    ADD_QUEST_BTN(qt[2327].id, qt[2327].name)
  end
  if qData[2332].state == 0 and qData[2331].state == 2 and GET_PLAYER_LEVEL() >= qt[2332].needLevel then
    ADD_QUEST_BTN(qt[2332].id, qt[2332].name)
  end
  if qData[2334].state == 0 and qData[2333].state == 2 and GET_PLAYER_LEVEL() >= qt[2334].needLevel then
    ADD_QUEST_BTN(qt[2334].id, qt[2334].name)
  end
  if qData[2339].state == 0 and qData[2338].state == 2 and GET_PLAYER_LEVEL() >= qt[2339].needLevel then
    ADD_QUEST_BTN(qt[2339].id, qt[2339].name)
  end
  if qData[2677].state == 0 and GET_PLAYER_LEVEL() >= qt[2677].needLevel then
    ADD_QUEST_BTN(qt[2677].id, qt[2677].name)
  end
  if qData[2793].state == 0 and qData[2792].state == 2 and GET_PLAYER_LEVEL() >= qt[2793].needLevel then
    ADD_QUEST_BTN(qt[2793].id, qt[2793].name)
  end
  if qData[2795].state == 0 and qData[2794].state == 2 and GET_PLAYER_LEVEL() >= qt[2795].needLevel then
    ADD_QUEST_BTN(qt[2795].id, qt[2795].name)
  end
  if qData[2798].state == 0 and qData[2797].state == 2 and GET_PLAYER_LEVEL() >= qt[2798].needLevel then
    ADD_QUEST_BTN(qt[2798].id, qt[2798].name)
  end
  if qData[2813].state == 0 and qData[2812].state == 2 and GET_PLAYER_LEVEL() >= qt[2813].needLevel then
    ADD_QUEST_BTN(qt[2813].id, qt[2813].name)
  end
  if qData[3725].state == 0 and GET_PLAYER_LEVEL() >= qt[3725].needLevel then
    ADD_QUEST_BTN(qt[3725].id, qt[3725].name)
  end
  if qData[3726].state == 0 and GET_PLAYER_LEVEL() >= qt[3726].needLevel then
    ADD_QUEST_BTN(qt[3726].id, qt[3726].name)
  end
  if qData[3727].state == 0 and GET_PLAYER_LEVEL() >= qt[3727].needLevel then
    ADD_QUEST_BTN(qt[3727].id, qt[3727].name)
  end
  if qData[3728].state == 0 and GET_PLAYER_LEVEL() >= qt[3728].needLevel then
    ADD_QUEST_BTN(qt[3728].id, qt[3728].name)
  end
  if qData[2837].state == 0 and qData[2836].state == 2 and GET_PLAYER_LEVEL() >= qt[2837].needLevel then
    ADD_QUEST_BTN(qt[2837].id, qt[2837].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[893].state ~= 2 and GET_PLAYER_LEVEL() >= qt[893].needLevel then
    if qData[893].state == 1 then
      if qData[893].killMonster[qt[893].goal.killMonster[1].id] >= qt[893].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1047].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1047].needLevel then
    if qData[1047].state == 1 then
      if qData[1047].killMonster[qt[1047].goal.killMonster[1].id] >= qt[1047].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, qData[1047].state)
      end
    else
      QSTATE(id, qData[1047].state)
    end
  end
  if qData[1904].state ~= 2 and qData[1902].state == 2 and GET_PLAYER_LEVEL() >= qt[1904].needLevel then
    if qData[1904].state == 1 then
      if qData[1904].meetNpc[1] ~= qt[1904].goal.meetNpc[1] then
        QSTATE(id, 2)
      else
        QSTATE(id, qData[1904].state)
      end
    else
      QSTATE(id, qData[1904].state)
    end
  end
  if qData[2327].state ~= 2 and GET_PLAYER_LEVEL() >= qt[2327].needLevel then
    if qData[2327].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2331].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[2331].goal.getItem) then
      QSTATE(id, 2)
    else
      QSTATE(id, 1)
    end
  end
  if qData[2332].state ~= 2 and qData[2331].state == 2 and GET_PLAYER_LEVEL() >= qt[2332].needLevel then
    if qData[2332].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2333].state == 1 then
    QSTATE(id, 2)
  end
  if qData[2334].state ~= 2 and qData[2333].state == 2 and GET_PLAYER_LEVEL() >= qt[2334].needLevel then
    if qData[2334].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2338].state == 1 then
    QSTATE(id, 2)
  end
  if qData[2339].state ~= 2 and qData[2338].state == 2 and GET_PLAYER_LEVEL() >= qt[2339].needLevel then
    if qData[2339].state == 1 then
      QSTATE(id, 2)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2677].state ~= 2 and GET_PLAYER_LEVEL() >= qt[2677].needLevel then
    if qData[2677].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[2677].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2792].state == 1 and CHECK_ITEM_CNT(qt[2792].goal.getItem[1].id) >= qt[2792].goal.getItem[1].count and __QUEST_HAS_ALL_KILL_TARGETS(qt[2792].goal.killMonster) then
    QSTATE(id, 2)
  end
  if qData[2793].state ~= 2 and qData[2792].state == 2 and GET_PLAYER_LEVEL() >= qt[2793].needLevel then
    if qData[2793].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2794].state == 1 then
    QSTATE(id, 2)
  end
  if qData[2795].state ~= 2 and qData[2794].state == 2 and GET_PLAYER_LEVEL() >= qt[2795].needLevel then
    if qData[2795].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2797].state == 1 then
    QSTATE(id, 2)
  end
  if qData[2798].state ~= 2 and qData[2797].state == 2 and GET_PLAYER_LEVEL() >= qt[2798].needLevel then
    if qData[2798].state == 1 then
      QSTATE(id, 2)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2812].state == 1 then
    QSTATE(id, 2)
  end
  if qData[2813].state ~= 2 and qData[2812].state == 2 and GET_PLAYER_LEVEL() >= qt[2813].needLevel then
    if qData[2813].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[3725].state ~= 2 and GET_PLAYER_LEVEL() >= qt[3725].needLevel then
    if qData[3725].state == 1 then
      if qData[3725].killMonster[qt[3725].goal.killMonster[1].id] >= qt[3725].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[3726].state ~= 2 and GET_PLAYER_LEVEL() >= qt[3726].needLevel then
    if qData[3726].state == 1 then
      if qData[3726].killMonster[qt[3726].goal.killMonster[1].id] >= qt[3726].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[3727].state ~= 2 and GET_PLAYER_LEVEL() >= qt[3727].needLevel then
    if qData[3727].state == 1 then
      if qData[3727].killMonster[qt[3727].goal.killMonster[1].id] >= qt[3727].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[3728].state ~= 2 and GET_PLAYER_LEVEL() >= qt[3728].needLevel then
    if qData[3728].state == 1 then
      if qData[3728].killMonster[qt[3728].goal.killMonster[1].id] >= qt[3728].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2836].state ~= 2 and GET_PLAYER_LEVEL() >= qt[2836].needLevel then
    if qData[2836].state == 1 then
      if qData[2836].killMonster[qt[2836].goal.killMonster[1].id] >= qt[2836].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2837].state == 1 then
    QSTATE(id, 2)
  end
end
