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
  if id ~= 4901020 then
    return
  end
  clickNPCid = id
  if qData[145].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[145].goal.getItem) then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("还以为对我会不一样，可怎么能这样！")
        SET_QUEST_STATE(145, 2)
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("{0xFFFFFF00}??? [????]{END}? ?? ??? ???? ??? ? ????. ??? {0xFFFFFF00}10?{END}? ??????.")
    end
  end
  if qData[146].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[146].goal.getItem) then
      if 1 <= CHECK_INVENTORY_CNT(2) then
        NPC_SAY("{0xFFFFFF00}PLAYERNAME{END}?? ??? ?? ??????. ?? ??? ?????. ?? ??? ?? ??? ??? ?? ????.")
        SET_QUEST_STATE(146, 2)
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("{0xFFFFFF00}[????] 30?{END}? {0xFFFFFF00}[???] 30?{END}? ??? ???? ??? ??? ????. ??? ?? ?? ?????.")
    end
  end
end
function chkQState(id)
  QSTATE(id, -1)
end
