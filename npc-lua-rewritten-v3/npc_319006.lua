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
  if id ~= 4319006 then
    return
  end
  clickNPCid = id
  if qData[1407].state == 1 then
    NPC_SAY("???? ???? ??? ???? ?? ??? ?? ??¡­.")
    SET_QUEST_STATE(1407, 2)
  end
  if qData[1408].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[1408].goal.getItem) and __QUEST_HAS_ALL_ITEMS(qt[1408].goal.getItem) then
      if 1 <= CHECK_INVENTORY_CNT(2) then
        NPC_SAY("????¡­. ??¡­ ?¡­. ??? ?? ??? ?? ? ??¡­. ??? ? ?? ? ????¡­. ???¡­")
        SET_QUEST_STATE(1408, 2)
      else
        NPC_SAY("ÐÐÄÒÌ«³Á¡£")
      end
    else
      NPC_SAY("?? ??? ?? ???? ???? ????????? ???????? ? ?? 5?? ????¡­.")
    end
  end
  if qData[1408].state == 0 and GET_PLAYER_LEVEL() >= qt[1408].needLevel then
    ADD_QUEST_BTN(qt[1408].id, qt[1408].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
end
