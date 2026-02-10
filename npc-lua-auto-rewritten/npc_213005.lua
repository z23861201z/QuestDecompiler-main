function npcsay(id)
  if id ~= 4213005 then
    return
  end
  clickNPCid = id
  if qData[83].state == 1 then
    if CHECK_ITEM_CNT(qt[83].goal.getItem[1].id) >= qt[83].goal.getItem[1].count then
      NPC_SAY("???? ??????. ??? ????? ???? ??? ?? ?????. ?????.")
      SET_MEETNPC(83, 1, 4213002)
      SET_QUEST_STATE(83, 2)
      return
    else
      NPC_SAY("{0xFFFFFF00}[?????]{END}? {0xFFFFFF00}????{END}? ??? ??? ???. {0xFFFFFF00}10?{END}???? ???? ? ? ???... ? ? ??????. ")
    end
  end
  if qData[85].state == 1 then
    if qData[85].meetNpc[1] ~= id and qData[85].killMonster[qt[85].goal.killMonster[1].id] >= qt[85].goal.killMonster[1].count then
      if 1 <= CHECK_INVENTORY_CNT(4) then
        SET_MEETNPC(85, 1, id)
        NPC_SAY("?? ???. ??? ????? ??? ?? ??????. ?? ??? ?????. ?? {0xFFFFFF00}[??????]{END}?? ??? ???.")
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("{0xFFFFFF00}[??]? 30??{END}? ?? ??????.")
    end
  end
  if qData[129].state == 1 and CHECK_ITEM_CNT(qt[129].goal.getItem[1].id) >= qt[129].goal.getItem[1].count and CHECK_ITEM_CNT(qt[129].goal.getItem[2].id) >= qt[129].goal.getItem[2].count then
    NPC_SAY("?. ??? ??? ??? ????. ??? ??? ??????. ?? ??? ???. ?? ????.")
    SET_QUEST_STATE(129, 2)
  end
  if qData[131].state == 1 then
    if qData[131].killMonster[qt[131].goal.killMonster[1].id] >= qt[131].goal.killMonster[1].count then
      if 1 <= CHECK_INVENTORY_CNT(2) then
        NPC_SAY("?????. ??? ??? ?? ??? ? ?? ?????. ?? ????? ?? ?? ????? ??? ??? ?? ????.")
        SET_QUEST_STATE(131, 2)
        return
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("{0xFFFFFF00}[???]{END}? ???? ??? ?? ??? ?? ?? ????? ???. {0xFFFFFF00}25??{END}? ??? ????.")
    end
  end
  if qData[1229].state == 1 then
    NPC_SAY("因为{0xFFFFFF00}冥珠平原{END}的{0xFFFFFF00}大胡子{END}头疼着呢。你去击退他们，作为证据收集{0xFFFFFF00}20个大胡子的牙齿{END}拿到冥珠都城，{0xFFFFFF00}冥珠城父母官{END}肯定会很高兴的。")
  end
  if qData[1188].state == 1 and CHECK_ITEM_CNT(qt[1188].goal.getItem[1].id) >= qt[1188].goal.getItem[1].count and CHECK_ITEM_CNT(qt[1188].goal.getItem[2].id) >= qt[1188].goal.getItem[2].count then
    NPC_SAY("真的很感谢。托你的福路过竹林的人们可以安全的来回了。这是奖金。")
    SET_QUEST_STATE(1188, 2)
  end
  if qData[1228].state == 1 then
    NPC_SAY("来得正好。我从偷笔怪盗那儿听说了。")
    SET_QUEST_STATE(1228, 2)
  end
  if qData[1235].state == 1 then
    NPC_SAY("来了啊。正在等你呢。")
    SET_QUEST_STATE(1235, 2)
  end
  if qData[1236].state == 1 then
    NPC_SAY("通过{0xFFFFFF00}冥珠城井台{END}去{0xFFFFFF00}青岳秀洞{END}击退{0xFFFFFF00}大目王{END}，收集{0xFFFFFF00}5个大目王的头发{END}回来交给{0xFFFFFF00}冥珠城西边{END}的{0xFFFFFF00}衫菜{END}吧。")
  end
  ADD_STORE_BTN(id)
  ADD_EVENT_BTN_D(id)
  ADD_EVENT_BTN_JEWEL(id)
  ADD_GIVE_SOULBOX(id)
  GIVE_DONATION_ITEM(id)
  ADD_SOULALCOHOL_CHANGE_BTN(id)
  ADD_PARCEL_SERVICE_BTN(id)
  if qData[1229].state == 0 and qData[1228].state == 2 and GET_PLAYER_LEVEL() >= qt[1229].needLevel then
    ADD_QUEST_BTN(qt[1229].id, qt[1229].name)
  end
  if qData[1236].state == 0 and qData[1234].state == 2 and GET_PLAYER_LEVEL() >= qt[1236].needLevel then
    ADD_QUEST_BTN(qt[1236].id, qt[1236].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[83].state ~= 2 and GET_PLAYER_LEVEL() >= qt[83].needLevel then
    if qData[83].state == 1 then
      if CHECK_ITEM_CNT(qt[83].goal.getItem[1].id) >= qt[83].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[78].state == 2 and qData[85].state ~= 2 and GET_PLAYER_LEVEL() >= qt[85].needLevel then
    if qData[85].state == 1 then
      if qData[85].meetNpc[1] ~= id and qData[85].killMonster[qt[85].goal.killMonster[1].id] >= qt[85].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[129].state == 1 and GET_PLAYER_LEVEL() >= qt[129].needLevel then
    if CHECK_ITEM_CNT(qt[129].goal.getItem[1].id) >= qt[129].goal.getItem[1].count and CHECK_ITEM_CNT(qt[129].goal.getItem[2].id) >= qt[129].goal.getItem[2].count then
      QSTATE(id, 2)
    else
      QSTATE(id, 1)
    end
  end
  if qData[129].state == 2 and qData[131].state ~= 2 and GET_PLAYER_LEVEL() >= qt[131].needLevel then
    if qData[131].state == 1 then
      if qData[131].killMonster[qt[131].goal.killMonster[1].id] >= qt[131].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1188].state ~= 2 and qData[1188].state == 1 and CHECK_ITEM_CNT(qt[1188].goal.getItem[1].id) >= qt[1188].goal.getItem[1].count and CHECK_ITEM_CNT(qt[1188].goal.getItem[2].id) >= qt[1188].goal.getItem[2].count then
    QSTATE(id, 2)
  end
  if qData[1228].state == 1 then
    QSTATE(id, 2)
  end
  if qData[1235].state == 1 then
    QSTATE(id, 2)
  end
  if qData[1236].state == 1 then
    QSTATE(id, 1)
  end
  if qData[1229].state == 0 and qData[1228].state == 2 and GET_PLAYER_LEVEL() >= qt[1229].needLevel then
    QSTATE(id, 0)
  end
  if qData[1236].state == 0 and qData[1234].state == 2 and GET_PLAYER_LEVEL() >= qt[1236].needLevel then
    QSTATE(id, 0)
  end
end
