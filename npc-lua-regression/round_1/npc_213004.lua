function npcsay(id)
  if id ~= 4213004 then
    return
  end
  clickNPCid = id
  if qData[77].state == 1 then
    if qData[77].meetNpc[1] ~= id then
      NPC_QSAY(77, 1)
      SET_MEETNPC(77, 1, id)
      return
    elseif qData[77].meetNpc[1] == qt[77].goal.meetNpc[1] then
      NPC_SAY("???? ?? ???? ??? ????. ??? ?? {0xFFFFFF00}[?????]{END}? ? ?? ???? ??? ?? ???.")
    end
  end
  if qData[81].state == 1 and qData[81].meetNpc[1] ~= id then
    NPC_QSAY(81, 1)
    SET_INFO(81, 1)
    SET_MEETNPC(81, 1, id)
    return
  end
  if qData[441].state == 1 then
    if CHECK_ITEM_CNT(qt[441].goal.getItem[1].id) >= qt[441].goal.getItem[1].count and CHECK_ITEM_CNT(qt[441].goal.getItem[2].id) >= qt[441].goal.getItem[2].count then
      if 1 <= CHECK_INVENTORY_CNT(2) then
        NPC_SAY("??! ??? ? ????? ???. ?? ? ??? ????.")
        SET_QUEST_STATE(441, 2)
        return
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("{0xFFFFFF00}[??????]? [?????]{END}? ???? ?? ??? ? ?? ??????{0xFFFFFF00}?? 10?{END}? ??? ???.")
    end
  end
  if qData[197].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[197].goal.getItem) then
      NPC_SAY("??? ? ???? ??? ?? ??????. ?? ?? ?? ?? ?? ?? ???. ?? ???? ??????.")
      SET_QUEST_STATE(197, 2)
      return
    else
      NPC_SAY("????? ???????  {0xFFFFFF00}[??????] 15?{END}? ???. ")
    end
  end
  if qData[554].state == 1 then
    if CHECK_ITEM_CNT(qt[554].goal.getItem[1].id) >= qt[554].goal.getItem[1].count then
      NPC_SAY("??????~ ?? ?? ??? ??? ? ?? ??????. ???? ?? ??? ???? PLAYERNAME??? ? ?????????~")
      SET_QUEST_STATE(554, 2)
      return
    else
      NPC_SAY("?? ????? ??????. ????? ???? ???? ?? ? ?????. ??? ?? ???? {0xFFFFFF00}[???] 15?{END}? ??????~")
    end
  end
  if qData[1215].state == 1 then
    NPC_SAY("欢迎光临。冥珠城最好的武器都在此。什么？不是客人？")
    SET_QUEST_STATE(1215, 2)
  end
  if qData[1216].state == 1 then
    if qData[1216].killMonster[qt[1216].goal.killMonster[1].id] >= qt[1216].goal.killMonster[1].count then
      NPC_SAY("谢谢。这下还清债务有希望了。")
      SET_QUEST_STATE(1216, 2)
    else
      NPC_SAY("通过{0xFFFFFF00}冥珠城南边{END}的{0xFFFFFF00}冥珠城井台{END}可以移动到{0xFFFFFF00}青岳秀洞{END}。击退那里的{0xFFFFFF00}40只飞头鬼{END}吧。")
    end
  end
  if qData[1217].state == 1 then
    NPC_SAY("首先帮冥珠城哞读册吧？他在冥珠城西边。")
  end
  ADD_NEW_SHOP_BTN(id, 10007)
  if qData[1216].state == 0 and qData[1214].state == 2 and GET_PLAYER_LEVEL() >= qt[1216].needLevel then
    ADD_QUEST_BTN(qt[1216].id, qt[1216].name)
  end
  if qData[1217].state == 0 and qData[1216].state == 2 and GET_PLAYER_LEVEL() >= qt[1217].needLevel then
    ADD_QUEST_BTN(qt[1217].id, qt[1217].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[77].state == 1 and GET_PLAYER_LEVEL() >= qt[77].needLevel and qData[77].meetNpc[1] == qt[77].goal.meetNpc[1] then
    QSTATE(id, 1)
  end
  if qData[81].state == 1 and GET_PLAYER_LEVEL() >= qt[81].needLevel and qData[81].meetNpc[1] ~= id then
    QSTATE(id, 1)
  end
  if qData[441].state ~= 2 and GET_PLAYER_LEVEL() >= qt[441].needLevel then
    if qData[441].state == 1 then
      if CHECK_ITEM_CNT(qt[441].goal.getItem[1].id) >= qt[441].goal.getItem[1].count and CHECK_ITEM_CNT(qt[441].goal.getItem[2].id) >= qt[441].goal.getItem[2].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[197].state ~= 2 and GET_PLAYER_LEVEL() >= qt[197].needLevel then
    if qData[197].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[197].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[554].state ~= 2 and GET_PLAYER_LEVEL() >= qt[554].needLevel then
    if qData[554].state == 1 then
      if CHECK_ITEM_CNT(qt[554].goal.getItem[1].id) >= qt[554].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1215].state == 1 then
    QSTATE(id, 2)
  end
  if qData[1216].state == 1 then
    if qData[1216].killMonster[qt[1216].goal.killMonster[1].id] >= qt[1216].goal.killMonster[1].count then
      QSTATE(id, 2)
    else
      QSTATE(id, 1)
    end
  end
  if qData[1217].state == 1 then
    QSTATE(id, 1)
  end
end
