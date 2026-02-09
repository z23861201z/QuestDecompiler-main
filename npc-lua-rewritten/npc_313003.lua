local function __QUEST_CHECK_ITEMS(goalItems)
  for i, v in ipairs(goalItems) do
    if CHECK_ITEM_CNT(v.id) < v.count then
      return false
    end
  end
  return true
end

function npcsay(id)
  if id ~= 4313003 then
    return
  end
  clickNPCid = id
  NPC_SAY("那边的年轻人，要不要测测今天的{0xFFFFFF00}运势{END}啊？机会{0xFFFFFF00}一天只有一次{END}的。")
  if qData[1505].state == 1 and qData[1505].meetNpc[3] == qt[1505].goal.meetNpc[3] then
    SET_INFO(1505, 4)
    NPC_SAY("欢迎光临。第五个问题了。离冥珠城很近的地方有着藏有龙之力量的地方。代表那个地方的门派的首长是谁？")
    SET_MEETNPC(1505, 4, id)
  end
  if qData[1501].state == 1 then
    if __QUEST_CHECK_ITEMS(qt[1501].goal.getItem) and SET_ITEM_PERCENT(8590001) == 300 then
      if 1 <= CHECK_INVENTORY_CNT(2) then
        NPC_SAY("?? ? ???????? ??…?. ???. ?? ? ??? ????.?? ??? ?????? ??? ??????. ?? ?????. PLAYERNAME?? ???? ??? ???? ??? ?? ????.")
        SET_QUEST_STATE(1501, 2)
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("????? ????? ?? ?? ??? ??? ????. ????? ? ??? ? ??? ?? ???.")
    end
  end
  if qData[78].state == 1 then
    NPC_SAY("? [??????]? ??? ??? ????.")
  end
  if qData[80].state == 1 then
    if qData[80].meetNpc[1] == qt[80].goal.meetNpc[1] and qData[80].meetNpc[2] == qt[80].goal.meetNpc[2] and qData[80].meetNpc[3] ~= id then
      NPC_SAY("谢谢。这是老人因为感谢才给的，不要拒绝。")
      SET_MEETNPC(80, 3, id)
      SET_QUEST_STATE(80, 2)
      return
    else
      NPC_SAY("哎呦..还没去吗？[ 冥珠城宝芝林 ]在冥珠城东边。")
    end
  end
  if qData[81].state == 1 and qData[81].meetNpc[1] == qt[81].goal.meetNpc[1] and qData[81].meetNpc[2] == qt[81].goal.meetNpc[2] and qData[81].meetNpc[3] ~= id then
    SET_MEETNPC(81, 3, id)
    NPC_QSAY(81, 10)
    SET_QUEST_STATE(81, 2)
    return
  end
  if qData[80].state == 0 then
    ADD_QUEST_BTN(qt[80].id, qt[80].name)
  end
  ADD_NPC_CARD_DIVINE(id)
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[1501].state == 1 then
    if __QUEST_CHECK_ITEMS(qt[1501].goal.getItem) and SET_ITEM_PERCENT(8590001) == 300 then
      if 1 <= CHECK_INVENTORY_CNT(2) then
        QSTATE(id, 2)
      end
    else
      QSTATE(id, 1)
    end
  end
  if qData[80].state ~= 2 and GET_PLAYER_LEVEL() >= qt[80].needLevel then
    if qData[80].state == 1 then
      if qData[80].meetNpc[1] == qt[80].goal.meetNpc[1] and qData[80].meetNpc[2] == qt[80].goal.meetNpc[2] and qData[80].meetNpc[3] ~= id then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[81].state == 1 and GET_PLAYER_LEVEL() >= qt[81].needLevel then
    if qData[81].meetNpc[1] == qt[81].goal.meetNpc[1] and qData[81].meetNpc[2] == qt[81].goal.meetNpc[2] and qData[81].meetNpc[3] ~= id then
      QSTATE(id, 2)
    else
      QSTATE(id, 1)
    end
  end
end
