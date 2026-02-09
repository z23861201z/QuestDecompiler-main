function npcsay(id)
  if id ~= 4391012 then
    return
  end
  clickNPCid = id
  if qData[802].state == 1 then
    if 1 <= CHECK_INVENTORY_CNT(3) and 1 <= CHECK_INVENTORY_CNT(4) then
      NPC_SAY("谢谢。谢谢。我在这儿谢谢您了。有大侠出手，那些怪物暂时不敢来了。那明天也拜托您了。")
      SET_MEETNPC(802, 1, id)
      SET_QUEST_STATE(802, 2)
    else
      NPC_SAY("行囊太沉。")
      return
    end
  end
  ADD_NPC_WARP_INDUN_EXIT(id)
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[802].state == 1 then
    QSTATE(id, 2)
  end
end
