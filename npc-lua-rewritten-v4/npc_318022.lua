local function __QUEST_HAS_ALL_ITEMS(goalItems)
  for i, v in ipairs(goalItems) do
    if CHECK_ITEM_CNT(v.id) < v.count then
      return false
    end
  end
  return true
end

local function __QUEST_FIRST_ITEM_ID(goalItems)
  if goalItems == nil or goalItems[1] == nil then
    return 0
  end
  return goalItems[1].id
end

local function __QUEST_FIRST_ITEM_COUNT(goalItems)
  if goalItems == nil or goalItems[1] == nil then
    return 0
  end
  return goalItems[1].count
end

function npcsay(id)
  if id ~= 4318022 then
    return
  end
  clickNPCid = id
  if qData[773].state == 1 then
    if qData[773].killMonster[qt[773].goal.killMonster[1].id] >= qt[773].goal.killMonster[1].count then
      NPC_SAY("{0xFFFFFF00}????{END}? ???? ?? ?? ???? ?? ??? ?????.")
      SET_QUEST_STATE(773, 2)
      return
    else
      NPC_SAY("{0xFFFFFF00}????{END}? ??? ??????")
    end
  end
  if qData[774].state == 1 then
    if qData[774].killMonster[qt[774].goal.killMonster[1].id] >= qt[774].goal.killMonster[1].count then
      NPC_SAY("{0xFFFFFF00}???{END}? ???? ?? ?? ???? ?? ??? ?????.")
      SET_QUEST_STATE(774, 2)
      return
    else
      NPC_SAY("{0xFFFFFF00}???{END}? ??? ??????")
    end
  end
  if qData[775].state == 1 then
    if qData[775].killMonster[qt[775].goal.killMonster[1].id] >= qt[775].goal.killMonster[1].count then
      NPC_SAY("{0xFFFFFF00}??{END}? ???? ?? ?? ???? ?? ??? ?????.")
      SET_QUEST_STATE(775, 2)
      return
    else
      NPC_SAY("{0xFFFFFF00}??{END}? ??? ??????")
    end
  end
  if qData[776].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[776].goal.getItem) then
      NPC_SAY("?? ?? ???. ??? ??? ?? ????.")
      SET_QUEST_STATE(776, 2)
      return
    else
      NPC_SAY("{0xFFFFFF00}???, ?????, ????{END}? ?????? 5?? ?? ???.")
    end
  end
  if qData[777].state == 1 then
    if qData[777].killMonster[qt[777].goal.killMonster[1].id] >= qt[777].goal.killMonster[1].count then
      NPC_SAY("{0xFFFFFF00}??{END}? ???? ?? ?? ???? ?? ??? ?????.{0xFFFFFF00}PLAYERNAME{END}?? ?? ?? ?? ?????. {0xFFFFFF00}??????? ?? ?????{END}? ?? ???.")
      SET_QUEST_STATE(777, 2)
      return
    else
      NPC_SAY("{0xFFFFFF00}??{END}? ??? ??????")
    end
  end
  if qData[773].state == 0 then
    ADD_QUEST_BTN(qt[773].id, qt[773].name)
  end
  if qData[774].state == 0 then
    ADD_QUEST_BTN(qt[774].id, qt[774].name)
  end
  if qData[775].state == 0 then
    ADD_QUEST_BTN(qt[775].id, qt[775].name)
  end
  if qData[776].state == 0 then
    ADD_QUEST_BTN(qt[776].id, qt[776].name)
  end
  if qData[777].state == 0 then
    ADD_QUEST_BTN(qt[777].id, qt[777].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[773].state ~= 2 and GET_PLAYER_LEVEL() >= qt[773].needLevel then
    if qData[773].state == 1 then
      if qData[773].killMonster[qt[773].goal.killMonster[1].id] >= qt[773].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, qData[773].state)
      end
    else
      QSTATE(id, qData[773].state)
    end
  end
  if qData[774].state ~= 2 and GET_PLAYER_LEVEL() >= qt[774].needLevel then
    if qData[774].state == 1 then
      if qData[774].killMonster[qt[774].goal.killMonster[1].id] >= qt[774].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, qData[774].state)
      end
    else
      QSTATE(id, qData[774].state)
    end
  end
  if qData[775].state ~= 2 and GET_PLAYER_LEVEL() >= qt[775].needLevel then
    if qData[775].state == 1 then
      if qData[775].killMonster[qt[775].goal.killMonster[1].id] >= qt[775].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, qData[775].state)
      end
    else
      QSTATE(id, qData[775].state)
    end
  end
  if qData[776].state ~= 2 and GET_PLAYER_LEVEL() >= qt[776].needLevel then
    if qData[776].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[776].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, qData[776].state)
      end
    else
      QSTATE(id, qData[776].state)
    end
  end
  if qData[777].state ~= 2 and GET_PLAYER_LEVEL() >= qt[777].needLevel then
    if qData[777].state == 1 then
      if qData[777].killMonster[qt[777].goal.killMonster[1].id] >= qt[777].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, qData[777].state)
      end
    else
      QSTATE(id, qData[777].state)
    end
  end
end
