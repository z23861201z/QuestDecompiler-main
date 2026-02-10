function npcsay(id)
  if id ~= 4391105 then
    return
  end
  clickNPCid = id
  if qData[869].state == 1 then
    if 1 <= CHECK_INVENTORY_CNT(4) then
      NPC_SAY("辛苦了。但这是少侠跟愤怒的巨大鬼怪战斗时掉落的物品，少侠应该比我更需要。去异界门看看没准就知道用途了... ")
      SET_QUEST_STATE(869, 2)
      return
    else
      NPC_SAY("行囊太沉。")
    end
  end
  ADD_NPC_WARP_INDUN_EXIT(id)
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[869].state == 1 and qData[869].state ~= 2 and GET_PLAYER_LEVEL() >= qt[869].needLevel then
    if qData[869].meetNpc[1] == qt[869].goal.meetNpc[1] then
      QSTATE(id, 2)
    else
      QSTATE(id, 2)
    end
  end
end
