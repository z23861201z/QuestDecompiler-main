function npcsay(id)
  if id ~= 4314036 then
    return
  end
  clickNPCid = id
  if qData[2119].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[2119].goal.getItem) then
      NPC_SAY("辛苦了。我要烤着吃")
      SET_QUEST_STATE(2119, 2)
      return
    else
      NPC_SAY("快去拿雪卵来！我好想吃啊")
    end
  end
  if qData[2120].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[2120].goal.getItem) then
      NPC_SAY("辛苦了。这次我要煮着吃")
      SET_QUEST_STATE(2120, 2)
      return
    else
      NPC_SAY("快去拿雪卵来！我好想吃啊")
    end
  end
  if qData[2121].state == 1 then
    if CHECK_ITEM_CNT(qt[2121].goal.getItem[1].id) >= qt[2121].goal.getItem[1].count then
      NPC_SAY("真的辛苦了。这次我得省着点儿吃了")
      SET_QUEST_STATE(2121, 2)
      return
    else
      NPC_SAY("啊！好想吃哦")
    end
  end
  if qData[2131].state == 1 then
    if qData[2131].killMonster[qt[2131].goal.killMonster[1].id] >= qt[2131].goal.killMonster[1].count then
      NPC_SAY("辛苦了")
      SET_QUEST_STATE(2131, 2)
      return
    else
      NPC_SAY("体力！想要拯救世界就要增强体力！")
    end
  end
  if qData[2132].state == 1 then
    if qData[2132].killMonster[qt[2132].goal.killMonster[1].id] >= qt[2132].goal.killMonster[1].count then
      NPC_SAY("辛苦了")
      SET_QUEST_STATE(2132, 2)
      return
    else
      NPC_SAY("体力！想要拯救世界就要增强体力！")
    end
  end
  if qData[2133].state == 1 then
    if qData[2133].killMonster[qt[2133].goal.killMonster[1].id] >= qt[2133].goal.killMonster[1].count then
      NPC_SAY("辛苦了.")
      SET_QUEST_STATE(2133, 2)
      return
    else
      NPC_SAY("体力！想要拯救世界就要增强体力！")
    end
  end
  if qData[2134].state == 1 then
    if CHECK_ITEM_CNT(qt[2134].goal.getItem[1].id) >= qt[2134].goal.getItem[1].count then
      NPC_SAY("辛苦了.")
      SET_QUEST_STATE(2134, 2)
      return
    else
      NPC_SAY("我的斧头很特别，非常特别")
    end
  end
  if qData[2119].state == 0 then
    ADD_QUEST_BTN(qt[2119].id, qt[2119].name)
  end
  if qData[2120].state == 0 and qData[2119].state == 2 then
    ADD_QUEST_BTN(qt[2120].id, qt[2120].name)
  end
  if qData[2121].state == 0 and qData[2120].state == 2 then
    ADD_QUEST_BTN(qt[2121].id, qt[2121].name)
  end
  if qData[2131].state == 0 then
    ADD_QUEST_BTN(qt[2131].id, qt[2131].name)
  end
  if qData[2132].state == 0 and qData[2131].state == 2 then
    ADD_QUEST_BTN(qt[2132].id, qt[2132].name)
  end
  if qData[2133].state == 0 and qData[2132].state == 2 then
    ADD_QUEST_BTN(qt[2133].id, qt[2133].name)
  end
  if qData[2134].state == 0 then
    ADD_QUEST_BTN(qt[2134].id, qt[2134].name)
  end
  if GET_PLAYER_JOB2() == 2 then
  end
  if GET_PLAYER_JOB2() == 4 then
  end
  if GET_PLAYER_JOB2() == 6 then
  end
end
function chkQState(id)
  QSTATE(id, false)
  if qData[2119].state ~= 2 and GET_PLAYER_LEVEL() >= qt[2119].needLevel then
    if qData[2119].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[2119].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2119].state == 2 and qData[2120].state ~= 2 and GET_PLAYER_LEVEL() >= qt[2120].needLevel then
    if qData[2120].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[2120].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2120].state == 2 and qData[2121].state ~= 2 and GET_PLAYER_LEVEL() >= qt[2121].needLevel then
    if qData[2121].state == 1 then
      if CHECK_ITEM_CNT(qt[2121].goal.getItem[1].id) >= qt[2121].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2131].state ~= 2 and GET_PLAYER_LEVEL() >= qt[2131].needLevel then
    if qData[2131].state == 1 then
      if qData[2131].killMonster[qt[2131].goal.killMonster[1].id] >= qt[2131].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2131].state ~= 2 and GET_PLAYER_LEVEL() >= qt[2131].needLevel then
    if qData[2131].state == 1 then
      if qData[2131].killMonster[qt[2131].goal.killMonster[1].id] >= qt[2131].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2131].state == 2 and qData[2132].state ~= 2 and GET_PLAYER_LEVEL() >= qt[2132].needLevel then
    if qData[2132].state == 1 then
      if qData[2132].killMonster[qt[2132].goal.killMonster[1].id] >= qt[2132].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2132].state == 2 and qData[2133].state ~= 2 and GET_PLAYER_LEVEL() >= qt[2133].needLevel then
    if qData[2133].state == 1 then
      if qData[2133].killMonster[qt[2133].goal.killMonster[1].id] >= qt[2133].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2134].state ~= 2 and GET_PLAYER_LEVEL() >= qt[2134].needLevel then
    if qData[2134].state == 1 then
      if CHECK_ITEM_CNT(qt[2134].goal.getItem[1].id) >= qt[2134].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
end
