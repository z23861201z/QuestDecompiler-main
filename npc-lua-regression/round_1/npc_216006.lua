function npcsay(id)
  if id ~= 4216006 then
    return
  end
  clickNPCid = id
  NPC_SAY("有需要找我啊。")
  if qData[2125].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[2125].goal.getItem) then
      NPC_SAY("谢谢。如果查到什么会告诉你的")
      SET_QUEST_STATE(2125, 2)
      return
    else
      NPC_SAY("还没收集完雪卵么？")
    end
  end
  if qData[2129].state == 1 then
    if CHECK_ITEM_CNT(qt[2129].goal.getItem[1].id) >= qt[2129].goal.getItem[1].count then
      NPC_SAY("慰灵节准备结束了。谢谢")
      SET_QUEST_STATE(2129, 2)
      return
    else
      NPC_SAY("还没收集到足够的冰花么？")
    end
  end
  ADD_NEW_SHOP_BTN(id, 10031)
  if qData[2125].state == 0 then
    ADD_QUEST_BTN(qt[2125].id, qt[2125].name)
  end
  if qData[2129].state == 0 then
    ADD_QUEST_BTN(qt[2129].id, qt[2129].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[2125].state ~= 2 and GET_PLAYER_LEVEL() >= qt[2125].needLevel then
    if qData[2125].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[2125].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2129].state ~= 2 and GET_PLAYER_LEVEL() >= qt[2129].needLevel then
    if qData[2129].state == 1 then
      if CHECK_ITEM_CNT(qt[2129].goal.getItem[1].id) >= qt[2129].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
end
