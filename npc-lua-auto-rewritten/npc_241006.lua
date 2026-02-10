function npcsay(id)
  if id ~= 4241006 then
    return
  end
  clickNPCid = id
  NPC_SAY("嗯嗯…在这里干什么呢？")
  if qData[2903].state == 1 then
    if CHECK_ITEM_CNT(qt[2903].goal.getItem[1].id) >= qt[2903].goal.getItem[1].count then
      NPC_SAY("哇，这么快...我来看看。果然我的猜测是对的。在{0xFFFFFF00}晶石怪的腿{END}上能感觉得出很强的魔气。这程度完全能让人生病。")
      SET_QUEST_STATE(2903, 2)
      return
    else
      NPC_SAY("在{0xFFFFFF00}大瀑布{END}击退{0xFFFFFF00}晶石怪{END}后，收集50个{0xFFFFFF00}晶石怪的腿{END}回来吧。")
    end
  end
  if qData[2903].state == 0 and GET_PLAYER_LEVEL() >= qt[2903].needLevel then
    ADD_QUEST_BTN(qt[2903].id, qt[2903].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[2903].state ~= 2 and GET_PLAYER_LEVEL() >= qt[2903].needLevel then
    if qData[2903].state == 1 then
      if CHECK_ITEM_CNT(qt[2903].goal.getItem[1].id) >= qt[2903].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
end
