function npcsay(id)
  if id ~= 4323008 then
    return
  end
  NPC_SAY("......")
  clickNPCid = id
  if qData[1475].state == 1 then
    NPC_SAY("去{0xFFFFFF00}安哥拉王宫{END}见{0xFFFFFF00}近卫兵降落伞{END}吧。得在他那儿得到旅行许可")
  end
  if qData[2821].state == 1 and qData[2821].killMonster[qt[2821].goal.killMonster[1].id] >= qt[2821].goal.killMonster[1].count then
    NPC_SAY("这里是{0xFFFFFF00}安哥拉王国{END}。")
    SET_QUEST_STATE(2821, 2)
    return
  end
  if qData[2857].state == 1 then
    NPC_SAY("{0xFFFFFF00}银行员辛巴达{END}在{0xFFFFFF00}安哥拉市商家{END}。")
  end
  if qData[2865].state == 1 then
    NPC_SAY("我现在还不能相信你！")
    SET_QUEST_STATE(2865, 2)
    return
  end
  if qData[2866].state == 1 then
    if qData[2866].killMonster[qt[2866].goal.killMonster[1].id] >= qt[2866].goal.killMonster[1].count then
      NPC_SAY("回来了？没受伤吧？")
      SET_QUEST_STATE(2866, 2)
      return
    else
      NPC_SAY("我相信你。在{0xFFFFFF00}吕墩平原[1]{END}击退60个{0xFFFFFF00}甲山女鬼{END}吧。")
    end
  end
  if qData[2867].state == 1 then
    if qData[2867].killMonster[qt[2867].goal.killMonster[1].id] >= qt[2867].goal.killMonster[1].count then
      NPC_SAY("都击退了啊。辛苦了！先缓一下，等达到{0xFFFFFF00}172功力{END}再见吧。")
      SET_QUEST_STATE(2867, 2)
      return
    else
      NPC_SAY("我相信你。帮忙击退60个{0xFFFFFF00}吕墩平原{END}的{0xFFFFFF00}狂豚魔人{END}吧。")
    end
  end
  if qData[2868].state == 1 then
    if qData[2868].killMonster[qt[2868].goal.killMonster[1].id] >= qt[2868].goal.killMonster[1].count then
      NPC_SAY("{0xFFFFCCCC}(用手捂住伤口){END}我有个请求。能去{0xFFFFFF00}医生八字胡老头{END}帮我拿点治疗剂吗？")
      SET_QUEST_STATE(2868, 2)
      return
    else
      NPC_SAY("这是最后一次！你追到{0xFFFFFF00}吕墩平原{END}击退60个{0xFFFFFF00}咸兴魔灵{END}吧。")
    end
  end
  if qData[2870].state == 1 then
    NPC_SAY("{0xFFFFFF00}医生八字胡老头{END}能在{0xFFFFFF00}安哥拉市广场{END}见到。他看起来凶，但其实是位很好的人。")
  end
  if qData[3776].state == 1 then
    if qData[3776].killMonster[qt[3776].goal.killMonster[1].id] >= qt[3776].goal.killMonster[1].count then
      NPC_SAY("大家都辛苦了。解散！")
      SET_QUEST_STATE(3776, 2)
      return
    else
      NPC_SAY("今天的目标是击退50个{0xFFFFFF00}甲山女鬼{END}！")
    end
  end
  if qData[3777].state == 1 then
    if qData[3777].killMonster[qt[3777].goal.killMonster[1].id] >= qt[3777].goal.killMonster[1].count then
      NPC_SAY("大家都辛苦了。解散！")
      SET_QUEST_STATE(3777, 2)
      return
    else
      NPC_SAY("今天的目标是击退50个{0xFFFFFF00}狂豚魔人{END}！")
    end
  end
  if qData[3780].state == 1 then
    if qData[3780].killMonster[qt[3780].goal.killMonster[1].id] >= qt[3780].goal.killMonster[1].count then
      NPC_SAY("大家都辛苦了。解散！")
      SET_QUEST_STATE(3780, 2)
      return
    else
      NPC_SAY("今天的目标是50个{0xFFFFFF00}咸兴魔灵{END}！")
    end
  end
  if qData[3781].state == 1 then
    if qData[3781].killMonster[qt[3781].goal.killMonster[1].id] >= qt[3781].goal.killMonster[1].count then
      NPC_SAY("大家都辛苦了。解散！")
      SET_QUEST_STATE(3781, 2)
      return
    else
      NPC_SAY("今天的目标是50个{0xFFFFFF00}马面人鬼{END}！")
    end
  end
  if qData[1475].state == 0 and GET_PLAYER_LEVEL() >= qt[1475].needLevel then
    ADD_QUEST_BTN(qt[1475].id, qt[1475].name)
  end
  if qData[2857].state == 0 and qData[2821].state == 2 and GET_PLAYER_LEVEL() >= qt[2857].needLevel then
    ADD_QUEST_BTN(qt[2857].id, qt[2857].name)
  end
  if qData[2865].state == 0 and qData[2864].state == 2 and GET_PLAYER_LEVEL() >= qt[2865].needLevel then
    ADD_QUEST_BTN(qt[2865].id, qt[2865].name)
  end
  if qData[2866].state == 0 and qData[2865].state == 2 and GET_PLAYER_LEVEL() >= qt[2866].needLevel then
    ADD_QUEST_BTN(qt[2866].id, qt[2866].name)
  end
  if qData[2867].state == 0 and qData[2866].state == 2 and GET_PLAYER_LEVEL() >= qt[2867].needLevel then
    ADD_QUEST_BTN(qt[2867].id, qt[2867].name)
  end
  if qData[2868].state == 0 and qData[2867].state == 2 and GET_PLAYER_LEVEL() >= qt[2868].needLevel then
    ADD_QUEST_BTN(qt[2868].id, qt[2868].name)
  end
  if qData[2870].state == 0 and qData[2869].state == 2 and GET_PLAYER_LEVEL() >= qt[2870].needLevel then
    ADD_QUEST_BTN(qt[2870].id, qt[2870].name)
  end
  if qData[3776].state == 0 and qData[2866].state == 2 and GET_PLAYER_LEVEL() >= qt[3776].needLevel then
    ADD_QUEST_BTN(qt[3776].id, qt[3776].name)
  end
  if qData[3777].state == 0 and qData[2867].state == 2 and GET_PLAYER_LEVEL() >= qt[3777].needLevel then
    ADD_QUEST_BTN(qt[3777].id, qt[3777].name)
  end
  if qData[3780].state == 0 and qData[2885].state == 2 and GET_PLAYER_LEVEL() >= qt[3780].needLevel then
    ADD_QUEST_BTN(qt[3780].id, qt[3780].name)
  end
  if qData[3781].state == 0 and qData[2896].state == 2 and GET_PLAYER_LEVEL() >= qt[3781].needLevel then
    ADD_QUEST_BTN(qt[3781].id, qt[3781].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[1475].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1475].needLevel then
    if qData[1475].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2821].state ~= 2 and qData[2820].state == 2 and GET_PLAYER_LEVEL() >= qt[2821].needLevel then
    if qData[2821].state == 1 then
      if qData[2821].killMonster[qt[2821].goal.killMonster[1].id] >= qt[2821].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2857].state ~= 2 and qData[2821].state == 2 and GET_PLAYER_LEVEL() >= qt[2857].needLevel then
    if qData[2857].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2865].state ~= 2 and qData[2864].state == 2 and GET_PLAYER_LEVEL() >= qt[2865].needLevel then
    if qData[2865].state == 1 then
      QSTATE(id, 2)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2866].state ~= 2 and qData[2865].state == 2 and GET_PLAYER_LEVEL() >= qt[2866].needLevel then
    if qData[2866].state == 1 then
      if qData[2866].killMonster[qt[2866].goal.killMonster[1].id] >= qt[2866].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2867].state ~= 2 and qData[2866].state == 2 and GET_PLAYER_LEVEL() >= qt[2867].needLevel then
    if qData[2867].state == 1 then
      if qData[2867].killMonster[qt[2867].goal.killMonster[1].id] >= qt[2867].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2868].state ~= 2 and qData[2867].state == 2 and GET_PLAYER_LEVEL() >= qt[2868].needLevel then
    if qData[2868].state == 1 then
      if qData[2868].killMonster[qt[2868].goal.killMonster[1].id] >= qt[2868].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2870].state ~= 2 and qData[2869].state == 2 and GET_PLAYER_LEVEL() >= qt[2870].needLevel then
    if qData[2870].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[3776].state ~= 2 and qData[2866].state == 2 and GET_PLAYER_LEVEL() >= qt[3776].needLevel then
    if qData[3776].state == 1 then
      if qData[3776].killMonster[qt[3776].goal.killMonster[1].id] >= qt[3776].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[3777].state ~= 2 and qData[2867].state == 2 and GET_PLAYER_LEVEL() >= qt[3777].needLevel then
    if qData[3777].state == 1 then
      if qData[3777].killMonster[qt[3777].goal.killMonster[1].id] >= qt[3777].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[3780].state ~= 2 and qData[2885].state == 2 and GET_PLAYER_LEVEL() >= qt[3780].needLevel then
    if qData[3780].state == 1 then
      if qData[3780].killMonster[qt[3780].goal.killMonster[1].id] >= qt[3780].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[3781].state ~= 2 and qData[2896].state == 2 and GET_PLAYER_LEVEL() >= qt[3781].needLevel then
    if qData[3781].state == 1 then
      if qData[3781].killMonster[qt[3781].goal.killMonster[1].id] >= qt[3781].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
end
