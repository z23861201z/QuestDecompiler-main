function npcsay(id)
  if id ~= 4391102 then
    return
  end
  clickNPCid = id
  NPC_SAY("辛苦了。要不是少侠真不敢想象…")
  if qData[1263].state == 1 and qData[1263].killMonster[qt[1263].goal.killMonster[1].id] >= qt[1263].goal.killMonster[1].count then
    if 1 <= CHECK_INVENTORY_CNT(2) then
      NPC_SAY("以为都结束了的。少侠继清阴关又救了冥珠城。这是冥珠城居民们的谢礼。")
      SET_QUEST_STATE(1263, 2)
    else
      NPC_SAY("行囊太沉。")
    end
  end
  if qData[803].state == 1 then
    NPC_SAY("非常感谢。您是真正的武林侠客。")
    SET_QUEST_STATE(803, 2)
    return
  end
  ADD_NPC_WARP_INDUN_EXIT(id)
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[1263].state == 1 then
    if qData[1263].killMonster[qt[1263].goal.killMonster[1].id] >= qt[1263].goal.killMonster[1].count then
      QSTATE(id, 2)
    else
      QSTATE(id, 1)
    end
  end
  if qData[803].state == 1 then
    QSTATE(id, 2)
  end
end
