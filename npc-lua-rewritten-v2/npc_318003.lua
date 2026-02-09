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
  if id ~= 4318003 then
    return
  end
  clickNPCid = id
  if qData[579].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[579].goal.getItem) then
      NPC_SAY("???! ?? ? ??? ??? ???? ????.")
      SET_QUEST_STATE(579, 2)
      return
    else
      NPC_SAY("??? ??? ??? ???? ?????, ?? ???? ???.. {0xFFFFFF00}[???] 7?{END} ? ? ????. ??? ?????? ?? ? ?? ???.")
      return
    end
  end
  if qData[605].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[605].goal.getItem) then
      NPC_SAY("???, ??~ ?????? ??? ???? ?? ?????.")
      SET_QUEST_STATE(605, 2)
      return
    else
      NPC_SAY("?????? ?? ???? ???? {0xFFFFFF00}[????]{END}? ?? ? ??. {0xFFFFFF00}15?{END}? ????. ???? ?? ????. ??")
      return
    end
  end
  if qData[579].state == 0 then
    ADD_QUEST_BTN(qt[579].id, qt[579].name)
  end
  if qData[605].state == 0 then
    ADD_QUEST_BTN(qt[605].id, qt[605].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[579].state ~= 2 and GET_PLAYER_LEVEL() >= qt[579].needLevel then
    if qData[579].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[579].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[605].state ~= 2 and GET_PLAYER_LEVEL() >= qt[605].needLevel then
    if qData[605].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[605].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
end
