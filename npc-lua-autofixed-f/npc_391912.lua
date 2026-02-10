function npcsay(id)
  if id ~= 4391912 then
    return
  end
  clickNPCid = id
  if qData[804].state == 1 and qData[804].meetNpc[2] ~= qt[804].goal.meetNpc[2] then
    if 1 <= CHECK_INVENTORY_CNT(3) and 1 <= CHECK_INVENTORY_CNT(4) then
      NPC_SAY("辛苦了。怪物暂时被打退了。虽然迟早会再回来，但是有大侠在这里，我们就安心了。希望这个奖励还不错。")
      SET_MEETNPC(804, 1, id)
      SET_QUEST_STATE(804, 2)
    else
      NPC_SAY("行囊太沉。")
      return
    end
  end
  if qData[1832].state == 1 and qData[1832].meetNpc[0] ~= qt[1832].goal.meetNpc[0] then
    if 1 <= CHECK_INVENTORY_CNT(4) then
      NPC_SAY("辛苦了。但这是少侠跟愤怒的巨大鬼怪战斗时掉落的物品，少侠应该比我更需要。去异界门看看没准就知道用途了... ")
      SET_MEETNPC(1832, 1, id)
      SET_QUEST_STATE(1832, 2)
    else
      NPC_SAY("行囊太沉。")
      return
    end
  end
  ADD_NPC_WARP_INDUN_EXIT(id)
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[804].state == 1 and GET_PLAYER_LEVEL() >= qt[804].needLevel then
    if qData[804].meetNpc[2] ~= qt[804].goal.meetNpc[2] then
      QSTATE(id, 2)
    else
      QSTATE(id, 1)
    end
  end
  if qData[1832].state == 1 and GET_PLAYER_LEVEL() >= qt[1832].neetLevel then
    if qData[1832].meetNpc[0] ~= qt[1832].goal.meetNpc[0] then
      QSTATE(id, 2)
    else
      QSTATE(id, 1)
    end
  end
end
