function npcsay(id)
  if id ~= 4323004 then
    return
  end
  NPC_SAY("这样下去可能会出大事。")
  clickNPCid = id
  if qData[2185].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[2185].goal.getItem) then
      NPC_SAY("谢谢！所有东西都准备好了。辛苦了~虽然报酬不是很多，但还是希望您能收下")
      SET_QUEST_STATE(2185, 2)
      return
    else
      NPC_SAY("帮我去击退火骨士兵，收集50个烧剩的骨头回来吧")
    end
  end
  if qData[3648].state == 1 then
    if CHECK_ITEM_CNT(qt[3648].goal.getItem[1].id) >= qt[3648].goal.getItem[1].count then
      NPC_SAY("谢谢！所有东西都准备好了。辛苦了。希望你明天也能帮忙")
      SET_QUEST_STATE(3648, 2)
      return
    else
      NPC_SAY("击退火骨士兵，收集50个烧剩的骨头回来吧")
    end
  end
  if qData[2185].state == 0 then
    ADD_QUEST_BTN(qt[2185].id, qt[2185].name)
  end
  if qData[3648].state == 0 and qData[2185].state == 2 then
    ADD_QUEST_BTN(qt[3648].id, qt[3648].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[2185].state ~= 2 and GET_PLAYER_LEVEL() >= qt[2185].needLevel then
    if qData[2185].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[2185].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[3648].state ~= 2 and qData[2185].state == 2 and GET_PLAYER_LEVEL() >= qt[3648].needLevel then
    if qData[3648].state == 1 then
      if CHECK_ITEM_CNT(qt[3648].goal.getItem[1].id) >= qt[3648].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
end
