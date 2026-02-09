local function __QUEST_CHECK_ITEMS(goalItems)
  for i, v in ipairs(goalItems) do
    if CHECK_ITEM_CNT(v.id) < v.count then
      return false
    end
  end
  return true
end

function npcsay(id)
  if id ~= 4216002 then
    return
  end
  clickNPCid = id
  if qData[284].state == 1 and qData[287].state == 1 and qData[287].meetNpc[1] ~= qt[287].goal.meetNpc[1] then
    NPC_SAY("嗯… 这次写什么种类的书呢… ")
    SET_MEETNPC(287, 1, id)
    SET_QUEST_STATE(287, 2)
  end
  if qData[289].state == 1 then
    if __QUEST_CHECK_ITEMS(qt[289].goal.getItem) then
      NPC_SAY("?? ??? ? ???~ ?? ???? ??? ???? ????~ ??? ???? ? ?? ? ????.")
      SET_QUEST_STATE(289, 2)
    else
      NPC_SAY("? ?? ? ??? ?? {0xFFFFFF00}???? 80?{END}? ?????.")
    end
  end
  if qData[290].state == 1 then
    NPC_SAY("?? ?? ?? ??? {0xFFFFFF00}??????{END}?? ????.")
  end
  if qData[291].state == 1 then
    if __QUEST_CHECK_ITEMS(qt[291].goal.getItem) then
      if __QUEST_CHECK_ITEMS(qt[291].goal.getItem) then
        if 1 <= CHECK_INVENTORY_CNT(4) then
          NPC_SAY([[
???. ?? ? ???. ??? ????.
 ]])
          SET_QUEST_STATE(291, 2)
          return
        else
          NPC_SAY("??? ? ??? ???")
        end
      else
        NPC_SAY("?????? ??? ???")
      end
    else
      NPC_SAY("????? ??? ??? ?? ???? ??{0xFFFFFF00}???{END} ? ????.")
    end
  end
  ADD_NEW_SHOP_BTN(id, 10019)
  ADD_MOVESOUL_BTN(id)
  ADD_ENCHANT_BTN(id)
  ADD_PURIFICATION_BTN(id)
  if qData[284].state == 1 and qData[287].state == 2 and qData[289].state == 0 then
    ADD_QUEST_BTN(qt[289].id, qt[289].name)
  end
  if qData[284].state == 1 and qData[289].state == 2 and qData[290].state == 0 then
    ADD_QUEST_BTN(qt[290].id, qt[290].name)
  end
  if qData[285].state == 1 and qData[291].state == 0 then
    ADD_QUEST_BTN(qt[291].id, qt[291].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
end
