function npcsay(id)
  if id ~= 4391913 then
    return
  end
  clickNPCid = id
  if qData[805].state == 1 then
    if 1 <= CHECK_INVENTORY_CNT(3) and 1 <= CHECK_INVENTORY_CNT(4) then
      NPC_SAY("居民给大侠您准备了小礼物，大侠可以在其中挑选一样，其余会用于都城整修。请选择您心仪的物品。")
      SET_MEETNPC(805, 1, id)
      SET_QUEST_STATE(805, 2)
    else
      NPC_SAY("行囊太沉。")
      return
    end
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[805].state == 1 and GET_PLAYER_LEVEL() >= qt[805].needLevel then
    QSTATE(id, 2)
  end
end
