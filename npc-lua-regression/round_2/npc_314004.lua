function npcsay(id)
  if id ~= 4314004 then
    return
  end
  clickNPCid = id
  NPC_SAY("好想你啊相公，你安息吧。")
  if qData[1131].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[1131].goal.getItem) then
      if 2 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("太感谢了。这个恩惠都不知道该怎么报答呢。虽然微不足道但却是我的心意，还请你收下吧。")
        SET_QUEST_STATE(1131, 2)
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("一定要去击退北清阴平原的触目仔和蛋蛋小妖，收集回来5个[ 触目仔的眼珠 ]和5个[ 毒菇 ]。拜托了。只要父亲的病好了就无所求了..呜呜")
    end
  end
  if qData[1131].state == 0 then
    ADD_QUEST_BTN(qt[1131].id, qt[1131].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[1131].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1131].needLevel then
    if qData[1131].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[1131].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
end
