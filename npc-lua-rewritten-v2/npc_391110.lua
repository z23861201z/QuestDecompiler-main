function npcsay(id)
  if id ~= 4391110 then
    return
  end
  clickNPCid = id
  NPC_SAY("不能在这个地方逗留太久，快逃出去吧！")
  if qData[2162].state == 1 then
    if 1 <= CHECK_INVENTORY_CNT(4) then
      NPC_SAY("谢谢你的帮忙！这是你想要的东西")
      SET_QUEST_STATE(2162, 2)
      return
    else
      NPC_SAY("行囊太沉。")
    end
  end
  if qData[3623].state == 1 then
    NPC_SAY("谢谢你的帮忙！")
    SET_QUEST_STATE(3623, 2)
    return
  end
  ADD_NPC_WARP_INDUN_EXIT(id)
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[2162].state == 1 then
    QSTATE(id, 2)
  end
  if qData[3623].state == 1 then
    QSTATE(id, 2)
  end
end
