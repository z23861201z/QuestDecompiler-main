function npcsay(id)
  if id ~= 4313006 then
    return
  end
  clickNPCid = id
  if qData[78].state == 1 and qData[78].meetNpc[1] ~= id then
    NPC_QSAY(78, 1)
    SET_MEETNPC(78, 1, id)
    SET_QUEST_STATE(78, 2)
  end
  if qData[85].state == 1 and qData[85].meetNpc[1] == qt[85].goal.meetNpc[1] and qData[85].meetNpc[2] ~= id then
    if 1 <= CHECK_INVENTORY_CNT(4) then
      if CHECK_ITEM_CNT(qt[85].goal.getItem[1].id) >= qt[85].goal.getItem[1].count then
        NPC_SAY("PLAYERNAME? ?? ???. ??? ??? ??? ?????. ??? ??? ??? ?? ?? ????. ??? ?? ? ????? ?? ????.")
        SET_MEETNPC(85, 2, id)
        SET_QUEST_STATE(85, 2)
      else
        NPC_SAY("{0xFFFFFF00}???? ??{END}? ?? ??????")
      end
    else
      NPC_SAY("行囊太沉。")
    end
  end
  if qData[1233].state == 1 then
    NPC_SAY("呜，呜…。帮帮我吧。我的父母可能会死掉的。")
    SET_QUEST_STATE(1233, 2)
    return
  end
  if qData[1234].state == 1 then
    if CHECK_ITEM_CNT(qt[1234].goal.getItem[1].id) >= qt[1234].goal.getItem[1].count then
      NPC_SAY("谢谢。这下我的父母也可以恢复健康了。")
      SET_QUEST_STATE(1234, 2)
    else
      NPC_SAY("蓝蜗牛在{0xFFFFFF00}冥珠城井台{END}的{0xFFFFFF00}青岳秀洞{END}可以找到。击退{0xFFFFFF00}蓝蜗牛{END}收集{0xFFFFFF00}20个蓝蜗牛的壳{END}回来吧。")
    end
  end
  if qData[1235].state == 1 then
    NPC_SAY("快点去冥珠城南边的冥珠城银行处看看吧。")
  end
  if qData[1234].state == 0 and qData[1233].state == 2 and GET_PLAYER_LEVEL() >= qt[1234].needLevel then
    ADD_QUEST_BTN(qt[1234].id, qt[1234].name)
  end
  if qData[1235].state == 0 and qData[1234].state == 2 and GET_PLAYER_LEVEL() >= qt[1235].needLevel then
    ADD_QUEST_BTN(qt[1235].id, qt[1235].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[78].state == 1 and GET_PLAYER_LEVEL() >= qt[78].needLevel then
    QSTATE(id, 2)
  end
  if qData[85].state == 1 and GET_PLAYER_LEVEL() >= qt[85].needLevel then
    if CHECK_ITEM_CNT(qt[85].goal.getItem[1].id) >= qt[85].goal.getItem[1].count then
      QSTATE(id, 2)
    else
      QSTATE(id, 1)
    end
  end
  if qData[1234].state == 1 and GET_PLAYER_LEVEL() >= qt[1234].needLevel then
    if CHECK_ITEM_CNT(qt[1234].goal.getItem[1].id) >= qt[1234].goal.getItem[1].count then
      QSTATE(id, 2)
    else
      QSTATE(id, 1)
    end
  end
  if qData[1234].state == 0 and qData[1233].state == 2 and GET_PLAYER_LEVEL() >= qt[1234].needLevel then
    QSTATE(id, 0)
  end
  if qData[1235].state == 1 then
    QSTATE(id, 1)
  end
  if qData[1235].state == 0 and qData[1234].state == 2 and GET_PLAYER_LEVEL() >= qt[1235].needLevel then
    QSTATE(id, 0)
  end
end
