function npcsay(id)
  if id ~= 4391032 then
    return
  end
  clickNPCid = id
  if qData[806].state == 1 then
    if 1 <= CHECK_INVENTORY_CNT(3) and 1 <= CHECK_INVENTORY_CNT(4) then
      NPC_SAY("对不起~对不起~我再也不这样了。就算再饿我也会忍着的。以后我再也不抢人类的食物了")
      SET_QUEST_STATE(806, 2)
    else
      NPC_SAY("行囊太沉。")
    end
  end
  if qData[806].state ~= 1 then
    NPC_SAY("哈哈，地狱的钱都是我的~")
    ADD_NPC_WARP_INDUN_EXIT(id)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[676].state == 2 and qData[806].state == 1 and GET_PLAYER_LEVEL() >= qt[806].needLevel then
    QSTATE(id, 2)
  end
end
