function npcsay(id)
  if id ~= 4317002 then
    return
  end
  clickNPCid = id
  if qData[346].state == 1 then
    if qData[346].killMonster[qt[346].goal.killMonster[1].id] >= qt[346].goal.killMonster[1].count then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("真是太谢谢了。这下可以重新种地了。这些虽然微不足道但是我的诚意。")
        SET_QUEST_STATE(346, 2)
        return
      else
        NPC_SAY("??? ?????.")
      end
    else
      NPC_SAY("??? ????? ???? ?? ?? ?????... {0xFFFFFF00}[???] 15??{END}? ? ??? ????.")
    end
  end
  if qData[1137].state == 1 and qData[1137].meetNpc[1] == qt[1137].goal.meetNpc[1] and qData[1137].meetNpc[2] == qt[1137].goal.meetNpc[2] and qData[1137].meetNpc[3] == qt[1137].goal.meetNpc[3] and qData[1137].meetNpc[4] ~= id and CHECK_ITEM_CNT(8990012) > 0 then
    NPC_SAY("幸亏你传去了简讯，大家都重拾了信心。真的很感谢。")
    SET_MEETNPC(1137, 4, id)
    SET_QUEST_STATE(1137, 2)
  end
  if qData[1155].state == 1 then
    if 1 <= CHECK_INVENTORY_CNT(3) then
      NPC_SAY("嗯？什么事情啊？")
      SET_QUEST_STATE(1155, 2)
    else
      NPC_SAY("行囊太沉。")
    end
  end
  if qData[1157].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[1157].goal.getItem) then
      NPC_SAY("谢谢。可以用这个修理车轮了。虽然不多但表我谢意。")
      SET_QUEST_STATE(1157, 2)
    else
      NPC_SAY("修理车轮需要10个[车轮残片]。在强悍巷道击退叫车轮怪的怪物吧。")
    end
  end
  if qData[1165].state == 1 then
    if qData[1165].killMonster[qt[1165].goal.killMonster[1].id] >= qt[1165].goal.killMonster[1].count then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("真是太谢谢了。这下可以重新种地了。这些虽然微不足道但是我的诚意。")
        SET_QUEST_STATE(1165, 2)
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("还没好吗？这些家伙一直在毁掉田地呢… 一定要击退15只土拨鼠。土拨鼠在强悍巷道里。")
    end
  end
  if qData[1157].state == 0 and qData[1155].state == 2 then
    ADD_QUEST_BTN(qt[1157].id, qt[1157].name)
  end
  if qData[1165].state == 0 then
    ADD_QUEST_BTN(qt[1165].id, qt[1165].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[1137].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1137].needLevel and qData[1137].state == 1 and qData[1137].meetNpc[1] == qt[1137].goal.meetNpc[1] and qData[1137].meetNpc[2] == qt[1137].goal.meetNpc[2] and qData[1137].meetNpc[3] == qt[1137].goal.meetNpc[3] and qData[1137].meetNpc[4] ~= id then
    QSTATE(id, 2)
  end
  if qData[1153].state == 2 and qData[1155].state ~= 2 and qData[1155].state == 1 then
    QSTATE(id, 2)
  end
  if qData[1155].state == 2 and qData[1157].state ~= 2 then
    if qData[1157].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[1157].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1165].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1165].needLevel then
    if qData[1165].state == 1 then
      if qData[1165].killMonster[qt[1165].goal.killMonster[1].id] >= qt[1165].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
end
