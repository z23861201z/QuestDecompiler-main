function npcsay(id)
  if id ~= 4215003 then
    return
  end
  clickNPCid = id
  if qData[152].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[152].goal.getItem) then
      if 1 <= CHECK_INVENTORY_CNT(2) then
        NPC_SAY("??? ???? ?? ??????. ?????. ?? ??? ??? ? ?? ? ?? ? ???.")
        SET_QUEST_STATE(152, 2)
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("????? ????? ???? ???? ?? ??? ????. {0xFFFFFF00}???? 40?{END}? ??????")
    end
  end
  if qData[165].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[165].goal.getItem) then
      NPC_SAY("??! ?? ???~ ?? ?? ??? ???? ?? ?? ?? ? ????. ???? ???. ?? ??? ?????.")
      SET_QUEST_STATE(165, 2)
    else
      NPC_SAY("{0xFFFFFF00}??? ?? 40?{END}? ?????? ???? ??? ?? ????? ??? ??????. ??")
    end
  end
  if qData[1272].state == 1 then
    NPC_SAY("为了帮助我才来的？太感谢了。")
    SET_QUEST_STATE(1272, 2)
  end
  if qData[1273].state == 1 then
    if CHECK_ITEM_CNT(qt[1273].goal.getItem[1].id) >= qt[1273].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("这么快就收集回来了？谢谢。那个，龙林城金系系武器店在找你呢。")
        SET_QUEST_STATE(1273, 2)
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("击退铁腕山的白发老妖，收集30个白灰粉回来吧。")
    end
  end
  if qData[1275].state == 1 then
    if CHECK_ITEM_CNT(qt[1275].goal.getItem[1].id) >= qt[1275].goal.getItem[1].count and CHECK_ITEM_CNT(qt[1275].goal.getItem[2].id) >= qt[1275].goal.getItem[2].count then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("天啊！太谢谢了。托你的福，可以顺利的举行婚礼了。")
        SET_QUEST_STATE(1275, 2)
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("需要击退铁腕山的鬼新娘和白发老妖就能获得的彩缎和白灰粉各15个。")
    end
  end
  ADD_NEW_SHOP_BTN(id, 10013)
  if qData[152].state == 0 and GET_PLAYER_FAME() >= 60 then
    ADD_QUEST_BTN(qt[152].id, qt[152].name)
  end
  if qData[165].state == 0 and qData[152].state == 2 then
    ADD_QUEST_BTN(qt[165].id, qt[165].name)
  end
  if qData[1273].state == 0 and qData[1272].state == 2 and GET_PLAYER_LEVEL() >= qt[1273].needLevel then
    ADD_QUEST_BTN(qt[1273].id, qt[1273].name)
  end
  if qData[1275].state == 0 and qData[1274].state == 2 and GET_PLAYER_LEVEL() >= qt[1275].needLevel then
    ADD_QUEST_BTN(qt[1275].id, qt[1275].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[1272].state == 1 then
    QSTATE(id, 2)
  end
  if qData[1273].state ~= 2 and qData[1272].state == 2 and GET_PLAYER_LEVEL() >= qt[1273].needLevel then
    if qData[1273].state == 1 then
      if CHECK_ITEM_CNT(qt[1273].goal.getItem[1].id) >= qt[1273].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1275].state ~= 2 and qData[1274].state == 2 and GET_PLAYER_LEVEL() >= qt[1275].needLevel then
    if qData[1275].state == 1 then
      if CHECK_ITEM_CNT(qt[1275].goal.getItem[1].id) >= qt[1275].goal.getItem[1].count and CHECK_ITEM_CNT(qt[1275].goal.getItem[2].id) >= qt[1275].goal.getItem[2].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
end
