function npcsay(id)
  if id ~= 4915018 then
    return
  end
  clickNPCid = id
  if qData[142].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[142].goal.getItem) then
      if 1 <= CHECK_INVENTORY_CNT(2) then
        NPC_SAY([[
???! ???.
?? ?? ??? ?? ??. ???!
?? ?? ???. ?? ?? ???!]])
        SET_QUEST_STATE(142, 2)
        return
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("{0xFFFFFF00}[????]? [????]{END} ???? ?? {0xFFFFFF00}10?{END}? ?? ??? ????? ??.")
    end
  end
  if qData[162].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[162].goal.getItem) then
      if 1 <= CHECK_INVENTORY_CNT(2) then
        NPC_SAY("?? ?? ? ??? ????. ?? ??? ????.")
        SET_QUEST_STATE(162, 2)
        return
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("???? ?? ???? ??? ?? ????!! {0xFFFFFF00}???? 40?{END}? ?????")
    end
  end
  if qData[1069].state == 1 then
    if CHECK_ITEM_CNT(qt[1069].goal.getItem[1].id) >= qt[1069].goal.getItem[1].count and CHECK_ITEM_CNT(qt[1069].goal.getItem[2].id) >= qt[1069].goal.getItem[2].count then
      NPC_SAY("?? ????? ? ?? ??? ?? ????. ?? ?? ?? ???.")
      SET_QUEST_STATE(1069, 2)
    else
      NPC_SAY("???? ?? ???? ??? ?? ????!! {0xFFFFFF00}???? 30?{END}? ???? {0xFFFFFF00}???? 40?{END}? ?????")
    end
  end
  if qData[238].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[238].goal.getItem) then
      NPC_SAY("???????. ?? ??? ??? ? ??? ?????. ??? ???? ??? ??? ?????. ????. ?? ??? ??? ????.")
      SET_QUEST_STATE(238, 2)
      return
    else
      NPC_SAY("{0xFFFFFF00}???? 60?{END}? ????? ??? ????. ?? ?? ????? ????.")
    end
  end
  if qData[1268].state == 1 then
    NPC_SAY("嗯？需要帮助？最讨厌麻烦的事情了。嘿嘿。")
    SET_QUEST_STATE(1268, 2)
  end
  if qData[1269].state == 1 then
    NPC_SAY("去找{0xFFFFFF00}龙林城南边{END}的{0xFFFFFF00}皇宫武士陈调{END}，得到信任吧。")
  end
  if qData[1276].state == 1 then
    NPC_SAY("嗯？又是什么事情啊？")
    SET_QUEST_STATE(1276, 2)
  end
  if qData[1277].state == 1 then
    NPC_SAY("龙林派师兄应该在龙林城北边。")
  end
  if qData[1285].state == 1 then
    NPC_SAY("嘿嘿。那就是皇宫圣旨吗？给我看一下。事情变得越来越有趣了呢。诺 重新拿走吧。")
    SET_QUEST_STATE(1285, 2)
  end
  if qData[1286].state == 1 then
    NPC_SAY("不是。我就是一个懒惰鬼。嘿嘿。快去高一燕那儿看看吧。他在韩野都城。")
  end
  if qData[1269].state == 0 and qData[1268].state == 2 and GET_PLAYER_LEVEL() >= qt[1269].needLevel then
    ADD_QUEST_BTN(qt[1269].id, qt[1269].name)
  end
  if qData[1277].state == 0 and qData[1276].state == 2 and GET_PLAYER_LEVEL() >= qt[1277].needLevel then
    ADD_QUEST_BTN(qt[1277].id, qt[1277].name)
  end
  if qData[1286].state == 0 and qData[1285].state == 2 and GET_PLAYER_LEVEL() >= qt[1286].needLevel then
    ADD_QUEST_BTN(qt[1286].id, qt[1286].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[142].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[142].goal.getItem) then
      QSTATE(id, 2)
    else
      QSTATE(id, 1)
    end
  end
  if qData[162].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[162].goal.getItem) then
      QSTATE(id, 2)
    else
      QSTATE(id, 1)
    end
  end
  if qData[238].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[238].goal.getItem) then
      QSTATE(id, 2)
    else
      QSTATE(id, 1)
    end
  end
  if qData[1069].state == 1 then
    if CHECK_ITEM_CNT(qt[1069].goal.getItem[1].id) >= qt[1069].goal.getItem[1].count and CHECK_ITEM_CNT(qt[1069].goal.getItem[2].id) >= qt[1069].goal.getItem[2].count then
      QSTATE(id, 2)
    else
      QSTATE(id, 1)
    end
  end
  if qData[1268].state == 1 then
    QSTATE(id, 2)
  end
  if qData[1269].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1269].needLevel then
    if qData[1269].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[1276].state == 1 then
    QSTATE(id, 2)
  end
  if qData[1277].state ~= 2 and qData[1276].state == 2 and GET_PLAYER_LEVEL() >= qt[1277].needLevel then
    if qData[1277].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[1285].state == 1 then
    QSTATE(id, 2)
  end
  if qData[1286].state ~= 2 and qData[1285].state == 2 and GET_PLAYER_LEVEL() >= qt[1286].needLevel then
    if qData[1286].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
end
