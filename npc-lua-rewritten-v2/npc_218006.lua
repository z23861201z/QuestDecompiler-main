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
  if id ~= 4218006 then
    return
  end
  clickNPCid = id
  if qData[1395].state == 1 then
    NPC_SAY("??, ?????? ???? ???? ??????")
    SET_QUEST_STATE(1395, 2)
  end
  if qData[1396].state == 1 then
    NPC_SAY("??? ??? ?? ??????? ?? ??? ?? ??? ???.")
  end
  if qData[1397].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[1397].goal.getItem) then
      NPC_SAY("???? ??? ??? ? ?? ? ???.")
      SET_QUEST_STATE(1397, 2)
    else
      NPC_SAY("?? ?? ?????")
    end
  end
  if qData[1398].state == 1 then
    NPC_SAY("?????? ??? ??? ?? ???. ? ??? ???? ??? ???.")
  end
  if qData[1396].state == 0 and qData[1395].state == 2 then
    ADD_QUEST_BTN(qt[1396].id, qt[1396].name)
  end
  if qData[1398].state == 0 and qData[1397].state == 2 then
    ADD_QUEST_BTN(qt[1398].id, qt[1398].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
end
