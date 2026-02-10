function npcsay(id)
  if id ~= 4314035 then
    return
  end
  clickNPCid = id
  if qData[2122].state == 1 then
    if qData[2122].killMonster[qt[2122].goal.killMonster[1].id] >= qt[2122].goal.killMonster[1].count then
      NPC_SAY("谢谢，少侠")
      SET_QUEST_STATE(2122, 2)
      return
    else
      NPC_SAY("双头鸡怪，要是没有这个家伙就好了")
    end
  end
  if qData[2123].state == 1 then
    if qData[2123].killMonster[qt[2123].goal.killMonster[1].id] >= qt[2123].goal.killMonster[1].count then
      NPC_SAY("真的非常感谢，少侠")
      SET_QUEST_STATE(2123, 2)
      return
    else
      NPC_SAY("没睡好觉，皮肤都松弛了")
    end
  end
  if qData[2124].state == 1 then
    if qData[2124].killMonster[qt[2124].goal.killMonster[1].id] >= qt[2124].goal.killMonster[1].count then
      NPC_SAY("终于可以安心了，我不回忘记你的恩惠.")
      SET_QUEST_STATE(2124, 2)
      return
    else
      NPC_SAY("现在害怕得连觉也不敢睡了.")
    end
  end
  if qData[2126].state == 1 then
    if CHECK_ITEM_CNT(qt[2126].goal.getItem[1].id) >= qt[2126].goal.getItem[1].count then
      NPC_SAY("啊，真的很美.")
      SET_QUEST_STATE(2126, 2)
      return
    else
      NPC_SAY("就算不是鲜花，是冰花也想看一下.")
    end
  end
  if qData[2127].state == 1 then
    if CHECK_ITEM_CNT(qt[2127].goal.getItem[1].id) >= qt[2127].goal.getItem[1].count then
      NPC_SAY("谢谢.")
      SET_QUEST_STATE(2127, 2)
      return
    else
      NPC_SAY("还没收集好么？快去收集吧.")
    end
  end
  if qData[2128].state == 1 then
    if CHECK_ITEM_CNT(qt[2128].goal.getItem[1].id) >= qt[2128].goal.getItem[1].count then
      NPC_SAY("我终于达成愿望做了花坛。谢谢.")
      SET_QUEST_STATE(2128, 2)
      return
    else
      NPC_SAY("我得做一个花坛")
    end
  end
  if qData[2135].state == 1 then
    if CHECK_ITEM_CNT(qt[2135].goal.getItem[1].id) >= qt[2135].goal.getItem[1].count then
      NPC_SAY("非常感谢。啊啾！")
      SET_QUEST_STATE(2135, 2)
      return
    else
      NPC_SAY("只要冰柱就可以了。吼吼吼")
    end
  end
  if qData[2122].state == 0 then
    ADD_QUEST_BTN(qt[2122].id, qt[2122].name)
  end
  if qData[2123].state == 0 and qData[2122].state == 2 then
    ADD_QUEST_BTN(qt[2123].id, qt[2123].name)
  end
  if qData[2124].state == 0 and qData[2123].state == 2 then
    ADD_QUEST_BTN(qt[2124].id, qt[2124].name)
  end
  if qData[2126].state == 0 then
    ADD_QUEST_BTN(qt[2126].id, qt[2126].name)
  end
  if qData[2127].state == 0 and qData[2126].state == 2 then
    ADD_QUEST_BTN(qt[2127].id, qt[2127].name)
  end
  if qData[2128].state == 0 and qData[2127].state == 2 then
    ADD_QUEST_BTN(qt[2128].id, qt[2128].name)
  end
  if qData[2135].state == 0 then
    ADD_QUEST_BTN(qt[2135].id, qt[2135].name)
  end
  if GET_PLAYER_JOB2() == 1 then
  end
  if GET_PLAYER_JOB2() == 3 then
  end
  if GET_PLAYER_JOB2() == 5 then
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[2122].state ~= 2 and GET_PLAYER_LEVEL() >= qt[2122].needLevel then
    if qData[2122].state == 1 then
      if qData[2122].killMonster[qt[2122].goal.killMonster[1].id] >= qt[2122].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2122].state == 2 and qData[2123].state ~= 2 and GET_PLAYER_LEVEL() >= qt[2123].needLevel then
    if qData[2123].state == 1 then
      if qData[2123].killMonster[qt[2123].goal.killMonster[1].id] >= qt[2123].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2123].state == 2 and qData[2124].state ~= 2 and GET_PLAYER_LEVEL() >= qt[2124].needLevel then
    if qData[2124].state == 1 then
      if qData[2124].killMonster[qt[2124].goal.killMonster[1].id] >= qt[2124].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2126].state ~= 2 and GET_PLAYER_LEVEL() >= qt[2126].needLevel then
    if qData[2126].state == 1 then
      if CHECK_ITEM_CNT(qt[2126].goal.getItem[1].id) >= qt[2126].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2126].state == 2 and qData[2127].state ~= 2 and GET_PLAYER_LEVEL() >= qt[2127].needLevel then
    if qData[2127].state == 1 then
      if CHECK_ITEM_CNT(qt[2127].goal.getItem[1].id) >= qt[2127].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2127].state == 2 and qData[2128].state ~= 2 and GET_PLAYER_LEVEL() >= qt[2128].needLevel then
    if qData[2128].state == 1 then
      if CHECK_ITEM_CNT(qt[2128].goal.getItem[1].id) >= qt[2128].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2135].state ~= 2 and GET_PLAYER_LEVEL() >= qt[2135].needLevel then
    if qData[2135].state == 1 then
      if CHECK_ITEM_CNT(qt[2135].goal.getItem[1].id) >= qt[2135].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
end
