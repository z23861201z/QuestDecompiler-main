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
  if id ~= 4213008 then
    return
  end
  clickNPCid = id
  if qData[236].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[236].goal.getItem) then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("?? ?????! ??.. ?? ?????? ? ????. ?? ??? ????. ?! ??? ?? ??? ??? ? 100? ??.")
        SET_QUEST_STATE(236, 2)
      else
        NPC_SAY("ÐÐÄÒÌ«³Á¡£")
      end
    else
      NPC_SAY("{0xFFFFFF00}??? ??{END}? ?? ?? ????. ???? ??? ?? ?? ????. {0xFFFFFF00}50?{END} ??? ?????? ???.")
    end
  end
  ADD_NEW_SHOP_BTN(id, 10017)
  if qData[236].state == 0 then
    ADD_QUEST_BTN(qt[236].id, qt[236].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
end
