function npcsay(id)
  if id ~= 4213003 then
    return
  end
  clickNPCid = id
  if qData[105].state == 1 and qData[105].meetNpc[1] == qt[105].goal.meetNpc[1] then
    if qData[105].meetNpc[2] ~= qt[105].goal.meetNpc[2] then
      SET_INFO(105, 2)
      NPC_QSAY(105, 4)
      SET_MEETNPC(105, 2, id)
      return
    else
      NPC_SAY("{0xFFFFFF00}????{END}?? ???? ?????.")
    end
  end
  if qData[79].state == 1 then
    if qData[79].killMonster[qt[79].goal.killMonster[1].id] >= qt[79].goal.killMonster[1].count then
      NPC_SAY("???? ??? ????. ? ?? ???? ??? ??????. ??? ? ?? ??? ?? ??????. ???? ?? ?? ??? ?????.")
      SET_QUEST_STATE(79, 2)
      return
    else
      NPC_SAY("????? {0xFFFFFF00}[??]{END}? ???? ????..? {0xFFFFFF00}20??{END} ?? ???? ???? ???.")
    end
  end
  if qData[199].state == 1 then
    if qData[199].meetNpc[1] ~= qt[199].goal.meetNpc[1] then
      NPC_QSAY(199, 1)
      SET_INFO(199, 1)
      SET_MEETNPC(199, 1, id)
      return
    elseif qData[199].meetNpc[1] == qt[199].goal.meetNpc[1] and qData[199].meetNpc[2] ~= qt[199].goal.meetNpc[2] then
      if CHECK_ITEM_CNT(8910502) >= 10 then
        if 1 <= CHECK_INVENTORY_CNT(4) then
          NPC_SAY("???? ?????. ??. ?? ??? ?????.")
          SET_INFO(199, 2)
          SET_MEETNPC(199, 2, id)
        else
          NPC_SAY("行囊太沉。")
        end
        return
      else
        NPC_SAY("?? ???? ???? ????. ???? ???? ???? ?????. ???? {0xFFFFFF00}[??????] 10?{END}? ??? ???.")
      end
    end
  end
  if qData[710].state == 1 then
    if qData[710].meetNpc[1] ~= qt[710].goal.meetNpc[1] then
      NPC_QSAY(710, 1)
      SET_INFO(710, 1)
      SET_MEETNPC(710, 1, id)
      return
    elseif qData[710].meetNpc[1] == qt[710].goal.meetNpc[1] and qData[710].meetNpc[2] ~= qt[710].goal.meetNpc[2] then
      if CHECK_ITEM_CNT(8910502) >= 10 then
        if 1 <= CHECK_INVENTORY_CNT(4) then
          NPC_SAY("???? ?????. ??. ?? ??? ?????.")
          SET_INFO(710, 2)
          SET_MEETNPC(710, 2, id)
        else
          NPC_SAY("行囊太沉。")
        end
        return
      else
        NPC_SAY("?? ???? ???? ????. ???? ???? ???? ?????. ???? {0xFFFFFF00}[??????] 10?{END}? ??? ???.")
      end
    end
  end
  if qData[335].state == 1 then
    if qData[335].meetNpc[1] == qt[335].goal.meetNpc[1] then
      NPC_SAY("?? ? ?? ????? ??? ?? ?? ?????. ????. ? ????????")
      SET_MEETNPC(335, 2, id)
      SET_QUEST_STATE(335, 2)
      return
    else
      NPC_SAY("??? ??? ?? {0xFFFFFF00}?????{END}? ? ?????. ? ?? ??? ? ? ??? ?????.")
    end
  end
  if qData[336].state == 1 then
    NPC_SAY("?? ? ??? ?? ??? ? ?????.")
  end
  if qData[337].state == 1 and qData[337].meetNpc[1] == qt[337].goal.meetNpc[1] then
    NPC_SAY("??…. ??, ? ??? ?? ??????…. ??? ??? ??. ? ??? ? ? ?? ????.")
    SET_MEETNPC(337, 2, id)
    SET_QUEST_STATE(337, 2)
    return
  end
  if qData[338].state == 1 then
    NPC_SAY("?????? {0xFFFFFF00}??????{END}? ??? ??? ???. ? ?? ?? ??? ???.")
  end
  if qData[340].state == 1 and __QUEST_HAS_ALL_ITEMS(qt[340].goal.getItem) then
    NPC_SAY("?? ?? ?? ????. ?????? ?????? ?? ?????.")
    SET_QUEST_STATE(340, 2)
    return
  end
  if qData[341].state == 1 then
    if qData[341].meetNpc[1] == qt[341].goal.meetNpc[1] then
      NPC_SAY("??????? ?? ??? ??? ?????. ?? ?? ??? ? ? ????? ?…. ? ????. ????? ????.")
      SET_MEETNPC(341, 2, id)
      SET_QUEST_STATE(341, 2)
      return
    else
      NPC_SAY("?? ?? ??? ????? ??. ?? ?? ????? ??? ???.")
    end
  end
  if qData[343].state == 1 and __QUEST_HAS_ALL_ITEMS(qt[343].goal.getItem) then
    NPC_SAY("?? ?? ?? ????. ?????? ?????? ?? ?????.")
    SET_QUEST_STATE(343, 2)
    return
  end
  if qData[344].state == 1 then
    if qData[344].meetNpc[1] == qt[344].goal.meetNpc[1] then
      NPC_SAY("?? ??? ???. ?? ??? ?????? ??? ?? ???? ?? ??? ???????. ?? ??? ??? ?…. ??. ?????. ??. ??? ?????….")
      SET_MEETNPC(344, 2, id)
      SET_QUEST_STATE(344, 2)
      return
    else
      NPC_SAY("?? ?? ??? ????? ??. ?? ?? ????? ??? ???.")
    end
  end
  if qData[345].state == 1 then
    if qData[345].meetNpc[1] == qt[345].goal.meetNpc[1] then
      NPC_SAY("????…. ??? ?? ????? ??? ???? ??? ??? ???. ???? ? ????? ??????.")
      SET_MEETNPC(345, 2, id)
      SET_QUEST_STATE(345, 2)
      return
    else
      NPC_SAY("?? ?????…. ??? ??? ???….")
    end
  end
  if qData[1223].state == 1 then
    NPC_SAY("欢迎光临。什么？你是为了和冥珠城名田瞧的合约而来？")
    SET_QUEST_STATE(1223, 2)
    return
  end
  if qData[1224].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[1224].goal.getItem) then
      if CHECK_INVENTORY_CNT(3) > 0 then
        NPC_SAY("好厉害。没想到会这么快收集回来。")
        SET_QUEST_STATE(1224, 2)
        return
      else
        NPC_SAY("行囊已满。")
      end
    else
      NPC_SAY("击退{0xFFFFFF00}冥珠平原{END}的{0xFFFFFF00}红衣小女孩{END}收集{0xFFFFFF00}15个木屐{END}回来吧。")
    end
  end
  if qData[1225].state == 1 then
    NPC_SAY("要重新回到冥珠城东边的冥珠城名田瞧那儿吗？")
  end
  if qData[1237].state == 1 and CHECK_ITEM_CNT(qt[1237].goal.getItem[1].id) >= qt[1237].goal.getItem[1].count then
    if 1 <= CHECK_INVENTORY_CNT(2) then
      NPC_SAY("来得正好。我会给为了冥珠城做出贡献的我的朋友制作出最好的衣服。")
      SET_QUEST_STATE(1237, 2)
    else
      NPC_SAY("行囊太沉。")
    end
  end
  if qData[1238].state == 1 then
    NPC_SAY("去冥珠都城的冥珠城父母官处了解结果吧。 ")
  end
  ADD_NEW_SHOP_BTN(id, 10006)
  if qData[1224].state == 0 and qData[1223].state == 2 and GET_PLAYER_LEVEL() >= qt[1224].needLevel then
    ADD_QUEST_BTN(qt[1224].id, qt[1224].name)
  end
  if qData[1225].state == 0 and qData[1224].state == 2 and GET_PLAYER_LEVEL() >= qt[1225].needLevel then
    ADD_QUEST_BTN(qt[1225].id, qt[1225].name)
  end
  if qData[1238].state == 0 and qData[1237].state == 2 and GET_PLAYER_LEVEL() >= qt[1238].needLevel then
    ADD_QUEST_BTN(qt[1238].id, qt[1238].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[105].state == 1 and GET_PLAYER_LEVEL() >= qt[105].needLevel and qData[105].meetNpc[1] == qt[105].goal.meetNpc[1] and qData[105].meetNpc[2] ~= qt[105].goal.meetNpc[2] then
    QSTATE(id, 2)
  end
  if qData[1223].state == 1 then
    QSTATE(id, 2)
  end
  if qData[1224].state == 1 and __QUEST_HAS_ALL_ITEMS(qt[1224].goal.getItem) then
    if CHECK_INVENTORY_CNT(3) > 0 then
      QSTATE(id, 2)
    else
      QSTATE(id, 1)
    end
  end
  if qData[1224].state == 0 and qData[1223].state == 2 and GET_PLAYER_LEVEL() >= qt[1224].needLevel then
    QSTATE(id, 0)
  end
  if qData[1225].state == 1 then
    QSTATE(id, 1)
  end
  if qData[1226].state == 1 then
    QSTATE(id, 1)
  end
  if qData[1237].state == 1 and CHECK_ITEM_CNT(qt[1237].goal.getItem[1].id) >= qt[1237].goal.getItem[1].count then
    if 1 <= CHECK_INVENTORY_CNT(2) then
      QSTATE(id, 2)
    else
      QSTATE(id, 1)
    end
  end
  if qData[1238].state == 1 then
    QSTATE(id, 1)
  end
  if qData[1238].state == 0 and qData[1237].state == 2 and GET_PLAYER_LEVEL() >= qt[1238].needLevel then
    QSTATE(id, 0)
  end
  if qData[199].state == 1 and GET_PLAYER_LEVEL() >= qt[199].needLevel then
    if CHECK_ITEM_CNT(8910502) >= 10 then
      QSTATE(id, 2)
    elseif CHECK_ITEM_CNT(8990058) ~= 1 then
      QSTATE(id, 1)
    end
  end
  if qData[710].state == 1 and GET_PLAYER_LEVEL() >= qt[710].needLevel then
    if CHECK_ITEM_CNT(8910502) >= 10 then
      QSTATE(id, 2)
    elseif CHECK_ITEM_CNT(8990058) ~= 1 then
      QSTATE(id, 1)
    end
  end
  if qData[335].state ~= 2 and GET_PLAYER_LEVEL() >= qt[335].needLevel then
    if qData[335].state == 1 then
      if qData[335].meetNpc[1] == qt[335].goal.meetNpc[1] then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[335].state == 2 and qData[336].state ~= 2 and GET_PLAYER_LEVEL() >= qt[336].needLevel then
    if qData[336].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[337].state == 1 and qData[337].meetNpc[1] == qt[337].goal.meetNpc[1] then
    QSTATE(id, 2)
  end
  if qData[337].state == 2 and qData[338].state ~= 2 and GET_PLAYER_LEVEL() >= qt[338].needLevel then
    if qData[338].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[340].state == 1 and GET_PLAYER_LEVEL() >= qt[340].needLevel then
    if __QUEST_HAS_ALL_ITEMS(qt[340].goal.getItem) then
      QSTATE(id, 2)
    else
      QSTATE(id, 1)
    end
  end
  if qData[340].state == 2 and qData[341].state ~= 2 and GET_PLAYER_LEVEL() >= qt[341].needLevel then
    if qData[341].state == 1 then
      if qData[341].meetNpc[1] == qt[341].goal.meetNpc[1] then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[343].state == 1 and GET_PLAYER_LEVEL() >= qt[343].needLevel then
    if __QUEST_HAS_ALL_ITEMS(qt[343].goal.getItem) then
      QSTATE(id, 2)
    else
      QSTATE(id, 1)
    end
  end
  if qData[343].state == 2 and qData[344].state ~= 2 and GET_PLAYER_LEVEL() >= qt[344].needLevel then
    if qData[344].state == 1 then
      if qData[344].meetNpc[1] == qt[344].goal.meetNpc[1] then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[344].state == 2 and qData[345].state ~= 2 and GET_PLAYER_LEVEL() >= qt[345].needLevel then
    if qData[345].state == 1 then
      if qData[345].meetNpc[1] == qt[345].goal.meetNpc[1] then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
end
