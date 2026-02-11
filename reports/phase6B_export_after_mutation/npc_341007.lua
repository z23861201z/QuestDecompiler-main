function npcsay(id)
  if id ~= 4341007 then
    return
  end
  clickNPCid = id
  if qData[2914].state == 1 then
    if CHECK_ITEM_CNT(qt[2914].goal.getItem[1].id) >= qt[2914].goal.getItem[1].count then
      NPC_SAY("哇，这就是{0xFFFFFF00}虎羊大仙符咒{END}！能感受到破坏美。得亏拜托你了。")
      SET_QUEST_STATE(2914, 2)
      return
    else
      NPC_SAY("在{0xFFFFFF00}大瀑布{END}击退{0xFFFFFF00}虎羊大仙{END}，收集回来1个{0xFFFFFF00}虎羊大仙符咒{END}吧。")
    end
  end
  if qData[2914].state == 0 and GET_PLAYER_LEVEL() >= qt[2914].needLevel then
    ADD_QUEST_BTN(qt[2914].id, qt[2914].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[2914].state ~= 2 and GET_PLAYER_LEVEL() >= qt[2914].needLevel then
    if qData[2914].state == 1 then
      if CHECK_ITEM_CNT(qt[2914].goal.getItem[1].id) >= qt[2914].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
end
