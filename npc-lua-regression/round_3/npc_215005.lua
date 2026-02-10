function npcsay(id)
  if id ~= 4215005 then
    return
  end
  clickNPCid = id
  if qData[234].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[234].goal.getItem) then
      NPC_SAY("??????. ???? ??? ? ?? ??? ????. ?? ??????. ??? ??? ?????. ???? ?? ??? ? ??????.")
      SET_QUEST_STATE(234, 2)
    else
      NPC_SAY("{0xFFFFFF00}??????? 10?{END} ??? ????. ??? ?? ???? ?? ???????.")
    end
  end
  if qData[543].state == 1 and qData[543].meetNpc[1] ~= id then
    NPC_SAY("?? PLAYERNAME? ???? ??????")
    SET_MEETNPC(543, 1, id)
    SET_QUEST_STATE(543, 2)
  end
  if qData[544].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[544].goal.getItem) then
      NPC_SAY("?? ??????. ??? ???? ?? ? ? ????.")
      SET_QUEST_STATE(544, 2)
    else
      NPC_SAY("PLAYERNAME?? ????? ???? 20? ?? ?? ?? ? ? ??????.")
    end
  end
  if qData[545].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[545].goal.getItem) then
      NPC_SAY("???????! ??????. ? ?? ???? ??????.")
      SET_QUEST_STATE(545, 2)
    else
      NPC_SAY("???? ?????? ????? ???.")
    end
  end
  if qData[546].state == 1 then
    NPC_SAY("PLAYERNAME?? ??? ???? ?? ????????? ?? ?? ?????.")
  end
  if qData[557].state == 1 then
    if CHECK_ITEM_CNT(qt[557].goal.getItem[1].id) >= qt[557].goal.getItem[1].count then
      NPC_SAY("?????. PLAYERNAME? ????? ???? ? ??? ??? ????, ?? ??? ? ?????.")
      SET_QUEST_STATE(557, 2)
    else
      NPC_SAY("???? ???? ????? ?? ? ????. 60?? ???? ??????.")
    end
  end
  if qData[1070].state == 1 then
    if qData[1070].killMonster[qt[1070].goal.killMonster[1].id] >= qt[1070].goal.killMonster[1].count and CHECK_ITEM_CNT(qt[1070].goal.getItem[1].id) >= qt[1070].goal.getItem[1].count then
      NPC_SAY("??? ?????? ??? ??????. ?????.")
      SET_QUEST_STATE(1070, 2)
      return
    else
      NPC_SAY("???? ?? ??? {0xFFFFFF00}???? 15?{END}? {0xFFFFFF00}??? 30??{END}? ??? ??? ????.")
    end
  end
  if qData[1284].state == 1 then
    if CHECK_ITEM_CNT(qt[1284].goal.getItem[1].id) >= qt[1284].goal.getItem[1].count then
      NPC_SAY("谢谢。只要龙通路竣工，交易就会更加活跃的。")
      SET_QUEST_STATE(1284, 2)
    else
      NPC_SAY("帮我收集30个击退铁腕山的石碑怪就能获得的石碑碎片回来吧。")
    end
  end
  if qData[1302].state == 1 then
    NPC_SAY("来了啊。正在等你呢。")
    SET_QUEST_STATE(1302, 2)
  end
  if qData[1303].state == 1 then
    if CHECK_ITEM_CNT(qt[1303].goal.getItem[1].id) >= qt[1303].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("辛苦了。要不开始进行下一个？")
        SET_QUEST_STATE(1303, 2)
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("击退铁腕山的树妖，收集30个树枝回来吧。")
    end
  end
  if qData[1304].state == 1 then
    if CHECK_ITEM_CNT(qt[1304].goal.getItem[1].id) >= qt[1304].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("辛苦了。现在开始试试吧。")
        SET_QUEST_STATE(1304, 2)
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("去隐藏的铁腕山击退羊逃之，收集1张羊逃之符咒回来吧。")
    end
  end
  if qData[1305].state == 1 then
    NPC_SAY("龙林城哞读册在龙林城北边。详细的内容从他那儿了解吧。")
  end
  ADD_STORE_BTN(id)
  ADD_EVENT_BTN_JEWEL(id)
  GIVE_DONATION_ITEM(id)
  ADD_PARCEL_SERVICE_BTN(id)
  if qData[234].state == 0 then
    ADD_QUEST_BTN(qt[234].id, qt[234].name)
  end
  if qData[544].state == 0 and qData[543].state == 2 then
    ADD_QUEST_BTN(qt[544].id, qt[544].name)
  end
  if qData[545].state == 0 and qData[544].state == 2 then
    ADD_QUEST_BTN(qt[545].id, qt[545].name)
  end
  if qData[546].state == 0 and qData[545].state == 2 then
    ADD_QUEST_BTN(qt[546].id, qt[546].name)
  end
  if qData[557].state == 0 then
    ADD_QUEST_BTN(qt[557].id, qt[557].name)
  end
  if qData[1070].state == 0 then
    ADD_QUEST_BTN(qt[1070].id, qt[1070].name)
  end
  if qData[1284].state == 0 and GET_PLAYER_LEVEL() >= qt[1284].needLevel then
    ADD_QUEST_BTN(qt[1284].id, qt[1284].name)
  end
  if qData[1303].state == 0 and qData[1302].state == 2 and GET_PLAYER_LEVEL() >= qt[1303].needLevel then
    ADD_QUEST_BTN(qt[1303].id, qt[1303].name)
  end
  if qData[1304].state == 0 and qData[1303].state == 2 and GET_PLAYER_LEVEL() >= qt[1304].needLevel then
    ADD_QUEST_BTN(qt[1304].id, qt[1304].name)
  end
  if qData[1305].state == 0 and qData[1304].state == 2 and GET_PLAYER_LEVEL() >= qt[1305].needLevel then
    ADD_QUEST_BTN(qt[1305].id, qt[1305].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[1284].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1284].needLevel then
    if qData[1284].state == 1 then
      if CHECK_ITEM_CNT(qt[1284].goal.getItem[1].id) >= qt[1284].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1302].state == 1 then
    QSTATE(id, 2)
  end
  if qData[1303].state ~= 2 and qData[1302].state == 2 and GET_PLAYER_LEVEL() >= qt[1303].needLevel then
    if qData[1303].state == 1 then
      if CHECK_ITEM_CNT(qt[1303].goal.getItem[1].id) >= qt[1303].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1304].state ~= 2 and qData[1303].state == 2 and GET_PLAYER_LEVEL() >= qt[1304].needLevel then
    if qData[1304].state == 1 then
      if CHECK_ITEM_CNT(qt[1304].goal.getItem[1].id) >= qt[1304].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1305].state ~= 2 and qData[1304].state == 2 and GET_PLAYER_LEVEL() >= qt[1305].needLevel then
    if qData[1305].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
end
