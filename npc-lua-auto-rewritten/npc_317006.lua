function npcsay(id)
  if id ~= 4317006 then
    return
  end
  clickNPCid = id
  if qData[329].state == 1 then
    if CHECK_ITEM_CNT(qt[329].goal.getItem[1].id) >= qt[329].goal.getItem[1].count then
      NPC_SAY("十分感谢。托你的福我可以休息一会儿了。这些虽然不多但请你手下。")
      SET_QUEST_STATE(329, 2)
    else
      NPC_SAY("一天到晚举着牌子的我不觉得可怜吗？一定要帮我击退强悍巷道里的车轮怪收集10个[车轮残片]回来吧。")
    end
  end
  if qData[1161].state == 1 then
    if CHECK_ITEM_CNT(qt[1161].goal.getItem[1].id) >= qt[1161].goal.getItem[1].count then
      NPC_SAY("十分感谢。托你的福我可以休息一会儿了。这些虽然不多但请你手下。")
      SET_QUEST_STATE(1161, 2)
    else
      NPC_SAY("一天到晚举着牌子的我不觉得可怜吗？一定要帮我击退强悍巷道里的车轮怪收集10个[车轮残片]回来吧。")
    end
  end
  if qData[1168].state == 1 then
    if CHECK_ITEM_CNT(qt[1168].goal.getItem[1].id) >= qt[1168].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("谢谢。现在可以集中精神学习了。")
        SET_QUEST_STATE(1168, 2)
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("10个应该就够了。击退强悍巷道的蓝色大菜头收集10个[蓝色的灯油]回来吧。那样晚上学习也不成问题了。")
    end
  end
  if qData[1161].state == 0 then
    ADD_QUEST_BTN(qt[1161].id, qt[1161].name)
  end
  if qData[1168].state == 0 then
    ADD_QUEST_BTN(qt[1168].id, qt[1168].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[1161].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1161].needLevel then
    if qData[1161].state == 1 then
      if CHECK_ITEM_CNT(qt[1161].goal.getItem[1].id) >= qt[1161].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1168].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1168].needLevel then
    if qData[1168].state == 1 then
      if CHECK_ITEM_CNT(qt[1168].goal.getItem[1].id) >= qt[1168].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
end
